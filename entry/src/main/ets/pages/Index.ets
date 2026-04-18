import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { common } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';
import { UserAccount, UserAccountList } from '../model/UserTypes';

let context: common.UIAbilityContext = getContext() as common.UIAbilityContext;

@Entry
@Component
struct Index {
  @State username: string = '';
  @State password: string = '';
  @State isRemember: boolean = false;

  // 页面显示前读取保存的用户信息
  async loadUserInfo(): Promise<void> {
    try {
      const prefs = await preferences.getPreferences(context, 'saveUserInfo');
      this.username = (await prefs.get('userName', '')) as string;
      this.isRemember = (await prefs.get('isRemember', false)) as boolean;

      if (this.isRemember) {
        this.password = (await prefs.get('password', '')) as string;
      } else {
        this.password = '';
      }
    } catch (err) {
      console.error('加载用户信息失败: ' + err);
    }
  }

  aboutToAppear(): void {
    this.loadUserInfo();
  }

  validateInputs(): boolean {
    if (this.username.length < 3) {
      promptAction.showToast({ message: '用户名不能少于3位' });
      return false;
    }
    if (this.password.length < 6) {
      promptAction.showToast({ message: '密码不能少于6位' });
      return false;
    }
    return true;
  }

  async saveUserInfo(prefs: preferences.Preferences): Promise<void> {
    if (this.isRemember) {
      await prefs.put('userName', this.username);
      await prefs.put('password', this.password);
      await prefs.put('isRemember', true);
    } else {
      await prefs.put('userName', this.username);
      await prefs.put('password', '');
      await prefs.put('isRemember', false);
    }
    await prefs.flush();
  }

  // 校验用户名密码并登录
  async checkCredentials(): Promise<void> {
    try {
      const prefs = await preferences.getPreferences(context, 'userAccounts');
      const accountsStr = await prefs.get('accounts', '[]') as string;
      const accounts: UserAccountList = JSON.parse(accountsStr);

      // 验证用户名和密码
      const user = accounts.find(acc => 
        acc.username === this.username && acc.password === this.password
      );

      if (user) {
        // 保存当前登录用户信息
        const currentPrefs = await preferences.getPreferences(context, 'saveUserInfo');
        await this.saveUserInfo(currentPrefs);
        router.replaceUrl({
          url: 'pages/VideoList',
          params: { username: this.username }
        });
      } else {
        promptAction.showToast({ message: '用户名或密码错误' });
      }
    } catch (err) {
      console.error('登录失败:', err);
      promptAction.showToast({ message: '登录失败' });
    }
  }

  build() {
    Column() {
      Text('欢迎登录')
        .fontSize(26)
        .margin({ top: 60 })
        .alignSelf(ItemAlign.Center);

      TextInput({ placeholder: '用户名', text: this.username })
        .onChange((val: string) => this.username = val)
        .margin({ top: 20 })
        .width('80%')
        .alignSelf(ItemAlign.Center);

      TextInput({ placeholder: '密码', text: this.password })
        .type(InputType.Password)
        .onChange((val: string) => this.password = val)
        .margin({ top: 12 })
        .width('80%')
        .alignSelf(ItemAlign.Center);

      Row() {
        Checkbox()
          .select(this.isRemember)
          .onChange((val: boolean) => this.isRemember = val);
        Text('记住密码')
          .fontSize(14)
          .margin({ left: 6 });
      }
      .margin({ top: 8 })
      .alignSelf(ItemAlign.Center);

      Button('登录')
        .margin({ top: 20 })
        .onClick(async () => {
          if (this.validateInputs()) {
            await this.checkCredentials();
          }
        })
        .alignSelf(ItemAlign.Center);

      Button('注册')
        .margin({ top: 10 })
        .onClick(() => router.pushUrl({ url: 'pages/Register' }))
        .alignSelf(ItemAlign.Center);
    }.width('100%');
  }
}
