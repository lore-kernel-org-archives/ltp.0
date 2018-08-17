From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 17 Aug 2018 12:26:55 +0800
Subject: [LTP] [PATCH v2 2/4] lib/tst_test.c: add .needs_devfs flag
In-Reply-To: <20180816132815.GB30369@rei>
References: <20180815114220.GA26923@rei>
 <1534409147-29519-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1534409147-29519-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180816132815.GB30369@rei>
Message-ID: <5B764E8F.1000000@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/08/16 21:28, Cyril Hrubis wrote:
> Hi!
>> We add .needs_devfs flag to prepare a suitable filesystem to test
>> device special files and use ext2 instead of tmpfs(because tmpfs
>> doesn't support extended attributes) as default filesystem if
>> .dev_fs_type is not specified.
> Can we do that only if the test temporary directory is not suitable for
> creating devices?
>
> There are distributions out there that have /tmp residing on pretty much
> normal filesystems, also user can override TMPDIR to point to a path
> backed up by a regular fs. In these cases this will slow down these
> tests for no good reason.
>
> So I would rather go for:
>
> if tst_test->needs_devfs is set:
>
> * mkdir tst_test->mntpoint if it does not exits
> * check if tst_test->mntpoint is suitable for creating devices
> * if not, mount some filesystem over it
>    - mounting tmpfs without nodev flag should be more than enough
>      and if that fails for you, we can fall back to a regular filesystem
Hi Cyril,

Thanks for your review and suggestion.

Mounting tmpfs without nodev over tst_test->mntpoint doesn't fail for 
me, so it isn't
necessary to mount a regular filesystem instead of tmpfs  over 
tst_test->mntpoint.

Thanks,
Xiao Yang



