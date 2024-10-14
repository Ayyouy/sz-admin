<template>
  <div class="wrapper">
    <el-dialog
      title="修改支付渠道"
      :visible.sync="dialogVisible"
      width="50%">
      <div>
        <el-form :model="form" ref="ruleForm" label-width="80px" :rules="rule" class="demo-form-inline">
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
        symbol: ''
      },
      fileList: [],
      rule: {
        channelType: [
          { required: true, message: '请输入渠道类型', trigger: 'blur' }
        ]
      }
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
  methods: {
    // handleExceed (files, fileList) {
    //   this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
    // },
    // beforeRemove (file, fileList) {
    //   return this.$confirm(`确定移除 ${file.name}？`)
    // },
    // handleSuccess (response, file, fileList) {
    //   this.imgurl = response.data.url
    // },
    submit (formName) {
      // 提交
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            id: this.info.id,
            code: this.form.code,
            rate: this.form.rate,
            currency: this.form.currency,
            symbol: this.form.symbol
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
