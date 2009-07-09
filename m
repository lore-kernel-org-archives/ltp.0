Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MOnfC-0006u1-Hw
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 07:03:26 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOnf6-0005oH-Le
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 07:03:25 +0000
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 3683D65A6E
	for <ltp-list@lists.sourceforge.net>;
	Thu,  9 Jul 2009 07:03:16 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 9 Jul 2009 03:03:22 -0400
MIME-Version: 1.0
Message-Id: <200907090303.22607.vapier@gentoo.org>
Subject: [LTP] [rfc] extend test type field with tst_* functions
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0644671750810670843=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP <ltp-list@lists.sourceforge.net>

--===============0644671750810670843==
Content-Type: multipart/signed; boundary="nextPart2727592.MW3fmkcTr4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2727592.MW3fmkcTr4
Content-Type: multipart/mixed;
  boundary="Boundary-01=_6YZVK74AyG34BHK"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_6YZVK74AyG34BHK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the perceived problem: many many tests duplicate errno display and they do =
so=20
inconsistently.  many times the display is crappy and a lot less helpful th=
an=20
it could & should be.  a test should merely have to say "include the errno =
in=20
the test output" so it can focus on its own details.  much like the multitu=
de=20
of C library functions out there like perror() or printf's %m.

the proposed fix: extend the first argument to (1) take a define for the te=
st=20
result and (2) also accept optional bit fields to further manipulate the=20
output.  the advantage here is we dont have to add a whole lot of helper=20
functions to complement the existing ones.  i.e. a new tst_resmp() that wou=
ld=20
behave like tst_resm() but also append the errno output.

at the moment, the T* defines in test.h are set up like a bit field.  this =
is=20
silly because no where are these values treated like bits -- they're always=
=20
checked by their value.  so the first thing is to convert them to a linear=
=20
number map so we can stake out the lower 4 bits for the result.  this frees=
 up=20
higher bit values.

then two new output modifiers are added -- TERRNO and TTERRNO.  the former=
=20
appends errno output using the "errno" value while the latter uses=20
"TEST_ERRNO".  this allows us to convert both types of testing methods.  th=
e=20
output too is much more useful for people who are actually reviewing testin=
g=20
errors:
=2E...: errno=3DETXTBSY(26): Text file busy
the advantage of having all three is that you dont have to spend time looki=
ng=20
up the value you actually care about, and makes coordinating things easier=
=20
(like strace output and the test source code).

attached is the patch to do this implementation as well as an example of=20
converting mmap09 to the new interface
=2Dmike

--Boundary-01=_6YZVK74AyG34BHK
Content-Type: text/x-patch;
  charset="UTF-8";
  name="ltp-ttype-masks.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ltp-ttype-masks.patch"

=2D-- include/test.h
+++ include/test.h
@@ -44,13 +44,19 @@
=20
 #include "compiler.h"
=20
=2D#define TPASS    0    /* Test passed flag */
=2D#define TFAIL    1    /* Test failed flag */
=2D#define TBROK    2    /* Test broken flag */
=2D#define TWARN    4    /* Test warning flag */
=2D#define TRETR    8    /* Test retire flag */
=2D#define TINFO    16   /* Test information flag */
=2D#define TCONF    32   /* Test not appropriate for configuration flag */
+/* Use low 4 bits to encode test type */
+#define TTYPE_MASK 0xf
+#define TPASS      0    /* Test passed flag */
+#define TFAIL      1    /* Test failed flag */
+#define TBROK      2    /* Test broken flag */
+#define TWARN      3    /* Test warning flag */
+#define TRETR      4    /* Test retire flag */
+#define TINFO      5    /* Test information flag */
+#define TCONF      6    /* Test not appropriate for configuration flag */
+#define TTYPE_RESULT(ttype) ((ttype) & TTYPE_MASK)
+
+#define TERRNO     0x100   /* Append errno information to output */
+#define TTERRNO    0x200   /* Append TEST_ERRNO information to output */
=20
 /*
  * To determine if you are on a Umk or Unicos system,
@@ -179,6 +185,7 @@
 /*
  * Functions from lib/tst_res.c
  */
