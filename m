From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 May 2019 16:37:46 +0200
Subject: [LTP] [PATCH] ltp-cap.m4: add libcap version detection && fix
 compiler error
In-Reply-To: <5CDBD564.8010300@cn.fujitsu.com>
References: <1557732392-7049-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190513131451.GA22761@dell5510> <5CDA5124.3070708@cn.fujitsu.com>
 <20190514120119.GA26452@dell5510> <5CDBD564.8010300@cn.fujitsu.com>
Message-ID: <20190515143746.GA7507@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> > > At the beginning, I
> > >    think it makes no sense because libcap-1 is too old.  But I notices that ltp-quota.m4
> > >    has quota_v1 and quota_v2. I changes my mind.
> > >    Since we have drop libnuma v1, I agree with you that we also drop libcap v1(too old).
> > >    Also, I think we should drop quota_v1 because it is too old (since Linux 2.4.22, Q_GETINFO has
> > >    been supported in kernel).
> > Good point. But I'm not sure if it's the same, as QFMT_VFS_OLD is part of kernel
> > source tree (part of kernel space code) so it makes sense to test it, whereas
> > libcap v1 and libnuma v1 are just old versions of user space library.
> > Or am I wrong?
> Hi Petr

>    I have seen kernel source about quota and try it. I think you are right.  But current quota_v1
> and quota_v2 detection has problem. In kernel source, I disable CONFIG_QFMT_V2 and enable CONFIG_QFMT_V1
> ,then I found ltp still detects quotav2 instead of quotav1,  and run ./quotactl01, the following error occurs:
LTP detection in ltp-quota.m4 defines _LINUX_QUOTA_VERSION for detection.
I guess you'd have to define HAVE_QUOTAV1 and undefine HAVE_QUOTAV2 in in
include/config.h, but not tested.

BTW _LINUX_QUOTA_VERSION was removed from glibc in 2.25 [1] [2], which based setup
on <linux/quota.h>. And musl defines only _LINUX_QUOTA_VERSION 2.

Regards man info that v1 is from kernel v2.4.22 we should probably also remove
it's support.

We got a bit away from libcap :).

Kind regards,
Petr

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=4d728087ef8cc826b05bd21d0c74d4eca9b1a27d;hp=de6b6d14e9b4d8e9a7333addca55163d9ebb7ff6
[2] https://patchwork.ozlabs.org/patch/664156/
