<template>
  <!-- <div class="wrapper"> -->
  <el-dialog
    :title="`${isEdit ? '修改' : '详情'}`"
    :visible.sync="dialogVisible"
    width="50%"
    append-to-body
  >
    <div>
      <el-form
        :inline="true"
        :model="form"
        ref="ruleForm"
        label-width="80px"
        :rules="rule"
        class="demo-form-inline"
      >
        <el-form-item label="姓名">
          <el-input disabled :value="detail.nickName" placeholder=""></el-input>
        </el-form-item>
        <!-- <el-form-item label="归属代理">
          <el-input disabled :value="detail.bb" placeholder=""></el-input>
        </el-form-item> -->
        <el-form-item label="提现金额" prop="">
          <el-input
            disabled
            :value="detail.symbol + '' + detail.withAmt"
            placeholder=""
          ></el-input>
        </el-form-item>
        <el-form-item label="汇率" prop="">
          <el-input disabled :value="detail.rate" placeholder=""></el-input>
        </el-form-item>
        <el-form-item label="提现金额" prop="">
          <el-input
            disabled
            :value="'$'+detail.realAmt"
            placeholder=""
          ></el-input>
        </el-form-item>
        <el-form-item label="出金货币" prop="">
          <el-input disabled :value="detail.currency" placeholder=""></el-input>
        </el-form-item>
        <template v-if="detail.currency === '泰达币' || detail.currency === 'USDT'">
          <el-form-item label="钱包地址" prop="">
            <el-input disabled :value="detail.bankNo" placeholder=""></el-input>
          </el-form-item>
        </template>
        <template v-else>
          <el-form-item label="出金银行" prop="">
            <el-input disabled :value="detail.bankName" placeholder=""></el-input>
          </el-form-item>
          <el-form-item label="出金账号" prop="">
            <el-input disabled :value="detail.bankNo" placeholder=""></el-input>
          </el-form-item>
        </template>
        <el-form-item label="申请时间" prop="">
          <el-input disabled :value="detail.applyTime" placeholder=""></el-input>
        </el-form-item>
        <el-form-item label="审核状态" prop="orderStatus">
          <el-select v-if="!isEdit" :disabled="isEdit" v-model="form.orderStatus" placeholder="审核状态">
            <el-option label="审核成功" :value="1"></el-option>
            <el-option label="审核失败" :value="2"></el-option>
          </el-select>
          <el-select v-else :disabled="isEdit" v-model="detail.withStatus" placeholder="审核状态">
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
            v-model="detail.withMsg"
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
  <!-- </div> -->
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
    info(newVal) {
      this.detail = Object.assign({},newVal);
      this.form.orderStatus = '';
      this.form.orderDesc = '';
      var date = new Date(this.detail.applyTime);
      this.detail.applyTime = date.toLocaleString(); // 返回格式化后的日期字符串
    }
  },
  data() {
    return {
      dialogVisible: false,
      form: {
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
      isEdit: false,
      detail: {},
    };
  },
  methods: {
    submit(formName) {
      // 提交
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            withId: this.info.id,
            state: this.form.orderStatus,
            authMsg: this.form.orderDesc,
          };
          let data = await api.withdrawUpdateState(opts);
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
