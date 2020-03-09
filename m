From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 9 Mar 2020 16:17:22 +0100
Subject: [LTP] 
	=?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E6?=
	=?utf-8?b?LjAtMC5yYzQuMi5lbHJkeS5ja2kgKGFyayk=?=
In-Reply-To: <cki.2EFDE2FCE3.JLIPSG6DVZ@redhat.com>
References: <cki.2EFDE2FCE3.JLIPSG6DVZ@redhat.com>
Message-ID: <CAFqZXNsahRxaAmH0vdzs29mXkViKjng8rRi2E70FS7eNSFW=oA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Mar 7, 2020 at 1:02 AM CKI Project <cki-project@redhat.com> wrote:
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo: https://gitlab.com/cki-project/kernel-ark.git
>             Commit: 76ff5208ed98 - [redhat] kernel-5.6.0-0.rc4.2.elrdy
>
> The results of these automated tests are provided below.
>
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: FAILED
>
>     Pipeline: https://xci32.lab.eng.rdu2.redhat.com/cki-project/cki-pipeline/pipelines/475149
>
> One or more kernel tests failed:
>   To view existing or log new failures in CKI:
>     http://internal-documentation-ark.cloud.paas.psi.redhat.com/datawarehouse/failure_analysis/#view-known-failures
>   To view testing trends per kernel, e.g. determine if a test failed on previous kernels:
>     http://internal-documentation-ark.cloud.paas.psi.redhat.com/datawarehouse/failure_analysis/#test-results
>
>     x86_64:
>      ? LTP
>      ? Libhugetlbfs - version 2.2.1
>      ? Tracepoints: operational test

>      ? selinux-policy: serge-testsuite

FWIW, the SELinux testsuite failed on the BPF subtest due to
unprivileged BPF being disabled on ARK kernels (and the rlIsRHEL check
didn't cover it, since this was run on Fedora...). I opened a PR to
fix our test wrapper to better detect cases when CAP_SYS_ADMIN is
needed to do BPF stuff and also to actually run the subtest (granting
the sys_admin capability to the relevant domains) in such case instead
of just disabling it.

-- 
Ondrej Mosnacek <omosnace@redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

