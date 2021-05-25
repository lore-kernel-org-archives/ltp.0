From: Li Wang <liwan@redhat.com>
Date: Tue, 25 May 2021 16:31:20 +0800
Subject: [LTP] 
	=?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E13?=
	=?utf-8?q?=2E0-rc3_=28arm-next=2C_c4681547=29?=
In-Reply-To: <cki.53EAC953CF.BF3ZY3WPMQ@redhat.com>
References: <cki.53EAC953CF.BF3ZY3WPMQ@redhat.com>
Message-ID: <CAEemH2cYy7chvW+s09_1G+-ahiPvREdacdQmL15LBNbK92VOPw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 25, 2021 at 12:58 AM CKI Project <cki-project@redhat.com> wrote:

>
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>             Commit: c4681547bcce - Linux 5.13-rc3
>
> The results of these automated tests are provided below.
>
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: FAILED
>
> All kernel binaries, config files, and logs are available for download
> here:
>
>
> https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/05/24/308428205
>
> One or more kernel tests failed:
>
>     aarch64:
>      ? LTP
>

    ------------- 8< -------------
    81 tst_test.c:899: TINFO: Trying FUSE...
    82 tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s

    83 statx04.c:44: TPASS: sys_statx(AT_FDCWD, mntpoint/test_dir1, 0, 0,
&buf)
    84 statx04.c:53: TFAIL: STATX_ATTR_COMPRESSED flag is not set
    85 statx04.c:58: TFAIL: STATX_ATTR_APPEND flag is not set
    86 statx04.c:63: TFAIL: STATX_ATTR_IMMUTABLE flag is not set
    87 statx04.c:68: TFAIL: STATX_ATTR_NODUMP flag is not set

    88 statx04.c:77: TPASS: sys_statx(AT_FDCWD, mntpoint/test_dir2, 0, 0,
&buf)
    89 statx04.c:86: TPASS: STATX_ATTR_COMPRESSED flag is not set
    90 statx04.c:91: TPASS: STATX_ATTR_APPEND flag is not set
    91 statx04.c:96: TPASS: STATX_ATTR_IMMUTABLE flag is not set
    92 statx04.c:101: TPASS: STATX_ATTR_NODUMP flag is not set
    ---------------------------------

This failure is likely the 'STATX_ATTR_*' flags unsupported with the FUSE
issue.
We may need to fix it in the test.

Btw, I found there is a patch helping check the flag before using it. But I
don't
know why we didn't merge it@that moment.
https://lists.linux.it/pipermail/ltp/2019-October/014123.html

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210525/cef86be4/attachment.htm>
