From: Sasha Levin <sashal@kernel.org>
Date: Sun, 22 Mar 2020 21:58:28 -0400
Subject: [LTP] 
 =?utf-8?q?=F0=9F=92=A5_PANICKED=3A_Test_report_for_kernel_?=
 =?utf-8?q?5=2E5=2E11-6df57ed=2Ecki_=28stable-queue=29?=
In-Reply-To: <cki.D9E02DA05E.6L1W61X8RG@redhat.com>
References: <cki.D9E02DA05E.6L1W61X8RG@redhat.com>
Message-ID: <20200323015828.GS4189@sasha-vm>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, Mar 22, 2020 at 11:50:11PM -0000, CKI Project wrote:
>
>Hello,
>
>We ran automated tests on a recent commit from this kernel tree:
>
>       Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>            Commit: 6df57ed14ddf - Revert "drm/fbdev: Fallback to non tiled mode if all tiles not present"
>
>The results of these automated tests are provided below.
>
>    Overall result: FAILED (see details below)
>             Merge: OK
>           Compile: OK
>             Tests: PANICKED
>
>All kernel binaries, config files, and logs are available for download here:
>
>  https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/22/500600
>
>One or more kernel tests failed:
>
>    ppc64le:
>     ? LTP
>
>    aarch64:
>     ? Boot test
>
>    x86_64:
>     ? xfstests - ext4

So I go in the xfstests___ext4/ directory to see what paniced, right? I
don't see panics in those logs...

-- 
Thanks,
Sasha