+const char *strttype(int ttype);
 void tst_res(int ttype, char *fname, char *arg_fmt, ...);
 void tst_resm(int ttype, char *arg_fmt, ...);
 void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ..=
=2E);
=2D-- lib/tst_res.c
+++ lib/tst_res.c
@@ -115,6 +115,7 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include "test.h"
+#include "usctest.h"
=20
 #define VERBOSE      1     /* flag values for the T_mode variable */
 #define CONDENSE     2
@@ -206,6 +207,80 @@ extern int  TST_TOTAL;  /* Total number=20
  */
 char *TESTDIR =3D NULL;
=20
+struct pair {
+	const char *name;
+	int val;
+};
+#define PAIR(def) [def] =3D { .name =3D #def, .val =3D def, },
+const char *pair_lookup(struct pair *pair, int pair_size, int idx)
+{
+	if (idx < 0 || idx >=3D pair_size || pair[idx].name =3D=3D NULL)
+		return "???";
+	return pair[idx].name;
+}
+#define pair_lookup(pair, idx) pair_lookup(pair, ARRAY_SIZE(pair), idx)
+
+/*
+ * strttype() - convert a type result to the human readable string
+ */
+const char *strttype(int ttype)
+{
+	struct pair ttype_pairs[] =3D {
+		PAIR(TPASS)
+		PAIR(TFAIL)
+		PAIR(TBROK)
+		PAIR(TRETR)
+		PAIR(TCONF)
+		PAIR(TWARN)
+		PAIR(TINFO)
+	};
+	return pair_lookup(ttype_pairs, TTYPE_RESULT(ttype));
+}
+
+/*
+ * strerrnodef() - convert an errno value to its C define
+ */
+static const char *strerrnodef(int err)
+{
+	struct pair errno_pairs[] =3D {
+		PAIR(EPERM)
+		PAIR(ENOENT)
+		PAIR(ESRCH)
+		PAIR(EINTR)
+		PAIR(EIO)
+		PAIR(ENXIO)
+		PAIR(E2BIG)
+		PAIR(ENOEXEC)
+		PAIR(EBADF)
+		PAIR(ECHILD)
+		PAIR(EAGAIN)
+		PAIR(ENOMEM)
+		PAIR(EACCES)
+		PAIR(EFAULT)
+		PAIR(ENOTBLK)
+		PAIR(EBUSY)
+		PAIR(EEXIST)
+		PAIR(EXDEV)
+		PAIR(ENODEV)
+		PAIR(ENOTDIR)
+		PAIR(EISDIR)
+		PAIR(EINVAL)
+		PAIR(ENFILE)
+		PAIR(EMFILE)
+		PAIR(ENOTTY)
+		PAIR(ETXTBSY)
+		PAIR(EFBIG)
+		PAIR(ENOSPC)
+		PAIR(ESPIPE)
+		PAIR(EROFS)
+		PAIR(EMLINK)
+		PAIR(EPIPE)
+		PAIR(EDOM)
+		PAIR(ERANGE)
+	};
+	return pair_lookup(errno_pairs, err);
+}
+
 /*
  * tst_res() - Main result reporting function.  Handle test information
  *             appropriately depending on output display mode.  Call
@@ -217,6 +292,7 @@ void tst_res(int ttype, char *fname, cha
 {
 	int  i;
 	char tmesg[USERMESG];
+	int ttype_result =3D TTYPE_RESULT(ttype);
=20
 #if DEBUG
 	printf("IN tst_res; Tst_count =3D %d; Tst_range =3D %d\n",
@@ -229,7 +305,7 @@ void tst_res(int ttype, char *fname, cha
 	 * Save the test result type by ORing ttype into the current exit
 	 * value (used by tst_exit()).
 	 */
