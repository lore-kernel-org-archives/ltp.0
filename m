From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Oct 2019 15:02:47 +0100
Subject: [LTP] [PATCH v2 1/6] syscalls/quotactl: Don't use ltp-quota.m4
In-Reply-To: <1571821231-3846-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1571821231-3846-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1571821231-3846-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20191031140247.GA6011@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Current quotactl01.c has logic problem. There is no relation between
> Q_GETINFO and quota format. The format should depend on quotacheck -F and
> kernel config such as CONFIG_QFMT_V1 or CONFIG_QFMT_V2(most linux distributions
> use the v2).

> Q_GETINFO cmd was introduced since Linux 2.4.22, we don't need to
> check it now.  Also, specfiy quota format to QFMT_VFS_V0 by quotacheck
> -F and check CONFIG_QFMT_V2 in kernel config to avoid issue such as#189[1].
> So in quotactl01.c, we don't need to use the macro of ltp-quota.m4.
> In quotactl0[2-3].c, we don't need to check very basic header <sys/quota.h>
> (it was introdued in glibc since 1997). Remove quota version macro.

> Don't remove ltp-quota.m4 because I will rewrite it to detect
> if_nextdqblk struct for Q_GETNEXTQUOTA cmd on the coming patch.
I'm going to merge 1st and 2nd commit as these are obviously ok.
With one change: I'll remove ltp-quota.m4, I see no problem to remove it in 1st
commit and later introduce different macro with the same name.

Kind regards,
Petr
