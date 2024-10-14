<template>
  <div class="wrapper">
    <el-dialog
      title="添加公告"
      :visible.sync="dialogVisible"
      width="50%">
      <div>
        <el-form :model="form" ref="ruleForm" label-width="80px" :rules="rule" class="demo-form-inline">
          <el-row>
            <el-col :span="24">
              <el-form-item label="公告标题" prop="artTitle">
                <el-input v-model="form.artTitle" placeholder="公告标题"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">
              <el-form-item label="公告类型" prop="artType">
                <el-input v-model="form.artType" placeholder="公告类型"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="来源" prop="author">
                <el-input v-model="form.author" placeholder="来源"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">
              <el-form-item label="是否显示" prop="isShow">
                <el-select v-model="form.isShow" placeholder="是否显示">
                  <el-option label="显示" value="0"></el-option>
                  <el-option label="不显示" value="1"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-form-item label="公告摘要" prop="artSummary">
            <el-input type="textarea" v-model="form.artSummary" placeholder="公告摘要"></el-input>
          </el-form-item>
          <el-form-item label="公告内容" prop="artCnt">
            <el-input type="textarea" rows="8" v-model="form.artCnt" placeholder="公告内容"></el-input>
          </el-form-item>
          <el-form-item label="公告链接" prop="spiderUrl">
            <el-input type="textarea" v-model="form.spiderUrl" placeholder="公告链接"></el-input>
          </el-form-item>
          <el-form-item label="公告图片" prop="channelAccount">
            <el-upload
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
              <el-button size="small" type="primary">上传公告图片</el-button>
            </el-upload>
          </el-form-item>
          <el-row>
            <img style="height:100px;" :src="imgUrl" alt="">
          </el-row>
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
import * as APIUrl from '@/axios/api.url'
import axios from 'axios'

export default {
  components: {},
  props: {
    getDate: {
      type: Function,
      default: function () {
      }
    },
    info: {
      type: Number
    }
  },
  data () {
    return {
      dialogVisible: false,
      form: {
        artTitle: '',
        artType: '',
        artImg: '',
        author: '',
        hitTimes: '', // 点击次数
        isShow: '',
        addTime: '',
        artSummary: '',
        artCnt: '',
        spiderUrl: ''
      },
      fileList: [],
      rule: {
        artTitle: [
          {required: true, message: '请输入公告名称', trigger: 'blur'},
          {min: 1, max: 100, message: '公告名称最多100个字', trigger: 'blur'}
        ],
        artType: [
          {required: true, message: '请输入公告类型', trigger: 'blur'}
        ],
        author: [
          {required: true, message: '请输入来源', trigger: 'blur'}
        ],
        artSummary: [
          {required: true, message: '请输入摘要', trigger: 'blur'},
          {min: 1, max: 500, message: '公告摘要最多500个字', trigger: 'blur'}
        ],
        artCnt: [
          {required: true, message: '请输入公告内容', trigger: 'blur'},
          {min: 1, max: 3000, message: '公告内容最多3000个字', trigger: 'blur'}
        ],
        isShow: [
          {required: true, message: '请选择显示状态', trigger: 'change'}
        ]
      },
      url: '',
      imgUrl: '' // 图片地址
    }
  },
  mounted () {
    // this.admin = process.env.API_HOST
    // if (this.admin === undefined) {
    //   this.admin = ''
    // }
    this.url = APIUrl.baseURL
  },
  methods: {
    handleRemove (file, fileList) {
      this.imgUrl = ''
      this.fileList = fileList
    },
    handleExceed (files, fileList) {
      // this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
      this.$message.warning('每次最多上传一个文件')
      this.fileList = []
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
          this.imgUrl = res.data.data.url
        })
      }
      return isLt10M
    },
    handleSuccess (response, file, fileList) {
      this.imgUrl = response.data.url
    },
    submit (formName) {
      // 提交
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            artTitle: this.form.artTitle,
            artType: this.form.artType,
            author: this.form.author,
            artSummary: this.form.artSummary,
            artCnt: this.form.artCnt,
            spiderUrl: this.form.spiderUrl,
            isShow: this.form.isShow,
            artImg: this.imgUrl
          }
          let data = await api.addArt(opts)
          if (data.status === 0) {
            this.$message.success(data.msg)
            this.getDate()
            this.clearForm()
            this.dialogVisible = false
          } else {
            this.$message.error(data.msg)
          }
        } else {
          return false
        }
      })
    },
    clearForm () {
      this.form = {
        artTitle: '',
        artType: '',
        artImg: '',
        author: '',
        isShow: '',
        artSummary: '',
        artCnt: '',
        spiderUrl: ''
      }
    }
  }
}
</script>
<style lang="less" scoped>
.img {
  max-width: 150px;
  max-height: 150px;
}
</style>
