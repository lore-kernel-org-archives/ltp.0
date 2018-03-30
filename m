From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 30 Mar 2018 20:20:45 +0300
Subject: [LTP] suggest about add tc command test
In-Reply-To: <eac070be-f61b-934b-5db1-0a636e5e306f@cn.fujitsu.com>
References: <eac070be-f61b-934b-5db1-0a636e5e306f@cn.fujitsu.com>
Message-ID: <48cec4fc-3fa8-e727-31f2-8cb2298c7c19@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 03/28/2018 05:34 AM, sunlianwen wrote:
> Hi Alexey
> 
>     I have a suggest about add tc command test for ltp network test. I think
> 
> the tc command is import and widely used. and tc command also can test
> 
> the sched and netfilter module of linux kernel, I know your person's technical
> 
> levelI is very nice. so I hope you can write some tests about tc command to
> 
> enrich ltp network test.
> 

Hi Lianwen,

Thanks for suggestion, do you have some test-cases in mind? You are
welcome to post the patches too :)

In general, I think you could setup something outside LTP, for example,
change qdisc on the test interfaces, etc.

Currently, only dctcp test is using 'tc netem' and I'm currently planning
to add BBR congestion-control algorithm tests there, also using netem
module.

Also, there are tests in Linux kernel:
https://github.com/torvalds/linux/tree/master/tools/testing/selftests/tc-testing

Thanks,
Alexey
