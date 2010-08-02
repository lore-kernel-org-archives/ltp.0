Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1Og1BG-0007BY-OS
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 20:00:14 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Og1BF-0002UP-Pd
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 20:00:14 +0000
Message-Id: <4C56CAAF020000E800067098@sinclair.provo.novell.com>
Date: Mon, 02 Aug 2010 13:39:59 -0600
From: "Murlin Wenzel" <mwenzel@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part735E651F.0__="
Subject: [LTP] [Patch] Allow swapon03 test to pass with unknown max_swapfiles
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
To: ltp-list <ltp-list@lists.sf.net>

--=__Part735E651F.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch will allow swapon03 test case to pass even when max_swapfiles =
is not known.  Create maximum possible number of swapfiles during setup, =
then verify that attempting to create one more swapfile will return EPERM. =
 This is meant to change as little as possible of the existing code.

Signed-off-by: Murlin Ray Wenzel mwenzel@novell.com


--=__Part735E651F.0__=
Content-Type: text/plain; name="swapon03-maxswap.PATCH"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="swapon03-maxswap.PATCH"

--- ltp-full-20100630/testcases/kernel/syscalls/swapon/swapon03.c.orig	=
2010-08-02 10:31:53.042358851 -0600=0A+++ ltp-full-20100630/testcases/kerne=
l/syscalls/swapon/swapon03.c	2010-08-02 13:05:19.978561054 -0600=0A@@ =
-142,8 +142,7 @@=0A 		/* Check return code */=0A 		if =
((TEST_RETURN =3D=3D -1) && (TEST_ERRNO =3D=3D expected_errno)) {=0A 		=
	tst_resm(TPASS, "swapon(2) got expected failure;"=0A-			=
	 " Got errno - %d, probably your"=0A-				 " =
MAX_SWAPFILES is 30", expected_errno);=0A+				 " =
Got errno =3D %d," , expected_errno);=0A 		} else if =
(TEST_RETURN < 0) {=0A 			tst_resm(TFAIL, "swapon(2) failed =
to produce"=0A 				 " expected error: %d, got %d =
(%s)."=0A@@ -174,7 +173,7 @@=0A 				    && =
(TEST_ERRNO =3D=3D expected_errno)) {=0A 					=
tst_resm(TPASS,=0A 						 "swapon(2)=
 got expected failure;"=0A-						 " =
Got errno - %d, probably your"=0A+						=
 " Got errno =3D %d, probably your"=0A 						=
 " MAX_SWAPFILES is 32",=0A 						 =
expected_errno);=0A 				} else {=0A@@ -291,11 =
+290,16 @@=0A =0A 			/* turn on the swap file */=0A 		=
	if ((res =3D syscall(__NR_swapon, filename, 0)) !=3D 0) {=0A-		=
		tst_brkm(TFAIL | TERRNO, cleanup,=0A-				=
	 "Failed swapon for file %s", filename);=0A-				=
/* must cleanup already swapon files */=0A-				=
clean_swap();=0A-				exit(1);=0A+			=
	if (errno =3D=3D EPERM) {=0A+					=
printf("Successfully created %d swapfiles\n", j);=0A+				=
	break;=0A+				} else {=0A+			=
		tst_brkm(TFAIL | TERRNO, cleanup,=0A+				=
		 "Failed swapon for file %s", filename);=0A+			=
		/* must cleanup already swapon files */=0A+			=
		clean_swap();=0A+					=
exit(1);=0A+				}=0A 			}=0A 		=
}=0A 		tst_exit();=0A
--=__Part735E651F.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
--=__Part735E651F.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=__Part735E651F.0__=--

