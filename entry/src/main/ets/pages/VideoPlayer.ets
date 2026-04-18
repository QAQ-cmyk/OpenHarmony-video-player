import router from '@ohos.router';

interface routerParams {
  video_image: Resource;
  video_src: Resource;
  video_name: string;
}

interface DurationObject {
  duration: number;
}

interface TimeObject {
  time: number;
}

interface FullscreenObject {
  fullscreen: boolean;
}

@Entry
@Component
struct VideoPlayer {
  @State fullParams: routerParams | null = null;
  @State source: Resource = $rawfile('test1.mp4');
  @State previewUri: Resource = $r('app.media.li');
  @State backIconResource: Resource = $r('app.media.ic_back');
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X;
  @State isAutoPlay: boolean = false;
  @State showControls: boolean = true;
  @State isPlay: boolean = false;
  @State inputTime: string = '';
  @State showRateTip: boolean = false;
  @State showRateMenu: boolean = false;
  @State playIconOpacity: number = 0;
  @State showPlayIcon: boolean = false;
  @State currentVideoIndex: number = 0;

  // 视频列表
  @State videoList: routerParams[] = [
    { video_image: $r('app.media.forest'), video_src: $rawfile('forest.mp4'), video_name: "哈尔滨森林博物馆" },
    { video_image: $r('app.media.snow'), video_src: $rawfile('snow.mp4'), video_name: "雪雕艺术" },
    { video_image: $r('app.media.paper'), video_src: $rawfile('paper.mp4'), video_name: "剪纸东林" },
    { video_image: $r('app.media.Delta'), video_src: $rawfile('Delta.mp4'), video_name: "三角洲" },
    { video_image: $r('app.media.Assault'), video_src: $rawfile('Assault.mp4'), video_name: "猛攻节" },
    { video_image: $r('app.media.stm32'), video_src: $rawfile('stm32.mp4'), video_name: "stm32NFC宣传" },
    { video_image: $r('app.media.key'), video_src: $rawfile('key.mp4'), video_name: "按键控制教程" },
    { video_image: $r('app.media.uart'), video_src: $rawfile('uart.mp4'), video_name: "串口解析" }
  ];

  controller: VideoController = new VideoController();
  @Provide currentTime: number = 0;

  @StorageLink('favoriteVideos') favoriteList: string[] = [];

  aboutToAppear(): void {
    const params = router.getParams() as routerParams;
    this.fullParams = params;
    
    if (params && params.video_name && params.video_src && params.video_image) {
      this.source = params.video_src;
      this.previewUri = params.video_image;
      
      // 查找当前视频在列表中的索引
      const index = this.videoList.findIndex(video => 
        video.video_name === params.video_name
      );
      // 设置当前视频索引，如果找不到则使用0
      this.currentVideoIndex = Math.max(0, index);
    }
  }

  changeRate(rate: PlaybackSpeed) {
    this.curRate = rate;
    this.showRateTip = true;
    setTimeout(() => {
      this.showRateTip = false;
    }, 1000);
  }

  // 播放下一个视频的方法
  nextVideo(): void {
    this.currentVideoIndex = (this.currentVideoIndex + 1) % this.videoList.length;
    const nextVideo = this.videoList[this.currentVideoIndex];
    this.source = nextVideo.video_src;
    this.previewUri = nextVideo.video_image;
    this.fullParams = nextVideo;
    this.controller.reset();
    this.isPlay = false;
  }

  // 播放上一个视频的方法
  prevVideo(): void {
    this.currentVideoIndex = (this.currentVideoIndex - 1 + this.videoList.length) % this.videoList.length;
    const prevVideo = this.videoList[this.currentVideoIndex];
    this.source = prevVideo.video_src;
    this.previewUri = prevVideo.video_image;
    this.fullParams = prevVideo;
    this.controller.reset();
    this.isPlay = false;
  }

  build() {
    Column({ space: 0 }) {
      // 顶部导航栏
      Row() {
        Button('返回')
          .margin({ left: 16 })
          .onClick(() => router.back());
        
        Text(this.fullParams?.video_name ?? '视频播放')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 12 });
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)
      .alignItems(VerticalAlign.Center);

      // 视频区域
      Stack() {
        Video({
          src: this.source,
          previewUri: this.previewUri,
          currentProgressRate: this.curRate,
          controller: this.controller
        })
          .width('100%')
          .height('100%')
          .autoPlay(this.isAutoPlay)
          .controls(this.showControls)
          .loop(false)
          .objectFit(ImageFit.Contain)
          .onUpdate((e?: TimeObject) => {
            if (e) this.currentTime = e.time;
          })
          .onFinish(() => {
            this.isPlay = false;
            this.nextVideo();
          })
          .onClick(() => {
            this.isPlay = !this.isPlay;
            this.isPlay ? this.controller.start() : this.controller.pause();
          });
      }
      .width('100%')
      .height('40%')
      .backgroundColor(Color.Black);

