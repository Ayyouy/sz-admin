<template>
  <div>
    <el-dialog
      title="权限设置"
      :visible.sync="dialogVisible"
      width="70%"
    >
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>权限配置</span>
        </div>
        <div class="text item">
          <el-form :inline="true" class="demo-form-inline" size="small" ref="logoForm">
            <div class="title">用户管理<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="1001">
                <el-form-item label="用户列表">
                  <el-switch v-model="P1001"></el-switch>
                  {{ P1001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="1002">
                <el-form-item label="模拟用户">
                  <el-switch v-model="P1002"></el-switch>
                  {{ P1002 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>

            <div class="title">代理管理<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="2001">
                <el-form-item label="代理列表">
                  <el-switch v-model="P2001"></el-switch>
                  {{ P2001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>

            <div class="title">分仓配资<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="3001">
                <el-form-item label="配资设置">
                  <el-switch v-model="P3001"></el-switch>
                  {{ P3001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3002">
                <el-form-item label="待审核配资">
                  <el-switch v-model="P3002"></el-switch>
                  {{ P3002 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3003">
                <el-form-item label="操盘中配资">
                  <el-switch v-model="P3003"></el-switch>
                  {{ P3003 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3004">
                <el-form-item label="未通过配资">
                  <el-switch v-model="P3004"></el-switch>
                  {{ P3004 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3005">
                <el-form-item label="到期配资">
                  <el-switch v-model="P3005"></el-switch>
                  {{ P3005 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3006">
                <el-form-item label="已结束配资">
                  <el-switch v-model="P3006"></el-switch>
                  {{ P3006 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3007">
                <el-form-item label="续期申请">
                  <el-switch v-model="P3007"></el-switch>
                  {{ P3007 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3008">
                <el-form-item label="续期记录">
                  <el-switch v-model="P3008"></el-switch>
                  {{ P3008 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3009">
                <el-form-item label="扩大配资申请">
                  <el-switch v-model="P3009"></el-switch>
                  {{ P3009 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3010">
                <el-form-item label="扩大配资记录">
                  <el-switch v-model="P3010"></el-switch>
                  {{ P3010 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3011">
                <el-form-item label="追加保证金申请">
                  <el-switch v-model="P3011"></el-switch>
                  {{ P3011 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3012">
                <el-form-item label="追加保证金记录">
                  <el-switch v-model="P3012"></el-switch>
                  {{ P3012 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3013">
                <el-form-item label="终止操盘申请">
                  <el-switch v-model="P3013"></el-switch>
                  {{ P3013 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="3014">
                <el-form-item label="终止操盘记录">
                  <el-switch v-model="P3014"></el-switch>
                  {{ P3014 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>

            <div class="title">产品管理<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="4001">
                <el-form-item label="股票产品">
                  <el-switch v-model="P4001"></el-switch>
                  {{ P4001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="4002">
                <el-form-item label="指数产品">
                  <el-switch v-model="P4002"></el-switch>
                  {{ P4002 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="5000">
                <el-form-item label="外盘期货">
                  <el-switch v-model="P5000"></el-switch>
                  {{ P5000 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="5001">
                <el-form-item label="基币管理">
                  <el-switch v-model="P5001"></el-switch>
                  {{ P5001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="5002">
                <el-form-item label="期货产品">
                  <el-switch v-model="P5002"></el-switch>
                  {{ P5002 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>

            <div class="title">持仓管理<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="6001">
                <el-form-item label="融资持仓">
                  <el-switch v-model="P6001"></el-switch>
                  {{ P6001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="6002">
                <el-form-item label="指数持仓">
                  <el-switch v-model="P6002"></el-switch>
                  {{ P6002 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="6003">
                <el-form-item label="期货持仓">
                  <el-switch v-model="P6003"></el-switch>
                  {{ P6003 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="6004">
                <el-form-item label="创建融资持仓">
                  <el-switch v-model="P6004"></el-switch>
                  {{ P6004 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>

            <div class="title">持仓统计<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="7001">
                <el-form-item label="股票持仓统计">
                  <el-switch v-model="P7001"></el-switch>
                  {{ P7001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="7002">
                <el-form-item label="指数持仓统计">
                  <el-switch v-model="P7002"></el-switch>
                  {{ P7002 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="7003">
                <el-form-item label="期货持仓统计">
                  <el-switch v-model="P7003"></el-switch>
                  {{ P7003 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>
            <div class="title">资金管理<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="8001">
                <el-form-item label="充值列表">
                  <el-switch v-model="P8001"></el-switch>
                  {{ P8001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="8002">
                <el-form-item label="提现列表">
                  <el-switch v-model="P8002"></el-switch>
                  {{ P8002 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="8003">
                <el-form-item label="资金记录">
                  <el-switch v-model="P8003"></el-switch>
                  {{ P8003 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>
            <div class="title">日志管理<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="9001">
                <el-form-item label="登录日志">
                  <el-switch v-model="P9001"></el-switch>
                  {{ P9001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="9002">
                <el-form-item label="短信日志">
                  <el-switch v-model="P9002"></el-switch>
                  {{ P9002 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="9003">
                <el-form-item label="定时任务">
                  <el-switch v-model="P9003"></el-switch>
                  {{ P9003 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="9004">
                <el-form-item label="资金互转记录">
                  <el-switch v-model="P9004"></el-switch>
                  {{ P9004 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="9005">
                <el-form-item label="站内消息">
                  <el-switch v-model="P9005"></el-switch>
                  {{ P9005 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>
            <div class="title">管理设置<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="10001">
                <el-form-item label="管理列表">
                  <el-switch v-model="P10001"></el-switch>
                  {{ P10001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>
            <div class="title">风控设置<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="11001">
                <el-form-item label="产品配置">
                  <el-switch v-model="P11001"></el-switch>
                  {{ P11001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="11002">
                <el-form-item label="股票风控">
                  <el-switch v-model="P11002"></el-switch>
                  {{ P11002 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="11003">
                <el-form-item label="指数风控">
                  <el-switch v-model="P11003"></el-switch>
                  {{ P11003 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="11004">
                <el-form-item label="期货风控">
                  <el-switch v-model="P11004"></el-switch>
                  {{ P11004 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="11005">
                <el-form-item label="点差设置">
                  <el-switch v-model="P11005"></el-switch>
                  {{ P11005 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>
            <div class="title">系统基本设置<span class="sub-tit">状态为开启即表示该账号开启这个权限 </span>
            </div>
            <el-row>
              <el-col :span="12001">
                <el-form-item label="系统基本设置">
                  <el-switch v-model="P12001"></el-switch>
                  {{ P12001 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="12002">
                <el-form-item label="公告设置">
                  <el-switch v-model="P12002"></el-switch>
                  {{ P12002 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="12003">
                <el-form-item label="banner设置">
                  <el-switch v-model="P12003"></el-switch>
                  {{ P12003 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
              <el-col :span="12004">
                <el-form-item label="支付渠道设置">
                  <el-switch v-model="P12004"></el-switch>
                  {{ P12004 ? '开启' : '关闭' }}
                </el-form-item>
              </el-col>
            </el-row>
          </el-form>
        </div>
        <el-row class="text-center submit-btn">
          <el-button type="primary" @click="updateProductSetting">保存设置信息</el-button>
        </el-row>
      </el-card>
    </el-dialog>
  </div>
</template>

<script>
import * as api from '@/axios/api'
import DetailDialog from './add-dialog'

export default {
  components: {
    DetailDialog
  },
  props: {
    info: {
      type: Object,
      default: function () {
        return {
          id: ''
        }
      }
    }
  },
  data () {
    return {
      dialogVisible: false,
      P1001: false,
      P1002: false,
      P1003: false,
      P2001: false,
      P3001: false,
      P3002: false,
      P3003: false,
      P3004: false,
      P3005: false,
      P3006: false,
      P3007: false,
      P3008: false,
      P3009: false,
      P3010: false,
      P3011: false,
      P3012: false,
      P3013: false,
      P3014: false,
      P3015: false,
      P3016: false,
      P3017: false,
      P3018: false,
      P4001: false,
      P4002: false,
      P5000: false,
      P5001: false,
      P5002: false,
      P6001: false,
      P6002: false,
      P6003: false,
      P6004: false,
      P7001: false,
      P7002: false,
      P7003: false,
      P8001: false,
      P8002: false,
      P8003: false,
      P9001: false,
      P9002: false,
      P9003: false,
      P9004: false,
      P9005: false,
      P10001: false,
      P11001: false,
      P11002: false,
      P11003: false,
      P11004: false,
      P11005: false,
      P12001: false,
      P12002: false,
      P12003: false,
      P12004: false
    }
  },
  mounted () {
    // this.getProductSetting()
  },
  methods: {
    // async getProductSetting () {
    //   let opts = {
    //     uid: this.info.id
    //   }
    //   let data = await api.getMenu(opts)
    //   if (data.status === 0) {
    //     this.menus = data.data
    //     for (let i = 0; i < this.menus.length; i++) {
    //       const menu = this.menus[i]
    //       if (menu.aid === 1001) {
    //         this.P1001 = menu.selected
    //       }
    //       if (menu.aid === 1002) {
    //         this.P1002 = menu.selected
    //       }
    //       if (menu.aid === 1003) {
    //         this.P1003 = menu.selected
    //       }
    //       if (menu.aid === 2001) {
    //         this.P2001 = menu.selected
    //       }
    //       if (menu.aid === 3001) {
    //         this.P3001 = menu.selected
    //       }
    //       if (menu.aid === 3002) {
    //         this.P3002 = menu.selected
    //       }
    //       if (menu.aid === 3003) {
    //         this.P3003 = menu.selected
    //       }
    //       if (menu.aid === 3004) {
    //         this.P3004 = menu.selected
    //       }
    //       if (menu.aid === 3005) {
    //         this.P3005 = menu.selected
    //       }
    //       if (menu.aid === 3006) {
    //         this.P3006 = menu.selected
    //       }
    //       if (menu.aid === 3007) {
    //         this.P3007 = menu.selected
    //       }
    //       if (menu.aid === 3008) {
    //         this.P3008 = menu.selected
    //       }
    //       if (menu.aid === 3009) {
    //         this.P3009 = menu.selected
    //       }
    //       if (menu.aid === 3010) {
    //         this.P3010 = menu.selected
    //       }
    //       if (menu.aid === 3011) {
    //         this.P3011 = menu.selected
    //       }
    //       if (menu.aid === 3012) {
    //         this.P3012 = menu.selected
    //       }
    //       if (menu.aid === 3013) {
    //         this.P3013 = menu.selected
    //       }
    //       if (menu.aid === 3014) {
    //         this.P3014 = menu.selected
    //       }
    //       if (menu.aid === 3015) {
    //         this.P3015 = menu.selected
    //       }
    //       if (menu.aid === 3016) {
    //         this.P3016 = menu.selected
    //       }
    //       if (menu.aid === 3017) {
    //         this.P3017 = menu.selected
    //       }
    //       if (menu.aid === 3018) {
    //         this.P3018 = menu.selected
    //       }
    //       if (menu.aid === 4001) {
    //         this.P4001 = menu.selected
    //       }
    //       if (menu.aid === 4002) {
    //         this.P4002 = menu.selected
    //       }
    //       if (menu.aid === 5000) {
    //         this.P5000 = menu.selected
    //       }
    //       if (menu.aid === 5001) {
    //         this.P5001 = menu.selected
    //       }
    //       if (menu.aid === 5002) {
    //         this.P5002 = menu.selected
    //       }
    //       if (menu.aid === 6001) {
    //         this.P6001 = menu.selected
    //       }
    //       if (menu.aid === 6002) {
    //         this.P6002 = menu.selected
    //       }
    //       if (menu.aid === 6003) {
    //         this.P6003 = menu.selected
    //       }
    //       if (menu.aid === 6004) {
    //         this.P6004 = menu.selected
    //       }
    //       if (menu.aid === 7001) {
    //         this.P7001 = menu.selected
    //       }
    //       if (menu.aid === 7002) {
    //         this.P7002 = menu.selected
    //       }
    //       if (menu.aid === 7003) {
    //         this.P7003 = menu.selected
    //       }
    //       if (menu.aid === 8001) {
    //         this.P8001 = menu.selected
    //       }
    //       if (menu.aid === 8002) {
    //         this.P8002 = menu.selected
    //       }
    //       if (menu.aid === 8003) {
    //         this.P8003 = menu.selected
    //       }
    //       if (menu.aid === 9001) {
    //         this.P9001 = menu.selected
    //       }
    //       if (menu.aid === 9002) {
    //         this.P9002 = menu.selected
    //       }
    //       if (menu.aid === 9003) {
    //         this.P9003 = menu.selected
    //       }
    //       if (menu.aid === 9004) {
    //         this.P9004 = menu.selected
    //       }
    //       if (menu.aid === 9005) {
    //         this.P9005 = menu.selected
    //       }
    //       if (menu.aid === 10001) {
    //         this.P10001 = menu.selected
    //       }
    //       if (menu.aid === 11001) {
    //         this.P11001 = menu.selected
    //       }
    //       if (menu.aid === 11002) {
    //         this.P11002 = menu.selected
    //       }
    //       if (menu.aid === 11003) {
    //         this.P11003 = menu.selected
    //       }
    //       if (menu.aid === 11004) {
    //         this.P11004 = menu.selected
    //       }
    //       if (menu.aid === 11005) {
    //         this.P11005 = menu.selected
    //       }
    //       if (menu.aid === 12001) {
    //         this.P12001 = menu.selected
    //       }
    //       if (menu.aid === 12002) {
    //         this.P12002 = menu.selected
    //       }
    //       if (menu.aid === 12003) {
    //         this.P12003 = menu.selected
    //       }
    //       if (menu.aid === 12004) {
    //         this.P12004 = menu.selected
    //       }
    //     }
    //     this.$store.state.siteInfo = data.data
    //   } else {
    //     this.$message.error(data.msg)
    //   }
    // },
    async updateProductSetting () {
      let auth = ''
      if (this.P1001) {
        auth = auth + '1001,'
      }
      if (this.P1002) {
        auth = auth + '1002,'
      }
      if (this.P1003) {
        auth = auth + '1003,'
      }
      if (this.P2001) {
        auth = auth + '2001,'
      }
      if (this.P3001) {
        auth = auth + '3001,'
      }
      if (this.P3002) {
        auth = auth + '3002,'
      }
      if (this.P3003) {
        auth = auth + '3003,'
      }
      if (this.P3004) {
        auth = auth + '3004,'
      }
      if (this.P3005) {
        auth = auth + '3005,'
      }
      if (this.P3006) {
        auth = auth + '3006,'
      }
      if (this.P3007) {
        auth = auth + '3007,'
      }
      if (this.P3008) {
        auth = auth + '3008,'
      }
      if (this.P3009) {
        auth = auth + '3009,'
      }
      if (this.P3010) {
        auth = auth + '3010,'
      }
      if (this.P3011) {
        auth = auth + '3011,'
      }
      if (this.P3012) {
        auth = auth + '3012,'
      }
      if (this.P3013) {
        auth = auth + '3013,'
      }
      if (this.P3014) {
        auth = auth + '3014,'
      }
      if (this.P3015) {
        auth = auth + '3015,'
      }
      if (this.P3016) {
        auth = auth + '3016,'
      }
      if (this.P3017) {
        auth = auth + '3017,'
      }
      if (this.P3018) {
        auth = auth + '3018,'
      }

      if (this.P4001) {
        auth = auth + '4001,'
      }
      if (this.P4002) {
        auth = auth + '4002,'
      }
      if (this.P5000) {
        auth = auth + '5000,'
      }
      if (this.P5001) {
        auth = auth + '5001,'
      }
      if (this.P5002) {
        auth = auth + '5002,'
      }
      if (this.P6001) {
        auth = auth + '6001,'
      }
      if (this.P6002) {
        auth = auth + '6002,'
      }
      if (this.P6003) {
        auth = auth + '6003,'
      }
      if (this.P6004) {
        auth = auth + '6004,'
      }
      if (this.P7001) {
        auth = auth + '7001,'
      }
      if (this.P7002) {
        auth = auth + '7002,'
      }
      if (this.P7003) {
        auth = auth + '7003,'
      }
      if (this.P8001) {
        auth = auth + '8001,'
      }
      if (this.P8002) {
        auth = auth + '8002,'
      }
      if (this.P8003) {
        auth = auth + '8003,'
      }
      if (this.P9001) {
        auth = auth + '9001,'
      }
      if (this.P9002) {
        auth = auth + '9002,'
      }
      if (this.P9003) {
        auth = auth + '9003,'
      }
      if (this.P9004) {
        auth = auth + '9004,'
      }
      if (this.P9005) {
        auth = auth + '9005,'
      }
      if (this.P10001) {
        auth = auth + '10001,'
      }
      if (this.P11001) {
        auth = auth + '11001,'
      }
      if (this.P11002) {
        auth = auth + '11002,'
      }
      if (this.P11003) {
        auth = auth + '11003,'
      }
      if (this.P11004) {
        auth = auth + '11004,'
      }
      if (this.P11005) {
        auth = auth + '11005,'
      }
      if (this.P12001) {
        auth = auth + '12001,'
      }
      if (this.P12002) {
        auth = auth + '12002,'
      }
      if (this.P12003) {
        auth = auth + '12003,'
      }
      if (this.P12004) {
        auth = auth + '12004,'
      }
      let opts = {
        aid: auth,
        uid: this.info.id
      }
      let data = await api.addAuth(opts)
      if (data.status === 0) {
        this.$message.success('修改成功')
      } else {
        this.$message.error(data.msg)
      }
    }
  }
}
</script>
<style lang="less" scoped>
.box-card {
  margin-bottom: 10px;

  .img {
    max-width: 80%;
    background: #eee;
    max-height: 100px;
  }
}

.submit-btn {
  margin: 20px 0;

  .el-button {
    width: 200px;
  }
}

.item {
  .title {
    border-bottom: 1px solid #eceff6;
    color: #606266;
    margin: 10px 0;
    text-indent: 1px;
    line-height: 35px;

    span {
      color: #999;
      font-size: 12px;
      margin-left: 10px;
    }

    &:before {
      content: "";
      width: 4px;
      height: 4px;
      background: #606266;
      display: inline-block;
      border-radius: 4px;
      margin-right: 5px;
      vertical-align: middle;
    }
  }
}

.explain {
  line-height: 25px;
}
</style>
