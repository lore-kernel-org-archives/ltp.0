From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 25 Jan 2021 11:44:45 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls: Take use of TST_EXP_PASS_SILENT
In-Reply-To: <YArXjchkIvhgjsg3@yuki.lan>
References: <20210112020227.11775-1-yangx.jy@cn.fujitsu.com>
 <20210112020227.11775-3-yangx.jy@cn.fujitsu.com> <YAgHUvIge6svN0gu@yuki.lan>
 <6008E512.50704@cn.fujitsu.com> <YArXjchkIvhgjsg3@yuki.lan>
Message-ID: <600E3EAD.3020406@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/1/22 21:47, Cyril Hrubis wrote:
> Hi!
>> BTW, I just want to avoid many TPASS for a subtest.
> Why? The capget01 clearly does two different tests per iteration.
>
> There is absolutely no correlation between the number of TPASS test
> produces and the number of iteration test does.
Hi Cyril,

I pushed the patchset without capget01 for now.  But I think
there is a whole test per iteration, like three steps:
1) Drop CAP_NET_RAW.
2) Get effective by specifying kernel revision.
3) Check that the effective doesn't include CAP_NET_RAW.
Is it necessary for per steps to report TPASS? :-)

Best Regards,
Xiao Yang


