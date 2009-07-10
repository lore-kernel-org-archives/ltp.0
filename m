Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MPDcu-0007kr-3E
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 10:46:48 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MPDcn-00030k-R4
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 10:46:48 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6AAXbUs008580
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2009 06:33:37 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6AAkfdU218624
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2009 06:46:41 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6AAkfVU026953
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2009 06:46:41 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200907090303.22607.vapier@gentoo.org>
References: <200907090303.22607.vapier@gentoo.org>
Date: Fri, 10 Jul 2009 16:16:35 +0530
Message-Id: <1247222795.6630.28.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [rfc] extend test type field with tst_* functions
Reply-To: subrata@linux.vnet.ibm.com
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi Mike,

On Thu, 2009-07-09 at 03:03 -0400, Mike Frysinger wrote:
> the perceived problem: many many tests duplicate errno display and
> they do so 
> inconsistently.  many times the display is crappy and a lot less
> helpful than 
> it could & should be.  a test should merely have to say "include the
> errno in 
> the test output" so it can focus on its own details.  much like the
> multitude 
> of C library functions out there like perror() or printf's %m.
> 
> the proposed fix: extend the first argument to (1) take a define for
> the test 
> result and (2) also accept optional bit fields to further manipulate
> the 
> output.  the advantage here is we dont have to add a whole lot of
> helper 
> functions to complement the existing ones.  i.e. a new tst_resmp()
> that would 
> behave like tst_resm() but also append the errno output.
> 

I like this idea. Very few comments:

     1. The new patch does not show the implementation of tst_resmp(), 
     2. If there are changes on this regard, the corresponding
        information should be updated in ltp/doc/man3/tst_res.3, 
     3. The new usage of tst_resmp() also should be communicated to
        users, probably through ltp/README,

Regards--
Subrata

