From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Sep 2020 14:40:18 +0200
Subject: [LTP] [PATCH] controllers/cpuset_base_ops_testset.sh: Accept
 either 0 or -EINVAL when passing '0-'
In-Reply-To: <5F7479CF.4090007@cn.fujitsu.com>
References: <20200929025606.322543-1-yangx.jy@cn.fujitsu.com>
 <20200930104709.GC6611@yuki.lan> <5F7479CF.4090007@cn.fujitsu.com>
Message-ID: <20200930124018.GF6611@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for your reply. :-)
> 1) I still got '0' value instead of -EINVAL on Centos 6.10(2.6.32-754) 
> so not sure why we have the wrong kernel check before.
>      Perhaps, is there anothe older kernel commit to change the behavior 
> as well?
> 2) I don't think that kernel check is enough because  the change of 
> behavior may be backported into old kernel.
> 
> How about removing the combination directly as Richard suggested on #695.

So what about disabling the test on older kernels completely and expect
EINVAL on 4.3 and newer?

That will still catch regression in mailine kernel but will not fail on
older ones.

-- 
Cyril Hrubis
chrubis@suse.cz
