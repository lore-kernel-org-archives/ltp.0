Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hakehuang@gmail.com>) id 1QuHUx-0005XU-Cj
	for ltp-list@lists.sourceforge.net; Fri, 19 Aug 2011 05:20:03 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QuHUu-0007Sr-VF
	for ltp-list@lists.sourceforge.net; Fri, 19 Aug 2011 05:20:03 +0000
Received: by gyg4 with SMTP id 4so2457514gyg.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Aug 2011 22:19:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mailman.321379.1313481992.22889.ltp-list@lists.sourceforge.net>
References: <mailman.321379.1313481992.22889.ltp-list@lists.sourceforge.net>
Date: Fri, 19 Aug 2011 13:19:54 +0800
Message-ID: <CAPt5XBfBW2-mTXVYR=B-mbaN2pCPG0UGa7vm0Bb2X7G6pyqRMA@mail.gmail.com>
From: hake huang <hakehuang@gmail.com>
Subject: Re: [LTP] Ltp-list Digest, Vol 63, Issue 22
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8832048434305054136=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8832048434305054136==
Content-Type: multipart/alternative; boundary=001636c5bf2334459b04aad4e14a

--001636c5bf2334459b04aad4e14a
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I test LTP in arm, cortex-a9 which is 4 core system, and find that the mmap1
of memtest06, failed. when I check the LTP mail list and find this patch
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10706.html
however, when I apply this patch, I can still see the same problem but with
less frequency. It looks like the write process and read process are running
on different core, when write process unmap and remap the address, and the
other process is read at the same time.

So any suggestions?

Regards,

Hake

2011/8/16 <ltp-list-request@lists.sourceforge.net>

