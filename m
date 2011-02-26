Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <cristian@regolo.cc>) id 1PtTaD-0002ng-SK
	for ltp-list@lists.sourceforge.net; Sat, 26 Feb 2011 23:29:53 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PtTaC-00072T-KT
	for ltp-list@lists.sourceforge.net; Sat, 26 Feb 2011 23:29:53 +0000
Date: Sun, 27 Feb 2011 00:30:34 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110227003034.16263db3@regolo>
In-Reply-To: <AANLkTi=iT+dYAW4K9JGW9BD1vau0s6e8d+QOgvzrryS4@mail.gmail.com>
References: <AANLkTi=iT+dYAW4K9JGW9BD1vau0s6e8d+QOgvzrryS4@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1154022802947654297=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============1154022802947654297==
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/VMsUhWXslfn5eMQt0I7pKjG";
	protocol="application/pgp-signature"

--Sig_/VMsUhWXslfn5eMQt0I7pKjG
Content-Type: multipart/mixed; boundary="MP_/t6ujasebp9g8EA03gIV52o4"

--MP_/t6ujasebp9g8EA03gIV52o4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Garrett,

find attached the modified patch.


Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 testcases/kernel/fs/fs_inod/fs_inod |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)


Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

--MP_/t6ujasebp9g8EA03gIV52o4
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename=0001-Make-fs_inod-script-shell-agnostic.patch

diff --git a/testcases/kernel/fs/fs_inod/fs_inod b/testcases/kernel/fs/fs_i=
nod/fs_inod
index 39d7302..b962dad 100755
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
+    : $((step_errors +=3D 1))
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
+	: $((i +=3D 1))
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
+	    : $((k +=3D 1))
 	done
=20
-	let j=3D"$j + 1"
+	: $((j +=3D 1))
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
+	    : $((k +=3D 1))
 	done
=20
-	let j=3D"$j + 1"
+	: $((j +=3D 1))
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
+	: $((i +=3D 1))
     done
=20
     # wait for all background processes to complete execution
@@ -244,7 +244,7 @@ function step1
          step$I
          if [ $? !=3D 0 ]; then
             echo "step$I failed - see above errors"
-            let ERRORS=3D$ERRORS+$step_errors
+            : $((ERRORS +=3D step_errors))
          fi
     done  =20
=20

--MP_/t6ujasebp9g8EA03gIV52o4--

--Sig_/VMsUhWXslfn5eMQt0I7pKjG
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNaY0aAAoJEID329zPTTLkmdQP+QHLKU3e12FiFCE5LXxmDRQi
pgV+hVykT63R5j/zJwTLHSpp006z3cJ7M5yVS9Pl9vrCx93nXXgMWy0008EhH7dL
MOGFn1VNOQEotip8WECHZP0VhFe6sSwr6DPBB14gd2W9+DWmPdjbKNrlAwr6GxaW
IDMN7lWmZptJQn5yqkKNYOHGU2FKi3EY/gMUNg2XVSii0960q/hFa6fka/yKPyFa
QmlUv8vOaNMHXGm+MNBT8w2qHJ3ahAQjyYnJbGo3kwIvVqrTStF+RY5FJYIByR6x
N++fqgncWqQ3VJ0UHvpfomTac90G/qTKhLcWyE6xJJYG1qbx9moF1sM64pLPbnlf
i1FF14Ru1AY1DGzkTflQw1wfgTVTemV0nBXlyGExPhtPse07Po6tpJF9hQW37uZH
en8+moeLSh0ukPpunjtOa7HH3ipnaRp+NV/AeLx+KRn0imVlrJszJqQ+zTpmfSIx
keNH2BhN+UtpqF4em6MSzRgtUSCLm9sCuaos/gdo4OGLcFROTXYjur/bcAGQfVk4
MHU9F0eSdELx+0U2w0d4n1XtrWunHDFYIjLvkuz9NFGTCNpgzWUJ0IxeDa1c0Pa8
wabwtooNi5TOpXHiYLrVd9Sr2fTB29s3GLKDuI5TWvMBdat6d5VlZzxS9zMvrcku
GonLaWthecoO8k3RD+2h
=xfzm
-----END PGP SIGNATURE-----

--Sig_/VMsUhWXslfn5eMQt0I7pKjG--


--===============1154022802947654297==
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
--===============1154022802947654297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1154022802947654297==--

