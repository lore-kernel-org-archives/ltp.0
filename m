Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C086C433EF
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 13:02:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD0D608FB
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 13:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CD0D608FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8004C3C71C2
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 14:02:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C93B3C3265
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 14:02:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B9F22601497
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 14:02:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DBD11F782;
 Wed,  3 Nov 2021 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635944535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJfYEqxumQp0yyVKMcq4n6r9CbAOmn1oCyFj0i1Qr28=;
 b=n77+VMhqk3MJ/JZC5/MXsd6wuhvoof/qeR5HJ/IQURtVcq3ETNndN46PHO8X68FHFRfobp
 a/sOe22gqHCzfOK0gTegLhy/flAG50+hUXMK2tPrH/BARYeWT65cej5ORPMHdu9g1CZukd
 ZLA0XrIpvox8nVDRvbbCmEIHJG1j2Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635944535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJfYEqxumQp0yyVKMcq4n6r9CbAOmn1oCyFj0i1Qr28=;
 b=VGh1P8rIGhmgBcAaeBcRfscfsivVsN6vaJ2dc5wm3eyVS3Rsao+1fNN714pK/e2Ci0eDgJ
 2hA4DKwZ3o64iBBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B38C13E03;
 Wed,  3 Nov 2021 13:02:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qxdgAleIgmHxZQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 03 Nov 2021 13:02:15 +0000
Date: Wed, 3 Nov 2021 14:03:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Krzysztof Dynowski <k.dynowski@samsung.com>
Message-ID: <YYKIj/LE2jv4yL5x@yuki>
References: <CGME20211103090509eucms1p3879e480f890ad8e00a40febd3cf98279@eucms1p1>
 <20211103113400eucms1p132b09d599216a0b3c42f24fd670d0c40@eucms1p1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211103113400eucms1p132b09d599216a0b3c42f24fd670d0c40@eucms1p1>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Make global vars/funcs static, where possible #879
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
First of all the mine type for the attachment is still wrong, it should
be text/plain.

>    -char *TCID = "abs01";
>    -int local_flag = PASSED;
>    -int block_number;
>    -FILE *temp;
>    -int TST_TOTAL = 1;
>    +static const char *TCID = "abs01";

Actually this is wrong, the test library makes use fo the TCID so it's
not supposed to be static.

>    +static int local_flag = PASSED;
>    +static int block_number;
>    +static FILE *temp;
>    +static int TST_TOTAL = 1;

Same for the TST_TOTAL. See lib/tst_res.c line 123.

