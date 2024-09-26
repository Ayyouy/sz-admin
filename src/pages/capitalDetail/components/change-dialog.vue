<template>
  <div class="wrapper">
    <el-dialog
      :title="`${isEdit ? '修改' : '详情'}`"
      :visible.sync="dialogVisible"
      width="50%"
    >
      <!-- append-to-body -->
      <div>
        <el-form
          :inline="true"
          :model="form"
          ref="ruleForm"
          label-width="80px"
          :rules="rule"
          class="demo-form-inline"
        >
          <el-form-item label="订单编号" prop="orderSn">
            <el-input
              disabled
              :value="detail.orderSn"
              placeholder=""
            ></el-input>
          </el-form-item>
          <el-form-item label="用户名" prop="orderSn">
            <el-input
              disabled
              :value="detail.nickName"
              placeholder=""
            ></el-input>
          </el-form-item>
          <el-form-item label="充值渠道" prop="orderSn">
            <el-input
              v-if="detail.payChannel == 0"
              disabled
              value="支付宝"
              placeholder=""
            ></el-input>
            <el-input
              v-if="detail.payChannel == 1"
              disabled
              value="银行转账"
              placeholder=""
            ></el-input>
            <el-input
              v-if="detail.payChannel == 2"
              disabled
              value="虚拟货币"
              placeholder=""
            ></el-input>
          </el-form-item>
          <el-form-item label="货币" prop="currency">
            <el-input
              disabled
              :value="detail.currency"
              placeholder=""
            ></el-input>
          </el-form-item>
          <el-form-item label="充值金额" prop="">
            <el-input
              disabled
              :value="detail.symbol + '' + detail.payAmt"
              placeholder=""
            ></el-input>
          </el-form-item>
          <el-form-item label="汇率" prop="rate">
            <el-input disabled :value="detail.rate" placeholder=""></el-input>
          </el-form-item>
          <el-form-item label="充值金额" prop="">
            <el-input
              disabled
              :value="'$' + detail.realAmt"
              placeholder=""
            ></el-input>
          </el-form-item>
          <!-- :src="detail.rechargeImg" -->
          <el-form-item label="上传凭证" prop="">
            <el-image
              class="uploadImage"
              :src="detail.rechargeImg"
              fit="cover"
              @click="imgDialog = true"
            >
              <div slot="placeholder">加载中<span class="dot">...</span></div>
            </el-image>
          </el-form-item>
          <el-form-item label="审核状态" prop="orderStatus">
            <el-select
              v-if="!isEdit"
              :disabled="isEdit"
              v-model="form.orderStatus"
              placeholder="审核状态"
            >
              <el-option label="审核成功" :value="1"></el-option>
              <el-option label="审核失败" :value="2"></el-option>
            </el-select>
            <el-select
              v-else
              :disabled="isEdit"
              v-model="detail.orderStatus"
              placeholder="审核状态"
            >
              <el-option label="审核中" :value="0"></el-option>
              <el-option label="审核成功" :value="1"></el-option>
              <el-option label="审核失败" :value="2"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="审核备注" prop="orderDesc">
            <el-input
              v-if="!isEdit"
              :disabled="isEdit"
              v-model="form.orderDesc"
              type="textarea"
              placeholder="审核失败时，需要填写原因"
            ></el-input>
            <el-input
              v-else
              :disabled="isEdit"
              v-model="detail.orderDesc"
              type="textarea"
              placeholder=""
            ></el-input>
          </el-form-item>
        </el-form>
      </div>
      <span v-if="!isEdit" slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submit('ruleForm')">确 定</el-button>
      </span>
    </el-dialog>
    <el-dialog
      title="预览"
      :visible.sync="imgDialog"
      fullscreen
    >
      <el-image
        class="uploadImage"
        :src="detail.rechargeImg"
        fit="contain"
        style="width: 100%;height: 80vh"
      >
        <div slot="placeholder">加载中<span class="dot">...</span></div>
      </el-image>
    </el-dialog>
  </div>
</template>

<script>
import * as api from "@/axios/api";

export default {
  components: {},
  props: {
    getDate: {
      type: Function,
      default: function () {},
    },
    info: {
      type: Object,
      default: function () {
        return {};
      },
    },
  },
  watch: {
    info(newval) {
      this.detail = Object.assign({}, newval);
      this.form.orderStatus = "";
      this.form.orderDesc = "";
    },
  },
  data() {
    return {
      dialogVisible: false,
      form: {
        chargeId: "",
        orderStatus: "",
        orderDesc: "",
      },
      rule: {
        // chargeId: [
        //     { required: true, message: '请输入订单号码', trigger: 'blur' },
        // ],
        orderStatus: [
          { required: true, message: "请选择审核状态", trigger: "change" },
        ],
      },
      url: "https://q1.itc.cn/q_70/images03/20240430/59fe8596e4cb4824a6f27315328a3559.jpeg",
      isEdit: false,
      detail: {},
      imgDialog: false,
    };
  },
  methods: {
    submit(formName) {
      // 提交
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            chargeId: this.info.id,
            state: this.form.orderStatus,
            orderDesc: this.form.orderDesc,
          };
          let data = await api.updateState(opts);
          if (data.status == 0) {
            this.$message.success("修改成功");
            this.getDate();
          } else {
            this.$message.error(data.msg);
          }
          this.dialogVisible = false;
        } else {
          return false;
        }
      });
    },
  },
};
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
