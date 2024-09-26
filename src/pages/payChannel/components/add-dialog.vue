<template>
  <div class="wrapper">
    <el-dialog title="添加支付渠道" :visible.sync="dialogVisible" width="50%">
      <div>
        <el-form
          :model="form"
          ref="ruleForm"
          label-width="80px"
          :rules="rule"
          class="demo-form-inline"
        >
          <!-- <el-form-item label="渠道类型" prop="channelType">
              <el-select v-model="form.channelType" placeholder="渠道类型">
                  <el-option label="支付宝" value="0"></el-option>
                  <el-option label="对公转账" value="1"></el-option>
                  <el-option label="微信" value="2"></el-option>
              </el-select>
          </el-form-item> -->
          <!-- <el-alert
              title="默认企业支付宝转账的渠道类型为0,的渠道类型为1,其他类型请自定义"
              type="success"
              :closable="false">
          </el-alert> -->
          <el-row>
            <el-col :span="12">
              <el-form-item label="通道名称" prop="channelType">
                <el-input
                  v-model="form.channelType"
                  placeholder="请输入通道名称，如：支付宝"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="通道类型" prop="cType">
                <el-select v-model="form.cType" placeholder="通道类型">
                  <el-option label="支付宝" value="0"></el-option>
                  <el-option label="银行转账" value="1"></el-option>
                  <el-option label="虚拟货币" value="2"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">
              <el-form-item label="货币" prop="countryId">
                <el-select v-model="form.countryId" placeholder="货币">
                  <el-option label="港币" value="1"></el-option>
                  <el-option label="美元" value="2"></el-option>
                  <el-option label="日元" value="3"></el-option>
                  <el-option label="卢比" value="4"></el-option>
                  <el-option label="USDT" value="5"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">
              <el-form-item label="最小充值" prop="channelMinLimit">
                <el-input
                  v-model="form.channelMinLimit"
                  placeholder="最小充值金额"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="最大充值" prop="channelMaxLimit">
                <el-input
                  v-model="form.channelMaxLimit"
                  placeholder="最大充值金额"
                ></el-input>
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
            <el-col :span="12">
              <el-form-item label="是否可用" prop="isLock">
                <el-select v-model="form.isLock" placeholder="是否显示">
                  <el-option label="可用" value="0"></el-option>
                  <el-option label="不可用" value="1"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-form-item label="收款名称" prop="channelName">
            <el-input
              v-model="form.channelName"
              placeholder="请输入收款名称，如：**公司"
            ></el-input>
          </el-form-item>
          <el-form-item label="收款账号" prop="channelAccount">
            <el-input
              v-model="form.channelAccount"
              placeholder="请输入收款账号"
            ></el-input>
          </el-form-item>
          <el-form-item label="收款银行" prop="channelDesc">
            <el-input
              v-model="form.channelDesc"
              placeholder="请输入收款银行"
            ></el-input>
          </el-form-item>
          <el-form-item label="支付接口" prop="formUrl">
            <el-input
              v-if="form.cType == 0 || form.cType == 1"
              disabled
              placeholder="/user/recharge/inMoney.do"
            ></el-input>
            <el-input
              v-else
              v-model="form.formUrl"
              placeholder="支付提交的接口地址"
            ></el-input>
          </el-form-item>
          <el-form-item v-show="form.cType == 2" label="代码" prop="code">
            <el-input v-model="form.code" placeholder="代码"></el-input>
          </el-form-item>
          <el-row>
            <!-- <el-alert
                title="如果通道名是支付宝，必须上传收款二维码"
                type="error"
                :closable="false">
            </el-alert> -->
          </el-row>

          <el-row>
            <el-upload
              :with-credentials="true"
              class="upload-demo"
              :action="admin + '/admin/upload.do'"
              :on-preview="handlePreview"
              :on-remove="handleRemove"
              :on-success="handleSuccess"
              :before-remove="beforeRemove"
              multiple
              :limit="1"
              name="upload_file"
              :on-exceed="handleExceed"
              :file-list="fileList"
            >
              <el-button size="small" type="primary">上传收款二维码</el-button>
            </el-upload>
          </el-row>
          <el-row style="margin-top: 24px;">
            <el-upload
              :with-credentials="true"
              class="upload-demo"
              :action="admin + '/admin/upload.do'"
              :on-preview="handlePreview"
              :on-remove="handleRemoveIcon"
              :on-success="handleSuccessIcon"
              :before-remove="beforeRemove"
              multiple
              :limit="1"
              name="upload_file"
              :on-exceed="handleExceed"
              :file-list="iconFileList"
            >
              <el-button size="small" type="primary">上传icon图标</el-button>
            </el-upload>
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
import * as api from "@/axios/api";
import * as APIUrl from "@/axios/api.url";

