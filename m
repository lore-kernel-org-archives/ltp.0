Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naveenspen@gmail.com>) id 1MGTgx-0008FZ-M2
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 08:06:51 +0000
Received: from mail-yx0-f177.google.com ([209.85.210.177])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGTgw-0004Lx-GN
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 08:06:51 +0000
Received: by yxe7 with SMTP id 7so399975yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 16 Jun 2009 01:06:49 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 16 Jun 2009 13:36:49 +0530
Message-ID: <ab64ec20906160106g664052edo690bdaf97c2ed847@mail.gmail.com>
From: naveen penumala <naveenspen@gmail.com>
Subject: [LTP] unable to install ltp-full-20090531
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7970722793354930016=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

--===============7970722793354930016==
Content-Type: multipart/alternative; boundary=001e680f11a0247705046c72a803

--001e680f11a0247705046c72a803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Please look at the below compilation error at the time of "make all" after
configuration.
Here i'm using Suse linux, and kernel version is 2.6.16.21.

Please help me regarding this.


make[4]: Entering directory
`/home/kevin/tests/LTP/ltp-full-20090531/testcases/kernel/mem/mem'
gcc -g -O2 -Wall -I../../../../include    mem02.c -L../../../../lib -lltp
-o mem02
mem02.c: In function =E2main=E2:
mem02.c:71: internal compiler error: in merge_alias_info, at
tree-ssa-copy.c:235
Please submit a full bug report,
with preprocessed source if appropriate.
make[4]: *** [mem02] Error 1
make[4]: Leaving directory
`/home/kevin/tests/LTP/ltp-full-20090531/testcases/kernel/mem/mem'
make[3]: *** [all] Error 2
make[3]: Leaving directory
`/home/kevin/tests/LTP/ltp-full-20090531/testcases/kernel/mem'
make[2]: *** [all] Error 2
make[2]: Leaving directory
`/home/kevin/tests/LTP/ltp-full-20090531/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory
`/home/kevin/tests/LTP/ltp-full-20090531/testcases'
make: *** [all] Error 2


Thanks & Regards,
-NVN

--001e680f11a0247705046c72a803
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, <br><br>Please look at the below compilation error at the time of &quot=
;make all&quot; after configuration.<br>Here i&#39;m using Suse linux, and =
kernel version is 2.6.16.21.<br><br>Please help me regarding this. <br><br>
<br>make[4]: Entering directory `/home/kevin/tests/LTP/ltp-full-20090531/te=
stcases/kernel/mem/mem&#39;<br>gcc -g -O2 -Wall -I../../../../include=A0=A0=
=A0 mem02.c -L../../../../lib -lltp=A0 -o mem02<br>mem02.c: In function =E2=
main=E2:<br>
mem02.c:71: internal compiler error: in merge_alias_info, at tree-ssa-copy.=
c:235<br>Please submit a full bug report,<br>with preprocessed source if ap=
propriate.<br>make[4]: *** [mem02] Error 1<br>make[4]: Leaving directory `/=
home/kevin/tests/LTP/ltp-full-20090531/testcases/kernel/mem/mem&#39;<br>
make[3]: *** [all] Error 2<br>make[3]: Leaving directory `/home/kevin/tests=
/LTP/ltp-full-20090531/testcases/kernel/mem&#39;<br>make[2]: *** [all] Erro=
r 2<br>make[2]: Leaving directory `/home/kevin/tests/LTP/ltp-full-20090531/=
testcases/kernel&#39;<br>
make[1]: *** [all] Error 2<br>make[1]: Leaving directory `/home/kevin/tests=
/LTP/ltp-full-20090531/testcases&#39;<br>make: *** [all] Error 2<br><br><br=
>Thanks &amp; Regards,<br>-NVN<br>

--001e680f11a0247705046c72a803--


--===============7970722793354930016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--===============7970722793354930016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7970722793354930016==--

