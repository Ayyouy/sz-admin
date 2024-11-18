<template>
  <div>
    <el-form :inline="true" :model="info" class="demo-form-inline" size="small">
      <el-row style="margin-bottom: 20px;margin-left: 4px">
        <el-col :span="24">
          <span style="font-weight: bold;font-size: 18px">时间设置</span>
          <span class="sub-tit">
            填写规则请按照括号中的示例填写，":"统一为英文中的字符，提现时间为24小时制，请填写整数
          </span>
        </el-col>
      </el-row>
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>美国股市</span>
          <span class="sub-tit">请按照括号中的示例填写</span>
        </div>
        <div class="text item">
          <el-row>
            <el-col :span="8">
              <el-form-item label="上午开始交易时间">
                <el-input class="form-input" v-model="info.transAmBegin" placeholder="例：9:30"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="下午结束交易时间">
                <el-input class="form-input" v-model="info.transAmEnd" placeholder="例：15:30"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="休市时间">
                <el-date-picker
                  v-model="info.rangeTime"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  type="datetimerange"
                  range-separator="至"
                  start-placeholder="开始日期"
                  end-placeholder="结束日期">
                </el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>
        </div>
      </el-card>
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>印度股市</span>
          <span class="sub-tit">请按照括号中的示例填写</span>
        </div>
        <div class="text item">
          <el-row>
            <el-col :span="8">
              <el-form-item label="上午开始交易时间">
                <el-input class="form-input" v-model="info.transAmBegin" placeholder="例：9:30"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="下午结束交易时间">
                <el-input class="form-input" v-model="info.transAmEnd" placeholder="例：15:30"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="休市时间">
                <!--                <el-input class="form-input" v-model="info.transPmBegin" placeholder="交易时间"></el-input>-->
                <el-date-picker
                  v-model="info.rangeTime"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  type="datetimerange"
                  range-separator="至"
                  start-placeholder="开始日期"
                  end-placeholder="结束日期">
                </el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>
        </div>
      </el-card>
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>日本股市</span>
          <span class="sub-tit">请按照括号中的示例填写</span>
        </div>
        <div class="text item">
          <el-row>
            <el-col :span="8">
              <el-form-item label="上午开始交易时间">
                <el-input class="form-input" v-model="info.transAmBegin" placeholder="例：9:30"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="上午结束交易时间">
                <el-input class="form-input" v-model="info.transAmEnd" placeholder="例：10:30"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="8">
              <el-form-item label="下午开始交易时间">
                <el-input class="form-input" v-model="info.transPmBegin" placeholder="例：13:30"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="下午结束交易时间">
                <el-input class="form-input" v-model="info.transPmEnd" placeholder="例：15:00"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="休市时间">
                <el-date-picker
                  v-model="info.rangeTime"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  type="datetimerange"
                  range-separator="至"
                  start-placeholder="开始日期"
                  end-placeholder="结束日期">
                </el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>
        </div>
      </el-card>
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>香港股市</span>
          <span class="sub-tit">请按照括号中的示例填写</span>
        </div>
        <div class="text item">
          <el-row>
            <el-col :span="8">
              <el-form-item label="上午开始交易时间">
                <el-input class="form-input" v-model="info.transAmBegin" placeholder="例：9:30"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="上午结束交易时间">
                <el-input class="form-input" v-model="info.transAmEnd" placeholder="例：10:30"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="8">
              <el-form-item label="下午开始交易时间">
                <el-input class="form-input" v-model="info.transPmBegin" placeholder="例：13:30"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="下午结束交易时间">
                <el-input class="form-input" v-model="info.transPmEnd" placeholder="例：15:00"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="休市时间">
                <el-date-picker
                  v-model="info.rangeTime"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  type="datetimerange"
                  range-separator="至"
                  start-placeholder="开始日期"
                  end-placeholder="结束日期">
                </el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>
        </div>
      </el-card>
      <el-row style="margin-bottom: 20px;margin-top: 20px;margin-left: 4px">
        <el-col :span="24">
          <span style="font-weight: bold;font-size: 18px">停盘设置</span>
          <span class="sub-tit">
            请选择对应股票的停盘时间
          </span>
        </el-col>
      </el-row>
      <el-card class="box-card">
        <div class="text item">
          <el-row>
            <el-col :span="12">
              <el-form-item label="美国股市">
                <el-date-picker
                  v-model="info.rangeTime"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  type="datetimerange"
                  range-separator="至"
                  start-placeholder="开始日期"
                  end-placeholder="结束日期">
                </el-date-picker>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="印度股市">
                <el-date-picker
                  v-model="info.rangeTime"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  type="datetimerange"
                  range-separator="至"
                  start-placeholder="开始日期"
                  end-placeholder="结束日期">
                </el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
          <el-col :span="12">
            <el-form-item label="日本股市">
              <el-date-picker
                v-model="info.rangeTime"
                value-format="yyyy-MM-dd HH:mm:ss"
                type="datetimerange"
                range-separator="至"
                start-placeholder="开始日期"
                end-placeholder="结束日期">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="香港股市">
              <el-date-picker
                v-model="info.rangeTime"
                value-format="yyyy-MM-dd HH:mm:ss"
                type="datetimerange"
                range-separator="至"
                start-placeholder="开始日期"
                end-placeholder="结束日期">
              </el-date-picker>
            </el-form-item>
          </el-col>
          </el-row>
        </div>
      </el-card>
      <el-row class="text-center submit-btn">
        <el-button type="primary" @click="SettingInfo">保存设置信息</el-button>
      </el-row>
    </el-form>
  </div>
