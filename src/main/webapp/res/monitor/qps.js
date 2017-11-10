// 基于准备好的dom，初始化实例
var QPSChart = echarts.init(document.getElementById('qps'), 'macarons');
var QPSData = {
    time: ["2017-07-12", "2017-07-13", "2017-07-14", "2017-07-15", "2017-07-16", "2017-07-17", "2017-07-18"],
    maxQPS: [16, 28, 60, 70, 56, 4, 25],
    avgQPS: [48, 130, 192, 151, 72, 56, 191],
};
// 指定图表的配置项和数据
var QPSOption = {
    title: {
        text: '',
        subtext: ''
    },
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        data: ['最大QPS', '平均QPS']
    },
    toolbox: {
        show: false,
        feature: {
            magicType: {show: true, type: ['stack', 'tiled']},
            saveAsImage: {show: true}
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: QPSData.time
    },
    yAxis: {},
    grid: [{
        left: 'left',
        top: 'top',
        right: '10',
        bottom: 30
    }],
    series: [
        {
            name: '最大QPS',
            type: 'line',
            smooth: true,
            areaStyle: {
                normal: {}
            },
            lineStyle: {
                normal: {
                    width: 1.5
                }
            },
            data: QPSData.maxQPS
        },
        {
            name: '平均QPS',
            type: 'line',
            smooth: true,
            areaStyle: {
                normal: {}
            },
            lineStyle: {
                normal: {
                    width: 1.5
                }
            },
            data: QPSData.avgQPS
        }
    ]
};

// 使用刚指定的配置项和数据显示图表。
QPSChart.setOption(QPSOption);

//动态添加数据，可以通过Ajax获取数据然后填充
setInterval(function () {
    QPSData.time.push((new Date()).toLocaleTimeString().replace(/^\D*/, ''));
    QPSData.maxQPS.push(Math.floor(Math.random() * 200) + 20);
    QPSData.avgQPS.push(Math.floor(Math.random() * 100) + 20);

    //按自己需求可以取消这个限制
    if (QPSData.time.length >= 20) {
        //移除最开始的一条数据
        QPSData.time.shift();
        QPSData.maxQPS.shift();
        QPSData.avgQPS.shift();
    }
    QPSChart.setOption({
        xAxis: {
            data: QPSData.time
        },
        series: [
            {
                name: '最大QPS',
                data: QPSData.maxQPS
            },
            {
                name: '平均QPS',
                data: QPSData.avgQPS
            }
        ]
    });
}, 1000);
$(window).resize(function () {
    QPSChart.resize();
});