Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1P1By7-0002QQ-Bc
	for ltp-list@lists.sourceforge.net; Thu, 30 Sep 2010 05:46:11 +0000
Received: from out21.sjc.mx.trendmicro.com ([216.99.131.78])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P1By5-0002Mf-Op
	for ltp-list@lists.sourceforge.net; Thu, 30 Sep 2010 05:46:11 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.23])
	by out21.sjc.mx.trendmicro.com (Postfix) with ESMTP id B30B1980468
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Sep 2010 05:46:03 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 15D8E114B835
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Sep 2010 05:46:02 +0000 (UTC)
Message-ID: <000b01cb6062$9848f210$c8dad630$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 30 Sep 2010 14:44:48 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_14_44_51_Thursday_September_30_2010_31630"
Content-Language: ja
Subject: [LTP] [PATCH] fix "aio_error" test
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
To: ltp-list@lists.sourceforge.net
Cc: =?iso-2022-jp?B?GyRCYUQ6QhsoQiAbJEI3cjtUGyhC?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

----=_NextPart_ST_14_44_51_Thursday_September_30_2010_31630
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,


"conformance/interfaces/aio_error/3-1" failed with following message:
------------
conformance/interfaces/aio_error/3-1: execution: FAILED: Output: 
aio_error/3-1.c bad aio_read return value()
------------

This testset seems to be the error root test for "aio_error()".
Therefore, "aio_error()" must be called after failure of "aio_write()", 
I think.
But, "exit()" is called when expected failure of "aio_write()" occurred:
------------(3-1.c)
        if (aio_write(&aiocb) != 0)
 {
                printf(TNAME " bad aio_read return value()\n");
                exit(PTS_FAIL);
 }
------------

I think that "exit()" must be called when "aio_write()" succeeded.

And the message of unexpected movement of "aio_write()" is 
"aio_read()"'s one.
And the indent of this program "3-1.c" seems to include both space and tab.
I want to revise them, too.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
============
---
a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c	2010
-09-22 22:31:24.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c	2010
-09-30 09:51:42.000000000 +0900
@@ -36,42 +36,41 @@
 
 int main()
 {
-
-        char tmpfname[256];
+	char tmpfname[256];
 #define BUF_SIZE 512
-        char buf[BUF_SIZE];
-        int fd;
-        struct aiocb aiocb;
+	char buf[BUF_SIZE];
+	int fd;
+	struct aiocb aiocb;
 	int ret=0;
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
 		return PTS_UNSUPPORTED;
 
-        snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_3_1_%d",
-                  getpid());
-        unlink(tmpfname);
-        fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
-                  S_IRUSR | S_IWUSR);
-        if (fd == -1)
-        {
-                printf(TNAME " Error at open(): %s\n",
-                       strerror(errno));
-                exit(PTS_UNRESOLVED);
-        }
+	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_3_1_%d",
+			 getpid());
+	unlink(tmpfname);
+	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
+			  S_IRUSR | S_IWUSR);
+	if (fd == -1)
+	{
+		printf(TNAME " Error at open(): %s\n",
+			   strerror(errno));
+		exit(PTS_UNRESOLVED);
+	}
 
-        unlink(tmpfname);
+	unlink(tmpfname);
 
 	memset (&aiocb, 0, sizeof (struct aiocb));
 
-        aiocb.aio_fildes = fd;
-        aiocb.aio_buf = buf;
-        aiocb.aio_reqprio = -1;
-        aiocb.aio_nbytes = BUF_SIZE;
+	aiocb.aio_fildes = fd;
+	aiocb.aio_buf = buf;
+	aiocb.aio_reqprio = -1;
+	aiocb.aio_nbytes = BUF_SIZE;
 
-        if (aio_write(&aiocb) != 0)
+	if (aio_write(&aiocb) == 0)
 	{
-                printf(TNAME " bad aio_read return value()\n");
-                exit(PTS_FAIL);
+		printf(TNAME " bad aio_write return value()\n");
+		exit(PTS_FAIL);
 	}
 
 	while (aio_error (&aiocb) == EINPROGRESS);
