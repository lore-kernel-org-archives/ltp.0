Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jungsoo.son@lge.com>) id 1UmBdg-0007ox-2y
	for ltp-list@lists.sourceforge.net; Mon, 10 Jun 2013 23:36:40 +0000
Received: from lgemrelse7q.lge.com ([156.147.1.151])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UmBdd-0001Yr-Q5
	for ltp-list@lists.sourceforge.net; Mon, 10 Jun 2013 23:36:40 +0000
From: "Jungsoo Son" <jungsoo.son@lge.com>
References: <00f801ce63f3$7d4cc8f0$77e65ad0$@lge.com>
	<690761261.792664.1370873255744.JavaMail.root@redhat.com>
In-Reply-To: <690761261.792664.1370873255744.JavaMail.root@redhat.com>
Date: Tue, 11 Jun 2013 08:36:29 +0900
Message-ID: <012501ce6633$55508a70$fff19f50$@lge.com>
MIME-Version: 1.0
Content-Language: ko
Subject: Re: [LTP] [PATCH] syscalls/chown01: Fix test file creation
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Jan Stancek' <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

I added 'void' to setup() and cleanup() as your mention.


There is a bug in the code to create the file and the code is
very intricate. So replace it with SAFE_FILE_PRINTF().

Signed-off-by: jungsoo.son <jungsoo.son@lge.com>
---
 testcases/kernel/syscalls/chown/chown01.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/chown/chown01.c b/testcases/kernel/syscalls/chown/chown01.c
index 50b9ea5..d95564e 100644
--- a/testcases/kernel/syscalls/chown/chown01.c
+++ b/testcases/kernel/syscalls/chown/chown01.c
@@ -116,9 +116,7 @@
 #include <signal.h>
 #include "test.h"
 #include "usctest.h"
-
-void setup();
-void cleanup();
+#include "safe_macros.h"
 
 char *TCID = "chown01";
 int TST_TOTAL = 1;
@@ -126,8 +124,10 @@ int TST_TOTAL = 1;
 int exp_enos[] = { 0, 0 };
 
 char fname[255];
-int fd, uid, gid;
-char *buf = "davef";
+int uid, gid;
+
+static void setup(void);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
@@ -163,7 +163,7 @@ int main(int ac, char **av)
 
 }
 
-void setup()
+static void setup(void)
 {
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
@@ -176,17 +176,11 @@ void setup()
 	gid = getegid();
 
 	sprintf(fname, "t_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
-	else if (write(fd, &buf, strlen(buf)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "write(%s, &buf, strlen(buf)) failed", fname);
-	else if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed", fname);
+
+	SAFE_FILE_PRINTF(cleanup, fname, "davef");
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 
-- 
1.7.9.5


> -----Original Message-----
> From: Jan Stancek [mailto:jstancek@redhat.com]
> Sent: Monday, June 10, 2013 11:08 PM
> To: Jungsoo Son
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH] syscalls/chown01: Fix test file creation
> 
> 
> ----- Original Message -----
> > From: "Jungsoo Son" <jungsoo.son@lge.com>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Saturday, 8 June, 2013 4:54:26 AM
> > Subject: [LTP] [PATCH] syscalls/chown01: Fix test file creation
> >
> > There is a bug in the code to create the file and the code is very
> > intricate. So replace it with SAFE_FILE_PRINTF().
> >
> > Signed-off-by: jungsoo.son <jungsoo.son@lge.com>
> 
> Please add void to setup()/cleanup(). The rest looks OK.
> 
> Regards,
> Jan
> 
> > ---
> >  testcases/kernel/syscalls/chown/chown01.c |   24 +++++++++--------------
> -
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/chown/chown01.c
> > b/testcases/kernel/syscalls/chown/chown01.c
> > index 50b9ea5..14b699b 100644
> > --- a/testcases/kernel/syscalls/chown/chown01.c
> > +++ b/testcases/kernel/syscalls/chown/chown01.c
> > @@ -116,9 +116,7 @@
> >  #include <signal.h>
> >  #include "test.h"
> >  #include "usctest.h"
> > -
> > -void setup();
> > -void cleanup();
> > +#include "safe_macros.h"
> >
> >  char *TCID = "chown01";
> >  int TST_TOTAL = 1;
> > @@ -126,8 +124,10 @@ int TST_TOTAL = 1;  int exp_enos[] = { 0, 0 };
> >
> >  char fname[255];
> > -int fd, uid, gid;
> > -char *buf = "davef";
> > +int uid, gid;
> > +
> > +static void setup();
> > +static void cleanup();
> 
> in these two above ^^
> 
> >
> >  int main(int ac, char **av)
> >  {
> > @@ -163,7 +163,7 @@ int main(int ac, char **av)
> >
> >  }
> >
> > -void setup()
> > +static void setup()
> 
> here
> 
> >  {
> >
> >  	tst_sig(NOFORK, DEF_HANDLER, cleanup); @@ -176,17 +176,11 @@ void
> > setup()
> >  	gid = getegid();
> >
> >  	sprintf(fname, "t_%d", getpid());
> > -	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
> > -		tst_brkm(TBROK | TERRNO, cleanup,
> > -			 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
> > -	else if (write(fd, &buf, strlen(buf)) == -1)
> > -		tst_brkm(TBROK | TERRNO, cleanup,
> > -			 "write(%s, &buf, strlen(buf)) failed", fname);
> > -	else if (close(fd) == -1)
> > -		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed",
> > fname);
> > +
> > +	SAFE_FILE_PRINTF(cleanup, fname, "davef");
> >  }
> >
> > -void cleanup()
> > +static void cleanup()
> 
> and here.
> 
> >  {
> >  	TEST_CLEANUP;
> >
> > --
> > 1.7.9.5
> >
> >
> > ----------------------------------------------------------------------
> > -------- How ServiceNow helps IT people transform IT departments:
> > 1. A cloud service to automate IT design, transition and operations 2.
> > Dashboards that offer high-level views of enterprise services 3. A
> > single system of record for all IT processes
> > http://p.sf.net/sfu/servicenow-d2d-j
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
