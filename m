Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <violetleigh@gmail.com>) id 1PaQPe-0006yx-Iz
	for ltp-list@lists.sourceforge.net; Wed, 05 Jan 2011 10:16:14 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PaQPd-0001fO-OI
	for ltp-list@lists.sourceforge.net; Wed, 05 Jan 2011 10:16:14 +0000
Received: by gwaa12 with SMTP id a12so3518647gwa.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 05 Jan 2011 02:16:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201012291144.58092.vapier@gentoo.org>
References: <AANLkTi=qFxgs4CPQ2EUwHin1LTgxw0V-RENPV9rRqraF@mail.gmail.com>
	<201012291144.58092.vapier@gentoo.org>
Date: Wed, 5 Jan 2011 18:16:08 +0800
Message-ID: <AANLkTimxrSw2qSVnqqw+wUkNSgZOHwb59Qvo61swTf9s@mail.gmail.com>
From: Vivi <violetleigh@gmail.com>
Subject: Re: [LTP] [Bug Fix] utimensat01 can't build
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2341452183663299071=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

--===============2341452183663299071==
Content-Type: multipart/alternative; boundary=0016368e1d22742f52049916ac7b

--0016368e1d22742f52049916ac7b
Content-Type: text/plain; charset=ISO-8859-1

>>On Wednesday, December 29, 2010 04:35:48 Vivi wrote:
>> LTP test case utimensat01.c can't build without file usctest.h.

>this compiles fine for me on x86_64/Linux as well as Blackfin/Linux without
>this change.  so why do you need this ?
>-mike


I get following error when build utimensat01.c.
--
bfin-uclinux-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/test/work/cruise/checkouts/uclinux-dist/testsuites/ltp/ltp-full-20101031/testcases/kernel/include
-I../../../../include -I../../../../include -D__UCLIBC__ -DUCLINUX
-L../../../../lib  utimensat01.c   -lltp -o utimensat01
../../../../lib/libltp.a(tst_res.o): In function `tst_print':
/home/test/work/cruise/checkouts/uclinux-dist/testsuites/ltp/ltp-full-20101031/lib/tst_res.c:512:
undefined reference to `_TEST_ERRNO'
/home/test/work/cruise/checkouts/uclinux-dist/testsuites/ltp/ltp-full-20101031/lib/tst_res.c:512:
undefined reference to `_TEST_ERRNO'
collect2: ld returned 1 exit status
make: *** [utimensat01] Error 1
--

--0016368e1d22742f52049916ac7b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

&gt;&gt;On Wednesday, December 29, 2010 04:35:48 Vivi wrote:<br>
&gt;&gt; LTP test case utimensat01.c can&#39;t build without file usctest.h=
.<br><br>&gt;this compiles fine for me on x86_64/Linux as well as Blackfin/=
Linux without<br>
&gt;this change. =A0so why do you need this ?<br>
<font color=3D"#888888">&gt;-mike</font><br><br><br>I get following error w=
hen build utimensat01.c.<br>--<br>bfin-uclinux-gcc -g -O2 -g -O2 -fno-stric=
t-aliasing -pipe -Wall=A0 -I/home/test/work/cruise/checkouts/uclinux-dist/t=
estsuites/ltp/ltp-full-20101031/testcases/kernel/include -I../../../../incl=
ude -I../../../../include -D__UCLIBC__ -DUCLINUX=A0=A0 -L../../../../lib=A0=
 utimensat01.c=A0=A0 -lltp -o utimensat01<br>
../../../../lib/libltp.a(tst_res.o): In function `tst_print&#39;:<br>/home/=
test/work/cruise/checkouts/uclinux-dist/testsuites/ltp/ltp-full-20101031/li=
b/tst_res.c:512: undefined reference to `_TEST_ERRNO&#39;<br>/home/test/wor=
k/cruise/checkouts/uclinux-dist/testsuites/ltp/ltp-full-20101031/lib/tst_re=
s.c:512: undefined reference to `_TEST_ERRNO&#39;<br>
collect2: ld returned 1 exit status<br>make: *** [utimensat01] Error 1<br>-=
-<br>

--0016368e1d22742f52049916ac7b--


--===============2341452183663299071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============2341452183663299071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2341452183663299071==--

