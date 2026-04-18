import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';
import { UserAccount, UserAccountList } from '../model/UserTypes';

let context: common.UIAbilityContext = getContext() as common.UIAbilityContext;

@Entry
@Component
struct Register {
  @State username: string = '';
  @State password: string = '';
  @State confirmPassword: string = '';

  validate(): boolean {
    if (this.username.length < 3) {
      promptAction.showToast({ message: '用户名不能少于3位' });
      return false;
    }
    if (this.password.length < 6) {
      promptAction.showToast({ message: '密码不能少于6位' });
      return false;
    }
    if (this.password !== this.confirmPassword) {
      promptAction.showToast({ message: '两次密码输入不一致' });
      return false;
    }
    return true;
  }

  async saveUserInfo(): Promise<void> {
    try {
      const prefs = await preferences.getPreferences(context, 'userAccounts');
      // 获取现有用户列表
      const accountsStr = await prefs.get('accounts', '[]') as string;
      const accounts: UserAccountList = JSON.parse(accountsStr);
      
      // 检查用户名是否已存在
      if (accounts.some(acc => acc.username === this.username)) {
        promptAction.showToast({ message: '用户名已存在' });
        return;
      }

      // 添加新用户
      accounts.push({
        username: this.username,
        password: this.password
      });

      // 保存更新后的用户列表
      await prefs.put('accounts', JSON.stringify(accounts));
      await prefs.flush();
      promptAction.showToast({ message: '注册成功' });
      router.back();
    } catch (err) {
      console.error('注册失败:', err);
      promptAction.showToast({ message: '注册失败' });
    }
  }

  build() {
    Column() {
      Text('用户注册')
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

      TextInput({ placeholder: '确认密码', text: this.confirmPassword })
        .type(InputType.Password)
        .onChange((val: string) => this.confirmPassword = val)
        .margin({ top: 12 })
        .width('80%')
        .alignSelf(ItemAlign.Center);

      Button('注册')
        .margin({ top: 20 })
        .onClick(async () => {
          if (this.validate()) {
            await this.saveUserInfo();
          }
        })
        .alignSelf(ItemAlign.Center);
    }
  }
}