> Send Ltp-list mailing list submissions to
>        ltp-list@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        https://lists.sourceforge.net/lists/listinfo/ltp-list
> or, via email, send a message with subject or body 'help' to
>        ltp-list-request@lists.sourceforge.net
>
> You can reach the person managing the list at
>        ltp-list-owner@lists.sourceforge.net
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Ltp-list digest..."
>
>
> Today's Topics:
>
>   1.  [PATCH 4/6] hugemmap02.c (tangchen)
>   2.  [PATCH 5/6] hugemmap03.c (tangchen)
>   3.  [PATCH 6/6] hugemmap04.c (tangchen)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 16 Aug 2011 16:02:23 +0800
> From: tangchen <tangchen@cn.fujitsu.com>
> Subject: [LTP]  [PATCH 4/6] hugemmap02.c
> To: Cyril Hrubis <chrubis@suse.cz>, Garrett Cooper
>        <yanegomi@gmail.com>
> Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
> Message-ID: <4E4A240F.9020709@cn.fujitsu.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |   47
> +++++++-------------
>  1 files changed, 16 insertions(+), 31 deletions(-)
>
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> index 45cddf7..3bbbc46 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> @@ -63,6 +63,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "libmnt.h"
>
>  #define LOW_ADDR       (void *)(0x80000000)
>  #define LOW_ADDR2      (void *)(0x90000000)
> @@ -77,38 +78,17 @@ unsigned long *addrlist[5]; /* list of addresses of
> memory mapped region */
>  int i;
>  int fildes;                    /* file descriptor for tempfile */
>  int nfildes;                   /* file descriptor for /dev/zero */
> -char *Hopt;                     /* location of hugetlbfs */
> +char *mount_point = NULL;
>
> -void setup();                  /* Main setup function of test */
> -void cleanup();                        /* cleanup function for the test */
> -
> -void help()
> -{
> -       printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs
> \n");
> -}
> +void setup(void);                      /* Main setup function of test */
> +void cleanup(void);                    /* cleanup function for the test */
>
>  int
>  main(int ac, char **av)
>  {
>        int lc;
> -       char *msg;
> -        int Hflag = 0;
>        int page_sz, map_sz;
>
> -               option_t options[] = {
> -               { "H:",   &Hflag, &Hopt },    /* Required for location of
> hugetlbfs */
> -               { NULL, NULL, NULL }          /* NULL required to end array
> */
> -               };
> -
> -       /* Parse standard options given to run the test. */
> -       if ((msg = parse_opts(ac, av, options, &help)) != NULL)
> -               tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use
> -help", msg);
> -
> -       if (Hflag == 0) {
> -               tst_brkm(TBROK, NULL,
> -                   "-H option is REQUIRED for this test, use -h for
> options help");
> -       }
> -
>        page_sz = getpagesize();
>        map_sz = 2 * 1024 * hugepages_size();
>
> @@ -206,15 +186,20 @@ main(int ac, char **av)
>  *          Write some known data into file and get the size of the file.
>  */
>  void
> -setup()
> +setup(void)
>  {
> -       tst_tmpdir();
> -
> -       snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt,
> getpid());
> -
> +       tst_require_root(NULL);
>        tst_sig(FORK, DEF_HANDLER, cleanup);
>
>        TEST_PAUSE;
> +
> +       tst_tmpdir();
> +       mount_point = get_tst_tmpdir();
> +
> +       mount_hugetlbfs(mount_point);
> +       hugepage_alloc(1024);
> +
> +       snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount_point,
> getpid());
>  }
>
>  /*
> @@ -223,7 +208,7 @@ setup()
>  *            Remove the temporary directory created.
>  */
>  void
> -cleanup()
> +cleanup(void)
>  {
>        /*
>         * print timing stats if that option was specified.
> @@ -231,6 +216,6 @@ cleanup()
>        TEST_CLEANUP;
>
>        unlink(TEMPFILE);
> -
> +       umount_hugetlbfs(mount_point);
>        tst_rmdir();
>  }
> --
> 1.7.1
>
> --
> Best Regards,
> Tang chen
> -------------- next part --------------
> An embedded and charset-unspecified text was scrubbed...
> Name: 0004-hugemmap02.c-Automatically-mount-hugetlbfs-on-huge.patch
>
> ------------------------------
>
> Message: 2
> Date: Tue, 16 Aug 2011 16:03:25 +0800
> From: tangchen <tangchen@cn.fujitsu.com>
> Subject: [LTP]  [PATCH 5/6] hugemmap03.c
> To: Cyril Hrubis <chrubis@suse.cz>, Garrett Cooper
>        <yanegomi@gmail.com>
> Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
> Message-ID: <4E4A244D.6050901@cn.fujitsu.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |   66
> ++++++++------------
>  1 files changed, 26 insertions(+), 40 deletions(-)
>
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> index cac94b0..b17b19d 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> @@ -54,54 +54,31 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "libmnt.h"
>
>  #define HIGH_ADDR      (void *)(0x1000000000000)
>
> -char* TEMPFILE="mmapfile";
> +char TEMPFILE[MAXPATHLEN];
>
>  char *TCID="hugemmap03";       /* Test program identifier.    */
>  int TST_TOTAL=1;               /* Total number of test cases. */
>  unsigned long *addr;           /* addr of memory mapped region */
>  int fildes;                    /* file descriptor for tempfile */
> -char *Hopt;                     /* location of hugetlbfs */
> +char *mount_point = NULL;
>
> -void setup();                  /* Main setup function of test */
> -void cleanup();                        /* cleanup function for the test */
> -
> -void help()
> -{
> -       printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs
> \n");
> -}
> +void setup(void);                      /* Main setup function of test */
> +void cleanup(void);                    /* cleanup function for the test */
>
>  int
>  main(int ac, char **av)
>  {
>        int lc;                 /* loop counter */
> -       char *msg;              /* message returned from parse_opts */
> -        int Hflag=0;              /* binary flag: opt or not */
>        int page_sz;
>
>  #if __WORDSIZE==32  /* 32-bit compiled */
>        tst_brkm(TCONF, NULL, "This test is only for 64bit");
>  #endif
>
> -               option_t options[] = {
> -               { "H:",   &Hflag, &Hopt },    /* Required for location of
> hugetlbfs */
> -               { NULL, NULL, NULL }          /* NULL required to end array
> */
> -               };
> -
> -       /* Parse standard options given to run the test. */
> -       msg = parse_opts(ac, av, options, &help);
> -       if (msg != (char *) NULL) {
> -               tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use
> -help", msg);
> -               tst_exit();
> -       }
> -
> -       if (Hflag == 0) {
> -               tst_brkm(TBROK, NULL, "-H option is REQUIRED for this test,
> use -h for options help");
> -               tst_exit();
> -       }
> -
>        page_sz = getpagesize();
>
>        setup();
> @@ -122,8 +99,15 @@ main(int ac, char **av)
>                addr = mmap(HIGH_ADDR, page_sz, PROT_READ,
>                            MAP_SHARED | MAP_FIXED, fildes, 0);
>                if (addr != MAP_FAILED) {
> -                       tst_resm(TFAIL, "Normal mmap() into high region
> unexpectedly succeeded on %s, errno=%d : %s",
> -                                TEMPFILE, errno, strerror(errno));
> +                       tst_resm(TFAIL|TERRNO, "Normal mmap() into high
> region unexpectedly "
> +                               "succeeded on %s",
> +                               TEMPFILE);
> +
> +                       /* Unmap the mapped memory */
> +                       if (munmap(addr, page_sz) != 0) {
> +                               tst_brkm(TFAIL|TERRNO, NULL, "munmap()
> fails to unmap the "
> +                                       "memory");
> +                       }
>                        continue;
>                } else {
>                        tst_resm(TPASS, "Normal mmap() into high region
> failed correctly");
> @@ -132,7 +116,6 @@ main(int ac, char **av)
>
>                close(fildes);
>        }
> -
>        cleanup();
>
>        tst_exit();
> @@ -149,18 +132,20 @@ main(int ac, char **av)
>  *          Write some known data into file and get the size of the file.
>  */
>  void
> -setup()
> +setup(void)
>  {
> -       char mypid[40];
> -
> -       sprintf(mypid,"/%d",getpid());
> -       TEMPFILE=strcat(mypid,TEMPFILE);
> -       TEMPFILE=strcat(Hopt,TEMPFILE);
> -
> +       tst_require_root(NULL);
>        tst_sig(FORK, DEF_HANDLER, cleanup);
>
>        TEST_PAUSE;
>
> +       tst_tmpdir();
> +       mount_point = get_tst_tmpdir();
> +
> +       mount_hugetlbfs(mount_point);
> +       hugepage_alloc(1024);
> +
> +       snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount_point,
> getpid());
>  }
>
>  /*
> @@ -169,7 +154,7 @@ setup()
>  *            Remove the temporary directory created.
>  */
>  void
> -cleanup()
> +cleanup(void)
>  {
>        /*
>         * print timing stats if that option was specified.
> @@ -177,5 +162,6 @@ cleanup()
>        TEST_CLEANUP;
>
>        unlink(TEMPFILE);
> -
> +       umount_hugetlbfs(mount_point);
> +       tst_rmdir();
>  }
> --
> 1.7.1
>
> --
> Best Regards,
> Tang chen
> -------------- next part --------------
> An embedded and charset-unspecified text was scrubbed...
> Name: 0005-hugemmap03.c-Automatically-mount-hugetlbfs-on-huge.patch
>
> ------------------------------
>
> Message: 3
> Date: Tue, 16 Aug 2011 16:04:10 +0800
> From: tangchen <tangchen@cn.fujitsu.com>
> Subject: [LTP]  [PATCH 6/6] hugemmap04.c
> To: Cyril Hrubis <chrubis@suse.cz>, Garrett Cooper
>        <yanegomi@gmail.com>
> Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
> Message-ID: <4E4A247A.6070606@cn.fujitsu.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |   52
> ++++++--------------
>  1 files changed, 16 insertions(+), 36 deletions(-)
>
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> index 4cc6ed4..9774e87 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> @@ -73,10 +73,11 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "libmnt.h"
>
>  #define BUFFER_SIZE  256
>
> -char* TEMPFILE="mmapfile";
> +char TEMPFILE[MAXPATHLEN];
>
>  char *TCID="hugemmap04";       /* Test program identifier.    */
>  int TST_TOTAL=1;               /* Total number of test cases. */
> @@ -87,41 +88,17 @@ int freepages=0;            /* Amount of free huge
> pages to use for testing */
>  int beforetest=0;              /* Amount of free huge pages before testing
> */
>  int aftertest=0;               /* Amount of free huge pages after testing
> */
>  int hugepagesmapped=0;         /* Amount of huge pages mapped after
> testing */
> -char *Hopt;                     /* location of hugetlbfs */
> +char *mount_point = NULL;
>
> -void setup();                  /* Main setup function of test */
> -void cleanup();                        /* cleanup function for the test */
> -
> -void help()
> -{
> -       printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs
> \n");
> -}
> +void setup(void);                      /* Main setup function of test */
> +void cleanup(void);                    /* cleanup function for the test */
>
>  int
>  main(int ac, char **av)
>  {
>        int lc;                 /* loop counter */
> -       char *msg;              /* message returned from parse_opts */
> -        int Hflag=0;              /* binary flag: opt or not */
>        int huge_pagesize=0;
>
> -               option_t options[] = {
> -               { "H:",   &Hflag, &Hopt },    /* Required for location of
> hugetlbfs */
> -               { NULL, NULL, NULL }          /* NULL required to end array
> */
> -               };
> -
> -       /* Parse standard options given to run the test. */
> -       msg = parse_opts(ac, av, options, &help);
> -       if (msg != (char *) NULL) {
> -               tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use
> -help", msg);
> -               tst_exit();
> -       }
> -
> -       if (Hflag == 0) {
> -               tst_brkm(TBROK, NULL, "-H option is REQUIRED for this test,
> use -h for options help");
> -               tst_exit();
> -       }
> -
>        /* Check number of hugepages */
>        if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
>                tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
> @@ -151,7 +128,7 @@ main(int ac, char **av)
>                tst_resm(TINFO,"Total amount of free huge pages is
> %d",freepages);
>                tst_resm(TINFO,"Max number allowed for 1 mmap file in
> 32-bits is 128");
>                if (freepages > 128)
> -                 freepages=128;
> +                       freepages=128;
>  #endif
>                /*
>                 * Call mmap
> @@ -206,16 +183,18 @@ main(int ac, char **av)
>  void
>  setup()
>  {
> -       char mypid[40];
> -
> -       sprintf(mypid,"/%d",getpid());
> -       TEMPFILE=strcat(mypid,TEMPFILE);
> -       TEMPFILE=strcat(Hopt,TEMPFILE);
> -
> +       tst_require_root(NULL);
>        tst_sig(FORK, DEF_HANDLER, cleanup);
>
>        TEST_PAUSE;
>
> +       tst_tmpdir();
> +       mount_point = get_tst_tmpdir();
> +
> +       mount_hugetlbfs(mount_point);
> +       hugepage_alloc(1024);
> +
> +       snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount_point,
> getpid());
>  }
>
>  /*
> @@ -232,5 +211,6 @@ cleanup()
>        TEST_CLEANUP;
>
>        unlink(TEMPFILE);
> -
> +       umount_hugetlbfs(mount_point);
> +       tst_rmdir();
>  }
> --
> 1.7.1
>
> --
> Best Regards,
> Tang chen
> -------------- next part --------------
> An embedded and charset-unspecified text was scrubbed...
> Name: 0006-hugemmap04.c-Automatically-mount-hugetlbfs-on-huge.patch
>
> ------------------------------
>
>
> ------------------------------------------------------------------------------
> uberSVN's rich system and user administration capabilities and model
> configuration take the hassle out of deploying and managing Subversion and
> the tools developers use with it. Learn more about uberSVN and get a free
> download at:  http://p.sf.net/sfu/wandisco-dev2dev
>
>
> ------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>
> End of Ltp-list Digest, Vol 63, Issue 22
> ****************************************
>

--001636c5bf2334459b04aad4e14a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I test LTP in arm, cortex-a9 which is 4 core system, and find th=
at the mmap1 of memtest06, failed. when I check the LTP mail list and find =
this patch<br><a href=3D"http://www.mail-archive.com/ltp-list@lists.sourcef=
orge.net/msg10706.html">http://www.mail-archive.com/ltp-list@lists.sourcefo=
rge.net/msg10706.html</a><br>
however, when I apply this patch, I can still see the same problem but with=
 less frequency. It looks like the write process and read process are runni=
ng on different core, when write process unmap and remap the address, and t=
he other process is read at the same time.<br>
<br>So any suggestions?<br><br>Regards,<br><br>Hake<br><br><div class=3D"gm=
ail_quote">2011/8/16  <span dir=3D"ltr">&lt;<a href=3D"mailto:ltp-list-requ=
est@lists.sourceforge.net">ltp-list-request@lists.sourceforge.net</a>&gt;</=
span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Send Ltp-list mailing list submissions to<b=
r>
 =A0 =A0 =A0 =A0<a href=3D"mailto:ltp-list@lists.sourceforge.net">ltp-list@=
lists.sourceforge.net</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
 =A0 =A0 =A0 =A0<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp=
-list" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-l=
ist</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:ltp-list-request@lists.sourceforge.net">l=
tp-list-request@lists.sourceforge.net</a><br>
<br>
You can reach the person managing the list at<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:ltp-list-owner@lists.sourceforge.net">ltp=
-list-owner@lists.sourceforge.net</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of Ltp-list digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
 =A0 1. =A0[PATCH 4/6] hugemmap02.c (tangchen)<br>
 =A0 2. =A0[PATCH 5/6] hugemmap03.c (tangchen)<br>
 =A0 3. =A0[PATCH 6/6] hugemmap04.c (tangchen)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Tue, 16 Aug 2011 16:02:23 +0800<br>
From: tangchen &lt;<a href=3D"mailto:tangchen@cn.fujitsu.com">tangchen@cn.f=
ujitsu.com</a>&gt;<br>
Subject: [LTP] =A0[PATCH 4/6] hugemmap02.c<br>
To: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>=
&gt;, Garrett Cooper<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.co=
m</a>&gt;<br>
Cc: &quot;<a href=3D"mailto:ltp-list@lists.sourceforge.net">ltp-list@lists.=
sourceforge.net</a>&quot; &lt;<a href=3D"mailto:ltp-list@lists.sourceforge.=
net">ltp-list@lists.sourceforge.net</a>&gt;<br>
Message-ID: &lt;<a href=3D"mailto:4E4A240F.9020709@cn.fujitsu.com">4E4A240F=
.9020709@cn.fujitsu.com</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;iso-8859-1&quot;<br>
<br>
Signed-off-by: Tang Chen &lt;<a href=3D"mailto:tangchen@cn.fujitsu.com">tan=
gchen@cn.fujitsu.com</a>&gt;<br>
---<br>
=A0testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c | =A0 47 +++++++-----=
--------<br>
=A01 files changed, 16 insertions(+), 31 deletions(-)<br>
<br>
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases=
/kernel/mem/hugetlb/hugemmap/hugemmap02.c<br>
index 45cddf7..3bbbc46 100644<br>
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c<br>
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c<br>
@@ -63,6 +63,7 @@<br>
=A0#include &quot;test.h&quot;<br>
=A0#include &quot;usctest.h&quot;<br>
=A0#include &quot;system_specific_hugepages_info.h&quot;<br>
+#include &quot;libmnt.h&quot;<br>
<br>
=A0#define LOW_ADDR =A0 =A0 =A0 (void *)(0x80000000)<br>
=A0#define LOW_ADDR2 =A0 =A0 =A0(void *)(0x90000000)<br>
@@ -77,38 +78,17 @@ unsigned long *addrlist[5]; /* list of addresses of mem=
ory mapped region */<br>
=A0int i;<br>
=A0int fildes; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* file descriptor fo=
r tempfile */<br>
=A0int nfildes; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* file descriptor for =
/dev/zero */<br>
-char *Hopt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* location of hugetlb=
fs */<br>
+char *mount_point =3D NULL;<br>
<br>
-void setup(); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Main setup function of=
 test */<br>
-void cleanup(); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* cleanup =
function for the test */<br>
-<br>
-void help()<br>
-{<br>
- =A0 =A0 =A0 printf(&quot; =A0-H /.. =A0Location of hugetlbfs, i.e. -H /va=
r/hugetlbfs \n&quot;);<br>
-}<br>
+void setup(void); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Main setup=
 function of test */<br>
+void cleanup(void); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* cleanup func=
tion for the test */<br>
<br>
=A0int<br>
=A0main(int ac, char **av)<br>
=A0{<br>
 =A0 =A0 =A0 =A0int lc;<br>
- =A0 =A0 =A0 char *msg;<br>
- =A0 =A0 =A0 =A0int Hflag =3D 0;<br>
 =A0 =A0 =A0 =A0int page_sz, map_sz;<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 option_t options[] =3D {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;H:&quot;, =A0 &amp;Hflag, &amp;Hopt }=
, =A0 =A0/* Required for location of hugetlbfs */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 { NULL, NULL, NULL } =A0 =A0 =A0 =A0 =A0/* NU=
LL required to end array */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
-<br>
- =A0 =A0 =A0 /* Parse standard options given to run the test. */<br>
- =A0 =A0 =A0 if ((msg =3D parse_opts(ac, av, options, &amp;help)) !=3D NUL=
L)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL, &quot;OPTION PARSING ER=
ROR - %s, use -help&quot;, msg);<br>
-<br>
- =A0 =A0 =A0 if (Hflag =3D=3D 0) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;-H option is REQUIRED for this =
test, use -h for options help&quot;);<br>
- =A0 =A0 =A0 }<br>
-<br>
 =A0 =A0 =A0 =A0page_sz =3D getpagesize();<br>
 =A0 =A0 =A0 =A0map_sz =3D 2 * 1024 * hugepages_size();<br>
<br>
@@ -206,15 +186,20 @@ main(int ac, char **av)<br>
 =A0* =A0 =A0 =A0 =A0 =A0Write some known data into file and get the size o=
f the file.<br>
 =A0*/<br>
=A0void<br>
-setup()<br>
+setup(void)<br>
=A0{<br>
- =A0 =A0 =A0 tst_tmpdir();<br>
-<br>
- =A0 =A0 =A0 snprintf(TEMPFILE, sizeof(TEMPFILE), &quot;%s/mmapfile%d&quot=
;, Hopt, getpid());<br>
-<br>
+ =A0 =A0 =A0 tst_require_root(NULL);<br>
 =A0 =A0 =A0 =A0tst_sig(FORK, DEF_HANDLER, cleanup);<br>
<br>
 =A0 =A0 =A0 =A0TEST_PAUSE;<br>
+<br>
+ =A0 =A0 =A0 tst_tmpdir();<br>
+ =A0 =A0 =A0 mount_point =3D get_tst_tmpdir();<br>
+<br>
+ =A0 =A0 =A0 mount_hugetlbfs(mount_point);<br>
+ =A0 =A0 =A0 hugepage_alloc(1024);<br>
+<br>
+ =A0 =A0 =A0 snprintf(TEMPFILE, sizeof(TEMPFILE), &quot;%s/mmapfile%d&quot=
;, mount_point, getpid());<br>
=A0}<br>
<br>
=A0/*<br>
@@ -223,7 +208,7 @@ setup()<br>
 =A0* =A0 =A0 =A0 =A0 =A0 =A0Remove the temporary directory created.<br>
 =A0*/<br>
=A0void<br>
-cleanup()<br>
+cleanup(void)<br>
=A0{<br>
 =A0 =A0 =A0 =A0/*<br>
 =A0 =A0 =A0 =A0 * print timing stats if that option was specified.<br>
@@ -231,6 +216,6 @@ cleanup()<br>
 =A0 =A0 =A0 =A0TEST_CLEANUP;<br>
<br>
 =A0 =A0 =A0 =A0unlink(TEMPFILE);<br>
-<br>
+ =A0 =A0 =A0 umount_hugetlbfs(mount_point);<br>
 =A0 =A0 =A0 =A0tst_rmdir();<br>
=A0}<br>
--<br>
1.7.1<br>
<br>
--<br>
Best Regards,<br>
Tang chen<br>
-------------- next part --------------<br>
An embedded and charset-unspecified text was scrubbed...<br>
Name: 0004-hugemmap02.c-Automatically-mount-hugetlbfs-on-huge.patch<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Tue, 16 Aug 2011 16:03:25 +0800<br>
From: tangchen &lt;<a href=3D"mailto:tangchen@cn.fujitsu.com">tangchen@cn.f=
ujitsu.com</a>&gt;<br>
Subject: [LTP] =A0[PATCH 5/6] hugemmap03.c<br>
To: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>=
&gt;, Garrett Cooper<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.co=
m</a>&gt;<br>
Cc: &quot;<a href=3D"mailto:ltp-list@lists.sourceforge.net">ltp-list@lists.=
sourceforge.net</a>&quot; &lt;<a href=3D"mailto:ltp-list@lists.sourceforge.=
net">ltp-list@lists.sourceforge.net</a>&gt;<br>
Message-ID: &lt;<a href=3D"mailto:4E4A244D.6050901@cn.fujitsu.com">4E4A244D=
.6050901@cn.fujitsu.com</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;iso-8859-1&quot;<br>
<br>
Signed-off-by: Tang Chen &lt;<a href=3D"mailto:tangchen@cn.fujitsu.com">tan=
gchen@cn.fujitsu.com</a>&gt;<br>
---<br>
=A0testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c | =A0 66 ++++++++----=
--------<br>
=A01 files changed, 26 insertions(+), 40 deletions(-)<br>
<br>
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases=
/kernel/mem/hugetlb/hugemmap/hugemmap03.c<br>
index cac94b0..b17b19d 100644<br>
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c<br>
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c<br>
@@ -54,54 +54,31 @@<br>
=A0#include &quot;test.h&quot;<br>
=A0#include &quot;usctest.h&quot;<br>
=A0#include &quot;system_specific_hugepages_info.h&quot;<br>
+#include &quot;libmnt.h&quot;<br>
<br>
=A0#define HIGH_ADDR =A0 =A0 =A0(void *)(0x1000000000000)<br>
<br>
-char* TEMPFILE=3D&quot;mmapfile&quot;;<br>
+char TEMPFILE[MAXPATHLEN];<br>
<br>
=A0char *TCID=3D&quot;hugemmap03&quot;; =A0 =A0 =A0 /* Test program identif=
ier. =A0 =A0*/<br>
=A0int TST_TOTAL=3D1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Total number of test c=
ases. */<br>
=A0unsigned long *addr; =A0 =A0 =A0 =A0 =A0 /* addr of memory mapped region=
 */<br>
=A0int fildes; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* file descriptor fo=
r tempfile */<br>
-char *Hopt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* location of hugetlb=
fs */<br>
+char *mount_point =3D NULL;<br>
<br>
-void setup(); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Main setup function of=
 test */<br>
-void cleanup(); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* cleanup =
function for the test */<br>
-<br>
-void help()<br>
-{<br>
- =A0 =A0 =A0 printf(&quot; =A0-H /.. =A0Location of hugetlbfs, i.e. -H /va=
r/hugetlbfs \n&quot;);<br>
-}<br>
+void setup(void); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Main setup=
 function of test */<br>
+void cleanup(void); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* cleanup func=
tion for the test */<br>
<br>
=A0int<br>
=A0main(int ac, char **av)<br>
=A0{<br>
 =A0 =A0 =A0 =A0int lc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* loop counter */<=
br>
- =A0 =A0 =A0 char *msg; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* message returned fro=
m parse_opts */<br>
- =A0 =A0 =A0 =A0int Hflag=3D0; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* binary flag: =
opt or not */<br>
 =A0 =A0 =A0 =A0int page_sz;<br>
<br>
=A0#if __WORDSIZE=3D=3D32 =A0/* 32-bit compiled */<br>
 =A0 =A0 =A0 =A0tst_brkm(TCONF, NULL, &quot;This test is only for 64bit&quo=
t;);<br>
=A0#endif<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 option_t options[] =3D {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;H:&quot;, =A0 &amp;Hflag, &amp;Hopt }=
, =A0 =A0/* Required for location of hugetlbfs */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 { NULL, NULL, NULL } =A0 =A0 =A0 =A0 =A0/* NU=
LL required to end array */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
-<br>
- =A0 =A0 =A0 /* Parse standard options given to run the test. */<br>
- =A0 =A0 =A0 msg =3D parse_opts(ac, av, options, &amp;help);<br>
- =A0 =A0 =A0 if (msg !=3D (char *) NULL) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL, &quot;OPTION PARSING ER=
ROR - %s, use -help&quot;, msg);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 if (Hflag =3D=3D 0) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL, &quot;-H option is REQU=
IRED for this test, use -h for options help&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();<br>
- =A0 =A0 =A0 }<br>
-<br>
 =A0 =A0 =A0 =A0page_sz =3D getpagesize();<br>
<br>
 =A0 =A0 =A0 =A0setup();<br>
@@ -122,8 +99,15 @@ main(int ac, char **av)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0addr =3D mmap(HIGH_ADDR, page_sz, PROT_READ=
,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MAP_SHARED | MAP_FI=
XED, fildes, 0);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (addr !=3D MAP_FAILED) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;Normal =
mmap() into high region unexpectedly succeeded on %s, errno=3D%d : %s&quot;=
,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEMPFILE, =
errno, strerror(errno));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL|TERRNO, &quot;=
Normal mmap() into high region unexpectedly &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;succeed=
ed on %s&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEMPFILE);<br=
>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Unmap the mapped memory */=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (munmap(addr, page_sz) !=
=3D 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TFAI=
L|TERRNO, NULL, &quot;munmap() fails to unmap the &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &quot;memory&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, &quot;Norma=
l mmap() into high region failed correctly&quot;);<br>
@@ -132,7 +116,6 @@ main(int ac, char **av)<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(fildes);<br>
 =A0 =A0 =A0 =A0}<br>
-<br>
 =A0 =A0 =A0 =A0cleanup();<br>
<br>
 =A0 =A0 =A0 =A0tst_exit();<br>
@@ -149,18 +132,20 @@ main(int ac, char **av)<br>
 =A0* =A0 =A0 =A0 =A0 =A0Write some known data into file and get the size o=
f the file.<br>
 =A0*/<br>
=A0void<br>
-setup()<br>
+setup(void)<br>
=A0{<br>
- =A0 =A0 =A0 char mypid[40];<br>
-<br>
- =A0 =A0 =A0 sprintf(mypid,&quot;/%d&quot;,getpid());<br>
- =A0 =A0 =A0 TEMPFILE=3Dstrcat(mypid,TEMPFILE);<br>
- =A0 =A0 =A0 TEMPFILE=3Dstrcat(Hopt,TEMPFILE);<br>
-<br>
+ =A0 =A0 =A0 tst_require_root(NULL);<br>
 =A0 =A0 =A0 =A0tst_sig(FORK, DEF_HANDLER, cleanup);<br>
<br>
 =A0 =A0 =A0 =A0TEST_PAUSE;<br>
<br>
+ =A0 =A0 =A0 tst_tmpdir();<br>
+ =A0 =A0 =A0 mount_point =3D get_tst_tmpdir();<br>
+<br>
+ =A0 =A0 =A0 mount_hugetlbfs(mount_point);<br>
+ =A0 =A0 =A0 hugepage_alloc(1024);<br>
+<br>
+ =A0 =A0 =A0 snprintf(TEMPFILE, sizeof(TEMPFILE), &quot;%s/mmapfile%d&quot=
;, mount_point, getpid());<br>
=A0}<br>
<br>
=A0/*<br>
@@ -169,7 +154,7 @@ setup()<br>
 =A0* =A0 =A0 =A0 =A0 =A0 =A0Remove the temporary directory created.<br>
 =A0*/<br>
=A0void<br>
-cleanup()<br>
+cleanup(void)<br>
=A0{<br>
 =A0 =A0 =A0 =A0/*<br>
 =A0 =A0 =A0 =A0 * print timing stats if that option was specified.<br>
@@ -177,5 +162,6 @@ cleanup()<br>
 =A0 =A0 =A0 =A0TEST_CLEANUP;<br>
<br>
 =A0 =A0 =A0 =A0unlink(TEMPFILE);<br>
-<br>
+ =A0 =A0 =A0 umount_hugetlbfs(mount_point);<br>
+ =A0 =A0 =A0 tst_rmdir();<br>
=A0}<br>
--<br>
1.7.1<br>
<br>
--<br>
Best Regards,<br>
Tang chen<br>
-------------- next part --------------<br>
An embedded and charset-unspecified text was scrubbed...<br>
Name: 0005-hugemmap03.c-Automatically-mount-hugetlbfs-on-huge.patch<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Tue, 16 Aug 2011 16:04:10 +0800<br>
From: tangchen &lt;<a href=3D"mailto:tangchen@cn.fujitsu.com">tangchen@cn.f=
ujitsu.com</a>&gt;<br>
Subject: [LTP] =A0[PATCH 6/6] hugemmap04.c<br>
To: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>=
&gt;, Garrett Cooper<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.co=
m</a>&gt;<br>
Cc: &quot;<a href=3D"mailto:ltp-list@lists.sourceforge.net">ltp-list@lists.=
sourceforge.net</a>&quot; &lt;<a href=3D"mailto:ltp-list@lists.sourceforge.=
net">ltp-list@lists.sourceforge.net</a>&gt;<br>
Message-ID: &lt;<a href=3D"mailto:4E4A247A.6070606@cn.fujitsu.com">4E4A247A=
.6070606@cn.fujitsu.com</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;iso-8859-1&quot;<br>
<br>
Signed-off-by: Tang Chen &lt;<a href=3D"mailto:tangchen@cn.fujitsu.com">tan=
gchen@cn.fujitsu.com</a>&gt;<br>
---<br>
=A0testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c | =A0 52 ++++++------=
--------<br>
=A01 files changed, 16 insertions(+), 36 deletions(-)<br>
<br>
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases=
/kernel/mem/hugetlb/hugemmap/hugemmap04.c<br>
index 4cc6ed4..9774e87 100644<br>
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c<br>
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c<br>
@@ -73,10 +73,11 @@<br>
=A0#include &quot;test.h&quot;<br>
=A0#include &quot;usctest.h&quot;<br>
=A0#include &quot;system_specific_hugepages_info.h&quot;<br>
+#include &quot;libmnt.h&quot;<br>
<br>
=A0#define BUFFER_SIZE =A0256<br>
<br>
-char* TEMPFILE=3D&quot;mmapfile&quot;;<br>
+char TEMPFILE[MAXPATHLEN];<br>
<br>
=A0char *TCID=3D&quot;hugemmap04&quot;; =A0 =A0 =A0 /* Test program identif=
ier. =A0 =A0*/<br>
=A0int TST_TOTAL=3D1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Total number of test c=
ases. */<br>
@@ -87,41 +88,17 @@ int freepages=3D0; =A0 =A0 =A0 =A0 =A0 =A0/* Amount of =
free huge pages to use for testing */<br>
=A0int beforetest=3D0; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Amount of free huge pa=
ges before testing */<br>
=A0int aftertest=3D0; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Amount of free huge pa=
ges after testing */<br>
=A0int hugepagesmapped=3D0; =A0 =A0 =A0 =A0 /* Amount of huge pages mapped =
after testing */<br>
-char *Hopt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* location of hugetlb=
fs */<br>
+char *mount_point =3D NULL;<br>
<br>
-void setup(); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Main setup function of=
 test */<br>
-void cleanup(); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* cleanup =
function for the test */<br>
-<br>
-void help()<br>
-{<br>
- =A0 =A0 =A0 printf(&quot; =A0-H /.. =A0Location of hugetlbfs, i.e. -H /va=
r/hugetlbfs \n&quot;);<br>
-}<br>
+void setup(void); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Main setup=
 function of test */<br>
+void cleanup(void); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* cleanup func=
tion for the test */<br>
<br>
=A0int<br>
=A0main(int ac, char **av)<br>
=A0{<br>
 =A0 =A0 =A0 =A0int lc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* loop counter */<=
br>
- =A0 =A0 =A0 char *msg; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* message returned fro=
m parse_opts */<br>
- =A0 =A0 =A0 =A0int Hflag=3D0; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* binary flag: =
opt or not */<br>
 =A0 =A0 =A0 =A0int huge_pagesize=3D0;<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 option_t options[] =3D {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;H:&quot;, =A0 &amp;Hflag, &amp;Hopt }=
, =A0 =A0/* Required for location of hugetlbfs */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 { NULL, NULL, NULL } =A0 =A0 =A0 =A0 =A0/* NU=
LL required to end array */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
-<br>
- =A0 =A0 =A0 /* Parse standard options given to run the test. */<br>
- =A0 =A0 =A0 msg =3D parse_opts(ac, av, options, &amp;help);<br>
- =A0 =A0 =A0 if (msg !=3D (char *) NULL) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL, &quot;OPTION PARSING ER=
ROR - %s, use -help&quot;, msg);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 if (Hflag =3D=3D 0) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL, &quot;-H option is REQU=
IRED for this test, use -h for options help&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();<br>
- =A0 =A0 =A0 }<br>
-<br>
 =A0 =A0 =A0 =A0/* Check number of hugepages */<br>
 =A0 =A0 =A0 =A0if (get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt=
;=3D 0)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(TCONF, cleanup, &quot;Not enough a=
vailable Hugepages&quot;);<br>
@@ -151,7 +128,7 @@ main(int ac, char **av)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO,&quot;Total amount of free h=
uge pages is %d&quot;,freepages);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO,&quot;Max number allowed for=
 1 mmap file in 32-bits is 128&quot;);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (freepages &gt; 128)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freepages=3D128;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freepages=3D128;<br>
=A0#endif<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Call mmap<br>
@@ -206,16 +183,18 @@ main(int ac, char **av)<br>
=A0void<br>
=A0setup()<br>
=A0{<br>
- =A0 =A0 =A0 char mypid[40];<br>
-<br>
- =A0 =A0 =A0 sprintf(mypid,&quot;/%d&quot;,getpid());<br>
- =A0 =A0 =A0 TEMPFILE=3Dstrcat(mypid,TEMPFILE);<br>
- =A0 =A0 =A0 TEMPFILE=3Dstrcat(Hopt,TEMPFILE);<br>
-<br>
+ =A0 =A0 =A0 tst_require_root(NULL);<br>
 =A0 =A0 =A0 =A0tst_sig(FORK, DEF_HANDLER, cleanup);<br>
<br>
 =A0 =A0 =A0 =A0TEST_PAUSE;<br>
<br>
+ =A0 =A0 =A0 tst_tmpdir();<br>
+ =A0 =A0 =A0 mount_point =3D get_tst_tmpdir();<br>
+<br>
+ =A0 =A0 =A0 mount_hugetlbfs(mount_point);<br>
+ =A0 =A0 =A0 hugepage_alloc(1024);<br>
+<br>
+ =A0 =A0 =A0 snprintf(TEMPFILE, sizeof(TEMPFILE), &quot;%s/mmapfile%d&quot=
;, mount_point, getpid());<br>
=A0}<br>
<br>
=A0/*<br>
@@ -232,5 +211,6 @@ cleanup()<br>
 =A0 =A0 =A0 =A0TEST_CLEANUP;<br>
<br>
 =A0 =A0 =A0 =A0unlink(TEMPFILE);<br>
-<br>
+ =A0 =A0 =A0 umount_hugetlbfs(mount_point);<br>
+ =A0 =A0 =A0 tst_rmdir();<br>
=A0}<br>
--<br>
1.7.1<br>
<br>
--<br>
Best Regards,<br>
Tang chen<br>
-------------- next part --------------<br>
An embedded and charset-unspecified text was scrubbed...<br>
Name: 0006-hugemmap04.c-Automatically-mount-hugetlbfs-on-huge.patch<br>
<br>
------------------------------<br>
<br>
---------------------------------------------------------------------------=
---<br>
uberSVN&#39;s rich system and user administration capabilities and model<br=
>
configuration take the hassle out of deploying and managing Subversion and<=
br>
the tools developers use with it. Learn more about uberSVN and get a free<b=
r>
download at: =A0<a href=3D"http://p.sf.net/sfu/wandisco-dev2dev" target=3D"=
_blank">http://p.sf.net/sfu/wandisco-dev2dev</a><br>
<br>
<br>
------------------------------<br>
<br>
_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br>
<br>
End of Ltp-list Digest, Vol 63, Issue 22<br>
****************************************<br>
</blockquote></div><br>

--001636c5bf2334459b04aad4e14a--


--===============8832048434305054136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
--===============8832048434305054136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8832048434305054136==--

