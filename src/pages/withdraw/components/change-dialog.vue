<template>
  <!-- <div class="wrapper"> -->
  <el-dialog
    :title="`${isEdit ? '审核' : '详情'}`"
    :visible.sync="dialogVisible"
    width="50%"
    append-to-body>
    <div>
      <el-form
        :inline="true"
        :model="form"
        label-width="80px"
        class="demo-form-inline">
        <el-form-item label="姓名">
          <el-input disabled :value="detail.nickName"></el-input>
        </el-form-item>
        <el-form-item label="提现金额">
          <el-input disabled :value="detail.symbol + '' + detail.withAmt"></el-input>
        </el-form-item>
        <el-form-item label="汇率">
          <el-input disabled :value="detail.rate"></el-input>
        </el-form-item>
        <el-form-item label="提现金额">
          <el-input disabled :value="'$'+detail.realAmt"></el-input>
        </el-form-item>
        <el-form-item label="出金货币">
          <el-input disabled :value="detail.currency"></el-input>
        </el-form-item>
        <template v-if="detail.currency === '泰达币' || detail.currency === 'USDT'">
          <el-form-item label="钱包地址">
            <el-input disabled :value="detail.bankNo"></el-input>
          </el-form-item>
        </template>
        <template v-else>
          <el-form-item label="出金银行">
            <el-input disabled :value="detail.bankName"></el-input>
          </el-form-item>
          <el-form-item label="出金账号">
            <el-input disabled :value="detail.bankNo"></el-input>
          </el-form-item>
        </template>
        <el-form-item label="申请时间">
          <el-input disabled :value="detail.applyTime"></el-input>
        </el-form-item>
        <el-form-item label="审核状态" prop="orderStatus">
          <el-select v-if="isEdit" v-model="form.orderStatus" placeholder="审核状态">
            <el-option label="审核成功" :value="1"></el-option>
            <el-option label="审核失败" :value="2"></el-option>
          </el-select>
          <div class="el-form-item__error" v-if="form.orderStatus==''">
            {{ statusError }}
          </div>
          <el-select v-if="!isEdit" disabled v-model="detail.withStatus" placeholder="审核状态">
            <el-option label="审核中" :value="0"></el-option>
            <el-option label="审核成功" :value="1"></el-option>
            <el-option label="审核失败" :value="2"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="审核备注" prop="orderDesc">
          <el-input
            v-if="isEdit"
            v-model="form.orderDesc"
            type="textarea"
            placeholder="审核失败时，需要填写原因"
          ></el-input>
          <div class="el-form-item__error" v-if="form.orderStatus==2&&form.orderDesc==''">
            {{ descError }}
          </div>
          <el-input
            v-if="!isEdit"
            disabled
            v-model="detail.withMsg"
            type="textarea"
          ></el-input>
        </el-form-item>
      </el-form>
    </div>
    <span v-if="isEdit" slot="footer" class="dialog-footer">
      <el-button @click="dialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="submit()">确 定</el-button>
    </span>
  </el-dialog>
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
      type: Object,
      default: function () {
        return {}
      }
    }
  },
  watch: {
    info (newVal) {
      this.detail = Object.assign({}, newVal)
      this.form.orderStatus = ''
      this.form.orderDesc = ''
      const date = new Date(this.detail.applyTime)
      this.detail.applyTime = date.toLocaleString() // 返回格式化后的日期字符串
    }
  },
  data () {
    return {
      dialogVisible: false,
      form: {
        orderStatus: '',
        orderDesc: ''
      },
      isEdit: false,
      detail: {},
      statusError: '',
      descError: ''
    }
  },
  methods: {
    async submit () {
      if (this.form.orderStatus === '') {
        this.statusError = '请选择审核状态'
        return false
      }
      if (this.form.orderStatus === 2 && this.form.orderDesc === '') {
        this.descError = '请输入审核失败原因'
        return false
      }
      // 提交
      let opts = {
        withId: this.info.id,
        state: this.form.orderStatus,
        authMsg: this.form.orderDesc
      }
      let data = await api.withdrawUpdateState(opts)
      if (data.status === 0) {
        this.$message.success('操作成功')
        this.getDate()
      } else {
        this.$message.error(data.msg)
      }
      this.dialogVisible = false
      this.statusError = ''
      this.descError = ''
    }
  }
}
</script>
<style lang="less" scoped>
/deep/ .uploadImage {
  width: 50px;
  height: 50px;

  > img {
    width: 100%;
    height: 100%;
  }

  .el-image-viewer__wrapper {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;

    .el-image-viewer__mask {
      position: absolute;
      width: 100%;
      height: 100%;
      top: 0;
      left: 0;
      opacity: 0.5;
      background: #000;
    }
  }
}
</style>
<!-- <style  lang="less">

/deep/ .el-image-viewer__wrapper {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    .el-image-viewer__mask {
      position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    opacity: .5;
    background: #000;
    }
  }
</style> -->
