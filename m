From: Jan Kara <jack@suse.cz>
Date: Thu, 24 Oct 2019 10:14:38 +0200
Subject: [LTP] [PATCH v2 5/6] syscalls/quotactl04: add project quota
 test for non-xfs filesystem
In-Reply-To: <1571821231-3846-6-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1571821231-3846-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1571821231-3846-6-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20191024081438.GJ31271@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed 23-10-19 17:00:30, Yang Xu wrote:
> This is a variant about quotactl01. It is used to test project quota.
> I split it into a new case instead of adding it in quotaclt01 because
> two points:
> 1)before linux 4.10, ext4 doesn't support project quota
> 2)on old kernel, kernel doesn't permit mount both prjquota and grpquota together
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Suggested-by: Jan Kara <jack@suse.cz>
>
...
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + * This testcase checks the basic flag of quotactl(2) for project quota on
> + * non-XFS filesystems.
> + *
> + * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for project.
> + * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
> + *    for project.
> + * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
> + *    for project.
> + * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
> + *    flag for project.
> + * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
> + *    flag for project.
> + * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for project.
> + * 7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for project.

Testing Q_SYNC is mostly pointless for project quota as it will just do
nothing (the quota changes are journalled).

> + * 8) quotactl(2) succeeds to get disk quota limit greater than or equal to
> + *    ID with Q_GETNEXTQUOTA flag for project.
> + * 9) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
> + */

Otherwise the set of checks looks sensible to do basic sanity check of
quotactl(2) syscall.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
