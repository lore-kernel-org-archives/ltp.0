Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1XllEG-0007jt-4O
	for ltp-list@lists.sourceforge.net; Tue, 04 Nov 2014 21:01:28 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XllEE-0005KC-Og
	for ltp-list@lists.sourceforge.net; Tue, 04 Nov 2014 21:01:28 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sA4L1JRq005491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Nov 2014 16:01:20 -0500
Received: from tarantula.localdomain (ovpn-113-179.phx2.redhat.com
	[10.3.113.179])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id sA4L1ITS020660
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Nov 2014 16:01:19 -0500
Date: Tue, 4 Nov 2014 15:01:18 -0600
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20141104210118.GE12659@tarantula.localdomain>
References: <20141103201517.GA9814@tarantula.localdomain>
	<20141103214510.GI5402@vapier.wh0rd.info>
	<20141103221828.GD9814@tarantula.localdomain>
	<20141103225247.GJ5402@vapier.wh0rd.info>
MIME-Version: 1.0
In-Reply-To: <20141103225247.GJ5402@vapier.wh0rd.info>
Subject: Re: [LTP] [PATCH] file_test: fix testcase for ppc64le
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7662173209342450688=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============7662173209342450688==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2014 at 05:52:47PM -0500, Mike Frysinger wrote:
> the test requires `cc` to be installed and fully functional.  that means=
=20
> binutils also have to be installed (`as` and `ld`).  i'm not aware of any=
=20
> distro that splits `readelf` out from the others.

Ok, it's reasonable to assume readelf is installed then.

The patch below adds two different checks for endiannes: first a simple
check of the ASCII character "I" in octal, then the readelf test.  If
neither test works it logs an error.

           =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

file_test: fix testcase for ppc64le

The file_test.sh test assumes all PPC systems are big-endian (MSB), but
this assumption is incorrect on the new ppc64le little-endian (LSB)
systems and file06 and file10 report false failures:

file06      0  TINFO  :  TEST #6: file command recognizes ELF executables
file06      6  TFAIL  :  ltpapicmd.c:156: file: Failed to Recognize ELF bin=
ary executable. Reason:
/tmp//cprog: ELF 64-bit LSB executable, version 1 (SYSV), dynamically linke=
d (uses shared libs), ...
=2E..
file10      0  TINFO  :  TEST #10: file command recognizes vmlinu file
file10     10  TFAIL  :  ltpapicmd.c:156: file: Failed to Recognize vmlinu =
correctly. Reason:
/boot/vmlinuz: ELF 64-bit LSB shared object, version 1 (SYSV), statically l=
inked, ...

This patch adds more robust testing for the endianness of a CPU.

Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>
---
 testcases/commands/ade/file/file_test.sh | 32 ++++++++++++++++++++++------=
----
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/=
ade/file/file_test.sh
index 101a8cca8bc9..b94ad2313a31 100755
--- a/testcases/commands/ade/file/file_test.sh
+++ b/testcases/commands/ade/file/file_test.sh
@@ -332,16 +332,7 @@ fi
=20
=20
 # TEST #6
-# Test if file command can recognize ELF binay executables
-
-# Check ppc architecture
-  TEST_ARCH=3DLSB   # Assume the architecture is Intel
-
-  if uname -m |
-    grep -qe '\(m68k\)\|\(sparc\)\|\(mips\b\)\|\(mipseb\)\|\(sh.eb\)' \
-         -e '\(powerpc\)\|\(ppc\)\|\(s390\)\|\(parisc\)'; then
-     TEST_ARCH=3DMSB
-  fi
+# Test if file command can recognize ELF binary executables
=20
 export TCID=3Dfile06
 export TST_COUNT=3D6
@@ -349,6 +340,27 @@ export TST_COUNT=3D6
 $LTPBIN/tst_resm TINFO \
         "TEST #6: file command recognizes ELF executables"
=20
+# check for CPU endianness
+TEST_ARCH=3DNULL
+ENDIAN=3D$(echo -n I | od -to2 2>/dev/null |
+             awk '{print substr($2,6,1); exit}' 2>/dev/null)
+if [ "$ENDIAN" =3D "0" ]; then
+    TEST_ARCH=3DMSB
+elif [ "$ENDIAN" =3D "1" ]; then
+    TEST_ARCH=3DLSB
+else
+    READELF=3D$(which readelf 2>/dev/null)
+    ENDIAN=3D$($READELF -h $READELF 2>/dev/null | grep endian)
+    if echo $ENDIAN | grep -q 'Data:.*big endian' ; then
+        TEST_ARCH=3DMSB
+    elif echo $ENDIAN | grep -q 'Data:.*little endian' ; then
+        TEST_ARCH=3DLSB
+    fi
+fi
+
+if [ "$TEST_ARCH" =3D "NULL" ]; then
+    $LTPBIN/tst_resm TFAIL "file: Could not determine CPU endianness"
+fi
=20
 cat > $LTPTMP/cprog.c <<EOF
 #include <stdio.h>

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJUWT6eAAoJEHUSMhRJf0WVBHcH/RYbUzRzKt8iqEW77Vrdi8gz
YqySgLYKFAJSNr8TwiA8cSesyeaVkDAR8cObt/sRKfCyl9cr2m8ckx1P/DCIOrKR
w9m4/QfdaMUHZtevSDN1qq4wQnXcuJSPNY+VxqaQzgbusodj06f/pE7F2QbF3o5a
a95BxUayyaaDB9AW6WkRt0QF38A8WnSjUdVdJuGpC9kq2Qc4hcWfwOJuKzwq/pjW
/DFScYv2ZrXFWzyjPvqGLlJrfYlvGOhsmdV8wi142L98uDMS5O9ySymLGwcTTWwB
QOQIw64qhvP+nq5iwN//CQuCW4+64/rYnIu42Xoe9Iiec04KZIGcU3rZoi8mC/s=
=CGcM
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--


--===============7662173209342450688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============7662173209342450688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7662173209342450688==--

