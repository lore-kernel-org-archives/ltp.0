Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1Qc6fj-0003kc-Re
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 02:08:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Qc6ff-00025L-VO
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 02:08:03 +0000
Message-ID: <4E0BDA39.9020006@cn.fujitsu.com>
Date: Thu, 30 Jun 2011 10:06:49 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D8B1B3F.6010303@cn.fujitsu.com>	<BANLkTi=n_UeC_YOT3o-czzAhwu9GRUbWhw@mail.gmail.com>	<4D9EB736.2030907@cn.fujitsu.com>	<4DAF85AA.5080609@cn.fujitsu.com>	<4DB0FF1C.5060000@redhat.com>	<4DC91E94.6050907@cn.fujitsu.com>	<20110519144712.GA11838@saboteur.suse.cz>	<4DDB2D48.3040206@cn.fujitsu.com>	<4DF11877.7060503@cn.fujitsu.com>	<BANLkTimMsG4=CvqqQRG54Vm40yr8S1NWMw@mail.gmail.com>
	<4DF1E7E5.2080401@cn.fujitsu.com>
In-Reply-To: <4DF1E7E5.2080401@cn.fujitsu.com>
Content-Type: multipart/mixed; boundary="------------030802030409080300050607"
Subject: Re: [LTP] [PATCH] hugemmap01.c : Automatically mount hugetlbfs on
 /huge.
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
Cc: ltp-list@lists.sourceforge.net


--------------030802030409080300050607
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

hi,

Any comment to this patch? Thanks.:)

-- 
Best Regards,
Tang chen

--------------030802030409080300050607
Content-Type: text/plain;
 name="hugemmap.patch"
Content-Disposition: attachment;
 filename="hugemmap.patch"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: tangchen <tangchen@cn.fujitsu.com>=0A---=0A runtest/hugetlb =
                                   |    8 +-=0A testcases/kernel/mem/hugetl=
b/hugemmap/Makefile     |   27 +++++++-=0A testcases/kernel/mem/hugetlb/hug=
emmap/hugemmap01.c |   59 +++++++---------=0A testcases/kernel/mem/hugetlb/=
hugemmap/hugemmap02.c |   49 +++++++-------=0A testcases/kernel/mem/hugetlb=
/hugemmap/hugemmap03.c |   56 ++++++++--------=0A testcases/kernel/mem/huge=
tlb/hugemmap/hugemmap04.c |   41 +++++-------=0A testcases/kernel/mem/huget=
lb/hugemmap/lib/Makefile |   25 +++++++=0A testcases/kernel/mem/hugetlb/hug=
emmap/lib/libmnt.c |   70 ++++++++++++++++++++=0A testcases/kernel/mem/huge=
tlb/hugemmap/lib/libmnt.h |   27 ++++++++=0A 9 files changed, 245 insertion=
s(+), 117 deletions(-)=0A create mode 100644 testcases/kernel/mem/hugetlb/h=
ugemmap/lib/Makefile=0A create mode 100644 testcases/kernel/mem/hugetlb/hug=
emmap/lib/libmnt.c=0A create mode 100644 testcases/kernel/mem/hugetlb/hugem=
map/lib/libmnt.h=0A=0Adiff --git a/runtest/hugetlb b/runtest/hugetlb=0Ainde=
x af45868..641c2a6 100644=0A--- a/runtest/hugetlb=0A+++ b/runtest/hugetlb=
=0A@@ -1,7 +1,7 @@=0A-hugemmap01 hugemmap01 -H/tmp=0A-hugemmap02 hugemmap02=
 -H/tmp -c10=0A-hugemmap03 hugemmap03 -H/tmp -I2 -c10=0A-hugemmap04 hugemma=
p04 -H/tmp=0A+hugemmap01 hugemmap01=0A+hugemmap02 hugemmap02 -c10=0A+hugemm=
ap03 hugemmap03 -I2 -c10=0A+hugemmap04 hugemmap04=0A hugemmap05 hugemmap05=
=0A hugemmap05=5F1 hugemmap05 -m=0A hugemmap05=5F2 hugemmap05 -s=0Adiff --g=
it a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/=
hugetlb/hugemmap/Makefile=0Aindex a1ba46e..b89a040 100644=0A--- a/testcases=
/kernel/mem/hugetlb/hugemmap/Makefile=0A+++ b/testcases/kernel/mem/hugetlb/=
hugemmap/Makefile=0A@@ -20,8 +20,31 @@=0A # Garrett Cooper, July 2009=0A #=
=0A =0A-top=5Fsrcdir              ?=3D ../../../../..=0A+top=5Fsrcdir		?=3D=
 ../../../../..=0A =0A include $(top=5Fsrcdir)/include/mk/testcases.mk=0A-i=
