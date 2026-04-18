import router from '@ohos.router';
import { Video } from '../viewmodel/video';

interface WaterFlowConst {
  WATER_FLOW_LAYOUT_WEIGHT: number;
  WATER_FLOW_COLUMNS_TEMPLATE: string;
}

const Const: WaterFlowConst = {
  WATER_FLOW_LAYOUT_WEIGHT: 1,
  WATER_FLOW_COLUMNS_TEMPLATE: "1fr 1fr"
};

@Entry
@Component
struct VideoList {
  @StorageLink('favoriteVideos') favoriteList: string[] = []
  @State videos: Video[] = []
  @State allVideos: Video[] = []  // 保存原始视频列表
  @State currentPage: number = 1   // 当前页码
  private scroller: Scroller = new Scroller()  // 滚动控制器

  aboutToAppear(): void {
    // 初始化原始视频列表
    this.allVideos = [
      new Video($r('app.media.forest'), $rawfile('forest.mp4'), "哈尔滨森林博物馆"),
      new Video($r('app.media.snow'), $rawfile('snow.mp4'), "雪雕艺术"),
      new Video($r('app.media.paper'), $rawfile('paper.mp4'), "剪纸东林"),
      new Video($r('app.media.Delta'), $rawfile('Delta.mp4'), "三角洲"),
      new Video($r('app.media.Assault'), $rawfile('Assault.mp4'), "猛攻节"),
      new Video($r('app.media.stm32'), $rawfile('stm32.mp4'), "stm32NFC宣传"),
      new Video($r('app.media.key'), $rawfile('key.mp4'), "按键控制教程"),
      new Video($r('app.media.uart'), $rawfile('uart.mp4'), "串口解析")
    ]
    this.loadMoreVideos()
  }

  // 加载更多视频
  loadMoreVideos() {
    const newVideos = this.allVideos.map(video => new Video(
      video.video_image,
      video.video_src,
      video.video_name  // 移除页码后缀，保持原始视频名称
    ))
    this.videos = this.videos.concat(newVideos)
    this.currentPage++
  }

  build() {
    Column() {
      Row() {
        Button("返回登录")
          .onClick(() => {
            router.replaceUrl({ url: "pages/Index" })  // 替换路由防止返回
          })
          .margin({ right: 16 })

        Text("视频列表")
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)

        Button("我的收藏")
          .margin({ left: 16 })
          .onClick(() => {
            router.pushUrl({ url: "pages/Favorite" })
          })
      }
      .margin({ left: 10, bottom: 12, top: 12 })

      Scroll(this.scroller) {
        WaterFlow() {
          ForEach(this.videos, (item: Video, index: number) => {
            FlowItem() {
              Column() {
                Image(item.video_image)
                  .width('100%')
                  .height(index % 3 === 0 ? 180 : index % 3 === 1 ? 140 : 160)  // 三种不同的高度
                  .borderRadius(8)
                  .onClick(() => {
                    router.pushUrl({
                      url: "pages/VideoPlayer",
                      params: {
                        video_src: item.video_src,
                        video_image: item.video_image,
                        video_name: item.video_name
                      }
                    });
                  });

                Text(item.video_name)
                  .margin({ top: 8 })
                  .textAlign(TextAlign.Center)
                  .fontSize(16);

                Button(this.favoriteList.includes(item.video_name) ? "取消收藏" : "收藏")
                  .margin({ top: 5 })
                  .onClick(() => {
                    const idx = this.favoriteList.indexOf(item.video_name);
                    if (idx >= 0) {
                      this.favoriteList.splice(idx, 1);
                    } else {
                      this.favoriteList.push(item.video_name);
                    }
                  });
              }
              .padding(8)
              .backgroundColor(Color.White)
              .borderRadius(12)
              .shadow({ radius: 4, color: '#888888', offsetX: 2, offsetY: 2 })
            }
          }, (item: Video): string => item.video_name)  // 添加返回值类型声明
        }
        .layoutWeight(Const.WATER_FLOW_LAYOUT_WEIGHT)
        .layoutDirection(FlexDirection.Column)
        .columnsTemplate(Const.WATER_FLOW_COLUMNS_TEMPLATE)
        .columnsGap(12)
        .rowsGap(12)
        .margin({ left: 12, right: 12 })
        .onReachEnd(() => {
          // 触底加载更多
          this.loadMoreVideos()
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
  }
}