=2D	T_exitval |=3D ttype;
+	T_exitval |=3D ttype_result;
=20
 	/*
 	 * Unless T_out has already been set by tst_environ(), make tst_res()
@@ -257,7 +333,7 @@ void tst_res(int ttype, char *fname, cha
 	 * Set the test case number and print the results, depending on the
 	 * display type.
 	 */
=2D	if (ttype =3D=3D TWARN || ttype =3D=3D TINFO) {
+	if (ttype_result =3D=3D TWARN || ttype_result =3D=3D TINFO) {
 		if (Tst_range > 1)
 			tst_print(TCID, 0, 1, TWARN,
 				  "tst_res(): Range not valid for TINFO or TWARN types");
@@ -303,6 +379,7 @@ void tst_res(int ttype, char *fname, cha
 static void tst_condense(int tnum, int ttype, char *tmesg)
 {
 	char *file;
+	int ttype_result =3D TTYPE_RESULT(ttype);
=20
 #if DEBUG
 	printf("IN tst_condense: tcid =3D %s, tnum =3D %d, ttype =3D %d, tmesg =
=3D %s\n",
@@ -314,7 +391,7 @@ static void tst_condense(int tnum, int t
 	 * If this result is the same as the previous result, return.
 	 */
 	if (Buffered =3D=3D TRUE) {
=2D		if (strcmp(Last_tcid, TCID) =3D=3D 0 && Last_type =3D=3D ttype &&
+		if (strcmp(Last_tcid, TCID) =3D=3D 0 && Last_type =3D=3D ttype_result &&
 		    strcmp(Last_mesg, tmesg) =3D=3D 0 && File =3D=3D NULL )
 			return;
=20
@@ -343,7 +420,7 @@ static void tst_condense(int tnum, int t
 		Last_tcid =3D (char *)malloc(strlen(TCID) + 1);
 		strcpy(Last_tcid, TCID);
 		Last_num =3D tnum;
=2D		Last_type =3D ttype;
+		Last_type =3D ttype_result;
 		Last_mesg =3D (char *)malloc(strlen(tmesg) + 1);
 		strcpy(Last_mesg, tmesg);
 		Buffered =3D TRUE;
@@ -381,7 +458,8 @@ void tst_flush(void)
  */
 static void tst_print(char *tcid, int tnum, int trange, int ttype, char *t=
mesg)
 {
=2D	char type[5];
+	const char *type;
+	int ttype_result =3D TTYPE_RESULT(ttype);
=20
 #if DEBUG
 	printf("IN tst_print: tnum =3D %d, trange =3D %d, ttype =3D %d, tmesg =3D=
 %s\n",
@@ -395,7 +473,7 @@ static void tst_print(char *tcid, int tn
 	 * also done here to catch internal warnings.  For internal warnings,
 	 * tst_print() is called directly with a case of TWARN.
 	 */
=2D	T_exitval |=3D ttype;
+	T_exitval |=3D ttype_result;
=20
 	/*
 	 * If output mode is DISCARD, or if the output mode is NOPASS and this
@@ -404,53 +482,33 @@ static void tst_print(char *tcid, int tn
 	 * tst_res(), since occasionally we get to this point without going
 	 * through tst_res() (e.g. internal TWARN messages).
 	 */
=2D	if (T_mode =3D=3D DISCARD || (T_mode =3D=3D NOPASS && ttype !=3D TFAIL =
&&
=2D	    ttype !=3D TBROK && ttype !=3D TWARN))
+	if (T_mode =3D=3D DISCARD || (T_mode =3D=3D NOPASS && ttype_result !=3D T=
=46AIL &&
+	    ttype_result !=3D TBROK && ttype_result !=3D TWARN))
 		return;
=20
 	/*
=2D	 * Fill in the type string according to ttype.
=2D	 */
=2D	switch (ttype) {
=2D		case TPASS:
=2D			strcpy(type, "PASS");
=2D		break;
=2D		case TFAIL:
=2D			strcpy(type, "FAIL");
=2D		break;
=2D		case TBROK:
=2D			strcpy(type, "BROK");
=2D		break;
=2D		case TRETR:
=2D			strcpy(type, "RETR");
=2D		break;
=2D		case TCONF:
=2D			strcpy(type, "CONF");
=2D		break;
=2D		case TWARN:
=2D			strcpy(type, "WARN");
=2D		break;
=2D		case TINFO:
=2D			strcpy(type, "INFO");
=2D		break;
=2D		default:
=2D			strcpy(type, "????");
=2D		break;
=2D	}
=2D
=2D	/*
 	 * Build the result line and print it.
 	 */
+	type =3D strttype(ttype);
 	if (T_mode =3D=3D VERBOSE) {
=2D		fprintf(T_out, "%-8s %4d  %s  :  %s\n", tcid, tnum, type, tmesg);
+		fprintf(T_out, "%-8s %4d  %s  :  %s", tcid, tnum, type, tmesg);
 	} else {
 		if (trange > 1)
=2D			fprintf(T_out, "%-8s %4d-%-4d  %s  :  %s\n",
+			fprintf(T_out, "%-8s %4d-%-4d  %s  :  %s",
 				tcid, tnum, tnum + trange - 1, type, tmesg);
 		else
=2D			fprintf(T_out, "%-8s %4d       %s  :  %s\n",
+			fprintf(T_out, "%-8s %4d       %s  :  %s",
 				tcid, tnum, type, tmesg);
 	}
+	if (ttype & TERRNO) {
+		int err =3D errno; /* avoid unintended side effects */
+		fprintf(T_out, ": errno=3D%s(%i): %s", strerrnodef(err),
+			err, strerror(err));
+	}
+	if (ttype & TTERRNO)
+		fprintf(T_out, ": TEST_ERRNO=3D%s(%i): %s", strerrnodef(TEST_ERRNO),
+			(int)TEST_ERRNO, strerror(TEST_ERRNO));
+	fprintf(T_out, "\n");
=20
 	/*
 	 * If tst_res() was called with a file, append file contents to the
@@ -559,6 +617,7 @@ int tst_environ(void)
 void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ..=
=2E)
 {
 	char tmesg[USERMESG];
+	int ttype_result =3D TTYPE_RESULT(ttype);
=20
 #if DEBUG
 	printf("IN tst_brk\n"); fflush(stdout);
@@ -570,10 +629,10 @@ void tst_brk(int ttype, char *fname, voi
 	/*
 	 * Only FAIL, BROK, CONF, and RETR are supported by tst_brk().
 	 */
=2D	if (ttype !=3D TFAIL && ttype !=3D TBROK && ttype !=3D TCONF &&
=2D	    ttype !=3D TRETR ) {
+	if (ttype_result !=3D TFAIL && ttype_result !=3D TBROK &&
+	    ttype_result !=3D TCONF && ttype_result !=3D TRETR) {
 		sprintf(Warn_mesg, "tst_brk(): Invalid Type: %d.  Using TBROK",
=2D			ttype);
+			ttype_result);
 		tst_print(TCID, 0, 1, TWARN, Warn_mesg);
 		ttype =3D TBROK;
 	}
@@ -641,8 +700,8 @@ void tst_brkloop(int ttype, char *fname,
 	if (ttype !=3D TFAIL && ttype !=3D TBROK && ttype !=3D TCONF &&
 	    ttype !=3D TRETR) {
 		sprintf(Warn_mesg,
=2D			"tst_brkloop(): Invalid Type: %d.  Using TBROK",
=2D			ttype);
+			"tst_brkloop(): Invalid Type: %d(%s).  Using TBROK",
+			ttype, strttype(ttype));
 		tst_print(TCID, 0, 1, TWARN, Warn_mesg);
 		ttype =3D TBROK;
 	}
@@ -805,7 +864,6 @@ int main(void)
 {
 	int  ttype;
 	int  range;
=2D	char *chrptr;
 	char chr;
 	char fname[MAXMESG];
=20
@@ -815,16 +873,18 @@ int main(void)
 	       -3 : call tst_brk()\n\
 	       -4 : call tst_brkloop()\n\
 	       -5 : call tst_res() with a range\n\
=2D	        0 : call tst_res(TPASS, ...)\n\
=2D	        1 : call tst_res(TFAIL, ...)\n\
=2D	        2 : call tst_res(TBROK, ...)\n\
=2D	        4 : call tst_res(TWARN, ...)\n\
=2D	        8 : call tst_res(TRETR, ...)\n\
=2D	       16 : call tst_res(TINFO, ...)\n\
=2D	       32 : call tst_res(TCONF, ...)\n\n");
+	       %2i : call tst_res(TPASS, ...)\n\
+	       %2i : call tst_res(TFAIL, ...)\n\
+	       %2i : call tst_res(TBROK, ...)\n\
+	       %2i : call tst_res(TWARN, ...)\n\
+	       %2i : call tst_res(TRETR, ...)\n\
+	       %2i : call tst_res(TINFO, ...)\n\
+	       %2i : call tst_res(TCONF, ...)\n\n",
+		TPASS, TFAIL, TBROK, TWARN, TRETR, TINFO, TCONF);
=20
 	while (1) {
=2D		printf("Enter ttype (-5,-4,-3,-2,-1,0,1,2,4,8,16,32): ");
+		printf("Enter ttype (-5,-4,-3,-2,-1,%i,%i,%i,%i,%i,%i,%i): ",
+			TPASS, TFAIL, TBROK, TWARN, TRETR, TINFO, TCONF);
 		scanf("%d%c", &ttype, &chr);
=20
 		switch (ttype) {
@@ -837,7 +897,8 @@ int main(void)
 			break;
=20
 			case -3:
=2D				printf("Enter the current type (1=3DFAIL, 2=3DBROK, 8=3DRETR, 32=3DC=
ONF): ");
+				printf("Enter the current type (%i=3DFAIL, %i=3DBROK, %i=3DRETR, %i=3D=
CONF): ",
+					TFAIL, TBROK, TRETR, TCONF);
 				scanf("%d%c", &ttype, &chr);
 				printf("Enter file name (<cr> for none): ");
 				gets(fname);
@@ -852,7 +913,8 @@ int main(void)
 				scanf("%d%c", &range, &chr);
 				Tst_lpstart =3D Tst_count;
 				Tst_lptotal =3D range;
=2D				printf("Enter the current type (1=3DFAIL, 2=3DBROK, 8=3DRETR, 32=3DC=
ONF): ");
+				printf("Enter the current type (%i=3DFAIL, %i=3DBROK, %i=3DRETR, %i=3D=
CONF): ",
+					TFAIL, TBROK, TRETR, TCONF);
 				scanf("%d%c", &ttype, &chr);
 				printf("Enter file name (<cr> for none): ");
 				gets(fname);
@@ -866,7 +928,8 @@ int main(void)
 			case -5:
 				printf("Enter the size of the range: ");
 				scanf("%d%c", &Tst_range, &chr);
=2D				printf("Enter the current type (0,1,2,4,8,16,32): ");
+				printf("Enter the current type (%i,%i,%i,%i,%i,%i,%i): ",
+					TPASS, TFAIL, TBROK, TWARN, TRETR, TINFO, TCONF);
 				scanf("%d%c", &ttype, &chr);
 			default:
 				printf("Enter file name (<cr> for none): ");

--Boundary-01=_6YZVK74AyG34BHK
Content-Type: text/x-patch; charset="UTF-8";
	name="ltp-mmap09-ttype-masks.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ltp-mmap09-ttype-masks.patch"

=2D-- testcases/kernel/syscalls/mmap/mmap09.c
+++ testcases/kernel/syscalls/mmap/mmap09.c
@@ -103,8 +103,7 @@ int main(int argc, char **argv)
=20
 			if (TEST_RETURN =3D=3D -1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
=2D				tst_resm(TFAIL, "%s - errnor: %d",
=2D					 TC[i].desc, TEST_ERRNO);
+				tst_resm(TFAIL|TTERRNO, "%s", TC[i].desc);
 			} else {
 				tst_resm(TPASS, TC[i].desc);
 			}
@@ -129,19 +128,16 @@ void setup()
 	tst_tmpdir();
=20
 	if ((fd =3D open("mmaptest", O_RDWR | O_CREAT, 0666)) < 0)
=2D		tst_brkm(TFAIL, cleanup, "failed to open mmaptest "
=2D			 "file, errno: %d", errno);
+		tst_brkm(TFAIL|TERRNO, cleanup, "open(mmaptest) file failed");
=20
 	/* ftruncate the file to 16k */
 	if (ftruncate(fd, mapsize) < 0)
=2D		tst_brkm(TFAIL, cleanup, "failed to ftruncate "
=2D			 "file, errno: %d", errno);
+		tst_brkm(TFAIL|TERRNO, cleanup, "ftruncate() file failed");
=20
 	maddr =3D mmap(0, (size_t) mapsize, PROT_READ | PROT_WRITE,
 		     MAP_FILE | MAP_SHARED, fd, (off_t) 0);
 	if (maddr =3D=3D MAP_FAILED)
=2D		tst_brkm(TFAIL, cleanup, "failed to mmap file, "
=2D			 "errno: %d", errno);
+		tst_brkm(TFAIL|TERRNO, cleanup, "mmap() file failed");
 	/* fill up the file with A's */
 	for (i =3D 0; i < mapsize; i++)
 		maddr[i] =3D 'A';

--Boundary-01=_6YZVK74AyG34BHK--

--nextPart2727592.MW3fmkcTr4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKVZY6AAoJEEFjO5/oN/WBU2EP/0cjvgtoOYSfzDpK22Q3h4hR
wf9kIbyVxJxCyt7iGWCBCX/+WUaqN2WCS7HNVcxcc2fLBGwN8ZgPOFt6sl1+g+R8
YQdHp8fJjQyHnJXO434FCu93NbYRO8DgdTCo0iMFMFWtsscAKprlrAmb9p1VloDE
p3cGClWcOirKfN8ZwbF0ou4rYXSCtEQaC81tB7zX/N1KSc3QFjz0jbvPBLSOKRDB
QubfAFlzsKkOanXsfrgrthkrPM517rd0Ee57EALxkGVaFN4QeYsEIsKF58mFfnzb
cTDabVC7eYsJ5UDbc42+ib2fhk3Sp0cC1Giw5NvDMa0H3k98PM6a/GTAbbTqK86l
RR+9vDdyYXqtRTvjQgwrt3F7DrmFwMETesvGNxQC0hk0RBmdDXQzh6Kf2RXx6Pkp
nlcGz4u6e9PVUik3u7fxbZ+NMpjUWLOHQiZKj5shNrI/P1Vc/cgwsRwJ4biw0+lR
ahEBLD4WDIFR0l4vM6yx0NdCJsx0ma3i4VQw9kPwuzesaHECtwQ5BfAt1Hm2e6Mj
LHwcy3YpXyDQzfcRCPz3yq3LtV2P3lryfshoov07iTyE2T7LGCW4bD6n+178ztdw
3wK4RFQKyTMCPxQK//BusqUH0JO9nkX0pgzth/ieeSOdRHw1rDsB8dQNE+sfSivf
KWC4QWiNBp3IEU7beQvS
=tLm4
-----END PGP SIGNATURE-----

--nextPart2727592.MW3fmkcTr4--


--===============0644671750810670843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============0644671750810670843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0644671750810670843==--

