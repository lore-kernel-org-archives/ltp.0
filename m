From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 1 Nov 2019 20:44:45 +0800
Subject: [LTP] [PATCH v2 3/6] syscalls/quotactl01.c: Add Q_GETNEXQUOTA
 test
In-Reply-To: <20191031143148.GA6781@dell5510>
References: <1571821231-3846-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1571821231-3846-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191031143148.GA6781@dell5510>
Message-ID: <dc5a87c6-512e-b9fc-66ca-987e9e88f9ae@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/10/31 22:31, Petr Vorel wrote:

> Hi Xu,
>
>> Q_GETNEXTQUOTA was introduced since linux 4.6, this operation is the
>> same as Q_GETQUOTA, but it returns quota information for the next ID
>> greater than or equal to id that has a quota set.
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   include/lapi/quotactl.h                       | 23 ++---
>>   m4/ltp-quota.m4                               | 36 +-------
>>   .../kernel/syscalls/quotactl/quotactl01.c     | 86 ++++++++++++-------
>>   3 files changed, 67 insertions(+), 78 deletions(-)
>> diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
> ...
>>   #ifndef LAPI_QUOTACTL_H__
>>   # define LAPI_QUOTACTL_H__
>> +#include <linux/quota.h>
> I'd prefer to add autotools check for <linux/quota.h configure.ac
> (I guess we ignore include/config.h.default atm).
>
> But, more important, I'd prefer to include <sys/quota.h> here as well:
>
> #ifdef HAVE_LINUX_QUOTA_H
> # include <linux/quota.h>
> #else
> # include <sys/quota.h>
> #endif

Hi Petr

It still has problems that sys/quota.h has some struct defintion as struct dqblk ,struct dqinfo.
Also, now linux/quota.h doesn't have quotactl function declaration.

I think we can use HAVE_STRUCT_IF_NEXTDQBLK macro in lapi/quotactl.h to decide whether include <linux/quota.h> because
I add <linux/quota.h> for finding struct if_netxdqblk defintion.

  

ps: In my ltp fork, it passed.

[1]https://travis-ci.org/xuyang0410/ltp/builds/605963472?utm_medium=notification&utm_source=github_status

Thanks
Yang Xu

>
> => move it from quotactl0*.c (there is not yet agreement to include headers in
> lapi files, but later lapi files does it).
>
> The reason is that old distros fail when both headers are included at the same
> time (probably <linux/quota.h> got fixed later, maybe there is an workaround,
> but the easiest way is to handle this in header anyway).
>
> Kind regards,
> Petr
>
> [1] https://travis-ci.org/pevik/ltp/jobs/605507690
> [2] https://api.travis-ci.org/v3/job/605507690/log.txt
>
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191101/06f679de/attachment.htm>
