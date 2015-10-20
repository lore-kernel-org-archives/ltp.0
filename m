From: TAKAHASHI Tetsuya <takahashi.tetsuya.cis@canon-is.co.jp>
Date: Tue, 20 Oct 2015 05:13:45 +0000
Subject: [LTP] [PATCH] syscalls/mallopt: Does not work correctly?
In-Reply-To: <20151001112940.GF8256@rei.suse.cz>
References: <330BE2030BD7834286495D8B7FCF1FB71C99B4FB@mbx01.itr.canon-is.co.jp>
 <20151001112940.GF8256@rei.suse.cz>
Message-ID: <330BE2030BD7834286495D8B7FCF1FB71C9A4D60@mbx01.itr.canon-is.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Thanks for reviewing.

> The purpose of SAFE_MALLOC() is to allocate the buffer, or exit the
> test. It will never return NULL.
Ok, I deleted unnecessary NULL check.


> >   /*
> >    * Check space usage.
> > @@ -86,16 +88,41 @@ int main(int argc, char *argv[])
> >    printinfo();
> >    tst_resm(TFAIL, "mallinfo failed: smblks != 0");
> >   }
> 
> We use tabs for indentation. It looks like even the context of the patch
> set uses spaces instead. One possibility is that your email client
> converted tabs to spaces. Please figure out how to send it correcty, as
> it is the patch will not apply.
Sorry, It was converted into the space by mistake.
I fixed patch.


> Here as well, the SAFE_MALLOC() will never fail, just use plain old
> malloc() here instead.
I replace SAFE_MALLOC after malopts with "malloc".


> Other than that you should also update the TST_TOTAL to match the number
> of PASS/FAIL messages
Ok, I updated TST_TOTAL to match the number of PASS/FAIL messages


---
diff -urpN a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
--- a/testcases/kernel/syscalls/mallopt/mallopt01.c	2015-09-03 22:07:51.000000000 +0900
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c	2015-10-16 14:29:16.235113264 +0900
@@ -51,13 +51,14 @@
 
 #define FAILED 0
 #define PASSED 1
+#define MAX_FAST_SIZE	(80 * sizeof(size_t) / 4)
 
 int local_flag = PASSED;
 
 char *TCID = "mallopt01";
 int block_number;
 FILE *temp;
-int TST_TOTAL = 1;
+int TST_TOTAL = 6;
 extern int tst_COUNT;		/* Test Case counter for tst_routines */
 
 void printinfo();
@@ -86,16 +87,42 @@ int main(int argc, char *argv[])
 		printinfo();
 		tst_resm(TFAIL, "mallinfo failed: smblks != 0");
 	}
+	if (info.uordblks >= 20480 && info.smblks == 0)
+		tst_resm(TPASS, "mallinfo() succeeded");
 	free(buf);
 
 	/*
 	 * Test mallopt's M_MXFAST and M_NLBLKS cmds.
 	 */
-	mallopt(M_MXFAST, 2048);
-	mallopt(M_NLBLKS, 50);
-	buf = SAFE_MALLOC(NULL, 1024);
 
-	free(buf);
+	if (mallopt(M_MXFAST, MAX_FAST_SIZE) == 0)
+		tst_resm(TFAIL, "mallopt(M_MXFAST, %d) failed", MAX_FAST_SIZE);
+	else
+		tst_resm(TPASS, "mallopt(M_MXFAST, %d) succeeded", MAX_FAST_SIZE);
+
+	if (mallopt(M_NLBLKS, 50) == 0)
+		tst_resm(TFAIL, "mallopt(M_NLBLKS, 50) failed");
+	else
+		tst_resm(TPASS, "mallopt(M_NLBLKS, 50) succeeded");
+
+	if ((buf = malloc(1024)) == NULL)
+		tst_resm(TFAIL, "malloc(1024) failed");
+	else {
+		tst_resm(TPASS, "malloc(1024) succeeded");
+		free(buf);
+	}
+
+	if (mallopt(M_MXFAST, 0) == 0)
+		tst_resm(TFAIL, "mallopt(M_MXFAST, 0) failed");
+	else
+		tst_resm(TPASS, "mallopt(M_MXFAST, 0) succeeded");
+
+	if ((buf = malloc(1024)) == NULL)
+		tst_resm(TFAIL, "malloc(1024) failed");
+	else {
+		tst_resm(TPASS, "malloc(1024) succeeded");
+		free(buf);
+	}
 
 	unlink("core");
 	tst_rmdir();
