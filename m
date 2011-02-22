Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <cristian@regolo.cc>) id 1ProvA-0003C1-4F
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 09:52:40 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Prov8-0006ck-OZ
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 09:52:40 +0000
Received: from regolo (85-18-251-172.ip.fastwebnet.it [85.18.251.172])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id B6ECE64
	for <ltp-list@lists.sourceforge.net>;
	Tue, 22 Feb 2011 10:52:32 +0100 (CET)
Date: Tue, 22 Feb 2011 10:52:30 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110222105230.0f9fe24b@regolo>
Mime-Version: 1.0
Subject: [LTP] [PATCH] clone06 syscall testcase: use PWD instead of TERM
 environment variable.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4383157934191192143=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4383157934191192143==
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/FHYms1i79NQi=jYv5te/m5Q";
	protocol="application/pgp-signature"

--Sig_/FHYms1i79NQi=jYv5te/m5Q
Content-Type: multipart/mixed; boundary="MP_/qYUL4Td=9K=QWwXxLZz+mI3"

--MP_/qYUL4Td=9K=QWwXxLZz+mI3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

please consider the following patch for the 'clone06' syscall test.

When running the test on a remote host with an ssh command the TERM environ=
ment
variable is not available. Use PWD instead, with a buffer size of MAXPATHLE=
N.

This is to show how using the TERM variable results in unexpected behavior:

>>> cristian@regolo:~$ ssh aiolia env | grep TERM
>>> cristian@regolo:~$ ssh aiolia
Last login: ...
>>> cristian@aiolia:~$ env | grep TERM
TERM=3Dxterm


Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 testcases/kernel/syscalls/clone/clone06.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)


Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

--MP_/qYUL4Td=9K=QWwXxLZz+mI3
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename=0001-clone06-syscall-testcase-use-PWD-instead-of-TERM-env.patch

diff --git a/testcases/kernel/syscalls/clone/clone06.c b/testcases/kernel/s=
yscalls/clone/clone06.c
index d79b302..8f797e3 100644
--- a/testcases/kernel/syscalls/clone/clone06.c
+++ b/testcases/kernel/syscalls/clone/clone06.c
@@ -42,12 +42,12 @@
  *	  Call clone()
  *
  *	  CHILD:
- *		get the value for environment variable, TERM  and write it
+ *		get the value for environment variable PWD and write it
  *		to pipe.
  *
  *	  PARENT:
- *		Reads the value for environment variable, TERM from pipe.
- *		Compare child's TERM value with that of parent,
+ *		Reads the value for environment variable PWD from pipe.
+ *		Compare child's PWD value with that of parent,
  *		if same,
  *			Test Passed.
  *		else
@@ -77,14 +77,13 @@
=20
 #include <errno.h>
 #include <sched.h>
+#include <sys/param.h> /* for MAXPATHLEN */
 #include <sys/wait.h>
 #include <fcntl.h>
 #include "test.h"
 #include "usctest.h"
 #include "clone_platform.h"
=20
-#define MAX_LINE_LENGTH 256
-
 static void setup();
 static void cleanup();
 static int child_environ();
@@ -101,7 +100,7 @@ int main(int ac, char **av)
 	char *msg;		/* message returned from parse_opts */
 	void *child_stack;	/* stack for child */
 	char *parent_env;
-	char buff[MAX_LINE_LENGTH];
+	char buff[MAXPATHLEN];
=20
 	/* parse standard options */
 	if ((msg =3D parse_opts(ac, av, NULL, NULL)) !=3D NULL)
@@ -146,7 +145,7 @@ int main(int ac, char **av)
 			tst_resm(TWARN|TERRNO, "close(pfd[0]) failed");
 		}
=20
-		parent_env =3D getenv("TERM");
+		parent_env =3D getenv("PWD");
=20
 		if ((strcmp(buff, parent_env)) =3D=3D 0) {
 			tst_resm(TPASS, "Test Passed");
@@ -186,24 +185,24 @@ void cleanup()
=20
 /*
  * child_environ() -	function executed by child.
- *			Gets the value for environment variable,TERM &
+ *			Gets the value for environment variable PWD and
  *			writes it to  a pipe.
  */
 int child_environ(void)
 {
=20
-	char var[MAX_LINE_LENGTH];
+	char var[MAXPATHLEN];
=20
 	/* Close read end from child */
 	if ((close(pfd[0])) =3D=3D -1) {
 		tst_brkm(TBROK|TERRNO, cleanup, "close(pfd[0]) failed");
 	}
=20
-	if ((sprintf(var, "%s", getenv("TERM") ? : "")) <=3D 0) {
+	if ((sprintf(var, "%s", getenv("PWD") ? : "")) <=3D 0) {
 		tst_resm(TWARN|TERRNO, "sprintf() failed");
 	}
=20
-	if ((write(pfd[1], var, MAX_LINE_LENGTH)) =3D=3D -1) {
+	if ((write(pfd[1], var, MAXPATHLEN)) =3D=3D -1) {
 		tst_resm(TWARN|TERRNO, "write to pipe failed");
 	}
=20
@@ -213,4 +212,4 @@ int child_environ(void)
 	}
=20
 	exit(0);
-}
\ No newline at end of file
+}

--MP_/qYUL4Td=9K=QWwXxLZz+mI3--

--Sig_/FHYms1i79NQi=jYv5te/m5Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNY4deAAoJEID329zPTTLkiqAP/3xIiOGMOuuIMT7LjDMaYyXW
UvTqJAw42MARcsKp2VB8eIzR6+FeJolr8ACosbY82f/OpwweilwTbSvn/9UQzZhK
LdjTFR8tLcbNtQWMXb2Ca12+xLyTb7yDMA+fruwmgthmNlJ3FKEpj1UV5sC3v1CI
xRCMaQhfUo30gGQiOyq0LfGYJXGe4uQzbNV4dX2lRN6MSMlRNQvJgUrxNStzOzSW
qwf0kWJT72IDtxyjiqdhDg2jTOo5gfhlTrXPLT+uhqNTZ+Zbcjd+0jHOjJ676378
vsgALJzQoGtBJDIDJDlwlSljBo9A2+rmmRklTfHqHin/3elBVtFCv3yemiD/bXxP
yewSLl5QPgtwN/JTx+o1umGjJT3V/1cTmRuhY26WoBkRC63FGmwgW3RTw3be9TZD
sbZGlGKQcwYvC6pnznnGVqZ3+sKpUR1KTYSnD0giDzR9eKCtDXobm2J8fKUgUau6
lVsnO+bxXr02ItrxpwlbCkCIOu4oNfPaQMTI8qqErT0xk88BbaS3o6URpHWkwgVy
qj8MfVz9VkNkFHi937/ELw+luGZd+3Wk7oT7BCY2ryKsbteSDGkk2u0VQEVZ8ZU8
LjheQerm28wZLxh4f/AuExAHEfXRmktXsAlMpQpgeB/kiKh1eL5/ob33ARWt9GR4
MIA/O+P57FEZB/dloM8R
=Kw0m
-----END PGP SIGNATURE-----

--Sig_/FHYms1i79NQi=jYv5te/m5Q--


--===============4383157934191192143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Index, Search & Analyze Logs and other IT data in Real-Time with Splunk 
Collect, index and harness all the fast moving IT data generated by your 
applications, servers and devices whether physical, virtual or in the cloud.
Deliver compliance at lower cost and gain new business insights. 
Free Software Download: http://p.sf.net/sfu/splunk-dev2dev
--===============4383157934191192143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4383157934191192143==--

