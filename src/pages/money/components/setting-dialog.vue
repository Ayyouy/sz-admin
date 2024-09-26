<template>
  <div class="wrapper">
    <el-dialog
      :title="form.frType==0?'团队奖条件修改':'层级奖条件修改'"
      :visible.sync="dialogVisible"
      width="50%">
      <div>
        <el-form :inline="true" :model="form" ref="ruleForm" size="mini" :rules="rule">
          <el-form-item label="条件" prop="name" v-show="form.frType==0">
            <el-input disabled :placeholder="form.frfrCondition"></el-input>
          </el-form-item>
          <el-form-item label="金额" prop="frConditionMax" v-show="form.frType==0">
            <el-input v-model="form.frConditionMax" placeholder="请输入" type="number"></el-input>
          </el-form-item>
          <el-form-item label="比例" prop="frRatio">
            <el-input v-model="form.frRatio" placeholder="请输入" type="number">%</el-input>
          </el-form-item>
        </el-form>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submit()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import * as api from '@/axios/api'

export default {
  components: {},
  props: {
    info: {
      type: Object,
      default: function () {
        return {}
      }
    },
    getDate: {
      type: Function,
      default: function () {
      }
    }
  },
  data() {
    return {
      dialogVisible: false,
      form: {
        frId: '',
        frType: -1, // 0 用户（团队） 1 层级（代理）
        frConditionMin: '',
        frConditionMax: '',
        frRatio: '',
        addUserId: '',
        frfrCondition: ''
      }
    }
  },
  watch: {
    info(val) {
      if (val) {
        this.form.frId = this.info.frId
        this.form.frType = this.info.frType
        this.form.frConditionMin = this.info.frConditionMin
        this.form.frConditionMax = this.info.frConditionMax
        this.form.frRatio = this.info.frRatio
        this.form.addUserId = this.info.addUserId
        this.form.frfrCondition = this.info.frfrCondition
      }
    }
  },
  methods: {
    async submit() {
      if (this.form.frType === 0) {
        if (this.form.frRatio <= 0 || this.form.frConditionMax <= 0) {
          this.$message.error('输入数据不可小于零')
          return false
        }
      } else {
        if (this.form.frRatio <= 0) {
          this.$message.error('输入数据不可小于零')
          return false
        }
      }

      let opts = {
        frId: this.form.frId,
        frType: this.form.frType, // 0 用户（团队） 1 层级（代理）
        frConditionMin: this.form.frConditionMin,
        frConditionMax: this.form.frConditionMax,
        frRatio: this.form.frRatio,
        addUserId: this.form.addUserId
      }
      let data = await api.settingsUpdate(opts)
      if (data.status === 0) {
        this.$message.success('修改成功')
        this.getDate()
      } else {
        this.$message.error(data.msg)
      }
      this.dialogVisible = false
    }
  }
}
</script>
<style lang="less" scoped>
</style>
