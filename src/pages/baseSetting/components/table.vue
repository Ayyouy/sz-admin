<template>
  <div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>logo设置</span>
      </div>
      <div class="text item">
        <el-form :inline="true" :model="logoform" class="demo-form-inline" size="small" ref="logoForm">
          <el-row>
            <el-col :span="8">
              <el-form-item label="名称">
                <el-input v-model="logoform.siteName" placeholder="名称"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="关键词">
                <el-input v-model="logoform.siteKeywords" placeholder="关键词"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="描述">
                <el-input v-model="logoform.siteDescription" placeholder="描述"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="6">
              <el-form-item label="大logo">
                <el-upload
                  name="upload_file"
                  :with-credentials='true'
                  action="#"
                  multiple
                  :limit="1"
                  :file-list="fileListlogo"
                  :show-file-list="false"
                  :auto-upload="false"
                  :on-exceed="handleExceed1"
                  :on-remove="handleRemove1"
                  :on-change="handleChange1"
                  :before-remove="beforeRemove"
                  class="upload-demo">
                  <el-button size="small" type="primary">上传大logo</el-button>
                </el-upload>
              </el-form-item>
              <p>
                图片建议：背景色为白色或者透明色，格式为png或者jpg图片
              </p>
            </el-col>
            <el-col :span="6">
              <img class="img" :src="logoform.siteLogo" alt="logo">
            </el-col>
            <el-col :span="6">
              <el-form-item label="小logo">
                <el-upload
                  name="upload_file"
                  :with-credentials='true'
                  action="#"
                  multiple
                  :limit="1"
                  :file-list="fileListlogo2"
                  :show-file-list="false"
                  :auto-upload="false"
                  :on-exceed="handleExceed2"
                  :on-remove="handleRemove2"
                  :on-change="handleChange2"
                  :before-remove="beforeRemove"
                  class="upload-demo">
                  <el-button size="small" type="primary">上传min-logo</el-button>
                </el-upload>
              </el-form-item>
              <p>
                图片建议：背景色为透明色，格式为png图片
              </p>
            </el-col>
            <el-col :span="6">
              <img class="img" :src="logoform.siteLogoSm" alt="logo">
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="24" class="text-right">
              <el-button type="primary" size="small" @click="SettingLogoInfo('logoForm')">保存设置</el-button>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </el-card>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>下载链接设置</span>
      </div>
      <div class="text item">
        <el-form :inline="true" :model="downform" class="demo-form-inline" size="small" ref="downform">
          <el-row>
            <el-col :span="8">
              <el-form-item label="安卓二维码">
                <el-upload
                  name="upload_file"
                  :with-credentials='true'
                  action="#"
                  multiple
                  :limit="1"
                  :file-list="fileList"
                  :show-file-list="false"
                  :auto-upload="false"
                  :on-exceed="handleExceed3"
                  :on-remove="handleRemove3"
                  :on-change="handleChange3"
                  :before-remove="beforeRemove"
                  class="upload-demo">
                  <el-button size="small" type="primary">上传安卓二维码</el-button>
                </el-upload>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <img class="img" style="height:80px;" :src="downform.siteAndroidImg" alt="">
            </el-col>
            <el-col :span="8">
              <el-form-item label="安卓下载链接">
                <el-input v-model="downform.siteAndroidUrl" placeholder="安卓下载链接"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="8">
              <el-form-item label="IOS二维码">
                <el-upload
                  name="upload_file"
                  :with-credentials='true'
                  action="#"
                  multiple
                  :limit="1"
                  :file-list="fileList2"
                  :show-file-list="false"
                  :auto-upload="false"
                  :on-exceed="handleExceed4"
                  :on-remove="handleRemove4"
                  :on-change="handleChange4"
                  :before-remove="beforeRemove"
                  class="upload-demo">
                  <el-button size="small" type="primary">上传IOS二维码</el-button>
                </el-upload>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <img class="img" style="height:80px;" :src="downform.siteIosImg" alt="">
            </el-col>
            <el-col :span="8">
              <el-form-item label="ios下载链接">
                <el-input v-model="downform.siteIosUrl" placeholder="ios下载链接"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="24" class="text-right">
              <el-button type="primary" size="small" @click="SettingDownInfo('downform')">保存设置</el-button>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </el-card>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>汇率设定</span>
      </div>
      <div class="text item">
        <el-form :inline="true" :model="logoform" class="demo-form-inline" size="small" ref="logoForm">
          <el-row>
            <el-col :span="8">
              <el-form-item label="汇率设定">
                <el-input v-model="logoform.siteName" placeholder="USDT"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="24" class="text-right">
              <el-button type="primary" size="small" @click="SettingLogoInfo('logoForm')">保存设置</el-button>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </el-card>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>系统颜色配置  （该颜色主题仅针对pc端和手机端用户配置）</span>
      </div>
      <div class="text item">
        <el-form :inline="true" :model="colorform" class="demo-form-inline" size="small" ref="colorform">
          <el-row>
            <el-col :span="8">
              <el-radio-group v-model="colorform.siteColor">
                <el-radio label="red">红色主题</el-radio>
                <el-radio label="black">黑色主题</el-radio>
              </el-radio-group>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="24" class="text-right">
              <el-button type="primary" size="small" @click="SettingColorInfo('colorform')">保存设置</el-button>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </el-card>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>公司信息</span>
      </div>
      <div class="text item">
        <el-form :model="companyform" label-width="80px" class="demo-form-inline" size="small" ref="companyform">
          <el-row>
            <el-col :span="24">
              <el-form-item label="公司简介">
                <el-input type="textarea" rows="3" v-model="companyform.siteIntro" placeholder="公司简介"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="公司信息">
                <el-input type="textarea" rows="5" v-model="companyform.companyInfo" placeholder="公司信息"></el-input>
              </el-form-item>
            </el-col>

          </el-row>

          <el-row>
            <el-col :span="24">
              <el-form-item label="风险提示">
                <el-input type="textarea" rows="3" v-model="companyform.riskNotice" placeholder="风险提示"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="版权信息">
                <el-input type="textarea" v-model="companyform.siteVersionInfo" placeholder="版权信息"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">
              <el-form-item label="资质1">
                <el-upload
                  name="upload_file"
                  :with-credentials='true'
                  action="#"
                  multiple
                  :limit="1"
                  :file-list="fileListimg"
                  :show-file-list="false"
                  :auto-upload="false"
                  :on-exceed="handleExceed5"
                  :on-remove="handleRemove5"
                  :on-change="handleChange5"
                  :before-remove="beforeRemove"
                  class="upload-demo">
                  <el-button size="small" type="primary">上传资质1</el-button>
                </el-upload>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="资质2">
                <el-upload
                  name="upload_file"
                  :with-credentials='true'
                  action="#"
                  multiple
                  :limit="1"
                  :file-list="fileListimg2"
                  :show-file-list="false"
                  :auto-upload="false"
                  :on-exceed="handleExceed6"
                  :on-remove="handleRemove6"
                  :on-change="handleChange6"
                  :before-remove="beforeRemove"
                  class="upload-demo">
                  <el-button size="small" type="primary">上传资质2</el-button>
                </el-upload>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col class="text-center" :span="12">
              <img class="img" preview="0" preview-text="描述文字" style="max-height:200px;max-width:80%;"
                   :src="companyform.certImg1" alt="">
            </el-col>
            <el-col class="text-center" :span="12">
              <img class="img" preview="1" preview-text="描述文字" style="max-height:200px;;max-width:80%;"
                   :src="companyform.certImg2" alt="">
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="24" class="text-right">
              <el-button type="primary" size="small" @click="SettingcompanyInfo('companyform')">保存设置</el-button>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </el-card>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>联系方式及协议</span>
      </div>
      <div class="text item">
        <el-form :inline="true" :model="contactform" class="demo-form-inline" size="small" ref="contactform">
          <el-row>
            <el-col :span="8">
              <el-form-item label="QQ号码">
                <el-input v-model="contactform.siteQq" placeholder="QQ号码"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="客服电话">
                <el-input v-model="contactform.sitePhone" placeholder="客服电话"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="语言">
                <el-input v-model="contactform.siteLanguage" placeholder="语言"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="8">
              <el-form-item label="邮件地址">
                <el-input v-model="contactform.siteHost" placeholder="邮件发送人"></el-input>
                <p>例如：http://www.***.com</p>
              </el-form-item>
            </el-col>
            <el-col :span="16">
              <el-form-item label="邮件接收人">
                <el-input v-model="contactform.siteEmailTo" placeholder="邮件接收人"></el-input>
                <p>出现550 User has no permission,登陆邮箱-设置-客户端授权密码</p>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="8">
              <el-form-item label="邮件发送人">
                <el-input v-model="contactform.siteEmailFrom" placeholder="邮件发送人"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="16">
              <el-form-item label="在线客服URL">
                <el-input v-model="contactform.onlineService" style="width:430px" placeholder="在线客服url"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>

            <el-col :span="24">
              <el-form-item label="注册协议地址">
                <el-upload
                  name="upload_file"
                  :with-credentials='true'
                  action="#"
                  multiple
                  :limit="1"
                  :file-list="fileListagress"
                  :show-file-list="false"
                  :auto-upload="false"
                  :on-exceed="handleExceed7"
                  :on-remove="handleRemove7"
                  :on-change="handleChange7"
                  :before-remove="beforeRemove"
                  class="upload-demo">
                  <el-button size="small" type="primary">上传注册协议地址</el-button>
                </el-upload>
              </el-form-item>
              <p style="margin-bottom:10px;">
                {{ contactform.regAgress }}
              </p>
            </el-col>
            <el-col :span="24">
              <el-form-item label="融资融券协议地址">
                <el-upload
                  name="upload_file"
                  :with-credentials='true'
                  action="#"
                  multiple
                  :limit="1"
                  :file-list="fileListagress2"
                  :show-file-list="false"
                  :auto-upload="false"
                  :on-exceed="handleExceed8"
                  :on-remove="handleRemove8"
                  :on-change="handleChange8"
                  :before-remove="beforeRemove"
                  class="upload-demo">
                  <el-button size="small" type="primary">上传融资融券协议地址</el-button>
                </el-upload>
              </el-form-item>
              <p style="margin-bottom:10px;">
                {{ contactform.tradeAgress }}
              </p>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="24">
              <el-form-item label="注册协议文本">
                <Editor v-model="contactform.regAgreeText" :isClear="false" @change="editorChange1"></Editor>
                <!-- <el-input type="textarea" rows="5" style="width:800px" v-model="contactform.regAgreeText" placeholder="注册协议文本"></el-input> -->
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="融资融券标题">
                <el-input type="textarea" rows="1" style="width:800px" v-model="contactform.tradeAgreeTitle"
                          placeholder="融资融券标题"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="融资融券文本">
                <Editor v-model="contactform.tradeAgreeText" :isClear="false" @change="editorChange2"></Editor>
                <!-- <el-input type="textarea" rows="5" style="width:800px" v-model="contactform.tradeAgreeText" placeholder="融资融券协议文本"></el-input> -->
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="24" class="text-right">
              <el-button type="primary" size="small" @click="SettingContactInfo('contactform')">保存设置</el-button>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </el-card>

    <DetailDialog ref="addSettingDialog"></DetailDialog>
  </div>

