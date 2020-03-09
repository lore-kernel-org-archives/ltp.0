From: Sasha Levin <sashal@kernel.org>
Date: Mon, 9 Mar 2020 17:53:05 -0400
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_PANICKED=3A_Test_report_for_kernel_5?=
 =?utf-8?q?=2E5=2E8-c30f33b=2Ecki_=28stable-queue=29?=
In-Reply-To: <cki.411617A928.D7E40QQCW6@redhat.com>
References: <cki.411617A928.D7E40QQCW6@redhat.com>
Message-ID: <20200309215305.GV21491@sasha-vm>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 09, 2020 at 09:24:35PM -0000, CKI Project wrote:
>
>Hello,
>
>We ran automated tests on a recent commit from this kernel tree:
>
>       Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>            Commit: c30f33bfb014 - selftests: forwarding: vxlan_bridge_1d: use more proper tos value
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
>  https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/09/480158
>
>One or more kernel tests failed:
>
>    s390x:
>     ? LTP
>
>    ppc64le:
>     ? LTP
>
>    aarch64:
>     ? audit: audit testsuite test
>
>    x86_64:
>     ? audit: audit testsuite test

Following the link above I got to
https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/09/480158/audit__audit_testsuite_test/,
but it shows that all tests are passing? The console log looks fine too:
https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/03/09/480158/x86_64_5_console.log.
Where's the panic?

-- 
Thanks,
Sasha
