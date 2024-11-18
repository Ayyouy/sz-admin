<template>
  <div class="wrapper">
    <el-dialog
      :title="`${isEdit ? '审核' : '详情'}`"
      :visible.sync="dialogVisible"
      width="50%">
      <div>
        <el-form
          :inline="true"
          :model="form"
          label-width="75px"
          class="demo-form-inline">
          <el-form-item label="订单编号">
            <el-input disabled :value="detail.orderSn"></el-input>
          </el-form-item>
          <el-form-item label="用户名">
            <el-input disabled :value="detail.nickName"></el-input>
          </el-form-item>
          <el-form-item label="充值渠道">
            <el-input v-if="detail.payChannel == '0'" disabled value="支付宝"></el-input>
            <el-input v-else-if="detail.payChannel == '1'" disabled value="银行转账"></el-input>
            <el-input v-else-if="detail.payChannel == '2'" disabled value="虚拟货币"></el-input>
          </el-form-item>
          <el-form-item label="货币">
            <el-input disabled :value="detail.currency"></el-input>
          </el-form-item>
          <el-form-item label="充值金额">
            <el-input disabled :value="detail.symbol + '' + detail.payAmt"></el-input>
          </el-form-item>
          <el-form-item label="汇率" prop="rate">
            <el-input disabled :value="detail.rate"></el-input>
          </el-form-item>
          <el-form-item label="充值金额">
            <el-input disabled :value="'$' + detail.realAmt"></el-input>
          </el-form-item>
          <el-form-item label="审核状态" prop="orderStatus">
            <el-select v-if="isEdit" v-model="form.orderStatus" placeholder="审核状态">
              <el-option label="审核成功" :value="1"></el-option>
              <el-option label="审核失败" :value="2"></el-option>
            </el-select>
            <div class="el-form-item__error" v-if="form.orderStatus==''">
              {{ statusError }}
            </div>
            <el-select v-if="!isEdit" disabled v-model="detail.orderStatus" placeholder="审核状态">
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
              v-model="detail.orderDesc"
              type="textarea"
            ></el-input>
          </el-form-item>
          <el-form-item label="上传凭证">
            <el-image style="width: 90px;height: 90px" class="uploadImage" :src="detail.rechargeImg" fit="cover" @click="imgDialog = true">
              <div slot="placeholder">加载中<span class="dot">...</span></div>
            </el-image>
          </el-form-item>
        </el-form>
      </div>
      <span v-if="isEdit" slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submit()">确 定</el-button>
      </span>
    </el-dialog>
    <el-dialog
      title="预览"
      :visible.sync="imgDialog"
      fullscreen>
      <el-image
        class="uploadImage"
        :src="detail.rechargeImg"
        fit="contain"
        style="width: 100%;height: 80vh">
        <div slot="placeholder">加载中<span class="dot">...</span></div>
      </el-image>
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
      type: Object,
      default: function () {
        return {}
      }
    }
  },
  watch: {
    info (val) {
      this.detail = Object.assign({}, val)
      this.form.orderStatus = ''
      this.form.orderDesc = ''
    }
  },
  data () {
    return {
      dialogVisible: false,
      form: {
        chargeId: '',
        orderStatus: '',
        orderDesc: ''
      },
      statusError: '',
      descError: '',
      isEdit: false,
      detail: {},
      imgDialog: false
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
        chargeId: this.info.id,
        state: this.form.orderStatus,
        orderDesc: this.form.orderDesc
      }
      let data = await api.updateState(opts)
      if (data.status === 0) {
        this.$message.success('操作成功')
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
/deep/ .uploadImage {
  width: 50px;
  height: 50px;

  > img {
    width: 100%;
    height: 100%;
  }
}

::v-deep .el-dialog__wrapper {
  z-index: -1 !important; /* 确保弹窗在最上层 */
}
</style>
