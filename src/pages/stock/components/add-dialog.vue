<template>
  <div class="wrapper">
    <el-dialog title="添加股票" :visible.sync="dialogVisible" width="50%">
      <div>
        <el-form
          :inline="true"
          :model="form"
          ref="ruleForm"
          size="mini"
          label-width="100px"
          :rules="rule"
        >
          <el-form-item label="国家" prop="countryId">
            <el-select v-model="form.countryId" placeholder="国家">
              <el-option
                v-for="i in countryIdList"
                :key="i.key"
                :label="i.type"
                :value="i.value"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="股票名称" prop="stockName">
            <el-input
              v-model="form.stockName"
              placeholder="股票名称"
            ></el-input>
          </el-form-item>
          <el-form-item label="股票代码" prop="stockCode">
            <el-input
              v-model="form.stockCode"
              placeholder="股票代码"
            ></el-input>
          </el-form-item>
          <!-- <el-form-item label="股票类型" prop="stockType">
            <el-select v-model="form.stockType" placeholder="股票类型">
              <el-option v-for="i in stockTypeList" :key="i.key" :label="i.type" :value="i.value"></el-option>
            </el-select>
          </el-form-item> -->
          <!-- <el-form-item label="科创板股票" prop="stockPlate">
            <el-select v-model="form.stockPlate" placeholder="是否为科创板股票">
              <el-option label="否" value=""></el-option>
              <el-option label="是" value="科创"></el-option>
            </el-select>
          </el-form-item> -->
          <el-form-item label="股票状态" prop="isLock">
            <el-select v-model="form.isLock" placeholder="锁定状态">
              <el-option label="未锁定" value="0"></el-option>
              <el-option label="锁定" value="1"></el-option>
            </el-select>
          </el-form-item>

          <el-form-item label="显示状态" prop="isShow">
            <el-select v-model="form.isShow" placeholder="显示状态">
              <el-option label="显示" value="0"></el-option>
              <el-option label="不显示" value="1"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="锁仓天数" prop="lockTime">
            <el-input
              v-model="form.lockTime"
              placeholder="锁仓天数（日）"
              type="number"
            ></el-input>
          </el-form-item>
          <el-form-item label="折扣率" prop="discount">
            <el-input
              v-model="form.discount"
              placeholder="折扣率"
              type="number"
            ></el-input>
          </el-form-item>
          <el-form-item label="总额度" prop="totalLimit">
            <el-input
              v-model="form.totalLimit"
              placeholder="总额度"
              type="number"
            ></el-input>
          </el-form-item>
          <el-form-item label="说明" prop="remark" class="remark">
            <!-- <el-input v-model="form.remark" placeholder="说明"></el-input> -->
            <quill-editor
              v-model="form.remark"
              ref="myQuillEditor"
              :options="editorOption"
            >
            </quill-editor>
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
import * as api from "@/axios/api";
import { quillEditor } from "vue-quill-editor";
import "quill/dist/quill.core.css";
import "quill/dist/quill.snow.css";
import "quill/dist/quill.bubble.css";

export default {
  components: {
    //界面组件引用
    quillEditor,
  },

  props: {
    getDate: {
      type: Function,
      default: function () {},
    },
  },
  data() {
    return {
      dialogVisible: false,
      countryIdList: [
        { type: "香港", value: "1" },
        { type: "美国", value: "2" },
        { type: "日本", value: "3" },
        { type: "印度", value: "4" },
      ],
      form: {
        stockCode: "",
        stockName: "",
        isLock: "0",
        isShow: "0",
        countryId: "",
        discount: "",
        lockTime: "",
        remark: "",
        totalLimit: "",
      },
      rule: {
        stockName: [
          { required: true, message: "请输入股票名称", trigger: "blur" },
        ],
        // stockPlate: [
        //     { required: true, message: '是否为科创板', trigger: 'change' },
        // ],
        stockCode: [
          { required: true, message: "请输入股票代码", trigger: "blur" },
        ],
        isLock: [{ required: true, message: "是否锁定", trigger: "change" }],
        isShow: [{ required: true, message: "是否显示", trigger: "change" }],
        lockTime: [
          { required: true, message: "请输入锁仓天数", trigger: "blur" },
        ],
        discount: [
          { required: true, message: "请输入折扣率", trigger: "blur" },
        ],
        totalLimit: [
          { required: true, message: "请输入总额度", trigger: "blur" },
        ],
        countryId: [
          { required: true, message: "请选择国家", trigger: "change" },
        ],
      },
      editorOption: {
        placeholder: "请输入",
        theme: "snow",
        modules: {
          toolbar: {
            container: [
              ["bold", "italic", "underline", "strike"], // 加粗 斜体 下划线 删除线
              ["blockquote", "code-block"], // 引用  代码块
              [{ header: 1 }, { header: 2 }], // 1、2 级标题
              [{ list: "ordered" }, { list: "bullet" }], // 有序、无序列表
              [{ script: "sub" }, { script: "super" }], // 上标/下标
              [{ indent: "-1" }, { indent: "+1" }], // 缩进
              // [{ direction: 'rtl' }], // 文本方向
              [
                {
                  size: [
                    "12",
                    "14",
                    "16",
                    "18",
                    "20",
                    "22",
                    "24",
                    "28",
                    "32",
                    "36",
                  ],
                },
              ], // 字体大小
              [{ header: [1, 2, 3, 4, 5, 6] }], // 标题
              [{ color: [] }, { background: [] }], // 字体颜色、字体背景颜色
              // [{ font: ['songti'] }], // 字体种类
              [{ align: [] }], // 对齐方式
              ["clean"], // 清除文本格式
              // ["image"], // 链接、图片，需要视频的可以加上video
            ],
            // handlers: {
            //   //此处是图片上传时候需要使用到的
            //   image: function (value) {
            //     console.log(value);
            //     if (value) {
            //       // 点击图片
            //       document.querySelector("#upload").click();
            //     }
            //   },
            // },
          },
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
        },
      },
    };
  },
  watch: {},
  computed: {},
  created() {},
  mounted() {},
  methods: {
    onEditorChange({ quill, html, text }) {
      console.log("editor change!", quill, html, text);
      this.form.remark = html;
    },

    submit(formName) {
      // 提交
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            stockCode: this.form.stockCode,
            stockName: this.form.stockName,
            isLock: this.form.isLock,
            isShow: this.form.isShow,
            countryId: this.form.countryId,
            discount: (this.form.discount / 100).toFixed(2),
            lockTime: this.form.lockTime * 24 * 60,
            remark: this.form.remark,
            totalLimit: this.form.totalLimit,
          };
          let data = await api.addStock(opts);
          if (data.status === 0) {
            this.$message.success("添加成功");
            this.clearForm();
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
    clearForm() {
      this.form = {
        stockCode: "",
        stockName: "",
        isLock: 0,
        isShow: 0,
        countryId: "",
        discount: "",
        lockTime: "",
        remark: "",
        totalLimit: "",
      };
    },
  },
};
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
