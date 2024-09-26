<template>
  <div class="wrapper">
    <el-dialog title="编辑基金" :visible.sync="dialogVisible" width="60%">
      <div>
        <el-form :inline="true" :model="form" ref="ruleForm" size="mini" label-width="100px" :rules="rule">
          <el-form-item label="标题" prop="name">
            <el-input v-model="form.name" placeholder="请输入"></el-input>
          </el-form-item>
          <el-form-item label="发行总份数" prop="totalNum">
            <el-input v-model="form.totalNum" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="每份净值" prop="perValue">
            <el-input v-model="form.perValue" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="每人限购（份）" prop="maxNum">
            <el-input v-model="form.maxNum" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="一期收益率" prop="oneIncome">
            <el-input v-model="form.oneIncome" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="二期收益率" prop="twoIncome">
            <el-input v-model="form.twoIncome" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="三期收益率" prop="threeIncome">
            <el-input v-model="form.threeIncome" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="四期收益率" prop="fourIncome">
            <el-input v-model="form.fourIncome" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="每期天数" prop="blackoutPeriod">
            <el-input v-model="form.blackoutPeriod" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="申购费率" prop="purchaseRates">
            <el-input v-model="form.purchaseRates" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="赎回费率" prop="redemptionRate">
            <el-input v-model="form.redemptionRate" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="直推奖比例" prop="recommendScale">
            <el-input v-model="form.recommendScale" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="基金信息" prop="info" class="remark">
            <quill-editor v-model="form.info" ref="myQuillEditor" :options="editorOption"></quill-editor>
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
import * as api from "@/axios/api"
import {quillEditor} from 'vue-quill-editor'
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'

export default {
  components: {
    // 界面组件引用
    quillEditor
  },
  props: {
    getDate: {
      type: Function,
      default: function () {
      }
    },
    info: {
      type: Object,
      default: function () {
        return {}
      }
    }
  },
  data() {
    return {
      dialogVisible: false,
      form: {
        name: '',
        id: 0,
        totalNum: 0,
        perValue: 0,
        maxNum: 0,
        oneIncome: 0,
        twoIncome: 0,
        threeIncome: 0,
        fourIncome: 0,
        blackoutPeriod: 0,
        purchaseRates: 0,
        redemptionRate: 0,
        recommendScale: 0,
        info: ''
      },
      rule: {
        name: [{required: true, message: '不可为空', trigger: 'blur'}],
        totalNum: [
          {required: true, message: '请输入发行总数', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        perValue: [
          {required: true, message: '请输入每份净值', trigger: 'change'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        maxNum: [
          {required: true, message: '请输入限购值', trigger: 'change'},
          {validator: this.validateNumber, trigger: 'blur'},
          {validator: this.validateCount, trigger: 'blur'},
        ],
        oneIncome: [
          {required: true, message: '请输入收益率', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        twoIncome: [
          {required: true, message: '请输入收益率', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        threeIncome: [
          {required: true, message: '请输入收益率', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        fourIncome: [
          {required: true, message: '请输入收益率', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        blackoutPeriod: [
          {required: true, message: '请输入每期天数', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        purchaseRates: [
          {required: true, message: '请输入费率', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        redemptionRate: [
          {required: true, message: '请输入费率', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        recommendScale: [
          {required: true, message: '请输入直推奖比例', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ]
      },
      editorOption: {
        placeholder: '请输入',
        theme: 'snow',
        modules: {
          toolbar: {
            container: [
              ['bold', 'italic', 'underline', 'strike'], // 加粗 斜体 下划线 删除线
              ['blockquote', 'code-block'], // 引用  代码块
              [{header: 1}, {header: 2}], // 1、2 级标题
              [{list: 'ordered'}, {list: 'bullet'}], // 有序、无序列表
              [{script: 'sub'}, {script: 'super'}], // 上标/下标
              [{indent: '-1'}, {indent: '+1'}], // 缩进
              [{size: ['12', '14', '16', '18', '20', '22', '24', '28', '32', '36']}], // 字体大小
              [{header: [1, 2, 3, 4, 5, 6]}], // 标题
              [{color: []}, {background: []}], // 字体颜色、字体背景颜色
              [{align: []}], // 对齐方式
              ['clean'] // 清除文本格式
            ]
          }
        }
      }
    }
  },
  watch: {
    info(val) {
      if (val) {
        this.form.name = this.info.name
        this.form.id = this.info.id
        this.form.totalNum = this.info.totalNum
        this.form.perValue = this.info.perValue
        this.form.maxNum = this.info.maxNum
        this.form.oneIncome = this.info.oneIncome
        this.form.twoIncome = this.info.twoIncome
        this.form.threeIncome = this.info.threeIncome
        this.form.fourIncome = this.info.fourIncome
        this.form.blackoutPeriod = this.info.blackoutPeriod
        this.form.purchaseRates = this.info.purchaseRates
        this.form.redemptionRate = this.info.redemptionRate
        this.form.recommendScale = this.info.recommendScale
        this.form.info = this.info.info
        this.form.addUserId = this.$store.state.userInfo.id
      }
    }
  },
  methods: {
    validateNumber(rule, value, callback) {
      if (!value) {
        return callback(new Error('输入不能为空'))
      }
      if (value <= 0) {
        return callback(new Error('输入值需大于零'))
      }
      callback()
    },
    validateCount(rule, value, callback) {
      if (value > this.form.totalNum) {
        return callback(new Error('限购值不能大于发行值'))
      }
      callback()
    },
    submit(formName) {
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            name: this.form.name,
            id: this.form.id,
            totalNum: this.form.totalNum,
            perValue: this.form.perValue,
            maxNum: this.form.maxNum,
            oneIncome: this.form.oneIncome,
            twoIncome: this.form.twoIncome,
            threeIncome: this.form.threeIncome,
            fourIncome: this.form.fourIncome,
            blackoutPeriod: this.form.blackoutPeriod,
            purchaseRates: this.form.purchaseRates,
            redemptionRate: this.form.redemptionRate,
            recommendScale: this.form.recommendScale,
            info: this.form.info,
            addUserId: this.$store.state.userInfo.id
          }
          let data = await api.editFund(opts)
          if (data.status === 0) {
            this.$message.success('编辑成功')
            this.clearForm()
            this.getDate()
          } else {
            this.$message.error(data.msg)
          }
          this.dialogVisible = false
        } else {
          return false
        }
      })
    },
    clearForm() {
      this.form = {
        name: '',
        id: 0,
        totalNum: 0,
        perValue: 0,
        maxNum: 0,
        oneIncome: 0,
        twoIncome: 0,
        threeIncome: 0,
        fourIncome: 0,
        blackoutPeriod: 0,
        purchaseRates: 0,
        redemptionRate: 0,
        recommendScale: 0,
        info: '',
        addUserId: 0
      }
    }
  }
}
</script>
<style lang="less" scoped>
/deep/ .remark {
  display: flex;

  .el-form-item__label {
    flex-shrink: 0;
  }

  .quill-editor {
    .ql-container {
      height: 300px;

      .ql-editor {
        height: 100%;
      }
    }
  }
}
</style>
