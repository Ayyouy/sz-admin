<template>
  <div class="wrapper">
    <el-dialog
      title="修改banner"
      :visible.sync="dialogVisible"
      width="50%"
    >
      <div>
        <el-form :model="form" ref="ruleForm" size="mini" label-width="100px" :rules="rule">
          <el-form-item label="图片" prop="bannerUrl">
            <el-upload
              ref="uploadBtn"
              name="upload_file"
              :with-credentials='true'
              action="#"
              multiple
              :limit="1"
              :file-list="fileList"
              :show-file-list="false"
              :auto-upload="false"
              :on-exceed="handleExceed"
              :on-remove="handleRemove"
              :on-change="handleChange"
              :before-remove="beforeRemove"
              class="upload-demo">
              <el-button size="small" type="primary">上传图片</el-button>
            </el-upload>
          </el-form-item>
          <el-row>
            <img class="img" :src="form.bannerUrl" alt="">
            <!-- <el-input v-model="form.targetUrl" placeholder="url"></el-input> -->
          </el-row>
          <el-form-item label="排序" prop="isOrder">
            <el-input v-model="form.isOrder" placeholder="排序值越大越靠前"></el-input>
          </el-form-item>
          <el-form-item label="pc图" prop="isPc">
            <el-switch
              v-model="form.isPc"
              active-color="#13ce66"
              inactive-color="#ddd">
            </el-switch>
            <span v-show="form.isPc">在pc端显示</span>
          </el-form-item>
          <el-form-item label="移动端图" prop="isM">
            <el-switch
              v-model="form.isM"
              active-color="#13ce66"
              inactive-color="#ddd">
            </el-switch>
            <span v-show="form.isM">在移动端显示</span>
          </el-form-item>
          <el-form-item label="标题" prop="banTitle">
            <el-input v-model="form.banTitle" placeholder="标题"></el-input>
          </el-form-item>
          <el-form-item label="描述" prop="banDesc">
            <el-input v-model="form.banDesc" placeholder="描述"></el-input>
          </el-form-item>
          <el-form-item label="链接" prop="targetUrl">
            <el-input v-model="form.targetUrl" placeholder="链接"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <span slot="footer" class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="submit('ruleForm')">确 定</el-button>
        </span>
    </el-dialog>
  </div>
</template>

<script>
import * as api from '@/axios/api'
import APIUrl from '@/axios/api.url'
import axios from 'axios' // 引入api.url.js

export default {
  components: {},
  props: {
    getDate: {
      type: Function,
      default: function () {
      }
    },
    info: {
      type: Object
    }
  },
  data () {
    return {
      dialogVisible: false,
      form: {
        bannerUrl: '',
        isOrder: '',
        isPc: false,
        isM: false,
        banDesc: '',
        banTitle: '',
        targetUrl: ''
      },
      rule: {
        bannerUrl: [
          {required: true, message: '请输入url', trigger: 'blur'}
        ],
        isOrder: [
          {required: true, message: '请输入排序', trigger: 'blur'}
        ]
      },
      url: '',
      fileList: []
    }
  },
  watch: {
    info (val) {
      if (val) {
        this.form.bannerUrl = val.bannerUrl
        this.form.isOrder = val.isOrder
        // 0 为显示 1为不显示
        this.form.isPc = val.isPc === 0 ? true : false
        this.form.isM = val.isM === 0 ? true : false
        this.form.banDesc = val.banDesc
        this.form.banTitle = val.banTitle
        this.form.targetUrl = val.targetUrl
      }
    }
  },
  mounted () {
    this.url = APIUrl.baseURL
  },
  methods: {
    handleRemove (file, fileList) {
      this.form.bannerUrl = ''
      this.fileList = fileList
    },
    handleExceed (files, fileList) {
      this.$refs.uploadBtn.clearFiles()
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      this.fileList = []
      this.form.bannerUrl = ''
    },
    beforeRemove (file, fileList) {
      return this.$confirm(`确定移除 ${file.name}？`)
    },
    handleChange (file, fileList) {
      this.fileList = fileList
      const isLt10M = (file.size / 1024 / 1024 < 10)
      if (!isLt10M) {
        this.$message.warning('上传图片大小不能超过 10MB!')
        this.fileList.pop()
      } else {
        const param = new FormData()
        param.append('upload_file', this.fileList[0].raw)
        const url = this.url + '/admin/upload.do'
        axios(url, {
          headers: {
            'Content-Type': 'multipart/form-data',
            'token': localStorage.getItem('admin-token')
          },
          method: 'POST',
          data: param
        }).then(res => {
          this.form.bannerUrl = res.data.data.url
          this.fileList = []
        }).catch(res => {
          this.$message.error(res.data.msg)
          this.fileList = []
          this.form.bannerUrl = ''
        })
      }
      return isLt10M
    },
    submit (formName) {
      // 提交
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            id: this.info.id,
            bannerUrl: this.form.bannerUrl,
            isOrder: this.form.isOrder,
            isPc: this.form.isPc === true ? '0' : '1',
            isM: this.form.isM === true ? '0' : '1',
            banDesc: this.form.banDesc,
            banTitle: this.form.banTitle,
            targetUrl: this.form.targetUrl
          }
          let data = await api.updateBanner(opts)
          if (data.status === 0) {
            this.$message.success('修改成功')
            this.getDate()
            this.$refs.ruleForm.clearValidate()
          } else {
            this.$message.error(data.msg)
          }
          this.dialogVisible = false
        } else {
          return false
        }
      })
    }
  }
}
</script>
<style lang="less" scoped>
.img {
  max-width: 200px;
  max-height: 120px;
  margin-left: 100px;
}
</style>