>     static void setup(void);
>     static int blenter(void);
>    diff --git a/testcases/misc/math/atof/atof01.c
>    b/testcases/misc/math/atof/atof01.c
>    index 98d085abb..67d904810 100644
>    --- a/testcases/misc/math/atof/atof01.c
>    +++ b/testcases/misc/math/atof/atof01.c
>    @@ -49,16 +49,16 @@
>     /*****         *****/
>     #define ERR            0.0000001
> 
>    -double pi;
>    +static double pi;
> 
>     /*char progname[]= "atof1()"; */
>     /**    LTP Port        **/
>    -char *TCID = "atof01";         /* Test program identifier */
>    +static const char *TCID = "atof01";            /* Test program
>    identifier */
> 
>    -int local_flag = PASSED;
>    -int block_number;
>    -FILE *temp;
>    -int TST_TOTAL = 1;
>    +static int local_flag = PASSED;
>    +static int block_number;
>    +static FILE *temp;
>    +static int TST_TOTAL = 1;
> 
>     static void setup(void);
>     static void blenter(void);
>    diff --git a/testcases/misc/math/float/main.c
>    b/testcases/misc/math/float/main.c
>    index 7285141a4..fecc154e5 100644
>    --- a/testcases/misc/math/float/main.c
>    +++ b/testcases/misc/math/float/main.c
>    @@ -29,13 +29,13 @@
> 
>     #define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }
>     /* LTP status reporting */
>    -char *TCID;                    /* Test program identifier.    */
>    -int TST_TOTAL = 1;             /* Total number of test cases. */
>    +static char *TCID;                     /* Test program identifier.
>    */
>    +static int TST_TOTAL = 1;              /* Total number of test cases.
>    */
> 
>     /* To avoid extensive modifications to the code, use this bodge */
>     #define exit(x) myexit(x)
> 
>    -void myexit(int x)
>    +static void myexit(int x)
>     {
>            if (x)
>                    tst_resm(TFAIL, "Test failed");
>    @@ -44,45 +44,45 @@ void myexit(int x)
>            tst_exit();
>     }
> 
>    -TH_DATA *pcom;
>    -TH_DATA **tabcom;
>    -TH_DATA **tabcour;
>    +static TH_DATA *pcom;
>    +static TH_DATA **tabcom;
>    +static TH_DATA **tabcour;
>     #ifndef        PATH_MAX
>     #define PATH_MAX               1024
>     #endif
>    -char datadir[PATH_MAX];                /* DATA directory */
>    +static char datadir[PATH_MAX];         /* DATA directory */
> 
>     #ifndef PTHREAD_THREADS_MAX
>     #define PTHREAD_THREADS_MAX    1024
>     #endif
>     #define DEFAULT_NUM_THREADS    20
>    -int num_threads = DEFAULT_NUM_THREADS;
>    -int num_loops = 500;
>    +static int num_threads = DEFAULT_NUM_THREADS;
>    +static int num_loops = 500;
> 
>    -int sig_cancel = 0;            /* flag set by handle_signals to tell
>    initial thread
>    +static int sig_cancel = 0;             /* flag set by handle_signals
>    to tell initial thread
>                                       to stop creating new threads (signal
>    caught) */
> 
>    -int indice = 0;                        /* # of threads created, to be
>    canceled by handle_signals
>    +static int indice = 0;                 /* # of threads created, to be
>    canceled by handle_signals
>                                       or waited for by initial thread */
> 
>    -pthread_mutex_t sig_mutex;
>    -pthread_t *threads;
>    +static pthread_mutex_t sig_mutex;
>    +static pthread_t *threads;
> 
>    -int debug = 0;
>    -int true = 1;
>    +static int debug = 0;
>    +static int is_true = 1;
> 
>     static void *handle_signals(void *);
> 
>     static void sys_error(const char *, int);
> 
>    -const double EPS = 0.1e-300;
>    +static const double EPS = 0.1e-300;
> 
>    -const int nb_func = NB_FUNC;
>    +static const int nb_func = NB_FUNC;
> 
>    -int generate(char *datadir, char *bin_path)
>    +static int generate(char *datadir, char *bin_path)
>     {
>            char *cmdline;
>    -       char *fmt = "cd %s; %s/%s %s";
>    +       const char *fmt = "cd %s; %s/%s %s";
> 
>            cmdline = malloc(2 * strlen(bin_path) + strlen(datadir) +
>    strlen(GENERATOR) + strlen(fmt));
>            if (cmdline == NULL)
>    @@ -229,7 +229,7 @@ int main(int argc, char *argv[])
> 
>            indice = 0;
>            for (i = 0; i < nb_func; i++) {
>    -
>    +               tst_resm(TINFO, "  > running test %d", i+1);
>                    for (th_num = 0; th_num < num_threads; th_num++) {
> 
>                            /* allocate struct of commucation  with the
>    thread */
>    @@ -237,7 +237,7 @@ int main(int argc, char *argv[])
>                            if (pcom == NULL)
>                                    tst_brkm(TFAIL | TERRNO, cleanup,
>                                             "calloc failed");
>    -                       *tabcour = (TH_DATA *) pcom;
>    +                       *tabcour = pcom;
>                            tabcour++;
>                            /*
>                             * update structure of communication
>    @@ -252,7 +252,7 @@ int main(int argc, char *argv[])
>                                    goto finished;
>                            }
>                            retval = pthread_create(&threads[indice],
>    &newattr,
>    -                                               thread_code, (void
>    *)pcom);
>    +                                               thread_code, pcom);
>                            if (retval != 0)
>                                    sys_error("main : create FAILED",
>    __LINE__);
>                            indice++;
>    diff --git a/testcases/misc/math/float/tfloat.h
>    b/testcases/misc/math/float/tfloat.h
>    index 50cb73d10..438bbe728 100644
>    --- a/testcases/misc/math/float/tfloat.h
>    +++ b/testcases/misc/math/float/tfloat.h
>    @@ -53,11 +53,7 @@
>     #define FUNC_LDEXP             7
>     #define FUNC_GAM               8
> 
>    -extern void * thread_code(void *);
>    -
>    -/* global variables, constants or initialized by main() */
>    -extern const double EPS; /* 0.1e-300 */
>    -extern int true, num_threads;

And these three constansts seem to be shared between thread_code.c and
main.c. I guess that proper fix would be to propagate them to the
TH_DATA structure.

>    +static void * thread_code(void *);
> 
>     /*
>      * TH_DATA structures
>    @@ -102,6 +98,4 @@ typedef struct {
>            TH_FUNC th_func;
>     } TH_DATA;
> 
>    -extern const TH_FUNC th_func[];

This one as well, appears to be shared between different C source files.

>     #endif /* ifndef _TFLOAT_H */
>    diff --git a/testcases/misc/math/float/thread_code.c
>    b/testcases/misc/math/float/thread_code.c
>    index ca18cef1e..125a60c15 100644
>    --- a/testcases/misc/math/float/thread_code.c
>    +++ b/testcases/misc/math/float/thread_code.c
>    @@ -274,7 +274,7 @@ static void compute_ldexp(TH_DATA * th_data, double
>    *din, double *dex,
>      *     pointer to a TH_DATA structure.
>      *
>      */
>    -void *thread_code(void *arg)
>    +static void *thread_code(void *arg)
>     {
>            TH_DATA *th_data = (TH_DATA *) arg;
>            size_t fsize, fsize2, fsize3;
>    diff --git a/testcases/misc/math/fptests/fptest01.c
>    b/testcases/misc/math/fptests/fptest01.c
>    index 2072dced6..76d5b0121 100644
>    --- a/testcases/misc/math/fptests/fptest01.c
>    +++ b/testcases/misc/math/fptests/fptest01.c
>    @@ -61,8 +61,8 @@
>     /** LTP Port **/
>     #include "test.h"
> 
>    -char *TCID = "fptest01";       /* Test program identifier.    */
>    -int TST_TOTAL = 1;             /* Total number of test cases. */
>    +static const char *TCID = "fptest01";  /* Test program identifier.
>    */
>    +static int TST_TOTAL = 1;              /* Total number of test cases.
>    */
>     /**************/
> 
>     struct event {
>    @@ -79,19 +79,19 @@ static int addevent(int, int, double);
>     static void gaussinit(double, double);
>     static double gauss(void);
> 
>    -struct event eventtab[EVENTMX];
>    -struct event rtrevent;
>    -int waiting[EVENTMX];          /* array of waiting processors */
>    -int nwaiting;                  /* number of waiting processors */
>    -double global_time;            /* global clock */
>    -double lsttime;                        /* time used for editing */
>    -double dtc, dts, alpha;                /* timing parameters */
>    -int nproc;                     /* number of processors */
>    -int barcnt;                    /* number of processors ATBARRIER */
>    -int ncycle;                    /* number of cycles completed */
>    -int ncycmax;                   /* number of cycles to run */
>    -int critfree;                  /* TRUE if critical section not
>    occupied */
>    -int gcount;                    /* # calls to gauss */
>    +static struct event eventtab[EVENTMX];
>    +static struct event rtrevent;
>    +static int waiting[EVENTMX];           /* array of waiting processors
>    */
>    +static int nwaiting;                   /* number of waiting processors
>    */
>    +static double global_time;             /* global clock */
>    +static double lsttime;                 /* time used for editing */
>    +static double dtc, dts, alpha;         /* timing parameters */
>    +static int nproc;                      /* number of processors */
>    +static int barcnt;                     /* number of processors
>    ATBARRIER */
>    +static int ncycle;                     /* number of cycles completed
>    */
>    +static int ncycmax;                    /* number of cycles to run */
>    +static int critfree;                   /* TRUE if critical section not
>    occupied */
>    +static int gcount;                     /* # calls to gauss */
> 
>     static struct event *nextevent(void);
> 
>    diff --git a/testcases/misc/math/fptests/fptest02.c
>    b/testcases/misc/math/fptests/fptest02.c
>    index e6b49feb9..5bb849d65 100644
>    --- a/testcases/misc/math/fptests/fptest02.c
>    +++ b/testcases/misc/math/fptests/fptest02.c
>    @@ -61,8 +61,8 @@
>     /** LTP Port **/
>     #include "test.h"
> 
>    -char *TCID = "fptest02";       /* Test program identifier.    */
>    -int TST_TOTAL = 1;             /* Total number of test cases. */
>    +static const char *TCID = "fptest02";  /* Test program identifier.
>    */
>    +static int TST_TOTAL = 1;              /* Total number of test cases.
>    */
>     /**************/
> 
>     struct event {
>    @@ -79,18 +79,18 @@ static int addevent(int, int, double);
>     static void gaussinit(double, double, int);
>     static double gauss(void);
> 
>    -struct event eventtab[EVENTMX];
>    -struct event rtrevent;
>    -int waiting[EVENTMX];          /* array of waiting processors */
>    -int nwaiting;                  /* number of waiting processors */
>    -double sgtime;                 /* global clock */
>    -double lsttime;                        /* time used for editing */
>    -double dtc, dts, alpha;                /* timing parameters */
>    -int nproc;                     /* number of processors */
>    -int barcnt;                    /* number of processors ATBARRIER */
>    -int ncycle;                    /* number of cycles completed */
>    -int ncycmax;                   /* number of cycles to run */
>    -int critfree;                  /* TRUE if critical section not
>    occupied */
>    +static struct event eventtab[EVENTMX];
>    +static struct event rtrevent;
>    +static int waiting[EVENTMX];           /* array of waiting processors
>    */
>    +static int nwaiting;                   /* number of waiting processors
>    */
>    +static double sgtime;                  /* global clock */
>    +static double lsttime;                 /* time used for editing */
>    +static double dtc, dts, alpha;         /* timing parameters */
>    +static int nproc;                      /* number of processors */
>    +static int barcnt;                     /* number of processors
>    ATBARRIER */
>    +static int ncycle;                     /* number of cycles completed
>    */
>    +static int ncycmax;                    /* number of cycles to run */
>    +static int critfree;                   /* TRUE if critical section not
>    occupied */
> 
>     static struct event *nextevent(void );
> 
>    diff --git a/testcases/misc/math/nextafter/nextafter01.c
>    b/testcases/misc/math/nextafter/nextafter01.c
>    index f4b212d4d..6faa4a7a5 100644
>    --- a/testcases/misc/math/nextafter/nextafter01.c
>    +++ b/testcases/misc/math/nextafter/nextafter01.c
>    @@ -43,16 +43,16 @@
>     #define        FAILED 0
>     #define        PASSED 1
> 
>    -char *TCID = "nextafter01";
>    +static const char *TCID = "nextafter01";
> 
>    -int local_flag = PASSED;
>    -int block_number;
>    -FILE *temp;
>    -int TST_TOTAL = 1;
>    +static int local_flag = PASSED;
>    +static int block_number;
>    +static FILE *temp;
>    +static int TST_TOTAL = 1;
> 
>    -void setup();
>    -void blenter();
>    -void blexit();
>    +static void setup();
>    +static void blenter();
>    +static void blexit();
> 
>     /*--------------------------------------------------------------*/
>     int main()
>    --
>    2.25.1


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