nclude $(abs=5Fsrcdir)/../Makefile.inc=0A+=0A+LIBDIR			:=3D lib=0A+LIB			:=
=3D $(LIBDIR)/libmnt=5Fhugetlb.a=0A+FILTER=5FOUT=5FDIRS		:=3D $(LIBDIR)=0A+=
=0A+$(LIBDIR):=0A+	mkdir -p "$@"=0A+=0A+$(LIB): $(LIBDIR)=0A+	$(MAKE) -C $^=
 -f "$(abs=5Fsrcdir)/$^/Makefile" all=0A+=0A+CPPFLAGS                +=3D -=
I$(abs=5Fsrcdir)/$(LIBDIR)=0A+=0A+LDFLAGS                 +=3D -L$(abs=5Fbu=
ilddir)/$(LIBDIR)=0A+=0A+LDLIBS                  +=3D -lmnt=5Fhugetlb=0A+=
=0A+MAKE=5FDEPS		:=3D $(LIB)=0A+=0A+trunk-clean:: | lib-clean=0A+=0A+lib-cl=
ean:: $(LIBDIR)=0A+	$(MAKE) -C $^ -f "$(abs=5Fsrcdir)/$^/Makefile" clean=0A=
+=0A include $(top=5Fsrcdir)/include/mk/generic=5Fleaf=5Ftarget.mk=0Adiff -=
-git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kerne=
l/mem/hugetlb/hugemmap/hugemmap01.c=0Aindex 874f736..ddde10c 100644=0A--- a=
/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c=0A+++ b/testcases/kerne=
l/mem/hugetlb/hugemmap/hugemmap01.c=0A@@ -73,53 +73,42 @@=0A #include "test=
.h"=0A #include "usctest.h"=0A #include "system=5Fspecific=5Fhugepages=5Fin=
fo.h"=0A+#include "lib/libmnt.h"=0A =0A #define BUFFER=5FSIZE  256=0A =0A-c=
har* TEMPFILE=3D"mmapfile";=0A+char TEMPFILE[MAXPATHLEN];=0A =0A char *TCID=
=3D"hugemmap01";	/* Test program identifier.    */=0A int TST=5FTOTAL=3D1;	=
	/* Total number of test cases. */=0A long *addr;			/* addr of memory mappe=
d region */=0A int fildes;			/* file descriptor for tempfile */=0A-char *Ho=
pt;                     /* location of hugetlbfs */=0A-int beforetest=3D0;	=
	/* Amount of free huge pages before testing */=0A-int aftertest=3D0;		/* A=
mount of free huge pages after testing */=0A+int free=5Fhuge=5Fbefore=3D0;=
=0A+int free=5Fhuge=5Fafter=3D0;=0A int hugepagesmapped=3D0;		/* Amount of =
huge pages mapped after testing */=0A+char *mount=5Fpoint =3D NULL;=0A =0A-=
void setup();			/* Main setup function of test */=0A-void cleanup();			/* c=
leanup function for the test */=0A-=0A-void help()=0A-{=0A-	printf("  -H /.=
.  Location of hugetlbfs, i.e. -H /var/hugetlbfs \n");=0A-}=0A+void setup(v=
oid);=0A+void cleanup(void);=0A =0A int=0A main(int ac, char **av)=0A {=0A =
	int lc;			/* loop counter */=0A 	char *msg;		/* message returned from pars=
e=5Fopts */=0A-        int Hflag=3D0;              /* binary flag: opt or n=
ot */=0A 	int page=5Fsz=3D0;=0A =0A-       	option=5Ft options[] =3D {=0A- =
       	{ "H:",   &Hflag, &Hopt },    /* Required for location of hugetlbfs=
 */=0A-            	{ NULL, NULL, NULL }          /* NULL required to end a=
rray */=0A-       	};=0A+	option=5Ft options[] =3D {=0A+		{ NULL, NULL, NUL=
L }	/* NULL required to end array */=0A+	};=0A =0A 	/* Parse standard optio=
ns given to run the test. */=0A-	msg =3D parse=5Fopts(ac, av, options, &hel=
p);=0A+	msg =3D parse=5Fopts(ac, av, options, NULL);=0A 	if (msg !=3D (char=
 *) NULL) {=0A 		tst=5Fbrkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use -h=
elp", msg);=0A 		tst=5Fexit();=0A 	}=0A =0A-	if (Hflag =3D=3D 0) {=0A-		tst=
=5Fbrkm(TBROK, NULL, "-H option is REQUIRED for this test, use -h for optio=
ns help");=0A-		tst=5Fexit();=0A-	}=0A-=0A 	setup();=0A =0A 	for (lc =3D 0;=
 TEST=5FLOOPING(lc); lc++) {=0A@@ -134,7 +123,7 @@ main(int ac, char **av)=
=0A 		Tst=5Fcount=3D0;=0A =0A 		/* Note the number of free huge pages BEFOR=
E testing */=0A-		beforetest =3D get=5Fno=5Fof=5Ffree=5Fhugepages();=0A+		f=
ree=5Fhuge=5Fbefore =3D get=5Fno=5Fof=5Ffree=5Fhugepages();=0A =0A 		/* Not=
e the size of huge page size BEFORE testing */=0A 		page=5Fsz =3D hugepages=
=5Fsize();=0A@@ -159,8 +148,8 @@ main(int ac, char **av)=0A 		}=0A =0A 		/*=
 Make sure the number of free huge pages AFTER testing decreased */=0A-		af=
tertest =3D get=5Fno=5Fof=5Ffree=5Fhugepages();=0A-		hugepagesmapped =3D be=
foretest - aftertest;=0A+		free=5Fhuge=5Fafter =3D get=5Fno=5Fof=5Ffree=5Fh=
ugepages();=0A+		hugepagesmapped =3D free=5Fhuge=5Fbefore - free=5Fhuge=5Fa=
fter;=0A 		if (hugepagesmapped < 1) {=0A 			tst=5Fresm(TWARN,"Number of HUG=
EPAGES=5FFREE stayed the same. Okay if");=0A 			tst=5Fresm(TWARN,"multiple =
copies running due to test collision.");=0A@@ -189,18 +178,21 @@ main(int a=
c, char **av)=0A  * 	     Write some known data into file and get the size =
of the file.=0A  */=0A void=0A-setup()=0A+setup(void)=0A {=0A-	char mypid[4=
0];=0A-=0A-	sprintf(mypid,"/%d",getpid());=0A-	TEMPFILE=3Dstrcat(mypid,TEMP=
FILE);=0A-	TEMPFILE=3Dstrcat(Hopt,TEMPFILE);=0A+	tst=5Frequire=5Froot(NULL)=
;=0A =0A 	tst=5Fsig(FORK, DEF=5FHANDLER, cleanup);=0A =0A 	TEST=5FPAUSE;=0A=
 =0A+	tst=5Ftmpdir();=0A+	mount=5Fpoint =3D get=5Ftst=5Ftmpdir();=0A+=0A+	m=
ount=5Fhugetlbfs(mount=5Fpoint);=0A+	hugepage=5Falloc(1024);=0A+=0A+	snprin=
tf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount=5Fpoint, getpid());=
=0A }=0A =0A /*=0A@@ -209,7 +201,7 @@ setup()=0A  * 	       Remove the temp=
orary directory created.=0A  */=0A void=0A-cleanup()=0A+cleanup(void)=0A {=
=0A 	/*=0A 	 * print timing stats if that option was specified.=0A@@ -217,5=
 +209,6 @@ cleanup()=0A 	TEST=5FCLEANUP;=0A =0A 	unlink(TEMPFILE);=0A-=0A+	=
umount=5Fhugetlbfs(mount=5Fpoint);=0A+	tst=5Frmdir();=0A }=0Adiff --git a/t=
estcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hu=
getlb/hugemmap/hugemmap02.c=0Aindex 45cddf7..bef5b78 100644=0A--- a/testcas=
es/kernel/mem/hugetlb/hugemmap/hugemmap02.c=0A+++ b/testcases/kernel/mem/hu=
getlb/hugemmap/hugemmap02.c=0A@@ -63,6 +63,7 @@=0A #include "test.h"=0A #in=
clude "usctest.h"=0A #include "system=5Fspecific=5Fhugepages=5Finfo.h"=0A+#=
include "lib/libmnt.h"=0A =0A #define LOW=5FADDR       (void *)(0x80000000)=
=0A #define LOW=5FADDR2      (void *)(0x90000000)=0A@@ -77,36 +78,27 @@ uns=
igned long *addrlist[5];	/* list of addresses of memory mapped region */=0A=
 int i;=0A int fildes;			/* file descriptor for tempfile */=0A int nfildes;=
			/* file descriptor for /dev/zero */=0A-char *Hopt;                     /=
* location of hugetlbfs */=0A+char *mount=5Fpoint =3D NULL;=0A =0A-void set=
up();			/* Main setup function of test */=0A-void cleanup();			/* cleanup f=
unction for the test */=0A-=0A-void help()=0A-{=0A-	printf("  -H /..  Locat=
ion of hugetlbfs, i.e. -H /var/hugetlbfs \n");=0A-}=0A+void setup(void);			=
/* Main setup function of test */=0A+void cleanup(void);			/* cleanup funct=
ion for the test */=0A =0A int=0A main(int ac, char **av)=0A {=0A 	int lc;=
=0A-	char *msg;=0A-        int Hflag =3D 0;=0A+	char *msg;		/* message retu=
rned from parse=5Fopts */=0A 	int page=5Fsz, map=5Fsz;=0A =0A-       	optio=
n=5Ft options[] =3D {=0A-        	{ "H:",   &Hflag, &Hopt },    /* Required=
 for location of hugetlbfs */=0A-            	{ NULL, NULL, NULL }         =
 /* NULL required to end array */=0A-       	};=0A+	option=5Ft options[] =
=3D {=0A+		{ NULL, NULL, NULL }	/* NULL required to end array */=0A+	};=0A =
=0A 	/* Parse standard options given to run the test. */=0A-	if ((msg =3D p=
arse=5Fopts(ac, av, options, &help)) !=3D NULL)=0A+	msg =3D parse=5Fopts(ac=
, av, options, NULL);=0A+	if (msg !=3D (char *) NULL) {=0A 		tst=5Fbrkm(TBR=
OK, NULL, "OPTION PARSING ERROR - %s, use -help", msg);=0A-=0A-	if (Hflag =
=3D=3D 0) {=0A-		tst=5Fbrkm(TBROK, NULL,=0A-		    "-H option is REQUIRED fo=
r this test, use -h for options help");=0A+		tst=5Fexit();=0A 	}=0A =0A 	pa=
ge=5Fsz =3D getpagesize();=0A@@ -206,15 +198,20 @@ main(int ac, char **av)=
=0A  * 	     Write some known data into file and get the size of the file.=
=0A  */=0A void=0A-setup()=0A+setup(void)=0A {=0A-	tst=5Ftmpdir();=0A-=0A-	=
snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());=0A+	=
tst=5Frequire=5Froot(NULL);=0A =0A 	tst=5Fsig(FORK, DEF=5FHANDLER, cleanup)=
;=0A-=0A 	TEST=5FPAUSE;=0A+=0A+	tst=5Ftmpdir();=0A+	mount=5Fpoint =3D get=
=5Ftst=5Ftmpdir();=0A+=0A+	mount=5Fhugetlbfs(mount=5Fpoint);=0A+	hugepage=
=5Falloc(1024);=0A+=0A+	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d=
", mount=5Fpoint, getpid());=0A }=0A =0A /*=0A@@ -223,7 +220,7 @@ setup()=
=0A  * 	       Remove the temporary directory created.=0A  */=0A void=0A-cl=
eanup()=0A+cleanup(void)=0A {=0A 	/*=0A 	 * print timing stats if that opti=
on was specified.=0A@@ -231,6 +228,6 @@ cleanup()=0A 	TEST=5FCLEANUP;=0A =
=0A 	unlink(TEMPFILE);=0A-=0A+	umount=5Fhugetlbfs(mount=5Fpoint);=0A 	tst=
=5Frmdir();=0A }=0Adiff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugem=
map03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c=0Aindex cac94b=
0..1ffb8a1 100644=0A--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.=
c=0A+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c=0A@@ -54,31 +5=
4,26 @@=0A #include "test.h"=0A #include "usctest.h"=0A #include "system=5F=
specific=5Fhugepages=5Finfo.h"=0A+#include "lib/libmnt.h"=0A =0A #define HI=
GH=5FADDR      (void *)(0x1000000000000)=0A =0A-char* TEMPFILE=3D"mmapfile"=
;=0A+char TEMPFILE[MAXPATHLEN];=0A =0A char *TCID=3D"hugemmap03";	/* Test p=
rogram identifier.    */=0A int TST=5FTOTAL=3D1;		/* Total number of test c=
ases. */=0A unsigned long *addr;		/* addr of memory mapped region */=0A int=
 fildes;			/* file descriptor for tempfile */=0A-char *Hopt;               =
      /* location of hugetlbfs */=0A+char *mount=5Fpoint =3D NULL;=0A =0A-v=
oid setup();			/* Main setup function of test */=0A-void cleanup();			/* cl=
eanup function for the test */=0A-=0A-void help()=0A-{=0A-	printf("  -H /..=
  Location of hugetlbfs, i.e. -H /var/hugetlbfs \n");=0A-}=0A+void setup(vo=
id);			/* Main setup function of test */=0A+void cleanup(void);			/* cleanu=
p function for the test */=0A =0A int=0A main(int ac, char **av)=0A {=0A 	i=
nt lc;			/* loop counter */=0A 	char *msg;		/* message returned from parse=
=5Fopts */=0A-        int Hflag=3D0;              /* binary flag: opt or no=
t */=0A 	int page=5Fsz;=0A =0A #if =5F=5FWORDSIZE=3D=3D32  /* 32-bit compil=
ed */=0A@@ -86,22 +81,16 @@ main(int ac, char **av)=0A #endif=0A =0A       =
 	option=5Ft options[] =3D {=0A-        	{ "H:",   &Hflag, &Hopt },    /* R=
equired for location of hugetlbfs */=0A             	{ NULL, NULL, NULL }  =
        /* NULL required to end array */=0A        	};=0A =0A 	/* Parse sta=
ndard options given to run the test. */=0A-	msg =3D parse=5Fopts(ac, av, op=
tions, &help);=0A+	msg =3D parse=5Fopts(ac, av, options, NULL);=0A 	if (msg=
 !=3D (char *) NULL) {=0A 		tst=5Fbrkm(TBROK, NULL, "OPTION PARSING ERROR -=
 %s, use -help", msg);=0A 		tst=5Fexit();=0A 	}=0A =0A-	if (Hflag =3D=3D 0)=
 {=0A-		tst=5Fbrkm(TBROK, NULL, "-H option is REQUIRED for this test, use -=
h for options help");=0A-		tst=5Fexit();=0A-	}=0A-=0A 	page=5Fsz =3D getpag=
esize();=0A =0A 	setup();=0A@@ -122,8 +111,15 @@ main(int ac, char **av)=0A=
 		addr =3D mmap(HIGH=5FADDR, page=5Fsz, PROT=5FREAD,=0A 			    MAP=5FSHARE=
D | MAP=5FFIXED, fildes, 0);=0A 		if (addr !=3D MAP=5FFAILED) {=0A-			tst=
=5Fresm(TFAIL, "Normal mmap() into high region unexpectedly succeeded on %s=
, errno=3D%d : %s",=0A-				 TEMPFILE, errno, strerror(errno));=0A+			tst=5F=
resm(TFAIL, "Normal mmap() into high region unexpectedly "=0A+				"succeede=
d on %s, errno=3D%d : %s",=0A+				TEMPFILE, errno, strerror(errno));=0A+=0A=
+			/* Unmap the mapped memory */=0A+			if (munmap(addr, page=5Fsz) !=3D 0)=
 {=0A+				tst=5Fbrkm(TFAIL, NULL, "munmap() fails to unmap the "=0A+					"m=
emory, errno=3D%d", errno);=0A+			}=0A 			continue;=0A 		} else {=0A 			tst=
=5Fresm(TPASS, "Normal mmap() into high region failed correctly");=0A@@ -13=
3,6 +129,7 @@ main(int ac, char **av)=0A 		close(fildes);=0A 	}=0A =0A+	clo=
se(fildes);=0A 	cleanup();=0A =0A 	tst=5Fexit();=0A@@ -149,18 +146,20 @@ ma=
in(int ac, char **av)=0A  * 	     Write some known data into file and get t=
he size of the file.=0A  */=0A void=0A-setup()=0A+setup(void)=0A {=0A-	char=
 mypid[40];=0A-=0A-	sprintf(mypid,"/%d",getpid());=0A-	TEMPFILE=3Dstrcat(my=
pid,TEMPFILE);=0A-	TEMPFILE=3Dstrcat(Hopt,TEMPFILE);=0A+	tst=5Frequire=5Fro=
ot(NULL);=0A =0A 	tst=5Fsig(FORK, DEF=5FHANDLER, cleanup);=0A-=0A 	TEST=5FP=
AUSE;=0A =0A+	tst=5Ftmpdir();=0A+	mount=5Fpoint =3D get=5Ftst=5Ftmpdir();=
=0A+=0A+	mount=5Fhugetlbfs(mount=5Fpoint);=0A+	hugepage=5Falloc(1024);=0A+=
=0A+	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount=5Fpoint, g=
etpid());=0A }=0A =0A /*=0A@@ -169,7 +168,7 @@ setup()=0A  * 	       Remove=
 the temporary directory created.=0A  */=0A void=0A-cleanup()=0A+cleanup(vo=
id)=0A {=0A 	/*=0A 	 * print timing stats if that option was specified.=0A@=
@ -177,5 +176,6 @@ cleanup()=0A 	TEST=5FCLEANUP;=0A =0A 	unlink(TEMPFILE);=
=0A-=0A+	umount=5Fhugetlbfs(mount=5Fpoint);=0A+	tst=5Frmdir();=0A }=0Adiff =
--git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kern=
el/mem/hugetlb/hugemmap/hugemmap04.c=0Aindex 4cc6ed4..ba606d4 100644=0A--- =
a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c=0A+++ b/testcases/kern=
el/mem/hugetlb/hugemmap/hugemmap04.c=0A@@ -73,10 +73,11 @@=0A #include "tes=
t.h"=0A #include "usctest.h"=0A #include "system=5Fspecific=5Fhugepages=5Fi=
nfo.h"=0A+#include "lib/libmnt.h"=0A =0A #define BUFFER=5FSIZE  256=0A =0A-=
char* TEMPFILE=3D"mmapfile";=0A+char TEMPFILE[MAXPATHLEN];=0A =0A char *TCI=
D=3D"hugemmap04";	/* Test program identifier.    */=0A int TST=5FTOTAL=3D1;=
		/* Total number of test cases. */=0A@@ -88,40 +89,29 @@ int beforetest=3D=
0;		/* Amount of free huge pages before testing */=0A int aftertest=3D0;		/=
* Amount of free huge pages after testing */=0A int hugepagesmapped=3D0;		/=
* Amount of huge pages mapped after testing */=0A char *Hopt;              =
       /* location of hugetlbfs */=0A+char *mount=5Fpoint =3D NULL;=0A =0A-=
void setup();			/* Main setup function of test */=0A-void cleanup();			/* c=
leanup function for the test */=0A-=0A-void help()=0A-{=0A-	printf("  -H /.=
.  Location of hugetlbfs, i.e. -H /var/hugetlbfs \n");=0A-}=0A+void setup(v=
oid);			/* Main setup function of test */=0A+void cleanup(void);			/* clean=
up function for the test */=0A =0A int=0A main(int ac, char **av)=0A {=0A 	=
int lc;			/* loop counter */=0A 	char *msg;		/* message returned from parse=
=5Fopts */=0A-        int Hflag=3D0;              /* binary flag: opt or no=
t */=0A 	int huge=5Fpagesize=3D0;=0A =0A        	option=5Ft options[] =3D {=
=0A-        	{ "H:",   &Hflag, &Hopt },    /* Required for location of huge=
tlbfs */=0A             	{ NULL, NULL, NULL }          /* NULL required to =
end array */=0A        	};=0A =0A 	/* Parse standard options given to run t=
he test. */=0A-	msg =3D parse=5Fopts(ac, av, options, &help);=0A+	msg =3D p=
arse=5Fopts(ac, av, options, NULL);=0A 	if (msg !=3D (char *) NULL) {=0A 		=
tst=5Fbrkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use -help", msg);=0A 		=
tst=5Fexit();=0A 	}=0A =0A-	if (Hflag =3D=3D 0) {=0A-		tst=5Fbrkm(TBROK, NU=
LL, "-H option is REQUIRED for this test, use -h for options help");=0A-		t=
st=5Fexit();=0A-	}=0A-=0A 	/* Check number of hugepages */=0A 	if (get=5Fno=
=5Fof=5Fhugepages() <=3D 0 || hugepages=5Fsize() <=3D 0)=0A 		tst=5Fbrkm(TC=
ONF, cleanup, "Not enough available Hugepages");=0A@@ -151,7 +141,7 @@ main=
(int ac, char **av)=0A 		tst=5Fresm(TINFO,"Total amount of free huge pages =
is %d",freepages);=0A 		tst=5Fresm(TINFO,"Max number allowed for 1 mmap fil=
e in 32-bits is 128");=0A 		if (freepages > 128)=0A-		  freepages=3D128;=0A=
+			freepages=3D128;=0A #endif=0A 		/*=0A 		 * Call mmap=0A@@ -206,16 +196,=
18 @@ main(int ac, char **av)=0A void=0A setup()=0A {=0A-	char mypid[40];=
=0A-=0A-	sprintf(mypid,"/%d",getpid());=0A-	TEMPFILE=3Dstrcat(mypid,TEMPFIL=
E);=0A-	TEMPFILE=3Dstrcat(Hopt,TEMPFILE);=0A+	tst=5Frequire=5Froot(NULL);=
=0A =0A 	tst=5Fsig(FORK, DEF=5FHANDLER, cleanup);=0A-=0A 	TEST=5FPAUSE;=0A =
=0A+	tst=5Ftmpdir();=0A+	mount=5Fpoint =3D get=5Ftst=5Ftmpdir();=0A+=0A+	mo=
unt=5Fhugetlbfs(mount=5Fpoint);=0A+	hugepage=5Falloc(1024);=0A+=0A+	snprint=
f(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount=5Fpoint, getpid());=0A=
 }=0A =0A /*=0A@@ -232,5 +224,6 @@ cleanup()=0A 	TEST=5FCLEANUP;=0A =0A 	un=
link(TEMPFILE);=0A-=0A+	umount=5Fhugetlbfs(mount=5Fpoint);=0A+	tst=5Frmdir(=
);=0A }=0Adiff --git a/testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile b=
/testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile=0Anew file mode 100644=
=0Aindex 0000000..f37b87a=0A--- /dev/null=0A+++ b/testcases/kernel/mem/huge=
tlb/hugemmap/lib/Makefile=0A@@ -0,0 +1,25 @@=0A+#=0A+#  Copyright (c) Inter=
national Business Machines  Corp., 2001=0A+#=0A+#  This program is free sof=
tware;  you can redistribute it and/or modify=0A+#  it under the terms of t=
he GNU General Public License as published by=0A+#  the Free Software Found=
ation; either version 2 of the License, or=0A+#  (at your option) any later=
 version.=0A+#=0A+#  This program is distributed in the hope that it will b=
e useful,=0A+#  but WITHOUT ANY WARRANTY;  without even the implied warrant=
y of=0A+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See=0A+#  =
the GNU General Public License for more details.=0A+#=0A+#  You should have=
 received a copy of the GNU General Public License=0A+#  along with this pr=
ogram;  if not, write to the Free Software=0A+#  Foundation, Inc., 59 Templ=
e Place, Suite 330, Boston, MA 02111-1307 USA=0A+#=0A+=0A+top=5Fsrcdir		?=
=3D ../../../../../..=0A+=0A+include $(top=5Fsrcdir)/include/mk/env=5Fpre.m=
k=0A+=0A+LIB			:=3D libmnt=5Fhugetlb.a=0A+=0A+include $(top=5Fsrcdir)/inclu=
de/mk/lib.mk=0Adiff --git a/testcases/kernel/mem/hugetlb/hugemmap/lib/libmn=
t.c b/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c=0Anew file mode 10=
0644=0Aindex 0000000..ac7fadb=0A--- /dev/null=0A+++ b/testcases/kernel/mem/=
hugetlb/hugemmap/lib/libmnt.c=0A@@ -0,0 +1,70 @@=0A+/*=0A+ *=0A+ *   Copyri=
ght (c) International Business Machines  Corp., 2001=0A+ *=0A+ *   This pro=
gram is free software;  you can redistribute it and/or modify=0A+ *   it un=
der the terms of the GNU General Public License as published by=0A+ *   the=
 Free Software Foundation; either version 2 of the License, or=0A+ *   (at =
your option) any later version.=0A+ *=0A+ *   This program is distributed i=
n the hope that it will be useful,=0A+ *   but WITHOUT ANY WARRANTY;  witho=
ut even the implied warranty of=0A+ *   MERCHANTABILITY or FITNESS FOR A PA=
RTICULAR PURPOSE.  See=0A+ *   the GNU General Public License for more deta=
ils.=0A+ *=0A+ *   You should have received a copy of the GNU General Publi=
c License=0A+ *   along with this program;  if not, write to the Free Softw=
are=0A+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-=
1307 USA=0A+ */=0A+=0A+/*=0A+ * NAME=0A+ *	libmnt.c=0A+ *=0A+ * DESCRIPTION=
=0A+ *	Helper functions for mounting hugetlbfs automatically.=0A+ *=0A+ *	T=
he library contains the following routines:=0A+ *=0A+ *	hugepage=5Falloc()=
=0A+ *	mount=5Fhugetlbfs()=0A+ *	umount=5Fhugetlbfs()=0A+ */=0A+#include <s=
tdio.h>=0A+#include <stdlib.h>=0A+#include <sys/mount.h>=0A+#include <errno=
.h>=0A+#include <sys/stat.h>=0A+=0A+#include "test.h"=0A+=0A+#include "libm=
nt.h"=0A+=0A+void=0A+hugepage=5Falloc(int num)=0A+{=0A+	FILE *file =3D fope=
n("/proc/sys/vm/nr=5Fhugepages", "w+");=0A+	if (file =3D=3D NULL) {=0A+		ts=
t=5Fbrkm(TBROK|TERRNO, NULL, "fopen failed on /proc/sys/vm/nr=5Fhugepages")=
;=0A+	}=0A+=0A+	if (fprintf(file, "%d", num) < 0) {=0A+		tst=5Fbrkm(TBROK|T=
ERRNO, NULL, "fprintf failed on /proc/sys/vm/nr=5Fhugepages");=0A+	}=0A+=0A=
+	fclose(file);=0A+}=0A+=0A+void=0A+mount=5Fhugetlbfs(char *mount=5Fpoint)=
=0A+{=0A+	if (mount("none", mount=5Fpoint, "hugetlbfs", 0, NULL) < 0) {=0A+=
		tst=5Fbrkm(TBROK|TERRNO, NULL, "mount failed on %s", mount=5Fpoint);=0A+	=
}=0A+}=0A+=0A+void=0A+umount=5Fhugetlbfs(char *mount=5Fpoint)=0A+{=0A+	umou=
nt(mount=5Fpoint);=0A+}=0Adiff --git a/testcases/kernel/mem/hugetlb/hugemma=
p/lib/libmnt.h b/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h=0Anew f=
ile mode 100644=0Aindex 0000000..b9b26ed=0A--- /dev/null=0A+++ b/testcases/=
kernel/mem/hugetlb/hugemmap/lib/libmnt.h=0A@@ -0,0 +1,27 @@=0A+/*=0A+ *=0A+=
 *   Copyright (c) International Business Machines  Corp., 2001=0A+ *=0A+ *=
   This program is free software;  you can redistribute it and/or modify=0A=
+ *   it under the terms of the GNU General Public License as published by=
=0A+ *   the Free Software Foundation; either version 2 of the License, or=
=0A+ *   (at your option) any later version.=0A+ *=0A+ *   This program is =
distributed in the hope that it will be useful,=0A+ *   but WITHOUT ANY WAR=
RANTY;  without even the implied warranty of=0A+ *   MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE.  See=0A+ *   the GNU General Public License =
for more details.=0A+ *=0A+ *   You should have received a copy of the GNU =
General Public License=0A+ *   along with this program;  if not, write to t=
he Free Software=0A+ *   Foundation, Inc., 59 Temple Place, Suite 330, Bost=
on, MA 02111-1307 USA=0A+ */=0A+=0A+/*=0A+ * libmnt.h - functions to mount =
hugetlbfs automatically.=0A+ */=0A+=0A+void hugepage=5Falloc(int num);=0A+v=
oid mount=5Fhugetlbfs(char *mount=5Fpoint);=0A+void umount=5Fhugetlbfs(char=
 *mount=5Fpoint);=0A+=0A-- =0A1.7.1 =0A=

--------------030802030409080300050607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
--------------030802030409080300050607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030802030409080300050607--

