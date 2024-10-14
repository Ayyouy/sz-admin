<template>
  <div class="wrapper">
    <el-dialog
      title="修改支付渠道"
      :visible.sync="dialogVisible"
      width="50%">
      <div>
        <el-form :model="form" ref="ruleForm" label-width="80px" :rules="rule" class="demo-form-inline">
          <!-- <el-form-item label="渠道类型" prop="channelType">
              <el-select v-model="form.channelType" placeholder="渠道类型">
                  <el-option label="支付宝" value="0"></el-option>
                  <el-option label="对公转账" value="1"></el-option>
                  <el-option label="微信" value="2"></el-option>
              </el-select>
          </el-form-item> -->
          <el-row>
            <el-col :span="12">
              <el-form-item label="货币" prop="currency">
                <el-input v-model="form.currency" placeholder="货币"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">
              <el-form-item label="简称" prop="code">
                <el-input v-model="form.code" placeholder="简称"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">
              <el-form-item label="符号" prop="symbol">
                <el-input v-model="form.symbol" placeholder="符号"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">
              <el-form-item label="汇率" prop="rate">
                <el-input v-model="form.rate" placeholder="汇率"></el-input>
              </el-form-item>
            </el-col>
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
        id: '',
        code: '',
        rate: '',
        currency: '',
        symbol: '',
      },
      fileList: [],
      rule: {
        channelType: [
          { required: true, message: '请输入渠道类型', trigger: 'blur' }
        ],
      },
      admin: '',
      imgurl: '' // 图片地址
    }
  },
  watch: {
    info (val) {
      this.form.code = val.code
      this.form.rate = val.rate
      this.form.currency = val.currency
      this.form.symbol = val.symbol

    }
  },
  computed: {},
  created () {},
  mounted () {
    this.admin = process.env.API_HOST
    if (this.admin === undefined) {
      this.admin = ''
    }
  },
  methods: {
    handleRemove (file, fileList) {
      this.imgurl = ''
    },
    handlePreview (file) {
    },
    handleExceed (files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
    },
    beforeRemove (file, fileList) {
      return this.$confirm(`确定移除 ${file.name}？`)
    },
    handleSuccess (response, file, fileList) {
      this.imgurl = response.data.url
    },
    submit (formName) {
      // 提交
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          // 支付宝的必须添加图片
          // if(this.form.cType == 0 && !this.imgurl){
          //     this.$message.error('支付宝必须添加图片')
          //     return
          // }
          let opts = {
            id: this.info.id,
            code: this.form.code,
            rate: this.form.rate,
            currency: this.form.currency,
            symbol: this.form.symbol,
          }
          let data = await api.updateexchangeRate(opts)
          if (data.status === 0) {
            this.$message.success('修改成功')
            this.dialogVisible = false
            this.getDate()
          } else {
            this.$message.error(data.msg)
          }
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
    max-width: 150px;
    max-height: 150px;
  }
</style>
