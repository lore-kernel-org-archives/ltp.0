From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 23 Jan 2020 17:34:06 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E14-0fce94b=2Ecki_=28stable=29?=
In-Reply-To: <cki.03B22F835F.RSIEVD547K@redhat.com>
References: <cki.03B22F835F.RSIEVD547K@redhat.com>
Message-ID: <600201642.3600472.1579818846276.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
>   ppc64le:
>     Host 1:
>        ? Boot test
>        ? Podman system integration test (as root)
>        ? Podman system integration test (as user)
>        ? LTP

This is safe to ignore.

I can reproduce on affected system, it doesn't hang on anything specific,
it's just that test is taking longer than expected and hits timeout.
I'll look into proposing LTP patch for this issue.

