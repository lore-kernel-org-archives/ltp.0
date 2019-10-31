From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Oct 2019 16:26:46 +0100
Subject: [LTP] 
 =?utf-8?q?=5BPATCH_v2_2/6=5D_m4/ltp-xfs=5Fquota=2Em4=3A_Re?=
 =?utf-8?q?move_useless_ltp=E2=80=94xfs=5Fquota=2Em4?=
In-Reply-To: <1571821231-3846-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1571821231-3846-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1571821231-3846-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20191031152646.GA7078@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> We can detect <xfs/xqm.h> in configure.ac instead of using
> ltp-xfs_quota.m4. Also we should need to check CONFIG_XFS_QUOTA
> whether enable in kernel config.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Merge these 2 commits with minor changes.

Could you please send new version, where you rebase the rest of this patchset,
fix issue including <linux/quota.h> with <sys/quota.h> causing failure on
centos6 [1] remove Q_SYNC from quotactl04.c [2] and add quotactl06 [3].

Thanks a lot!

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1181923/#2292956
[2] https://patchwork.ozlabs.org/patch/1181925/#2287412
[3] https://patchwork.ozlabs.org/patch/1185189/