> at the moment, the T* defines in test.h are set up like a bit field.
> this is 
> silly because no where are these values treated like bits -- they're
> always 
> checked by their value.  so the first thing is to convert them to a
> linear 
> number map so we can stake out the lower 4 bits for the result.  this
> frees up 
> higher bit values.
> 
> then two new output modifiers are added -- TERRNO and TTERRNO.  the
> former 
> appends errno output using the "errno" value while the latter uses 
> "TEST_ERRNO".  this allows us to convert both types of testing
> methods.  the 
> output too is much more useful for people who are actually reviewing
> testing 
> errors:
> ....: errno=ETXTBSY(26): Text file busy
> the advantage of having all three is that you dont have to spend time
> looking 
> up the value you actually care about, and makes coordinating things
> easier 
> (like strace output and the test source code).
> 
> attached is the patch to do this implementation as well as an example
> of 
> converting mmap09 to the new interface
> -mike
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (ltp-ttype-masks.patch)
> 
> 
> --- include/test.h
> +++ include/test.h
> @@ -44,13 +44,19 @@
>  
>  #include "compiler.h"
>  
> -#define TPASS    0    /* Test passed flag */
> -#define TFAIL    1    /* Test failed flag */
> -#define TBROK    2    /* Test broken flag */
> -#define TWARN    4    /* Test warning flag */
> -#define TRETR    8    /* Test retire flag */
> -#define TINFO    16   /* Test information flag */
> -#define TCONF    32   /* Test not appropriate for configuration flag
> */
> +/* Use low 4 bits to encode test type */
> +#define TTYPE_MASK 0xf
> +#define TPASS      0    /* Test passed flag */
> +#define TFAIL      1    /* Test failed flag */
> +#define TBROK      2    /* Test broken flag */
> +#define TWARN      3    /* Test warning flag */
> +#define TRETR      4    /* Test retire flag */
> +#define TINFO      5    /* Test information flag */
> +#define TCONF      6    /* Test not appropriate for configuration
> flag */
> +#define TTYPE_RESULT(ttype) ((ttype) & TTYPE_MASK)
> +
> +#define TERRNO     0x100   /* Append errno information to output */
> +#define TTERRNO    0x200   /* Append TEST_ERRNO information to output
> */
>  
>  /*
>   * To determine if you are on a Umk or Unicos system,
> @@ -179,6 +185,7 @@
>  /*
>   * Functions from lib/tst_res.c
>   */
> +const char *strttype(int ttype);
>  void tst_res(int ttype, char *fname, char *arg_fmt, ...);
>  void tst_resm(int ttype, char *arg_fmt, ...);
>  void tst_brk(int ttype, char *fname, void (*func)(void), char
> *arg_fmt, ...);
> --- lib/tst_res.c
> +++ lib/tst_res.c
> @@ -115,6 +115,7 @@
>  #include <stdarg.h>
>  #include <unistd.h>
>  #include "test.h"
> +#include "usctest.h"
>  
>  #define VERBOSE      1     /* flag values for the T_mode variable */
>  #define CONDENSE     2
> @@ -206,6 +207,80 @@ extern int  TST_TOTAL;  /* Total number 
>   */
>  char *TESTDIR = NULL;
>  
> +struct pair {
> +       const char *name;
> +       int val;
> +};
> +#define PAIR(def) [def] = { .name = #def, .val = def, },
> +const char *pair_lookup(struct pair *pair, int pair_size, int idx)
> +{
> +       if (idx < 0 || idx >= pair_size || pair[idx].name == NULL)
> +               return "???";
> +       return pair[idx].name;
> +}
> +#define pair_lookup(pair, idx) pair_lookup(pair, ARRAY_SIZE(pair),
> idx)
> +
> +/*
> + * strttype() - convert a type result to the human readable string
> + */
> +const char *strttype(int ttype)
> +{
> +       struct pair ttype_pairs[] = {
> +               PAIR(TPASS)
> +               PAIR(TFAIL)
> +               PAIR(TBROK)
> +               PAIR(TRETR)
> +               PAIR(TCONF)
> +               PAIR(TWARN)
> +               PAIR(TINFO)
> +       };
> +       return pair_lookup(ttype_pairs, TTYPE_RESULT(ttype));
> +}
> +
> +/*
> + * strerrnodef() - convert an errno value to its C define
> + */
> +static const char *strerrnodef(int err)
> +{
> +       struct pair errno_pairs[] = {
> +               PAIR(EPERM)
> +               PAIR(ENOENT)
> +               PAIR(ESRCH)
> +               PAIR(EINTR)
> +               PAIR(EIO)
> +               PAIR(ENXIO)
> +               PAIR(E2BIG)
> +               PAIR(ENOEXEC)
> +               PAIR(EBADF)
> +               PAIR(ECHILD)
> +               PAIR(EAGAIN)
> +               PAIR(ENOMEM)
> +               PAIR(EACCES)
> +               PAIR(EFAULT)
> +               PAIR(ENOTBLK)
> +               PAIR(EBUSY)
> +               PAIR(EEXIST)
> +               PAIR(EXDEV)
> +               PAIR(ENODEV)
> +               PAIR(ENOTDIR)
> +               PAIR(EISDIR)
> +               PAIR(EINVAL)
> +               PAIR(ENFILE)
> +               PAIR(EMFILE)
> +               PAIR(ENOTTY)
> +               PAIR(ETXTBSY)
> +               PAIR(EFBIG)
> +               PAIR(ENOSPC)
> +               PAIR(ESPIPE)
> +               PAIR(EROFS)
> +               PAIR(EMLINK)
> +               PAIR(EPIPE)
> +               PAIR(EDOM)
> +               PAIR(ERANGE)
> +       };
> +       return pair_lookup(errno_pairs, err);
> +}
> +
>  /*
>   * tst_res() - Main result reporting function.  Handle test
> information
>   *             appropriately depending on output display mode.  Call
> @@ -217,6 +292,7 @@ void tst_res(int ttype, char *fname, cha
>  {
>         int  i;
>         char tmesg[USERMESG];
> +       int ttype_result = TTYPE_RESULT(ttype);
>  
>  #if DEBUG
>         printf("IN tst_res; Tst_count = %d; Tst_range = %d\n",
> @@ -229,7 +305,7 @@ void tst_res(int ttype, char *fname, cha
>          * Save the test result type by ORing ttype into the current
> exit
>          * value (used by tst_exit()).
>          */
> -       T_exitval |= ttype;
> +       T_exitval |= ttype_result;
>  
>         /*
>          * Unless T_out has already been set by tst_environ(), make
> tst_res()
> @@ -257,7 +333,7 @@ void tst_res(int ttype, char *fname, cha
>          * Set the test case number and print the results, depending
> on the
>          * display type.
>          */
> -       if (ttype == TWARN || ttype == TINFO) {
> +       if (ttype_result == TWARN || ttype_result == TINFO) {
>                 if (Tst_range > 1)
>                         tst_print(TCID, 0, 1, TWARN,
>                                   "tst_res(): Range not valid for
> TINFO or TWARN types");
> @@ -303,6 +379,7 @@ void tst_res(int ttype, char *fname, cha
>  static void tst_condense(int tnum, int ttype, char *tmesg)
>  {
>         char *file;
> +       int ttype_result = TTYPE_RESULT(ttype);
>  
>  #if DEBUG
>         printf("IN tst_condense: tcid = %s, tnum = %d, ttype = %d,
> tmesg = %s\n",
> @@ -314,7 +391,7 @@ static void tst_condense(int tnum, int t
>          * If this result is the same as the previous result, return.
>          */
>         if (Buffered == TRUE) {
> -               if (strcmp(Last_tcid, TCID) == 0 && Last_type == ttype
> &&
> +               if (strcmp(Last_tcid, TCID) == 0 && Last_type ==
> ttype_result &&
>                     strcmp(Last_mesg, tmesg) == 0 && File == NULL )
>                         return;
>  
> @@ -343,7 +420,7 @@ static void tst_condense(int tnum, int t
>                 Last_tcid = (char *)malloc(strlen(TCID) + 1);
>                 strcpy(Last_tcid, TCID);
>                 Last_num = tnum;
> -               Last_type = ttype;
> +               Last_type = ttype_result;
>                 Last_mesg = (char *)malloc(strlen(tmesg) + 1);
>                 strcpy(Last_mesg, tmesg);
>                 Buffered = TRUE;
> @@ -381,7 +458,8 @@ void tst_flush(void)
>   */
>  static void tst_print(char *tcid, int tnum, int trange, int ttype,
> char *tmesg)
>  {
> -       char type[5];
> +       const char *type;
> +       int ttype_result = TTYPE_RESULT(ttype);
>  
>  #if DEBUG
>         printf("IN tst_print: tnum = %d, trange = %d, ttype = %d,
> tmesg = %s\n",
> @@ -395,7 +473,7 @@ static void tst_print(char *tcid, int tn
>          * also done here to catch internal warnings.  For internal
> warnings,
>          * tst_print() is called directly with a case of TWARN.
>          */
> -       T_exitval |= ttype;
> +       T_exitval |= ttype_result;
>  
>         /*
>          * If output mode is DISCARD, or if the output mode is NOPASS
> and this
> @@ -404,53 +482,33 @@ static void tst_print(char *tcid, int tn
>          * tst_res(), since occasionally we get to this point without
> going
>          * through tst_res() (e.g. internal TWARN messages).
>          */
> -       if (T_mode == DISCARD || (T_mode == NOPASS && ttype != TFAIL
> &&
> -           ttype != TBROK && ttype != TWARN))
> +       if (T_mode == DISCARD || (T_mode == NOPASS && ttype_result !=
> TFAIL &&
> +           ttype_result != TBROK && ttype_result != TWARN))
>                 return;
>  
>         /*
> -        * Fill in the type string according to ttype.
> -        */
> -       switch (ttype) {
> -               case TPASS:
> -                       strcpy(type, "PASS");
> -               break;
> -               case TFAIL:
> -                       strcpy(type, "FAIL");
> -               break;
> -               case TBROK:
> -                       strcpy(type, "BROK");
> -               break;
> -               case TRETR:
> -                       strcpy(type, "RETR");
> -               break;
> -               case TCONF:
> -                       strcpy(type, "CONF");
> -               break;
> -               case TWARN:
> -                       strcpy(type, "WARN");
> -               break;
> -               case TINFO:
> -                       strcpy(type, "INFO");
> -               break;
> -               default:
> -                       strcpy(type, "????");
> -               break;
> -       }
> -
> -       /*
>          * Build the result line and print it.
>          */
> +       type = strttype(ttype);
>         if (T_mode == VERBOSE) {
> -               fprintf(T_out, "%-8s %4d  %s  :  %s\n", tcid, tnum,
> type, tmesg);
> +               fprintf(T_out, "%-8s %4d  %s  :  %s", tcid, tnum,
> type, tmesg);
>         } else {
>                 if (trange > 1)
> -                       fprintf(T_out, "%-8s %4d-%-4d  %s  :  %s\n",
> +                       fprintf(T_out, "%-8s %4d-%-4d  %s  :  %s",
>                                 tcid, tnum, tnum + trange - 1, type,
> tmesg);
>                 else
> -                       fprintf(T_out, "%-8s %4d       %s  :  %s\n",
> +                       fprintf(T_out, "%-8s %4d       %s  :  %s",
>                                 tcid, tnum, type, tmesg);
>         }
> +       if (ttype & TERRNO) {
> +               int err = errno; /* avoid unintended side effects */
> +               fprintf(T_out, ": errno=%s(%i): %s", strerrnodef(err),
> +                       err, strerror(err));
> +       }
> +       if (ttype & TTERRNO)
> +               fprintf(T_out, ": TEST_ERRNO=%s(%i): %s",
> strerrnodef(TEST_ERRNO),
> +                       (int)TEST_ERRNO, strerror(TEST_ERRNO));
> +       fprintf(T_out, "\n");
>  
>         /*
>          * If tst_res() was called with a file, append file contents
> to the
> @@ -559,6 +617,7 @@ int tst_environ(void)
>  void tst_brk(int ttype, char *fname, void (*func)(void), char
> *arg_fmt, ...)
>  {
>         char tmesg[USERMESG];
> +       int ttype_result = TTYPE_RESULT(ttype);
>  
>  #if DEBUG
>         printf("IN tst_brk\n"); fflush(stdout);
> @@ -570,10 +629,10 @@ void tst_brk(int ttype, char *fname, voi
>         /*
>          * Only FAIL, BROK, CONF, and RETR are supported by tst_brk().
>          */
> -       if (ttype != TFAIL && ttype != TBROK && ttype != TCONF &&
> -           ttype != TRETR ) {
> +       if (ttype_result != TFAIL && ttype_result != TBROK &&
> +           ttype_result != TCONF && ttype_result != TRETR) {
>                 sprintf(Warn_mesg, "tst_brk(): Invalid Type: %d.
> Using TBROK",
> -                       ttype);
> +                       ttype_result);
>                 tst_print(TCID, 0, 1, TWARN, Warn_mesg);
>                 ttype = TBROK;
>         }
> @@ -641,8 +700,8 @@ void tst_brkloop(int ttype, char *fname,
>         if (ttype != TFAIL && ttype != TBROK && ttype != TCONF &&
>             ttype != TRETR) {
>                 sprintf(Warn_mesg,
> -                       "tst_brkloop(): Invalid Type: %d.  Using
> TBROK",
> -                       ttype);
> +                       "tst_brkloop(): Invalid Type: %d(%s).  Using
> TBROK",
> +                       ttype, strttype(ttype));
>                 tst_print(TCID, 0, 1, TWARN, Warn_mesg);
>                 ttype = TBROK;
>         }
> @@ -805,7 +864,6 @@ int main(void)
>  {
>         int  ttype;
>         int  range;
> -       char *chrptr;
>         char chr;
>         char fname[MAXMESG];
>  
> @@ -815,16 +873,18 @@ int main(void)
>                -3 : call tst_brk()\n\
>                -4 : call tst_brkloop()\n\
>                -5 : call tst_res() with a range\n\
> -               0 : call tst_res(TPASS, ...)\n\
> -               1 : call tst_res(TFAIL, ...)\n\
> -               2 : call tst_res(TBROK, ...)\n\
> -               4 : call tst_res(TWARN, ...)\n\
> -               8 : call tst_res(TRETR, ...)\n\
> -              16 : call tst_res(TINFO, ...)\n\
> -              32 : call tst_res(TCONF, ...)\n\n");
> +              %2i : call tst_res(TPASS, ...)\n\
> +              %2i : call tst_res(TFAIL, ...)\n\
> +              %2i : call tst_res(TBROK, ...)\n\
> +              %2i : call tst_res(TWARN, ...)\n\
> +              %2i : call tst_res(TRETR, ...)\n\
> +              %2i : call tst_res(TINFO, ...)\n\
> +              %2i : call tst_res(TCONF, ...)\n\n",
> +               TPASS, TFAIL, TBROK, TWARN, TRETR, TINFO, TCONF);
>  
>         while (1) {
> -               printf("Enter ttype (-5,-4,-3,-2,-1,0,1,2,4,8,16,32):
> ");
> +               printf("Enter ttype (-5,-4,-3,-2,-1,%i,%i,%i,%i,%i,%i,
> %i): ",
> +                       TPASS, TFAIL, TBROK, TWARN, TRETR, TINFO,
> TCONF);
>                 scanf("%d%c", &ttype, &chr);
>  
>                 switch (ttype) {
> @@ -837,7 +897,8 @@ int main(void)
>                         break;
>  
>                         case -3:
> -                               printf("Enter the current type
> (1=FAIL, 2=BROK, 8=RETR, 32=CONF): ");
> +                               printf("Enter the current type (%
> i=FAIL, %i=BROK, %i=RETR, %i=CONF): ",
> +                                       TFAIL, TBROK, TRETR, TCONF);
>                                 scanf("%d%c", &ttype, &chr);
>                                 printf("Enter file name (<cr> for
> none): ");
>                                 gets(fname);
> @@ -852,7 +913,8 @@ int main(void)
>                                 scanf("%d%c", &range, &chr);
>                                 Tst_lpstart = Tst_count;
>                                 Tst_lptotal = range;
> -                               printf("Enter the current type
> (1=FAIL, 2=BROK, 8=RETR, 32=CONF): ");
> +                               printf("Enter the current type (%
> i=FAIL, %i=BROK, %i=RETR, %i=CONF): ",
> +                                       TFAIL, TBROK, TRETR, TCONF);
>                                 scanf("%d%c", &ttype, &chr);
>                                 printf("Enter file name (<cr> for
> none): ");
>                                 gets(fname);
> @@ -866,7 +928,8 @@ int main(void)
>                         case -5:
>                                 printf("Enter the size of the range:
> ");
>                                 scanf("%d%c", &Tst_range, &chr);
> -                               printf("Enter the current type
> (0,1,2,4,8,16,32): ");
> +                               printf("Enter the current type (%i,%i,
> %i,%i,%i,%i,%i): ",
> +                                       TPASS, TFAIL, TBROK, TWARN,
> TRETR, TINFO, TCONF);
>                                 scanf("%d%c", &ttype, &chr);
>                         default:
>                                 printf("Enter file name (<cr> for
> none): ");
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (ltp-mmap09-ttype-masks.patch)
> 
> 
> --- testcases/kernel/syscalls/mmap/mmap09.c
> +++ testcases/kernel/syscalls/mmap/mmap09.c
> @@ -103,8 +103,7 @@ int main(int argc, char **argv)
>  
>                         if (TEST_RETURN == -1) {
>                                 TEST_ERROR_LOG(TEST_ERRNO);
> -                               tst_resm(TFAIL, "%s - errnor: %d",
> -                                        TC[i].desc, TEST_ERRNO);
> +                               tst_resm(TFAIL|TTERRNO, "%s",
> TC[i].desc);
>                         } else {
>                                 tst_resm(TPASS, TC[i].desc);
>                         }
> @@ -129,19 +128,16 @@ void setup()
>         tst_tmpdir();
>  
>         if ((fd = open("mmaptest", O_RDWR | O_CREAT, 0666)) < 0)
> -               tst_brkm(TFAIL, cleanup, "failed to open mmaptest "
> -                        "file, errno: %d", errno);
> +               tst_brkm(TFAIL|TERRNO, cleanup, "open(mmaptest) file
> failed");
>  
>         /* ftruncate the file to 16k */
>         if (ftruncate(fd, mapsize) < 0)
> -               tst_brkm(TFAIL, cleanup, "failed to ftruncate "
> -                        "file, errno: %d", errno);
> +               tst_brkm(TFAIL|TERRNO, cleanup, "ftruncate() file
> failed");
>  
>         maddr = mmap(0, (size_t) mapsize, PROT_READ | PROT_WRITE,
>                      MAP_FILE | MAP_SHARED, fd, (off_t) 0);
>         if (maddr == MAP_FAILED)
> -               tst_brkm(TFAIL, cleanup, "failed to mmap file, "
> -                        "errno: %d", errno);
> +               tst_brkm(TFAIL|TERRNO, cleanup, "mmap() file failed");
>         /* fill up the file with A's */
>         for (i = 0; i < mapsize; i++)
>                 maddr[i] = 'A';


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