      // 控制区域
      Column({ space: 12 }) {
        // 播放控制按钮
        Row() {
          Button('上一个')
            .width(80)
            .height(36)
            .fontSize(14)
            .backgroundColor('#f0f0f0')
            .fontColor('#333')
            .onClick(() => this.prevVideo());

          Button(this.isPlay ? '暂停' : '播放')
            .width(80)
            .height(36)
            .fontSize(14)
            .backgroundColor('#007AFF')
            .fontColor(Color.White)
            .onClick(() => {
              this.isPlay = !this.isPlay;
              this.isPlay ? this.controller.start() : this.controller.pause();
            });

          Button('下一个')
            .width(80)
            .height(36)
            .fontSize(14)
            .backgroundColor('#f0f0f0')
            .fontColor('#333')
            .onClick(() => this.nextVideo());
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 16 });

        // 时间控制按钮
        Row() {
          Button('后退10秒')
            .width(100)
            .height(36)
            .fontSize(14)
            .backgroundColor('#f0f0f0')
            .fontColor('#333')
            .onClick(() => {
              const target = Math.max(this.currentTime - 10, 0);
              this.controller.setCurrentTime(target, SeekMode.Accurate);
            });

          Button('前进10秒')
            .width(100)
            .height(36)
            .fontSize(14)
            .backgroundColor('#f0f0f0')
            .fontColor('#333')
            .onClick(() => {
              const target = this.currentTime + 10;
              this.controller.setCurrentTime(target, SeekMode.Accurate);
            });
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly);

        // 倍速控制按钮
        Row() {
          Button('0.75x')
            .width(80)
            .height(36)
            .fontSize(14)
            .backgroundColor(this.curRate === PlaybackSpeed.Speed_Forward_0_75_X ? '#007AFF' : '#f0f0f0')
            .fontColor(this.curRate === PlaybackSpeed.Speed_Forward_0_75_X ? Color.White : '#333')
            .onClick(() => this.changeRate(PlaybackSpeed.Speed_Forward_0_75_X));

          Button('1.0x')
            .width(80)
            .height(36)
            .fontSize(14)
            .backgroundColor(this.curRate === PlaybackSpeed.Speed_Forward_1_00_X ? '#007AFF' : '#f0f0f0')
            .fontColor(this.curRate === PlaybackSpeed.Speed_Forward_1_00_X ? Color.White : '#333')
            .onClick(() => this.changeRate(PlaybackSpeed.Speed_Forward_1_00_X));

          Button('2.0x')
            .width(80)
            .height(36)
            .fontSize(14)
            .backgroundColor(this.curRate === PlaybackSpeed.Speed_Forward_2_00_X ? '#007AFF' : '#f0f0f0')
            .fontColor(this.curRate === PlaybackSpeed.Speed_Forward_2_00_X ? Color.White : '#333')
            .onClick(() => this.changeRate(PlaybackSpeed.Speed_Forward_2_00_X));
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly);

        // 时间跳转控制
        Row({ space: 8 }) {
          TextInput({ placeholder: '跳转时间(秒)', text: this.inputTime })
            .width(160)
            .height(36)
            .backgroundColor('#f5f5f5')
            .padding({ left: 16 })
            .onChange(value => this.inputTime = value)
            .type(InputType.Number);

          Button('跳转')
            .width(80)
            .height(36)
            .fontSize(14)
            .backgroundColor('#007AFF')
            .fontColor(Color.White)
            .onClick(() => {
              const target = parseInt(this.inputTime);
              if (!isNaN(target)) {
                this.controller.setCurrentTime(target, SeekMode.Accurate);
              }
            });
        }
        .width('100%')
        .padding({ left: 16, right: 16 })  // 修改这里
        .justifyContent(FlexAlign.Center);

        // 收藏按钮
        Button(this.favoriteList.includes(this.fullParams?.video_name ?? '') ? '取消收藏' : '收藏')
          .width(120)
          .height(36)
          .fontSize(14)
          .backgroundColor(this.favoriteList.includes(this.fullParams?.video_name ?? '') ? '#ff4d4f' : '#f0f0f0')
          .fontColor(this.favoriteList.includes(this.fullParams?.video_name ?? '') ? Color.White : '#333')
          .margin({ top: 8 })
          .onClick(() => {
            const name = this.fullParams?.video_name ?? '';
            const index = this.favoriteList.indexOf(name);
            index >= 0 ? this.favoriteList.splice(index, 1) : this.favoriteList.push(name);
          });
      }
      .width('100%')
      .padding({ top: 16, bottom: 20 })
      .backgroundColor(Color.White);

      // 倍速提示
      if (this.showRateTip) {
        Text(this.getRateText())
          .fontSize(20)
          .fontColor(Color.White)
          .backgroundColor('#00000099')
          .padding(8)
          .borderRadius(4)
          .position({ x: '50%', y: '50%' })
          .translate({ x: '-50%', y: '-50%' });
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5');
  }

  private getRateText(): string {
    switch (this.curRate) {
      case PlaybackSpeed.Speed_Forward_0_75_X:
        return '0.75x';
      case PlaybackSpeed.Speed_Forward_1_00_X:
        return '1x';
      case PlaybackSpeed.Speed_Forward_2_00_X:
        return '2x';
      default:
        return '1x';
    }
  }
}