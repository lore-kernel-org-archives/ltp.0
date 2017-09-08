From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 8 Sep 2017 05:22:01 -0400 (EDT)
Subject: [LTP] [PATCH v2 1/2] libltp: add support to mount tmpfs for
 EROFS	testing
In-Reply-To: <20170907221625.13616-2-sspatil@google.com>
References: <20170907221625.13616-1-sspatil@google.com>
 <20170907221625.13616-2-sspatil@google.com>
Message-ID: <1249191462.10698048.1504862521083.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> Some tests go through losetup, create, format and mount filesystems only
> to test for 'EROFS' return value from system calls. The tests end up
> being flaky depending on the tools available on the platform. e.g.
> mkfs.<filesystem> tool is required for mounting a device with
> filesystem.
> 
> If the test is only to check for EROFS, this can be achieved by simply by the
> read-only mounting 'tmpfs' at 'mntpoint' and fallback to the original way if
> that fails.
> 
> Example of tests that can benefit from this are:
>   access04, mkdirat02, mknodat02, acct01, fchown04, mknod07 etc.
> 
> This also allows for these tests to successfully run on Android.
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---
> 
> v1->v2
> ------
> - Changed the interface to be at a higher level, i.e. instead of
>   making tests specify that they need a read-only tmpfs mount, we
>   do that automatically in the library as a preference and fallback
>   to the old way if that doesn't succeed.
> 
> - The read-only bind mount of "/" option was tried and it worked just
>   fine with an Android system, but broke my ubuntu instance badly (I lost
>   root).
>   I could never find out why, since hte patch worked fine on Android
>   and it correctly did the bind mount. However, I figured if there is any
>   chance of possible breakage, we should simply avoid that path for now.

I tried this too, with bind mounting only one directory inside TMPDIR:
  SAFE_MOUNT(source, target, NULL, MS_BIND, NULL);
  SAFE_MOUNT(NULL, target, NULL, MS_REMOUNT | MS_RDONLY | MS_BIND, NULL);
and it worked fine, but it turns out it's supported since 2.6.26.

This patch (which uses tmpfs for EROFS only) looks OK to me, and it allows
us to add RO bind mount later as fallback if there's need for it (e.g.
tmpfs not available on some distros).

I tested it as far back as RHEL5.6 (2.6.18 kernel).

Regards,
Jan
