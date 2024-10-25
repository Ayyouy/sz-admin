<template>
  <div class="wrapper">
    <el-dialog title="添加基金" :visible.sync="dialogVisible" width="50%">
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
            <el-input v-model="form.purchaseRates" :value="form.purchaseRates" placeholder="请输入"
                      type="number"></el-input>
          </el-form-item>
          <el-form-item label="赎回费率" prop="redemptionRate">
            <el-input v-model="form.redemptionRate" :value="form.redemptionRate" placeholder="请输入"
                      type="number"></el-input>
          </el-form-item>
          <el-form-item label="直推奖比例" prop="recommendScale">
            <el-input v-model="form.recommendScale" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="年化收益" prop="annualizedReturn">
            <el-input v-model="form.annualizedReturn" placeholder="请输入" type="number"></el-input>
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
import * as api from '@/axios/api'
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
    }
  },
  data () {
    return {
      dialogVisible: false,
      form: {
        name: '',
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
        annualizedReturn: 0,
        info: ''
      },
      rule: {
        annualizedReturn: [
          {required: true, message: '请输入年华收益', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        recommendScale: [
          {required: true, message: '请输入直推奖比例', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        redemptionRate: [
          {required: true, message: '请输入费率', trigger: 'blur'},
          {validator: this.validateNumberZero, trigger: 'blur'}
        ],
        purchaseRates: [
          {required: true, message: '请输入费率', trigger: 'blur'},
          {validator: this.validateNumberZero, trigger: 'blur'}
        ],
        blackoutPeriod: [
          {required: true, message: '请输入每期天数', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        fourIncome: [
          {required: true, message: '请输入收益率', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        threeIncome: [
          {required: true, message: '请输入收益率', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        twoIncome: [
          {required: true, message: '请输入收益率', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        oneIncome: [
          {required: true, message: '请输入收益率', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        maxNum: [
          {required: true, message: '请输入限购值', trigger: 'change'},
          {validator: this.validateNumber, trigger: 'blur'},
          {validator: this.validateCount, trigger: 'blur'}
        ],
        perValue: [
          {required: true, message: '请输入每份净值', trigger: 'change'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        totalNum: [
          {required: true, message: '请输入发行总数', trigger: 'blur'},
          {validator: this.validateNumber, trigger: 'blur'}
        ],
        name: [
          {required: true, message: '不可为空', trigger: 'blur'}
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
              // [{ direction: 'rtl' }], // 文本方向
              [{size: ['12', '14', '16', '18', '20', '22', '24', '28', '32', '36']}], // 字体大小
              [{header: [1, 2, 3, 4, 5, 6]}], // 标题
              [{color: []}, {background: []}], // 字体颜色、字体背景颜色
              // [{ font: ['songti'] }], // 字体种类
              [{align: []}], // 对齐方式
              ['clean'] // 清除文本格式
              // ["image"], // 链接、图片，需要视频的可以加上video
            ]
            // handlers: {
            //   //此处是图片上传时候需要使用到的
            //   image: function (value) {
            //     if (value) {
            //       // 点击图片
            //       document.querySelector("#upload").click();
            //     }
            //   },
            // },
          }
          // imageDrop: true, // 图片拖拽
          // imageResize: {
          //   // 图片放大缩小
          //   displayStyles: {
          //     backgroundColor: "black",
          //     border: "none",
          //     color: "white",
          //   },
          //   modules: ["Resize", "DisplaySize", "Toolbar"],
          // },
        }
      }
    }
  },
  methods: {
    validateNumberZero (rule, value, callback) {
      if (value < 0) {
        return callback(new Error('输入值需大于等于零'))
      }
      callback()
    },
    validateNumber (rule, value, callback) {
      if (value <= 0) {
        return callback(new Error('输入值需大于零'))
      }
      callback()
    },
    validateCount (rule, value, callback) {
      if (value > this.form.totalNum) {
        return callback(new Error('限购值不能大于发行值'))
      }
      callback()
    },
    submit (formName) {
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            name: this.form.name,
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
            annualizedReturn: this.form.annualizedReturn,
            info: this.form.info,
            addUserId: this.$store.state.userInfo.id
          }
          let data = await api.addFund(opts)
          if (data.status === 0) {
            this.$message.success('添加成功')
            this.clearForm()
            this.getDate()
          } else {
            this.$message.error(data.msg)
          }
          this.$refs.ruleForm.clearValidate()
          this.dialogVisible = false
        } else {
          return false
        }
      })
    },
    clearForm () {
      this.form = {
        name: '',
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
        annualizedReturn: 0,
        info: ''
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
