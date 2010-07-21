Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1ObTfR-0007Ql-Mr
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 07:24:37 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1ObTfP-0006BN-B6
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 07:24:37 +0000
Date: Wed, 21 Jul 2010 03:24:25 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <548688492.713411279697065260.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1254189541.713331279696879608.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_31087_480419438.1279697065258"
Subject: Re: [LTP] [11/12 FAILURE] LTP? file test fails
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>

------=_Part_31087_480419438.1279697065258
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:=20
>=20

On May 5, 2010, at 11:58 PM, Subrata Modak wrote:=20



Subject: LTP=C5=9B file_test fails=20
>=20
> Issues Description below:=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> # vi runtest/file_test=20
> file export TCdat=3D$LTPROOT/testcases/bin; file_test.sh=20
> <EOF>=20
>=20
> Run LTP with the following command:=20
> # ./runltp -f file_test=20
> <<<test_output>>>=20
> file01 0 TINFO : TEST #1: file command recogizes ASCII text files=20
> file01 1 TPASS : file: Recognised ASCII file correctly=20
> file02 0 TINFO : TEST #2: file command recognizes bash shell scripts=20
> file02 2 TPASS : file: Recognised bash shell script correctly=20
> file03 0 TINFO : TEST #3: file command recognizes korn shell scripts=20
> file03 3 TPASS : file: recognised korn shell script=20
> file04 0 TINFO : TEST #4: file command recognizes C shell scripts=20
> file04 4 TPASS : file: Recognised C shell script correctly=20
> file05 0 TINFO : TEST #5: file command recognizes C programs text=20
> file05 5 TPASS : file: Recognised C program text correctly=20
> file06 0 TINFO : TEST #6: file command recognizes ELF executables=20
> file06 6 TPASS : file: Recognized ELF binary executable=20
> file07 0 TINFO : TEST #7: file command recognizes tar files.=20
> file07 7 TPASS : file: Recognised tar files=20
> file08 0 TINFO : TEST #8: file command recognizes tar zip files=20
> file08 8 TPASS : file: Recognised tar zip file=20
> file09 0 TINFO : TEST #9: file command recognizes RPM files=20
> file09 9 TFAIL : file: Failed to Recognize RPM file. Reason:=20
> /root/rpmbuild/SRPMS/cprog-0.0.7-3.src.rpm: RPM v3.0 src=20
> file10 0 TINFO : TEST #10: file command recognizes vmlinu file=20
> file10 10 TPASS : file: Recognised vmlinu file correctly=20
> <<<execution_status>>>=20
> initiation_status=3D"ok"=20
> duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno=
=20
> cutime=3D7 cstime=3D18=20
> <<<test_end>>>=20
>=20
> This is why:=20
> grep "RPM v3 src" $LTPTMP/file.out > /dev/null 2>&1=20
> change that to=20
> egrep "RPM v3(\.0)? src" $LTPTMP/file.out > /dev/null 2>&1=20
> -- that should work.=20

Hi Garrett, this fix does work. However I haven't see it in June release
nor in git repo.

Acked/Tested-By: Caspar Zhang <czhang@redhat.com>

--- a/testcases/commands/ade/file/file_test.sh  2010-04-01 14:23:09.0000000=
00 +0800
+++ b/testcases/commands/ade/file/file_test.sh  2010-05-14 16:42:53.9433809=
55 +0800
@@ -556,7 +556,7 @@
=20
 if [ $? -eq 0 ]
 then
-    grep "RPM v3 src" $LTPTMP/file.out > /dev/null 2>&1
+    egrep "RPM v3(\.0)? src" $LTPTMP/file.out > /dev/null 2>&1
     if [ $? -eq 0 ]
     then
         $LTPBIN/tst_resm TPASS "file: Recognised RPM file correctly"

Thanks,
Caspar

--=20
Quality Assurance Associate (Kernel) in=20
Red Hat Inc. (Beijing R&D Branch)=20

TEL: +86-10-62608150=20
Web: http://www.redhat.com/=20

------=_Part_31087_480419438.1279697065258
Content-Type: text/x-patch; name=commands-file01-rpm-check-fix.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=commands-file01-rpm-check-fix.patch

diff -Naur a/testcases/commands/ade/file/file_test.sh b/testcases/commands/ade/file/file_test.sh
--- a/testcases/commands/ade/file/file_test.sh	2010-04-01 14:23:09.000000000 +0800
+++ b/testcases/commands/ade/file/file_test.sh	2010-05-14 16:42:53.943380955 +0800
@@ -556,7 +556,7 @@
 
 if [ $? -eq 0 ]
 then
-    grep "RPM v3 src" $LTPTMP/file.out > /dev/null 2>&1
+    egrep "RPM v3(\.0)? src" $LTPTMP/file.out > /dev/null 2>&1
     if [ $? -eq 0 ]
     then
         $LTPBIN/tst_resm TPASS "file: Recognised RPM file correctly"

------=_Part_31087_480419438.1279697065258
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
------=_Part_31087_480419438.1279697065258
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_31087_480419438.1279697065258--

