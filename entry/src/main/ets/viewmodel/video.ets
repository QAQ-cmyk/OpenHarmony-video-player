export class Video{
  video_image:Resource;
  video_src:Resource;
  video_name:string;
  constructor(video_image:Resource,video_src:Resource,video_name:string) {
    this.video_image=video_image;
    this.video_src=video_src;
    this.video_name=video_name;
  }

}