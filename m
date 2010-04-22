Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1O56PZ-0003jT-QM
	for ltp-list@lists.sourceforge.net; Fri, 23 Apr 2010 00:06:25 +0000
Received: from mail-qy0-f179.google.com ([209.85.221.179])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O56PY-0008Va-Vg
	for ltp-list@lists.sourceforge.net; Fri, 23 Apr 2010 00:06:25 +0000
Received: by qyk9 with SMTP id 9so12160605qyk.1
	for <ltp-list@lists.sourceforge.net>;
	Thu, 22 Apr 2010 17:06:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <n2wda0c1e761004221440xcdd24149lbfec28b682473d45@mail.gmail.com>
References: <n2wda0c1e761004221440xcdd24149lbfec28b682473d45@mail.gmail.com>
From: Henry Yei <hyei@mvista.com>
Date: Thu, 22 Apr 2010 16:38:12 -0700
Message-ID: <j2x42aa607e1004221638o1d369793idd2bd41b5da66b1a@mail.gmail.com>
Subject: Re: [LTP] [PATCH] linkat01: use . instead of /tmp
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Bryan Freed <bfreed@google.com>
Cc: ltp-list@lists.sourceforge.net

Bryan, I've confirmed that the linkat01 test passes with this fix on
x86 with 2.6.21 kernel and arm on 2.6.33 kernel. Thanks!

Henry Yei <hyei@mvista.com>

On Thu, Apr 22, 2010 at 2:40 PM, Bryan Freed <bfreed@google.com> wrote:
> I have a fix for a failing LTP testcase. =A0Section 6 of the online LTP d=
oc
> http://ltp.sourceforge.net/documentation/how-to/ltp.php#_7 says I can
> request a test be added by sending to this list, and it looks from the
> archive like the subject line for patches should contain "[LTP][PATCH]", =
so
> here goes. =A0There appears to be no standard diff format, so I will use =
what
> is convenient...
> Running the ltp suite on ChromeOS (x86 with a 2.6.32 kernel) fails linkat=
01
> testcase 21:
>
> linkat01 =A0 21 =A0TFAIL =A0: =A0linkat() failed: TEST_ERRNO=3DEXDEV(18):=
 Invalid
> cross-device link
> This is probably because my /tmp is mounted from someplace other than the
> filesystem that contains newdirfd.
> The goal of testcase 21 is to demonstrate that linking a directory will f=
ail
> EPERM. =A0The fix is to use olddir/. instead of /tmp.
> diff -urN
> ltp-full-20091231_vanilla/testcases/kernel/syscalls/linkat/linkat01.c
> ltp-full-20091231/testcases/kernel/syscalls/linkat/linkat01.c
> --- ltp-full-20091231_vanilla/testcases/kernel/syscalls/linkat/linkat01.c
> =A0 =A0 2009-11-26 23:43:12.000000000 -0800
> +++ ltp-full-20091231/testcases/kernel/syscalls/linkat/linkat01.c
> 2010-04-12 16:28:59.000000000 -0700
> @@ -158,7 +158,7 @@
> =A0=A0 =A0 =A0 =A0{ &cwd_fd, "/proc/cpuinfo", &newdirfd, TEST_FILE1, 0,
> =A0=A0 =A0 =A0 =A0 =A00, 0, EXDEV },
> =A0=A0 =A0 =A0 =A0/* 21. directory link */
> - =A0 =A0 =A0 { &cwd_fd, "/tmp", &newdirfd, TEST_FILE1, 0,
> + =A0 =A0 =A0 { &olddirfd, ".", &newdirfd, TEST_FILE1, 0,
> =A0=A0 =A0 =A0 =A0 =A00, 0, EPERM },
> =A0=A0 =A0 =A0 =A0/* 22. invalid flag */
> =A0=A0 =A0 =A0 =A0{ &olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 1,
>
> Let me know if this is the incorrect process for upstreaming LTP patches.
> bryan.
> -------------------------------------------------------------------------=
-----
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
