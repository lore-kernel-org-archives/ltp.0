Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <cristian@regolo.cc>) id 1PtMdt-0002Yx-Uz
	for ltp-list@lists.sourceforge.net; Sat, 26 Feb 2011 16:05:13 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PtMds-0004KX-Et
	for ltp-list@lists.sourceforge.net; Sat, 26 Feb 2011 16:05:13 +0000
Received: from regolo (93-46-32-253.ip105.fastwebnet.it [93.46.32.253])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id F0F1B64
	for <ltp-list@lists.sourceforge.net>;
	Sat, 26 Feb 2011 17:05:05 +0100 (CET)
Date: Sat, 26 Feb 2011 17:05:38 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110226170538.69eea71a@regolo>
Mime-Version: 1.0
Subject: [LTP] [PATCH] Make fs_inod script shell agnostic
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5887217623565083030=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5887217623565083030==
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/PX3aI+RHYddImb8cLfZD7KB";
	protocol="application/pgp-signature"

--Sig_/PX3aI+RHYddImb8cLfZD7KB
Content-Type: multipart/mixed; boundary="MP_//n8_5DHP4rI4+gh.=zzItCW"

--MP_//n8_5DHP4rI4+gh.=zzItCW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this patch will fix bashisms in fs_inod test script, i.e. it will be
shell agnostic.


Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 testcases/kernel/fs/fs_inod/fs_inod |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)


Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

--MP_//n8_5DHP4rI4+gh.=zzItCW
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename=0001-Make-fs_inod-script-shell-agnostic.patch

diff --git a/testcases/kernel/fs/fs_inod/fs_inod b/testcases/kernel/fs/fs_i=
nod/fs_inod
index 39d7302..b7b6bd4 100755
--- a/testcases/kernel/fs/fs_inod/fs_inod
+++ b/testcases/kernel/fs/fs_inod/fs_inod
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 #
 #
@@ -51,9 +51,9 @@
 #
 # RETURNS:              None.
 #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
-function err_log
+err_log()
 {
-    let step_errors=3D$step_errors+1
+    step_errors=3D$(($step_errors+1))
 }
=20
=20
@@ -66,7 +66,7 @@ function err_log
 #
 # RETURNS: 		None.
 #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
-function make_subdirs=20
+make_subdirs ()
 {
     i=3D0;
     while [ "$i" -lt "$numsubdirs" ]; do
@@ -74,7 +74,7 @@ function make_subdirs
             echo "$0: mkdir dir$i"
             mkdir -p dir$i || echo "mkdir dir$i FAILED"
         }
-	let i=3D"$i + 1"
+	i=3D$(($i + 1))
     done;
 }=20
=20
@@ -88,7 +88,7 @@ function make_subdirs
 #
 # RETURNS: 		None.
 #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
-function touch_files=20
+touch_files()
 {
     echo "$0: touch files [0-$numsubdirs]/file$numsubdirs[0-$numfiles]"
     j=3D0;
@@ -99,10 +99,10 @@ function touch_files
=20
 	while [ "$k" -lt "$numfiles" ]; do =20
 	    >file$j$k || err_log ">file$j$k FAILED"
-	    let k=3D"$k + 1"
+	    k=3D$(($k + 1))
 	done
=20
-	let j=3D"$j + 1"
+	j=3D$(($j + 1))
 	cd ..
     done
 }
@@ -117,7 +117,7 @@ function touch_files
 #
 # RETURNS: 	None.
 #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
-function rm_files=20
+rm_files()
 {
     echo "$0: rm files [0-$numsubdirs]/file$numsubdirs[0-$numfiles]"
     j=3D0;
@@ -128,10 +128,10 @@ function rm_files
=20
 	while [ "$k" -lt "$numfiles" ]; do =20
 	    rm -f file$j$k || err_log "rm -f file$j$k FAILED"
-	    let k=3D"$k + 1"
+	    k=3D$(($k + 1))
 	done
=20
-	let j=3D"$j + 1"
+	j=3D$(($j + 1))
 	cd ..
     done
 }
@@ -146,7 +146,7 @@ function rm_files
 #
 # RETURNS: 		None.
 #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
-function step1=20
+step1 ()
 {=20
     echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
     echo "MULTIPLE PROCESSES CREATING AND DELETING FILES"
@@ -199,7 +199,7 @@ function step1
 	rm_files &
 	pid1=3D$!
=20
-	let i=3D"$i + 1"
+	i=3D$(($i + 1))
     done
=20
     # wait for all background processes to complete execution
@@ -244,7 +244,7 @@ function step1
          step$I
          if [ $? !=3D 0 ]; then
             echo "step$I failed - see above errors"
-            let ERRORS=3D$ERRORS+$step_errors
+            ERRORS=3D$(($ERRORS+$step_errors))
          fi
     done  =20
=20

--MP_//n8_5DHP4rI4+gh.=zzItCW--

--Sig_/PX3aI+RHYddImb8cLfZD7KB
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNaSTSAAoJEID329zPTTLkXYAP+wRIsMjZHqjL1cHHltni+uFV
mv/W5XGtX9jzW5ylcVjckjy/9XJlDHLYa4mk/hhV+ha9eAAQlhoOt6oWl42y2NZY
ri7uXJ7LXDfEjvR+27AG5XXdTwEZsZINasmhvEQjgCoL9RXlNnVbdUjHc88UbQcR
AISPKATchkTOc6O5NkLSirqq5rphcT79qClRKIzUeGe/xLp33smQ09/jqT3j+YvY
VfClQzS2N5vx9737VaGYKN08SZSnlzhOBmjB5Iv+97BwR/tIa9esW9jiBLO51sIS
66kQZpy5fQZFmOndOgdmuBHU/JRYLTLHFxqA/o9L34kOq0+J2bSPrBtuTr+f3w0l
eVaH2wkhsnyxUGlAqoy5QX9J6MbZi9feOKaPGb/JpGAAXCXnEKZRNsvF0xM9B9jj
XOpTzfDBwc4C7mGI3SHdtVv+gJhdGchtGET9dKKnkJR9n5v8VRch4l9A3GLtIh8F
+l7TzlWwxCgat3+4bpKe1Gnw2r9z2iUw/BAOYltTo/rXUtO8o1UHGtMNRiLOn2OY
QH3TGCDhUBxUKaWIQVciN7209TZAGR3eLz72CL6a68FpkAnSDrknC8R7jEBM+K4j
zivu4E5v6RQDwAot/TNbGNYLLdKrapg9NQUfDXydb4IgMLNAykAvG0oKt+5WEr5D
Xjxoo4hfysFz8w3Q1eLd
=coAT
-----END PGP SIGNATURE-----

--Sig_/PX3aI+RHYddImb8cLfZD7KB--


--===============5887217623565083030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
--===============5887217623565083030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5887217623565083030==--

