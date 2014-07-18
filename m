Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1X8ALr-0003tU-CL
	for ltp-list@lists.sourceforge.net; Fri, 18 Jul 2014 15:45:39 +0000
Received: from smtp-out3.electric.net ([72.35.12.186])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X8ALp-0002Fr-F6
	for ltp-list@lists.sourceforge.net; Fri, 18 Jul 2014 15:45:39 +0000
Received: from 1X8ALj-0005Qo-TQ by out3a.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1X8ALj-0005V5-Uo
	for ltp-list@lists.sourceforge.net; Fri, 18 Jul 2014 08:45:31 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3a.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1X8ALj-0005Qo-TQ
	for ltp-list@lists.sourceforge.net; Fri, 18 Jul 2014 08:45:31 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Fri, 18 Jul 2014 15:45:29 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C2ADF018E@LCHQEX03.lancope.local>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_4506ACC2AE90484D87F9A883BA36C21C2ADF018ELCHQEX03lancope_"
MIME-Version: 1.0
Subject: [LTP] More LTP findings
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--_002_4506ACC2AE90484D87F9A883BA36C21C2ADF018ELCHQEX03lancope_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, all!

I'm also finding a fair number of tests (hung runs of run_cpuctl_test.sh I'=
m looking at you) blindly use hard-coded path $LTPROOT/output/.
Its existence is not fully enforced by runltp, though it tries half-hearted=
ly.

Suggested first-hack fix:  install the directory inside runltp's setup().
Provided in attached DIFF as well, since (sadly) something in my company's =
email infrastructure mangles whitespace.

=3D=3D=3D=3D 8< =3D=3D=3D=3D 8< =3D=3D=3D=3D
--- runltp.orig	2014-07-18 14:56:08.918779305 +0000
+++ runltp	2014-07-18 15:16:34.352791208 +0000
@@ -96,6 +96,9 @@
         echo "INFO:  Follow directions in INSTALL!"
         exit 1
     }
+
+    # TODO refactor out tests hard-coding this path
+    install -m 0755 -d "$LTPROOT/output"
 }
 =3D=3D=3D=3D >8 =3D=3D=3D=3D >8 =3D=3D=3D=3D

Longer-term refactoring might be to clean up runltp's handling of relative =
paths in options, and to replace these hard-coded paths by a guarded enviro=
nment variable in some sourced shell-file.

Thanks!

Joseph
Joseph Beckenbach, senior QA engineer : Automation
x97166
M 678-602-3192


--_002_4506ACC2AE90484D87F9A883BA36C21C2ADF018ELCHQEX03lancope_
Content-Type: application/octet-stream; name="DIFF"
Content-Description: DIFF
Content-Disposition: attachment; filename="DIFF"; size=313;
	creation-date="Fri, 18 Jul 2014 15:24:09 GMT";
	modification-date="Fri, 18 Jul 2014 15:17:38 GMT"
Content-Transfer-Encoding: base64

LS0tIHJ1bmx0cC5vcmlnCTIwMTQtMDctMTggMTQ6NTY6MDguOTE4Nzc5MzA1ICswMDAwCisrKyBy
dW5sdHAJMjAxNC0wNy0xOCAxNToxNjozNC4zNTI3OTEyMDggKzAwMDAKQEAgLTk2LDYgKzk2LDkg
QEAKICAgICAgICAgZWNobyAiSU5GTzogIEZvbGxvdyBkaXJlY3Rpb25zIGluIElOU1RBTEwhIgog
ICAgICAgICBleGl0IDEKICAgICB9CisKKyAgICAjIFRPRE8gcmVmYWN0b3Igb3V0IHRlc3RzIGhh
cmQtY29kaW5nIHRoaXMgcGF0aAorICAgIGluc3RhbGwgLW0gMDc1NSAtZCAiJExUUFJPT1Qvb3V0
cHV0IgogfQogCiB2ZXJzaW9uX29mX2x0cCgpCg==

--_002_4506ACC2AE90484D87F9A883BA36C21C2ADF018ELCHQEX03lancope_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
--_002_4506ACC2AE90484D87F9A883BA36C21C2ADF018ELCHQEX03lancope_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_002_4506ACC2AE90484D87F9A883BA36C21C2ADF018ELCHQEX03lancope_--

