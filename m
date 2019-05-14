From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 May 2019 14:01:19 +0200
Subject: [LTP] [PATCH] ltp-cap.m4: add libcap version detection && fix
 compiler error
In-Reply-To: <5CDA5124.3070708@cn.fujitsu.com>
References: <1557732392-7049-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190513131451.GA22761@dell5510> <5CDA5124.3070708@cn.fujitsu.com>
Message-ID: <20190514120119.GA26452@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> Hi Peter

>   I sent a mail to you last Friday mentioned this problem.
Noticed, before I find a time you send a patch, so I replied to it (it's always
better to send a question in public).

> At the beginning, I
>   think it makes no sense because libcap-1 is too old.  But I notices that ltp-quota.m4
>   has quota_v1 and quota_v2. I changes my mind.

>   Since we have drop libnuma v1, I agree with you that we also drop libcap v1(too old).
>   Also, I think we should drop quota_v1 because it is too old (since Linux 2.4.22, Q_GETINFO has
>   been supported in kernel).
Good point. But I'm not sure if it's the same, as QFMT_VFS_OLD is part of kernel
source tree (part of kernel space code) so it makes sense to test it, whereas
libcap v1 and libnuma v1 are just old versions of user space library.
Or am I wrong?

> Kind Regards,
> Yang Xu

Kind regards,
Petr
