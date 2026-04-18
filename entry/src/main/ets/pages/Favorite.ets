import router from '@ohos.router';
import { Video } from '../viewmodel/video';

@Entry
@Component
struct Favorite {
  @StorageLink('favoriteVideos') favoriteList: string[] = []
  // 所有视频列表（用于找到收藏的视频信息）
  private allVideos: Video[] = [
    new Video($r('app.media.forest'), $rawfile('forest.mp4'), "哈尔滨森林博物馆"),
    new Video($r('app.media.snow'), $rawfile('snow.mp4'), "雪雕艺术"),
    new Video($r('app.media.paper'), $rawfile('paper.mp4'), "剪纸东林"),
    new Video($r('app.media.Delta'), $rawfile('Delta.mp4'), "三角洲"),
    new Video($r('app.media.Assault'), $rawfile('Assault.mp4'), "猛攻节"),
    new Video($r('app.media.stm32'), $rawfile('stm32.mp4'), "stm32NFC宣传"),
    new Video($r('app.media.key'), $rawfile('key.mp4'), "按键控制教程"),
    new Video($r('app.media.uart'), $rawfile('uart.mp4'), "串口解析")
  ]

  // 获取收藏的视频列表
  getFavoriteVideos(): Video[] {
    // 打印当前收藏列表，用于调试
    console.info('Current favorites:', this.favoriteList)
    
    const favorites = this.allVideos.filter(video => {
      const isIncluded = this.favoriteList.includes(video.video_name)
      // 打印每个视频的匹配结果，用于调试
      console.info(`Video ${video.video_name}: ${isIncluded}`)
      return isIncluded
    })
    
    // 打印找到的收藏视频，用于调试
    console.info('Found favorite videos:', favorites.map(v => v.video_name))
    return favorites
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Button('返回')
          .onClick(() => router.back())
        Text('我的收藏')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // 收藏列表
      List() {
        ForEach(this.getFavoriteVideos(), (item: Video) => {
          ListItem() {
            Row() {
              Image(item.video_image)
                .width(120)
                .height(80)
                .borderRadius(8)
              Column() {
                Text(item.video_name)
                  .fontSize(16)
                  .margin({ bottom: 8 })
                Button('取消收藏')
                  .onClick(() => {
                    const index = this.favoriteList.indexOf(item.video_name)
                    if (index >= 0) {
                      this.favoriteList.splice(index, 1)
                    }
                  })
              }
              .margin({ left: 12 })
              .layoutWeight(1)
            }
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(8)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/VideoPlayer',
                params: {
                  video_src: item.video_src,
                  video_image: item.video_image,
                  video_name: item.video_name
                }
              })
            })
          }
          .margin({ bottom: 8 })
        })
      }
      .margin({ top: 8 })
      .padding({ left: 16, right: 16 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}