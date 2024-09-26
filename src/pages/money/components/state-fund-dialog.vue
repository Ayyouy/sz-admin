<template>
  <div class="wrapper">
    <el-dialog title="修改状态" :visible.sync="dialogVisible" width="50%">
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submit()">确 定</el-button>
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
      id: 0
    }
  },
  watch: {
    info(val) {
      if (val) {
        this.id = this.info.id
      }
    }
  },
  computed: {},
  methods: {
    async submit() {
      let opts = {
        id: this.id
      }
      let data = await api.stateFund(opts)
      if (data.status === 0) {
        this.$message.success('修改成功')
        this.clearForm()
        this.getDate()
      } else {
        this.$message.error(data.msg)
      }
      this.dialogVisible = false
    },
    clearForm() {
      this.form = {
        fId: 0
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