export default {
  components: {},
  props: {
    getDate: {
      type: Function,
      default: function () {},
    },
    info: {
      type: Number,
    },
  },
  data() {
    return {
      dialogVisible: false,
      form: {
        cType: "0",
        code: "",
        formUrl: "",
        channelType: "",
        channelName: "",
        channelDesc: "",
        channelAccount: "",
        channelMinLimit: "",
        channelMaxLimit: "",
        isShow: "0",
        isLock: "0",
        countryId: "",
      },
      fileList: [],
      iconFileList: [],
      rule: {
        countryId: [{ required: true, message: "请选择货币", trigger: "blur" }],
        channelType: [
          { required: true, message: "请输入渠道名称", trigger: "blur" },
        ],
        channelName: [
          { required: true, message: "请输入收款名称", trigger: "blur" },
        ],
        channelDesc: [
          { required: true, message: "请输入收款银行", trigger: "blur" },
        ],
        channelAccount: [
          { required: true, message: "请输入收款账户", trigger: "blur" },
        ],
        channelMinLimit: [
          { required: true, message: "请输入最小充值金额", trigger: "blur" },
        ],
        channelMaxLimit: [
          { required: true, message: "请输入最大充值金额", trigger: "blur" },
        ],
        cType: [
          { required: true, message: "请选择通道类型", trigger: "change" },
        ],
        isShow: [
          { required: true, message: "请选择显示状态", trigger: "change" },
        ],
        isLock: [
          { required: true, message: "请选择可用状态", trigger: "change" },
        ],
      },
      admin: "",
      imgurl: "", // 图片地址
      iconurl: "",
    };
  },
  watch: {},
  computed: {},
  created() {},
  mounted() {
    this.admin = process.env.API_HOST;
    if (this.admin === undefined) {
      this.admin = "";
    }
  },
  methods: {
    handleRemove(file, fileList) {
      console.log(file, fileList);
      this.fileList = []
      this.imgurl = ''
    },
    handleRemoveIcon(file, fileList) {
      console.log(file, fileList);
      this.iconFileList = []
      this.iconUrl = ''
    },
    handlePreview(file) {
      console.log(file);
    },
    handleExceed(files, fileList) {
      this.$message.warning(
        `当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${
          files.length + fileList.length
        } 个文件`
      );
    },
    beforeRemove(file, fileList) {
      return this.$confirm(`确定移除 ${file.name}？`);
    },
    handleSuccess(response, file, fileList) {
      console.log(response, "response");
      this.imgurl = response.data.url;
    },
    handleSuccessIcon(response, file, fileList) {
      console.log(response.data, "response");
      this.iconurl = response.data.url;
    },
    submit(formName) {
      // 提交
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            channelType: this.form.channelType,
            channelName: this.form.channelName,
            channelDesc: this.form.channelDesc,
            channelAccount: this.form.channelAccount,
            channelMinLimit: this.form.channelMinLimit,
            channelMaxLimit: this.form.channelMaxLimit,
            isShow: this.form.isShow,
            isLock: this.form.isLock,
            channelImg: this.imgurl,
            cType: this.form.cType,
            code: this.form.code,
            formUrl: this.form.formUrl,
            countryId: this.form.countryId,
            iconUrl: this.iconurl,
          };
          let data = await api.addPayChannel(opts);
          if (data.status === 0) {
            this.$message.success(data.msg);
            this.getDate();
            this.clearForm();
            this.dialogVisible = false;
          } else {
            this.$message.error(data.msg);
          }
        } else {
          return false;
        }
      });
    },
    clearForm() {
      this.form = {
        channelType: "",
        channelName: "",
        channelDesc: "",
        channelAccount: "",
        channelMinLimit: "",
        channelMaxLimit: "",
        isShow: "",
        isLock: "",
      };
    },
  },
};
</script>
<style lang="less" scoped>
.img {
  max-width: 150px;
  max-height: 150px;
}
</style>
