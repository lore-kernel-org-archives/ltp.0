Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bfreed@google.com>) id 1O54GP-0004ii-KQ
	for ltp-list@lists.sourceforge.net; Thu, 22 Apr 2010 21:48:49 +0000
Received: from smtp-out.google.com ([74.125.121.35])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O54GO-0000Z6-EL
	for ltp-list@lists.sourceforge.net; Thu, 22 Apr 2010 21:48:49 +0000
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com
	[10.3.21.1]) by smtp-out.google.com with ESMTP id o3MLmf78026878
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Apr 2010 23:48:41 +0200
Received: from vws9 (vws9.prod.google.com [10.241.21.137])
	by hpaq1.eem.corp.google.com with ESMTP id o3MLmVjw014271
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Apr 2010 23:48:40 +0200
Received: by vws9 with SMTP id 9so223630vws.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 22 Apr 2010 14:48:31 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 22 Apr 2010 14:40:25 -0700
Message-ID: <n2wda0c1e761004221440xcdd24149lbfec28b682473d45@mail.gmail.com>
From: Bryan Freed <bfreed@google.com>
Subject: [LTP] [PATCH] linkat01: use . instead of /tmp
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6794243463131495126=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6794243463131495126==
Content-Type: multipart/alternative; boundary=e0cb4e887ea199b2dc0484da2875

--e0cb4e887ea199b2dc0484da2875
Content-Type: text/plain; charset=ISO-8859-1

I have a fix for a failing LTP testcase.  Section 6 of the online LTP doc
http://ltp.sourceforge.net/documentation/how-to/ltp.php#_7 says I can
request a test be added by sending to this list, and it looks from the
archive like the subject line for patches should contain "[LTP][PATCH]", so
here goes.  There appears to be no standard diff format, so I will use what
is convenient...

Running the ltp suite on ChromeOS (x86 with a 2.6.32 kernel) fails linkat01
testcase 21:

linkat01   21  TFAIL  :  linkat() failed: TEST_ERRNO=EXDEV(18): Invalid
cross-device link

This is probably because my /tmp is mounted from someplace other than the
filesystem that contains newdirfd.
The goal of testcase 21 is to demonstrate that linking a directory will fail
EPERM.  The fix is to use olddir/. instead of /tmp.

diff -urN
ltp-full-20091231_vanilla/testcases/kernel/syscalls/linkat/linkat01.c
ltp-full-20091231/testcases/kernel/syscalls/linkat/linkat01.c
--- ltp-full-20091231_vanilla/testcases/kernel/syscalls/linkat/linkat01.c
    2009-11-26 23:43:12.000000000 -0800
+++ ltp-full-20091231/testcases/kernel/syscalls/linkat/linkat01.c
2010-04-12 16:28:59.000000000 -0700
@@ -158,7 +158,7 @@
        { &cwd_fd, "/proc/cpuinfo", &newdirfd, TEST_FILE1, 0,
          0, 0, EXDEV },
        /* 21. directory link */
-       { &cwd_fd, "/tmp", &newdirfd, TEST_FILE1, 0,
+       { &olddirfd, ".", &newdirfd, TEST_FILE1, 0,
          0, 0, EPERM },
        /* 22. invalid flag */
        { &olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 1,


Let me know if this is the incorrect process for upstreaming LTP patches.

bryan.

--e0cb4e887ea199b2dc0484da2875
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have a fix for a failing LTP testcase. =A0Section 6 of the online LTP doc=
 <a href=3D"http://ltp.sourceforge.net/documentation/how-to/ltp.php#_7" tar=
get=3D"_blank">http://ltp.sourceforge.net/documentation/how-to/ltp.php#_7</=
a> says I can request a test be added by sending to this list, and it looks=
 from the archive like the subject line for patches should contain &quot;[L=
TP][PATCH]&quot;, so here goes. =A0There appears to be no standard diff for=
mat, so I will use what is convenient...<div>

<br></div><div>Running the ltp suite on ChromeOS (x86 with a 2.6.32 kernel)=
 fails linkat01 testcase 21:<br><div>
<br></div><div><div>linkat01 =A0 21 =A0TFAIL =A0: =A0linkat() failed: TEST_=
ERRNO=3DEXDEV(18): Invalid cross-device link</div></div><div><br></div><div=
>This is probably because my /tmp is mounted from someplace other than the =
filesystem that contains newdirfd.</div>

<div>The goal of testcase 21 is to demonstrate that linking a directory wil=
l fail EPERM. =A0The fix is to use olddir/. instead of /tmp.</div><div><br>=
</div><div><div>diff -urN ltp-full-20091231_vanilla/testcases/kernel/syscal=
ls/linkat/linkat01.c ltp-full-20091231/testcases/kernel/syscalls/linkat/lin=
kat01.c</div>

<div>--- ltp-full-20091231_vanilla/testcases/kernel/syscalls/linkat/linkat0=
1.c =A0 =A0 =A0 2009-11-26 23:43:12.000000000 -0800</div><div>+++ ltp-full-=
20091231/testcases/kernel/syscalls/linkat/linkat01.c =A0 =A0 =A0 2010-04-12=
 16:28:59.000000000 -0700</div>

<div>@@ -158,7 +158,7 @@</div><div>=A0=A0 =A0 =A0 =A0{ &amp;cwd_fd, &quot;/=
proc/cpuinfo&quot;, &amp;newdirfd, TEST_FILE1, 0,</div><div>=A0=A0 =A0 =A0 =
=A0 =A00, 0, EXDEV },</div><div>=A0=A0 =A0 =A0 =A0/* 21. directory link */<=
/div><div>- =A0 =A0 =A0 { &amp;cwd_fd, &quot;/tmp&quot;, &amp;newdirfd, TES=
T_FILE1, 0,</div>

<div>+ =A0 =A0 =A0 { &amp;olddirfd, &quot;.&quot;, &amp;newdirfd, TEST_FILE=
1, 0,</div><div>=A0=A0 =A0 =A0 =A0 =A00, 0, EPERM },</div><div>=A0=A0 =A0 =
=A0 =A0/* 22. invalid flag */</div><div>=A0=A0 =A0 =A0 =A0{ &amp;olddirfd, =
TEST_FILE1, &amp;newdirfd, TEST_FILE1, 1,</div>

</div><div><br></div><div><br></div><div>Let me know if this is the incorre=
ct process for upstreaming LTP patches.</div><div><br></div><div>bryan.</di=
v>
</div>

--e0cb4e887ea199b2dc0484da2875--


--===============6794243463131495126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6794243463131495126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6794243463131495126==--