============


Regards--

-Tomonori Mitani

----=_NextPart_ST_14_44_51_Thursday_September_30_2010_31630
Content-Type: application/octet-stream;
	name="3-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="3-1.patch"

--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c=
=092010-09-22 22:31:24.000000000 +0900=0A+++ b/testcases/open_posix_testsui=
te/conformance/interfaces/aio_error/3-1.c=092010-09-30 09:51:42.000000000 +=
0900=0A@@ -36,42 +36,41 @@=0A =0A int main()=0A {=0A-=0A-        char tmpfn=
ame[256];=0A+=09char tmpfname[256];=0A #define BUF_SIZE 512=0A-        char=
 buf[BUF_SIZE];=0A-        int fd;=0A-        struct aiocb aiocb;=0A+=09cha=
r buf[BUF_SIZE];=0A+=09int fd;=0A+=09struct aiocb aiocb;=0A =09int ret=3D0;=
=0A =0A =09if (sysconf(_SC_ASYNCHRONOUS_IO) !=3D 200112L)=0A =09=09return P=
TS_UNSUPPORTED;=0A =0A-        snprintf(tmpfname, sizeof(tmpfname), "/tmp/p=
ts_aio_error_3_1_%d",=0A-                  getpid());=0A-        unlink(tmp=
fname);=0A-        fd =3D open(tmpfname, O_CREAT | O_RDWR | O_EXCL,=0A-    =
              S_IRUSR | S_IWUSR);=0A-        if (fd =3D=3D -1)=0A-        {=
=0A-                printf(TNAME " Error at open(): %s\n",=0A-             =
          strerror(errno));=0A-                exit(PTS_UNRESOLVED);=0A-   =
     }=0A+=09snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_3_1_%=
d",=0A+=09=09=09 getpid());=0A+=09unlink(tmpfname);=0A+=09fd =3D open(tmpfn=
ame, O_CREAT | O_RDWR | O_EXCL,=0A+=09=09=09  S_IRUSR | S_IWUSR);=0A+=09if =
(fd =3D=3D -1)=0A+=09{=0A+=09=09printf(TNAME " Error at open(): %s\n",=0A+=09=
=09=09   strerror(errno));=0A+=09=09exit(PTS_UNRESOLVED);=0A+=09}=0A =0A-  =
      unlink(tmpfname);=0A+=09unlink(tmpfname);=0A =0A =09memset (&aiocb, 0=
, sizeof (struct aiocb));=0A =0A-        aiocb.aio_fildes =3D fd;=0A-      =
  aiocb.aio_buf =3D buf;=0A-        aiocb.aio_reqprio =3D -1;=0A-        ai=
ocb.aio_nbytes =3D BUF_SIZE;=0A+=09aiocb.aio_fildes =3D fd;=0A+=09aiocb.aio=
_buf =3D buf;=0A+=09aiocb.aio_reqprio =3D -1;=0A+=09aiocb.aio_nbytes =3D BU=
F_SIZE;=0A =0A-        if (aio_write(&aiocb) !=3D 0)=0A+=09if (aio_write(&a=
iocb) =3D=3D 0)=0A =09{=0A-                printf(TNAME " bad aio_read retu=
rn value()\n");=0A-                exit(PTS_FAIL);=0A+=09=09printf(TNAME " =
bad aio_write return value()\n");=0A+=09=09exit(PTS_FAIL);=0A =09}=0A =0A =09=
while (aio_error (&aiocb) =3D=3D EINPROGRESS);=0A
----=_NextPart_ST_14_44_51_Thursday_September_30_2010_31630
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
----=_NextPart_ST_14_44_51_Thursday_September_30_2010_31630
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_14_44_51_Thursday_September_30_2010_31630--

