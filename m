From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 4 Aug 2017 09:00:57 +0800
Subject: [LTP] [PATCH] cve/cve-2017-2671.c: check if socket() supports
 IPPROTO_ICMP
In-Reply-To: <20170803155229.GD15519@rei>
References: <1501751564-8002-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170803155229.GD15519@rei>
Message-ID: <5983C749.9020004@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/08/03 23:52, Cyril Hrubis wrote:
> Hi!
>> socket() does not support IPPROTO_ICMP, and the ping_group_range file
>> does not exist in older kernels(e.g. RHEL5.11GA).  these supports are
>> introduced by:
>> 'c319b4d("net: ipv4: add IPPROTO_ICMP socket kind")'
> Hm, the question is if there is a system that supports IPPROTO_ICMP
> and where the ping_group_range file is missing. Does that even happen?
>
> If not we should simplify this by exitting (tst_brk()) with TCONF if the
> ping_group_range is missing instead of doing that later on
> EPROTONOSUPPORT.
>
Hi Cyril,

Thanks for your comments.  I think there is not  a system that supports 
IPPROTO_ICMP
and where the ping_group_range file is missing.  I will  simplify it as 
you suggested.

Thanks,
Xiao Yang.