</template>

<script>
import * as api from '@/axios/api'
import DetailDialog from './add-dialog'
import APIUrl from '@/axios/api.url' // 引入api.url.js
import Editor from '@/components/UE'
import axios from 'axios'

export default {
  components: {
    DetailDialog,
    Editor
  },
  props: {},
  data () {
    return {
      colorform: {
        siteColor: 'red'
      },
      logoform: {
        siteName: '',
        siteKeywords: '',
        siteDescription: '',
        siteLogo: '',
        siteLogoSm: ''
      },
      downform: {
        siteAndroidImg: '',
        siteAndroidUrl: '',
        siteIosImg: '',
        siteIosUrl: ''
      },
      contactform: {
        siteQq: '',
        sitePhone: '',
        siteEmailFrom: '',
        siteEmailTo: '',
        siteLanguage: '',
        siteVersionInfo: '',
        regAgress: '',
        tradeAgress: '',
        siteHost: '',
        tradeAgreeTitle: '',
        tradeAgreeText: '',
        regAgreeText: '',
        onlineService: ''
      },
      companyform: {
        companyInfo: '',
        siteIntro: '',
        certImg1: '',
        certImg2: '',
        riskNotice: '',
        siteVersionInfo: ''
      },
      fileList: [],
      fileList2: [],
      fileListlogo: [],
      fileListlogo2: [],
      fileListimg: [],
      fileListimg2: [],
      fileListagress: [],
      fileListagress2: [],
      info: {},
      type: '', // 添加或者更新
      admin: '',
      rule: {},
      id: '',
      url: ''
    }
  },
  watch: {},
  computed: {},
  mounted () {
    this.getSettingInfo()
    // this.admin = APIUrl.baseURL
    // if (this.admin === undefined) {
    //   this.admin = ''
    // }
    this.url = APIUrl.baseURL
  },
  methods: {
    beforeRemove (file, fileList) {
      return this.$confirm(`确定移除 ${file.name}？`)
    },
    handleExceed1 (files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      this.logoform.siteLogo = ''
      this.fileListlogo = []
    },
    handleRemove1 (file, fileList) {
      this.logoform.siteLogo = ''
      this.fileListlogo = fileList
    },
    handleChange1 (file, fileList) {
      this.fileListlogo = fileList
      const isLt10M = (file.size / 1024 / 1024 < 10)
      if (!isLt10M) {
        this.$message.warning('上传图片大小不能超过 10MB!')
        this.fileListlogo.pop()
      } else {
        this.handleConfirm(1, this.fileListlogo[0])
      }
      return isLt10M
    },
    handleExceed2 (files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      this.logoform.siteLogoSm = ''
      this.fileListlogo2 = []
    },
    handleRemove2 (file, fileList) {
      this.logoform.siteLogoSm = ''
      this.fileListlogo2 = fileList
    },
    handleChange2 (file, fileList) {
      this.fileListlogo2 = fileList
      const isLt10M = (file.size / 1024 / 1024 < 10)
      if (!isLt10M) {
        this.$message.warning('上传图片大小不能超过 10MB!')
        this.fileListlogo2.pop()
      } else {
        this.handleConfirm(2, this.fileListlogo2[0])
      }
      return isLt10M
    },
    handleExceed3 (files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      this.downform.siteAndroidImg = ''
      this.fileList = []
    },
    handleRemove3 (file, fileList) {
      this.downform.siteAndroidImg = ''
      this.fileList = fileList
    },
    handleChange3 (file, fileList) {
      this.fileList = fileList
      const isLt10M = (file.size / 1024 / 1024 < 10)
      if (!isLt10M) {
        this.$message.warning('上传图片大小不能超过 10MB!')
        this.fileList.pop()
      } else {
        this.handleConfirm(3, this.fileList[0])
      }
      return isLt10M
    },
    handleExceed4 (files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      this.downform.siteIosImg = ''
      this.fileList2 = []
    },
    handleRemove4 (file, fileList) {
      this.downform.siteIosImg = ''
      this.fileList2 = fileList
    },
    handleChange4 (file, fileList) {
      this.fileList2 = fileList
      const isLt10M = (file.size / 1024 / 1024 < 10)
      if (!isLt10M) {
        this.$message.warning('上传图片大小不能超过 10MB!')
        this.fileList2.pop()
      } else {
        this.handleConfirm(4, this.fileList2[0])
      }
      return isLt10M
    },
    handleExceed5 (files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      this.companyform.certImg1 = ''
      this.fileListimg = []
    },
    handleRemove5 (file, fileList) {
      this.companyform.certImg1 = ''
      this.fileListimg = fileList
    },
    handleChange5 (file, fileList) {
      this.fileListimg = fileList
      const isLt10M = (file.size / 1024 / 1024 < 10)
      if (!isLt10M) {
        this.$message.warning('上传图片大小不能超过 10MB!')
        this.fileListimg.pop()
      } else {
        this.handleConfirm(5, this.fileListimg[0])
      }
      return isLt10M
    },
    handleExceed6 (files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      this.companyform.certImg2 = ''
      this.fileListimg2 = []
    },
    handleRemove6 (file, fileList) {
      this.companyform.certImg2 = ''
      this.fileListimg2 = fileList
    },
    handleChange6 (file, fileList) {
      this.fileListimg2 = fileList
      const isLt10M = (file.size / 1024 / 1024 < 10)
      if (!isLt10M) {
        this.$message.warning('上传图片大小不能超过 10MB!')
        this.fileListimg2.pop()
      } else {
        this.handleConfirm(6, this.fileListimg2[0])
      }
      return isLt10M
    },
    handleExceed7 (files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      this.contactform.regAgress = ''
      this.fileListagress = []
    },
    handleRemove7 (file, fileList) {
      this.contactform.regAgress = ''
      this.fileListagress = fileList
    },
    handleChange7 (file, fileList) {
      this.fileListagress = fileList
      const isLt10M = (file.size / 1024 / 1024 < 10)
      if (!isLt10M) {
        this.$message.warning('上传图片大小不能超过 10MB!')
        this.fileListagress.pop()
      } else {
        this.handleConfirm(7, this.fileListagress[0])
      }
      return isLt10M
    },
    handleExceed8 (files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      this.contactform.tradeAgress = ''
      this.fileListagress2 = []
    },
    handleRemove8 (file, fileList) {
      this.contactform.tradeAgress = ''
      this.fileListagress2 = fileList
    },
    handleChange8 (file, fileList) {
      this.fileListagress2 = fileList
      const isLt10M = (file.size / 1024 / 1024 < 10)
      if (!isLt10M) {
        this.$message.warning('上传图片大小不能超过 10MB!')
        this.fileListagress2.pop()
      } else {
        this.handleConfirm(8, this.fileListagress2[0])
      }
      return isLt10M
    },
    handleConfirm (flag, file) {
      const param = new FormData()
      param.append('upload_file', file.raw)
      const url = this.url + '/admin/upload.do'
      axios(url, {
        headers: {
          'Content-Type': 'multipart/form-data',
          'token': localStorage.getItem('admin-token')
        },
        method: 'POST',
        data: param
      }).then(res => {
        switch (flag) {
          case 1:
            this.logoform.siteLogo = res.data.data.url
            this.fileListlogo = []
            break
          case 2:
            this.logoform.siteLogoSm = res.data.data.url
            this.fileListlogo2 = []
            break
          case 3:
            this.downform.siteAndroidImg = res.data.data.url
            this.fileList = []
            break
          case 4:
            this.downform.siteIosImg = res.data.data.url
            this.fileList2 = []
            break
          case 5:
            this.companyform.certImg1 = res.data.data.url
            this.fileListimg = []
            break
          case 6:
            this.companyform.certImg2 = res.data.data.url
            this.fileListimg2 = []
            break
          case 7:
            this.contactform.regAgress = res.data.data.url
            this.fileListagress = []
            break
          case 8:
            this.fileListagress2 = []
            this.contactform.tradeAgress = res.data.data.url
        }
      }).catch(() => {
        switch (flag) {
          case 1:
            this.logoform.siteLogo = ''
            this.fileListlogo = []
            break
          case 2:
            this.logoform.siteLogoSm = ''
            this.fileListlogo2 = []
            break
          case 3:
            this.downform.siteAndroidImg = ''
            this.fileList = []
            break
          case 4:
            this.downform.siteIosImg = ''
            this.fileList2 = []
            break
          case 5:
            this.companyform.certImg1 = ''
            this.fileListimg = []
            break
          case 6:
            this.companyform.certImg2 = ''
            this.fileListimg2 = []
            break
          case 7:
            this.contactform.regAgress = ''
            this.fileListagress = []
            break
          case 8:
            this.fileListagress2 = []
            this.contactform.tradeAgress = ''
        }
      })
    },
    editorChange1 (val) {
      this.contactform.regAgreeText = val
    },
    editorChange2 (val) {
      this.contactform.tradeAgreeText = val
    },
    handleSuccess (response, file, fileList) {
      this.downform.siteAndroidImg = response.data.url
    },
    async getSettingInfo () {
      let data = await api.getInfo()
      if (data.status === 0) {
        // logo
        this.logoform.siteName = data.data.siteName
        this.logoform.siteKeywords = data.data.siteKeywords
        this.logoform.siteDescription = data.data.siteDescription
        this.logoform.siteLogo = data.data.siteLogo
        this.logoform.siteLogoSm = data.data.siteLogoSm
        // downform
        this.downform.siteAndroidImg = data.data.siteAndroidImg
        this.downform.siteAndroidUrl = data.data.siteAndroidUrl
        this.downform.siteIosImg = data.data.siteIosImg
        this.downform.siteIosUrl = data.data.siteIosUrl
        // contactform
        this.contactform.siteQq = data.data.siteQq
        this.contactform.sitePhone = data.data.sitePhone
        this.contactform.siteEmailFrom = data.data.siteEmailFrom
        this.contactform.siteEmailTo = data.data.siteEmailTo
        this.contactform.siteLanguage = data.data.siteLanguage
        this.contactform.regAgress = data.data.regAgree
        this.contactform.tradeAgress = data.data.tradeAgree
        this.companyform.siteVersionInfo = data.data.siteVersionInfo
        this.contactform.siteHost = data.data.siteHost
        this.contactform.tradeAgreeTitle = data.data.tradeAgreeTitle
        this.contactform.tradeAgreeText = data.data.tradeAgreeText
        this.contactform.regAgreeText = data.data.regAgreeText
        this.contactform.onlineService = data.data.onlineService
        // 公司信息
        this.companyform.companyInfo = data.data.companyInfo
        this.companyform.siteIntro = data.data.siteIntro
        this.companyform.certImg1 = data.data.certImg1
        this.companyform.certImg2 = data.data.certImg2
        this.companyform.riskNotice = data.data.riskNotice
        // 颜色设置
        this.colorform.siteColor = data.data.siteColor
        this.type = 'edit'
        this.id = data.data.id
      } else {
        this.type = 'add'
        this.$message.error('还没有设置信息，请添加')
      }
    },

    // 上传 网站logo设置
    async SettingLogoInfo (formName) {
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            id: this.id,
            siteName: this.logoform.siteName,
            siteKeywords: this.logoform.siteKeywords,
            siteDescription: this.logoform.siteDescription,
            siteLogo: this.logoform.siteLogo,
            siteLogoSm: this.logoform.siteLogoSm
          }
          let data = ''
          if (this.type === 'add') {
            data = await api.addSettingInfo(opts)
          } else {
            data = await api.changeSettingInfo(opts)
          }
          if (data.status === 0) {
            this.getSettingInfo()
            this.$message.success(data.msg)
          } else {
            this.$message.error(data.msg)
          }
        }
      })
    },
    async SettingColorInfo (formName) {
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            id: this.id,
            siteColor: this.colorform.siteColor
          }
          let data = ''
          if (this.type === 'add') {
            data = await api.addSettingInfo(opts)
          } else {
            data = await api.changeSettingInfo(opts)
          }
          if (data.status === 0) {
            // this.getSettingInfo()
            location.reload()
            this.$message.success(data.msg)
          } else {
            location.reload()
            this.$message.error(data.msg)
          }
        }
      })
    },
    // 下载 设置
    async SettingDownInfo (formName) {
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            id: this.id,
            siteAndroidImg: this.downform.siteAndroidImg,
            siteAndroidUrl: this.downform.siteAndroidUrl,
            siteIosImg: this.downform.siteIosImg,
            siteIosUrl: this.downform.siteIosUrl
          }
          let data = ''
          if (this.type === 'add') {
            data = await api.addSettingInfo(opts)
          } else {
            data = await api.changeSettingInfo(opts)
          }
          if (data.status === 0) {
            this.getSettingInfo()
            this.$message.success(data.msg)
          } else {
            this.$message.error(data.msg)
          }
        }
      })
    },
    // 联系及版权信息 设置
    async SettingContactInfo (formName) {
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            id: this.id,
            siteQq: this.contactform.siteQq,
            sitePhone: this.contactform.sitePhone,
            siteEmailFrom: this.contactform.siteEmailFrom,
            siteEmailTo: this.contactform.siteEmailTo,
            siteLanguage: this.contactform.siteLanguage,
            // siteVersionInfo:this.contactform.siteVersionInfo,
            regAgree: this.contactform.regAgress,
            tradeAgree: this.contactform.tradeAgress,
            siteHost: this.contactform.siteHost,
            tradeAgreeTitle: this.contactform.tradeAgreeTitle,
            tradeAgreeText: this.contactform.tradeAgreeText,
            regAgreeText: this.contactform.regAgreeText,
            onlineService: this.contactform.onlineService
          }
          let data = ''
          if (this.type === 'add') {
            data = await api.addSettingInfo(opts)
          } else {
            data = await api.changeSettingInfo(opts)
          }
          if (data.status === 0) {
            this.getSettingInfo()
            this.$message.success(data.msg)
          } else {
            this.$message.error(data.msg)
          }
        }
      })
    },
    // 公司信息
    async SettingcompanyInfo (formName) {
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            id: this.id,
            companyInfo: this.companyform.companyInfo,
            siteIntro: this.companyform.siteIntro,
            certImg1: this.companyform.certImg1,
            certImg2: this.companyform.certImg2,
            riskNotice: this.companyform.riskNotice,
            siteVersionInfo: this.companyform.siteVersionInfo
          }
          let data = ''
          if (this.type === 'add') {
            data = await api.addSettingInfo(opts)
          } else {
            data = await api.changeSettingInfo(opts)
          }
          if (data.status === 0) {
            this.getSettingInfo()
            this.$message.success(data.msg)
          } else {
            this.$message.error(data.msg)
          }
        }
      })
    },
    addAccount () {
      // 添加设置信息
      this.$refs.addSettingDialog.dialogVisible = true
    }
  }
}
</script>
<style lang="less" scoped>

.box-card {
  margin-bottom: 10px;

  .img {
    max-width: 80%;
    background: #eee;
    max-height: 100px;
  }
}
</style>