---

Best regards.

> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Sent: Thursday, October 01, 2015 8:30 PM
> To: TAKAHASHI Tetsuya
> Cc: ltp@lists.linux.it; TAKEISHI Kazuhiro
> Subject: Re: [LTP] [PATCH] syscalls/mallopt: Does not work correctly?
> 
> Hi!
> > Therefore, I suggest to adding following functions.
> > 1. Checking mallopt() return values.
> > 2. Setting tests value is 0 and 80*sizeof(size_t)/4.
> 
> Sounds good, comments to the patch itself below.
> 
> > --- a/testcases/kernel/syscalls/mallopt/mallopt01.c 2015-09-08
> 18:37:03.000000000 +0900
> > +++ b/testcases/kernel/syscalls/mallopt/mallopt01.c 2015-09-10
> 16:20:44.471493667 +0900
> > @@ -51,6 +51,7 @@
> >
> >  #define FAILED 0
> >  #define PASSED 1
> > +#define MAX_FAST_SIZE (80 * sizeof(size_t) / 4)
> >
> >  int local_flag = PASSED;
> >
> > @@ -71,7 +72,8 @@ int main(int argc, char *argv[])
> >
> >   tst_tmpdir();
> >
> > - buf = SAFE_MALLOC(NULL, 20480);
> > + if ((buf = SAFE_MALLOC(NULL, 20480)) == NULL)
> > +  tst_brkm(TBROK, NULL, "malloc failed");
> 
> The purpose of SAFE_MALLOC() is to allocate the buffer, or exit the
> test. It will never return NULL.
> 
> >   /*
> >    * Check space usage.
> > @@ -86,16 +88,41 @@ int main(int argc, char *argv[])
> >    printinfo();
> >    tst_resm(TFAIL, "mallinfo failed: smblks != 0");
> >   }
> 
> We use tabs for indentation. It looks like even the context of the patch
> set uses spaces instead. One possibility is that your email client
> converted tabs to spaces. Please figure out how to send it correcty, as
> it is the patch will not apply.
> 
> > + if (info.uordblks >= 20480 && info.smblks == 0)
> > +  tst_resm(TPASS, "mallinfo() succeeded");
> >   free(buf);
> >
> >   /*
> >    * Test mallopt's M_MXFAST and M_NLBLKS cmds.
> >    */
> > - mallopt(M_MXFAST, 2048);
> > - mallopt(M_NLBLKS, 50);
> > - buf = SAFE_MALLOC(NULL, 1024);
> > + if (mallopt(M_MXFAST, MAX_FAST_SIZE) == 0)
> > +  tst_resm(TFAIL, "mallopt(M_MXFAST, %d) failed", MAX_FAST_SIZE);
> > + else
> > +  tst_resm(TPASS, "mallopt(M_MXFAST, %d) succeeded", MAX_FAST_SIZE);
> > +
> > + if (mallopt(M_NLBLKS, 50) == 0)
> > +  tst_resm(TFAIL, "mallopt(M_NLBLKS, 50) failed");
> > + else
> > +  tst_resm(TPASS, "mallopt(M_NLBLKS, 50) succeeded");
> > +
> > + if ((buf = SAFE_MALLOC(NULL, 1024)) == NULL)
> > +  tst_resm(TFAIL, "malloc(1024) failed");
> > + else {
> > +  tst_resm(TPASS, "malloc(1024) succeeded");
> > +  free(buf);
> > + }
> 
> Here as well, the SAFE_MALLOC() will never fail, just use plain old
> malloc() here instead.
> 
> > - free(buf);
> > + if (mallopt(M_MXFAST, 0) == 0)
> > +  tst_resm(TFAIL, "mallopt(M_MXFAST, 0) failed");
> > + else
> > +  tst_resm(TPASS, "mallopt(M_MXFAST, 0) succeeded");
> > +
> > + if ((buf = SAFE_MALLOC(NULL, 1024)) == NULL)
> > +  tst_resm(TFAIL, "malloc(1024) failed");
> > + else {
> > +  tst_resm(TPASS, "malloc(1024) succeeded");
> > +  free(buf);
> > + }
> 
> And here as well.
> 
> Other than that you should also update the TST_TOTAL to match the number
> of PASS/FAIL messages
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
