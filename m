Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1Xm5SK-0006ng-Lm
	for ltp-list@lists.sourceforge.net; Wed, 05 Nov 2014 18:37:20 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xm5SF-0005uV-3V
	for ltp-list@lists.sourceforge.net; Wed, 05 Nov 2014 18:37:20 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sA5Ib8EJ016154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Nov 2014 13:37:08 -0500
Received: from tarantula.localdomain (dhcp-176-121.dfw.redhat.com
	[10.15.176.121])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id sA5Ib6ZV002707
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Nov 2014 13:37:08 -0500
Date: Wed, 5 Nov 2014 12:37:06 -0600
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20141105183706.GA4361@tarantula.localdomain>
References: <20141103201517.GA9814@tarantula.localdomain>
	<20141103214510.GI5402@vapier.wh0rd.info>
	<20141103221828.GD9814@tarantula.localdomain>
	<20141103225247.GJ5402@vapier.wh0rd.info>
	<20141104210118.GE12659@tarantula.localdomain>
	<20141105021415.GM5402@vapier.wh0rd.info>
MIME-Version: 1.0
In-Reply-To: <20141105021415.GM5402@vapier.wh0rd.info>
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
Content-Type: multipart/mixed; boundary="===============6418883413836665333=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============6418883413836665333==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2014 at 09:14:15PM -0500, Mike Frysinger wrote:
> interesting idea.  there's a few issues with this code, but rather
> than get into that, why don't ew just rely on readelf and be done ?  i
> don't think we want to maintain two code paths here.

I was just trying to give the test the best chance of finding the
endianness (just-in-case there's a rare system that does not have
readelf installed).  I suppose it would be simpler, though, to start
with just the readelf test and then add the backup check later if there
are any bug reports about a missing readelf command.

If a missing readelf command becomes a problem, there are a number of
other ways to check:
  1. echo -n I | od -to2
  2. lscpu | grep "Byte Order"
  3. python -c "import sys;print sys.byteorder;"
  4. perl -MConfig -e 'print $Config{byteorder};'
  5. a small C helper program since we know at least the compiler
     is installed

The patch below uses just the readelf command, and it uses your
simplified code path, and it also updates the comments at the top of the
test (I forgot that in my earlier patches).

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
 testcases/commands/ade/file/file_test.sh | 44 +++++++++++++++++-----------=
----
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/=
ade/file/file_test.sh
index 101a8cca8bc9..59ec85e45b31 100755
--- a/testcases/commands/ade/file/file_test.sh
+++ b/testcases/commands/ade/file/file_test.sh
@@ -75,20 +75,17 @@
 # -------
 #   Similar test(as Test02) is performed with C program text
 #
-# Test06: Test if file command can recognize ELF binay executables
+# Test06: Test if file command can recognize ELF binary executables
 # -------
-# 1) Grep for 'm68k' or 'sparc' or 'mips' or 'mipseb' or 'sh.eb'
-#    or 'powerpc' or 'ppc' or 's390' from the output of the command
-#    'uname -m'
-# 2) If the above step is successful, assign string 'MSB' to variable
-#    TARGET_ARCH else assign string 'LSB'
-# 3) Write small C program to a known '.c' file
-# 4) Compile it using "cc"
+# 1) Use readelf to determine if the host is big- or little-endian
+#    and assign TEST_ARCH the string "MSB" or "LSB" respectively
+# 2) Write small C program to a known '.c' file
+# 3) Compile it using "cc"
 #    Ex: cc xyz xyz.c
-# 5) Use file command to get the type of the object file
-# 6) Grep for the string "ELF .*-bit $TEST_ARCH executable, .*"
+# 4) Use file command to get the type of the object file
+# 5) Grep for the string "ELF .*-bit $TEST_ARCH executable, .*"
 #    in the output of the 'file' command
-# 7) If the above command is successful, declare test as PASS
+# 6) If the above command is successful, declare test as PASS
 #    else declare test as FAIL
 #
 # Test07: Test if file command can recognize tar files
@@ -332,16 +329,7 @@ fi
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
@@ -349,6 +337,20 @@ export TST_COUNT=3D6
 $LTPBIN/tst_resm TINFO \
         "TEST #6: file command recognizes ELF executables"
=20
+# check for CPU endianness
+READELF=3D$(which readelf 2>/dev/null)
+case $(${READELF} -h ${READELF}) in
+    *Data:*"big endian"*)
+        TEST_ARCH=3DMSB
+        ;;
+    *Data:*"little endian"*)
+        TEST_ARCH=3DLSB
+        ;;
+    *)
+        TEST_ARCH=3DNULL
+        $LTPBIN/tst_resm TFAIL "file: Could not determine CPU endianness"
+        ;;
+esac
=20
 cat > $LTPTMP/cprog.c <<EOF
 #include <stdio.h>

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJUWm5SAAoJEHUSMhRJf0WVhowH/0/MSytW1n5uF0/zaiHjfWzy
MvbfsP2t4sbICMDEATb/qgYkpB+jjK2z5ZX9pHZSUlAOcXGXC63D8G9WGeXxhhKk
8xC055q/tdo2GUzNxFvOfsYOEp7q8JwLjZHdbC9cQVtzwtvmrZ957OUl+pj8uIfe
xr0qmFRvHe1eL56xjr6okTNWzSAtgDP8ZaCaKgnlXXgSxNV+HWefwmtt5cQ4zmYB
WVJ77zLoiq+OK/9Hh9bXSFg0l5KNPpL+zz9Z4NwpG7R0JN+ue2aEY1PsUe+9ZHYz
UUpZU6jkiHdScEksCz7+t/AbPN1T8YHRdQIK2X1P26KV4nPsmP9MmwZHjtfMZIE=
=ieor
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--


--===============6418883413836665333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6418883413836665333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6418883413836665333==--

