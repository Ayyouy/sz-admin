<template>
  <div class="wrapper">
    <el-dialog
      title="修改代理"
      :visible.sync="dialogVisible"
      width="50%"
      :onclose="closeDialog" :close-on-click-modal="false" :close-on-press-escape="false">
      <div>
        <el-form :inline="false" label-width="80px" :model="form" ref="ruleForm" :rules="rule" class="demo-form-inline">
          <el-form-item label="代理ID" prop="id">
            <el-input disabled v-model="info.id" placeholder="代理ID"></el-input>
          </el-form-item>
          <el-form-item label="代理名" prop="agentName">
            <el-input v-model="form.agentName" placeholder="代理名"></el-input>
          </el-form-item>
          <el-form-item label="代理手机" prop="agentPhone">
            <el-input v-model="form.agentPhone" placeholder="代理手机" type="tel" pattern="[0-9]*">
              <el-select
                v-model="form.select"
                slot="prepend"
                class="select"
                size="mini"
                style="width: 80px">
                <el-option v-for="item in options" :key="item" :label="item" :value="item">{{ item }}</el-option>
              </el-select>
            </el-input>
          </el-form-item>
          <el-form-item label="真实姓名" prop="agentRealName">
            <el-input v-model="form.agentRealName" placeholder="真实姓名"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="agentPwd">
            <el-input v-model="form.agentPwd" placeholder="密码为6~12位数字、字母或符号"
                      pattern="[a-zA-Z0-9]+"></el-input>
          </el-form-item>
          <el-form-item label="代理状态" prop="isLock">
            <el-select v-model="form.isLock" placeholder="代理状态">
              <el-option label="锁定" :value="1"></el-option>
              <el-option label="正常" :value="0"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="杠杆倍数" prop="siteLever">
            <el-input v-model="form.siteLever" placeholder="杠杆倍数，多个用/分割，如:100/50"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <span slot="footer" class="dialog-footer">
            <el-button @click="closeDialog">取 消</el-button>
            <el-button type="primary" @click="submit('ruleForm')">确 定</el-button>
        </span>
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
        return {
          id: ''
        }
      }
    },
    agentList: {
      type: Array,
      default: function () {
      }
    }
  },
  data () {
    return {
      dialogVisible: false,
      options: ['+1', '+852', '+91', '+81', '+86', '+88', '+00', '+99'],
      form: {
        select: '',
        agentName: '',
        agentPwd: '',
        agentPhone: '',
        agentRealName: '',
        isLock: '', // 锁定状态
        siteLever: ''
      },
      rule: {
        agentName: [
          {required: true, message: '请输入代理名称', trigger: 'blur'},
          {min: 2, max: 50, message: '长度在 2 到 50 个字符', trigger: 'blur'}
        ],
        agentPwd: [
          {required: true, message: '请输入密码', trigger: 'blur'},
          {validator: this.validatePwd, trigger: 'blur'}
        ],
        select: [
          {required: true, message: '请选择区号', trigger: 'blur'}
        ],
        agentPhone: [
          {required: true, message: '请输入手机号码', trigger: 'blur'},
          {min: 7, message: '请输入正确的手机号', trigger: 'blur'}
        ],
        agentRealName: [
          {required: true, message: '请输入真实姓名', trigger: 'blur'},
          {min: 2, max: 50, message: '长度在 2 到 50 个字符', trigger: 'blur'}
        ],
        isLock: [
          {required: true, message: '请输入锁定状态', trigger: 'change'}
        ]
      }
    }
  },
  watch: {
    info (val) {
      if (val) {
        this.form.agentName = this.info.agentName
        this.form.agentPwd = this.info.agentPwd
        this.form.agentRealName = this.info.agentRealName
        this.form.isLock = this.info.isLock
        this.form.siteLever = this.info.siteLever
        let selectPhone = String(this.info.agentPhone)
        for (let area in this.options) {
          if (selectPhone.includes(area)) {
            this.form.select = area
            this.form.agentPhone = selectPhone.replace(area, '')
            break
          }
        }
        if (this.form.select.length <= 0) {
          this.form.select = this.options[0]
        }
      }
    }
  },
  methods: {
    closeDialog () {
      this.$refs.ruleForm.clearValidate()
      this.dialogVisible = false
    },
    validatePwd (rule, value, callback) {
      if (value === undefined || value == null || value.length === 0) {
        return callback(new Error('请输入密码'))
      }
      const regex = /^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*]+$)[a-zA-Z\d!@#$%^&*].{6,12}$/
      if (!regex.test(value)) {
        return callback(new Error('密码为6~12位数字、字母或符号'))
      }
      callback()
    },
    submit (formName) {
      // 提交
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          let opts = {
            id: this.info.id,
            parentId: this.info.parentId,
            agentPhone: this.form.select + this.form.agentPhone,
            agentRealName: this.form.agentRealName,
            isLock: this.form.isLock,
            siteLever: this.form.siteLever
          }
          if (this.form.agentPwd) {
            opts.agentPwd = this.form.agentPwd
          }
          let data = await api.updateAgent(opts)
          if (data.status === 0) {
            this.$message.success(data.msg)
            this.getDate()
            this.dialogVisible = false
          } else {
            this.$message.error(data.msg)
          }
        } else {
          return false
        }
      })
    }
  }
}
</script>
<style lang="less" scoped>
</style>
