From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Feb 2020 17:44:07 +0100
Subject: [LTP] [PATCH V2 05/10] syscalls/fsconfig: New tests
In-Reply-To: <CAEemH2f6gudJjZ1HAsVFVKkuR3FUyBVHf1JQDHeQMdavQqc+2A@mail.gmail.com>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <6ac7573e8ea5ab6f0ab9256b73802126d72b5156.1582104018.git.viresh.kumar@linaro.org>
 <CAEemH2f6gudJjZ1HAsVFVKkuR3FUyBVHf1JQDHeQMdavQqc+2A@mail.gmail.com>
Message-ID: <20200221164407.GA3000@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> The test reports an EINVAL error when testing fsconfig() with
> 'FSCONFIG_SET_PATH' on XFS. I'm now trying to look close to this issue.

> kernel: 5.6.0-rc2+ x86_64
Confirmed, with this XFS config:

CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_VXFS_FS is not set

I'll have a look on it on Monday.

Kind regards,
Petr

> tst_test.c:1278: INFO: Testing on xfs
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:46: FAIL: fsconfig() failed: EINVAL (22)

