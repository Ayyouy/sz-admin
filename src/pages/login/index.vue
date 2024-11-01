<template>
  <div class="wrapper">
    <div class="lowin">
      <div class="lowin-brand bounceOut">
        <img :src="siteInfo.siteLogoSm" alt="logo">
      </div>
      <div class="lowin-wrapper">
        <div class="lowin-box lowin-login">
          <div class="lowin-box-inner">
            <p>管理系统登录</p>
            <div class="lowin-group">
              <label>账户名<a href="#" class="login-back-link">登录?</a></label>
              <input v-model="phone" min="7" minlength="7" type="text" placeholder="请输入账号" class="lowin-input">
            </div>
            <div class="lowin-group password-group">
              <label>密码</label>
              <input v-model="password" pattern="[a-zA-Z0-9]+" type="password" placeholder="请输入密码"
                     class="lowin-input">
            </div>
            <div class="lowin-group password-group">
              <label>验证码</label>
              <img @click="refreshImg" class='code-img' :src="adminUrl+'/code/getCode.do?time=' + imgCodeTime"
                   alt="验证码">
              <input v-model="code2" @keyup.enter="toLogin" type="text"
                     placeholder="验证码" pattern="[a-zA-Z0-9]+"
                     class="lowin-input">
            </div>
            <button @click="toLogin" class="lowin-btn login-btn">
              登录
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as api from '@/axios/api'
import {isNull} from '@/utils/utils'
import APIUrl from '@/axios/api.url' // 引入api.url.js

export default {
  components: {},
  props: {},
  data () {
    return {
      adminUrl: null,
      code2: '',
      name: '',
      phone: '',
      password: '',
      siteInfo: '',
      imgCodeTime: 0
    }
  },
  mounted () {
    this.adminUrl = APIUrl.baseURL
    this.getSiteInfo()
  },
  methods: {
    pwdReg (value) {
      const regex = /^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*]+$)[a-zA-Z\d!@#$%^&*].{6,12}$/
      return regex.test(value)
    },
    async toLogin () {
      // 登录
      if (isNull(this.phone) || this.phone.length < 7) {
        this.$message.error('请输入正确的账户名')
      } else if (isNull(this.password)) {
        this.$message.error('请输入密码')
      // } else if (!this.pwdReg(this.password)) {
      //   this.$message.error('密码为6~12位，数字、字母或符号')
      } else if (isNull(this.code2)) {
        this.$message.error('请输入验证码')
      } else {
        let opts = {
          adminPhone: this.phone,
          adminPwd: this.password,
          verifyCode: this.code2
        }
        let data = await api.login(opts)
        if (data.status === 0) {
          this.$store.state.userInfo.phone = this.phone
          this.$store.state.userInfo.adminName = data.data.adminName
          this.$store.state.userInfo.id = data.data.id
          localStorage.setItem('admin-token', data.data.token)
          localStorage.setItem('admin-name', data.data.adminName)
          localStorage.setItem('id', data.data.id)
          this.$router.push('/home')
        } else {
          this.$message.error(data.msg)
        }
      }
    },
    refreshImg () {
      this.adminUrl = ''
      this.imgCodeTime = Date.now()
      this.dialogImgShow = false
      let this_ = this
      setTimeout(() => {
        this_.adminUrl = APIUrl.baseURL
        this_.dialogImgShow = true
      }, 500)
    },
    async checkCode () {
      let data = await api.checkCode({code: this.code2})
      return data
    },
    async getSiteInfo () {
      // 获取站点信息
      let data = await api.getInfo()
      if (data.status === 0) {
        this.siteInfo = data.data
        this.$store.state.siteInfo = data.data
      } else {
        this.$message.error(data.msg)
      }
    }
  }
}
</script>
<style scoped>
.lowin .lowin-group.password-group {
  position: relative;
}

.code-img {
  float: right;
  width: 100px;
  height: 45px;
  line-height: 45px;
  position: absolute;
  right: 0;
  background: #fff;
}

</style>
