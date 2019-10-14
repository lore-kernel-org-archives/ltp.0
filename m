From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 14 Oct 2019 03:28:59 -0400 (EDT)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E0-rc2-d6c2c23=2Ecki_=28stable-next=29?=
In-Reply-To: <cki.B4A567748F.PFM8G4WKXI@redhat.com>
References: <cki.B4A567748F.PFM8G4WKXI@redhat.com>
Message-ID: <805988176.6044584.1571038139105.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> Hello,
> 
> We ran automated tests on a recent commit from this kernel tree:
> 
>        Kernel repo:
>        git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux-stable.git
>             Commit: d6c2c23a29f4 - Merge branch 'stable-next' of
>             ssh://chubbybox:/home/sasha/data/next into stable-next
> 
> The results of these automated tests are provided below.
> 
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: FAILED
> 
> All kernel binaries, config files, and logs are available for download here:
> 
>   https://artifacts.cki-project.org/pipelines/223563
> 
> One or more kernel tests failed:
> 
>     aarch64:
>       ? LTP: openposix test suite
> 

Test [1] is passing value close to LONG_MAX, which on arm64 is now treated as tagged userspace ptr:
  057d3389108e ("mm: untag user pointers passed to memory syscalls")

And now seems to hit overflow check after sign extension (EINVAL).
Test should probably find different way to choose invalid pointer.

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