</template>

<script>
import * as api from '@/axios/api'
// import DetailDialog from './detail-dialog'
export default {
  components: {
    // DetailDialog,
  },
  props: {},
  data () {
    return {
      info: {}
    }
  },
  watch: {},
  computed: {},
  mounted () {
    this.getSettingInfo()
  },
  methods: {
    async getSettingInfo () {
      let data = await api.getSettingInfo()
      if (data.status === 0) {
        this.info = data.data
      } else {
        this.$message.error(data.msg)
      }
    },
    async SettingInfo () {
      // 设置风控
      let opts = {
        id: this.info.id, // id
        buyFee: this.info.buyFee, // 买入手续费
        sellFee: this.info.sellFee, // 卖出手续费
        stayFee: this.info.stayFee, // 留仓费
        dutyFee: this.info.dutyFee, // 印花税
        stayMaxDays: this.info.stayMaxDays, // 最大留仓天数
        buyMinAmt: this.info.buyMinAmt, // 最小购买金额
        chargeMinAmt: this.info.chargeMinAmt, // 最小充值金额
        buyMinNum: this.info.buyMinNum, // 最小购买数量 单位 股
        forceStopFee: this.info.forceStopFee, // 强平手续费
        buyMaxAmtPercent: this.info.buyMaxAmtPercent, // 最大买入比例
        forceStopPercent: this.info.forceStopPercent, // 强平百分比 占用保证金的百分比
        hightAndLow: this.info.hightAndLow, // 涨跌停限制 如果2个涨停 填2
        withMinAmt: this.info.withMinAmt, // 最小提现金额
        creaseMaxPercent: this.info.creaseMaxPercent, // 买入控制 涨跌超过多少点不能买入 默认7个点
        kcCreaseMaxPercent: this.info.kcCreaseMaxPercent, // 买入控制 涨跌超过多少点不能买入 默认7个点科创板
        buyMaxNum: this.info.buyMaxNum, // 最大购买数量
        cantSellTimes: this.info.cantSellTimes, // 最大购买数量
        buySameTimes: this.info.buySameTimes, // 最大购买数量
        buySameNums: this.info.buySameNums, // 最大购买数量
        buyNumTimes: this.info.buyNumTimes, // 最大购买数量
        buyNumLots: this.info.buyNumLots, // 最大购买数量
        stockDays: this.info.stockDays, // 最大购买数量
        stockRate: this.info.stockRate, // 最大购买数量

        withTimeBegin: this.info.withTimeBegin, // 提现开始时间
        withTimeEnd: this.info.withTimeEnd, // 提现结束时间
        transAmBegin: this.info.transAmBegin, // 交易时间 上午开始
        transAmEnd: this.info.transAmEnd, // 交易时间 上午结束
        transPmBegin: this.info.transPmBegin, // 交易时间 下午开始
        transPmEnd: this.info.transPmEnd, // 交易时间 下午结束
        withFeeSingle: this.info.withFeeSingle, // 提现单笔手续费
        withFeePercent: this.info.withFeePercent, // 提现手续费百分比
        siteLever: this.info.siteLever, // 杠杆倍数
        forceStopRemindRatio: this.info.forceStopRemindRatio //强平提醒比例
      }
      let data = await api.riskSetting(opts)
      if (data.status === 0) {
        // this.info = data.data
        this.$message.success(data.msg)
      } else {
        this.$message.error(data.msg)
      }
    }
  }
}
</script>
<style lang="less" scoped>
.table .el-table .warning-row {
  background: rgba(245, 108, 108, .1);
}

.el-card .pro {
  font-size: 14px;
  color: #F44336;
  margin-left: -5px;
  line-height: 30px;
}

.sub-tit {
  font-size: 12px;
  color: #666;
  margin-left: 10px;
}

.form-input {
  width: 80%;
}

.item {
  a {
    color: #333;
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
</style>
