From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Tue, 6 Aug 2019 17:29:09 +0800
Subject: [LTP] [PATCH v7 3/3] syscalls/copy_file_range02: increase
 coverage and remove EXDEV test
In-Reply-To: <5D49200D.9000201@cn.fujitsu.com>
References: <20190730110555.GB7528@rei.lan>
 <1564569629-2358-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564569629-2358-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190805065832.ti6vpoviykfaxcj7@XZHOUW.usersys.redhat.com>
 <5D47D6B9.9090306@cn.fujitsu.com>
 <20190805102211.pvyufepn6xywi7vm@XZHOUW.usersys.redhat.com>
 <5D480C6F.7070108@cn.fujitsu.com> <5D49200D.9000201@cn.fujitsu.com>
Message-ID: <20190806092909.nd5cch7az6bpg56u@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 06, 2019 at 02:37:01PM +0800, Yang Xu wrote:
> on 2019/08/05 19:01, Yang Xu wrote:
> 
> > on 2019/08/05 18:22, Murphy Zhou  wrote:
> > > All of them, ext234 xfs and vfat. 64bit
> > > 
> > > copy_file_range02.c:127: FAIL: copy_file_range returned wrong value: 32
> > > 
> > > [root@8u ltp (master)]# gcc -v
> > > Using built-in specs.
> > > COLLECT_GCC=gcc
> > > COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrapper
> > > OFFLOAD_TARGET_NAMES=nvptx-none
> > > OFFLOAD_TARGET_DEFAULT=1
> > > Target: x86_64-redhat-linux
> > > Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla  --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl --disable-libmpx --enable-offload-targets=nvptx-none --without-cuda-driver --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=x86-64 --build=x86_64-redhat-linux
> > > Thread model: posix
> > > gcc version 8.3.1 20190507 (Red Hat 8.3.1-4) (GCC)
> > > [root@8u ltp (master)]# rpm -qv glibc
> > > glibc-2.28-72.el8.x86_64
> > > [root@8u ltp (master)]# mke2fs -V
> > > mke2fs 1.44.6 (5-Mar-2019)
> > > 	Using EXT2FS Library version 1.44.6
> > > [root@8u ltp (master)]# mkfs.xfs -V
> > > mkfs.xfs version 5.2.0-rc0
> > > [root@8u ltp (master)]#
> > > 
> > > Looks like the copy succeeded at that offset.
> > Hi Murphy
> > Today, I use theLinux 5.3-rc3 ,  ext234 xfs and vfat 64bit all pass. This case use glibc and tst_syscall, they all failed?
> > 
> > my environment as below:
> > # gcc -v
> > gcc version 8.2.1 20180905 (8.2.1-3) (GCC)
> > 
> > #glibc -v
> > glibc-2.28-18.el8.x86_64
> > 
> > #mke2fs  -V
> > mke2fs 1.44.4 (18-Aug-2018)
> >          Using EXT2FS Library version 1.44.4
> > 
> > #mkfs.xfs -V
> > mkfs.xfs version 5.2.0-rc0
> > 
> > I will use your environment to reproduce this problem. Please wait.
> Hi Murphy
> 
> Test 13) still passes on my environment. mke2fs and mkfs.xfs version should not affetc all filesystem results, I think them can be excluded.
> I update my gcc version to 8.3.1 20190507 ,glibc updates to  glibc-2.28-66.el8.x86_64(I don't have glibc-2.28-72.el8.x86_64, if you failed
> on both glibc and syscall, I think this fail is no related with glibc).
> 
> Can you print more informatin when you run this case, as below:
> 
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> index 26bfa008a..e4a7fd246 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> @@ -109,6 +109,8 @@ static void verify_copy_file_range(unsigned int n)
>                 tst_res(TCONF, "filesystem doesn't have free loopdev, skip it");
>                 return;
>         }
> +       if (tc->exp_err == EFBIG)
> +               tst_res(TINFO, "tc->dst %ld  tc->len %ld", tc->dst, tc->len);
>         TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd,
>                                 &tc->dst, tc->len, tc->flags));
> 
> copy_file_range02.c:120: PASS: copy_file_range failed as expected: EOVERFLOW
> copy_file_range02.c:113: INFO: tc->dst 9223372036854710270  tc->len 65537
> copy_file_range02.c:120: PASS: copy_file_range failed as expected: EFBIG

That's odd..

copy_file_range02.c:112: INFO: 12: tc->dst 9223372036854710270, tc->len 65537
copy_file_range02.c:128: FAIL: copy_file_range returned wrong value: 32

> 
> 
> 
> > Thanks
> > Yang Xu
> > 
> > 
> > 
> 
> 
> 
