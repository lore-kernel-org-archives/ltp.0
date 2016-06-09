From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Jun 2016 11:32:34 +0200
Subject: [LTP] ftruncate04 broken on kernels without mandatory locking
In-Reply-To: <57583855.9050602@redhat.com>
References: <57583855.9050602@redhat.com>
Message-ID: <20160609093234.GA453@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Upstream kernel commit
> 
>   9e8925b67a809bb27ce4b7d352d67f25cf1d7fc5
>   locks: Allow disabling mandatory locking at compile time
> 
> added a config option to remove support for mandatory locking
> (mount -o mand, MS_MANDLOCK), which went into v4.5.
> 
> Some distributions (like Fedora) already disable it, causing
> ftruncate04 to fail:
> 
> ftruncate04    0  TINFO  :  TMPDIR does not support mandatory locks
> ftruncate04    0  TINFO  :  Found free device '/dev/loop0'
> ftruncate04    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=''
> extra opts=''
> mke2fs 1.42.13 (17-May-2015)
> ftruncate04    1  TBROK  :  safe_macros.c:728: ftruncate04.c:247:
> mount(/dev/loop0, dir/, ext2, 64, (nil)) failed: errno=EPERM(1):
> Operation not permitted
> ftruncate04    2  TBROK  :  safe_macros.c:728: Remaining cases broken
> 
> and indeed
> 
> $ mount /dev/loop0 /mnt/
> $ umount /mnt
> $ mount /dev/loop0 /mnt/ -o mand
> mount: permission denied
> 
> The question is how to best fix the testcase - do the mount unsafely
> and assume EPERM should be TCONF? Or somehow check kernel config?
> Maybe do the mount first without MS_MANDLOCK (to rule out other perm
> issues) and then remount with MS_MANDLOCK, checking EPERM?

Too bad that it returns EPERM rather than ENOSYS.

Parsing kernel config portably between major distributions is very
troublesome if not impossible so I would like to avoid this path.

Checking for EPERM while remounting with MS_MANDLOCK sounds good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
