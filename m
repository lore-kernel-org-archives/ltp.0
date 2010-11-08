Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFLbc-0002JI-9Q
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 06:53:28 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFLbZ-0004sI-TX
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 06:53:28 +0000
Received: by wwb31 with SMTP id 31so5181729wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Sun, 07 Nov 2010 22:53:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <47150598.1390531288856558142.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <47150598.1390531288856558142.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Sun, 7 Nov 2010 22:53:19 -0800
Message-ID: <AANLkTimppURk7sj=OMSuDz2rqzk1BpSjNy8hkghYZo6_@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v3] overcommit libhugetlbfs and check the
	statistics
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Thu, Nov 4, 2010 at 12:42 AM, CAI Qian <caiqian@redhat.com> wrote:
> libhugetlbfs allows to overcommit hugepages and there are tunables in
> sysfs and procfs. The test here want to ensure it is possible to
> overcommit by either mmap or shared memory. Also ensure those
> reservation can be read/write, and several statistics work correctly.
>
> First, it resets nr_hugepages and nr_overcommit_hugepages. Then, set
> both to a specify value - N, and allocate N + %50 x N hugepages.
> Finally, it reads and writes every page. There are command options to
> choose either to manage hugepages from sysfs or procfs, and reserve them
> by mmap or shmget.
>
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> v3: fix -a option description; fix a nasty bug with tst_exit which skips
> =A0 =A0cleanup at the end of the test; add more information to assist test
> =A0 =A0debug.

No... you just didn't understand the API :)... if the cleanup function
is NULL, tst_exit is automatically used; otherwise, the function is
called, and cleanup is assumed to be called.

> v2: add more explanation and a command-line option to specify memory
> =A0 =A0allocation size.
>
> =A0testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | =A0487 ++++++++++=
++++++++++
> =A01 files changed, 487 insertions(+), 0 deletions(-)
> =A0create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
>
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcas=
es/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> new file mode 100644
> index 0000000..770f664
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> @@ -0,0 +1,487 @@
> +/*
> + * overcommit libhugetlbfs and check the statistics.
> + *
> + * libhugetlbfs allows to overcommit hugepages and there are tunables in
> + * sysfs and procfs. The test here want to ensure it is possible to
> + * overcommit by either mmap or shared memory. Also ensure those
> + * reservation can be read/write, and several statistics work correctly.

Is there a document that describes this behavior?

> + * First, it resets nr_hugepages and nr_overcommit_hugepages. Then, set
> + * both to a specify value - N, and allocate N + %50 x N hugepages.
> + * Finally, it reads and writes every page. There are command options to
> + * choose either to manage hugepages from sysfs or procfs, and reserve
> + * them by mmap or shmget.

What happens when you overcommit and meet this maximum though?

...

> +#define PROTECTION =A0 =A0 =A0 =A0 =A0 =A0 (PROT_READ | PROT_WRITE)
> +#define _PATH_MEMINFO =A0 =A0 =A0 =A0 =A0"/proc/meminfo"
> +#define _PATH_SYS_HUGE =A0 =A0 =A0 =A0 "/sys/kernel/mm/hugepages"
> +#define _PATH_SYS_2M =A0 =A0 =A0 =A0 =A0 _PATH_SYS_HUGE "/hugepages-2048=
kB/"
> +#define _PATH_SYS_2M_OVER =A0 =A0 =A0_PATH_SYS_2M "nr_overcommit_hugepag=
es"
> +#define _PATH_SYS_2M_FREE =A0 =A0 =A0_PATH_SYS_2M "free_hugepages"
> +#define _PATH_SYS_2M_RESV =A0 =A0 =A0_PATH_SYS_2M "resv_hugepages"
> +#define _PATH_SYS_2M_SURP =A0 =A0 =A0_PATH_SYS_2M "surplus_hugepages"
> +#define _PATH_SYS_2M_HUGE =A0 =A0 =A0_PATH_SYS_2M "nr_hugepages"
> +#define _PATH_PROC_VM =A0 =A0 =A0 =A0 =A0"/proc/sys/vm/"
> +#define _PATH_PROC_OVER =A0 =A0 =A0 =A0_PATH_PROC_VM "nr_overcommit_huge=
pages"
> +#define _PATH_PROC_HUGE =A0 =A0 =A0 =A0_PATH_PROC_VM "nr_hugepages"
> +#define _PATH_SHMMAX =A0 =A0 =A0 =A0 =A0 "/proc/sys/kernel/shmmax"
> +#define NEED_RESTORE =A0 =A0 =A0 =A0 =A0 2

Just make this a boolean type, i.e.:

int restore_shmmax;

...

/* cleanup */
    if (need_shmmax) {
    /* ... */
    }

    /* ... */
    need_shmmax =3D 1;

> +
> +/* Only ia64 requires this */

Why only ia64?

> +#ifdef __ia64__
> +#define ADDR (void *)(0x8000000000000000UL)
> +#define FLAGS (MAP_SHARED | MAP_FIXED)
> +#define SHMAT_FLAGS (SHM_RND)
> +#else
> +#define ADDR (void *)(0x0UL)
> +#define FLAGS (MAP_SHARED)
> +#define SHMAT_FLAGS (0)
> +#endif
> +
> +#ifndef SHM_HUGETLB
> +#define SHM_HUGETLB 04000
> +#endif
> +
> +char *TCID =3D "hugemmap05";
> +int TST_TOTAL =3D 1;
> +extern int Tst_count;
> +extern char *TESTDIR;
> +static char nr_hugepages[BUFSIZ], nr_overcommit_hugepages[BUFSIZ];
> +static char shmmax[BUFSIZ], *opt_allocstr;
> +static char buf[BUFSIZ], line[BUFSIZ], path[BUFSIZ], pathover[BUFSIZ];
> +static int opt_sysfs, opt_shmget, opt_alloc, size =3D 128, length =3D 38=
4;

length and size should be size_t. Also, instead of having opt_shmget
as a separate variable, why not just test for shmid > 0 (below in the
relevant code block, etc)?

...

> +static void checksys(char *path, char *pattern, int value);

The value of pattern is going to generate more harm than good because
they're currently /proc analogs. Please better humanize the value (or
point to relevant documentation in the source stating what the tunable
/sys nodes do.

...

> + =A0 =A0 =A0 if (opt_alloc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D atoi(opt_allocstr);

What happens if size <=3D 0? atoi is probably not what you want to use anyh=
ow...

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D (int)(size + size * 0.5) * 2;
> + =A0 =A0 =A0 }

...

> +               if(TEST_RETURN !=3D 0)
> +                       tst_resm(TFAIL, "overcommit() failed with %ld.",
> +                               TEST_RETURN);

No reason in outputting the return value (it's not like you don't have
any control over what it is).

...

> + =A0 =A0 =A0 cleanup();
              /* NOTREACHED */ // -- just to be pedantic.
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int overcommit(void)
> +{
> + =A0 =A0 =A0 void *addr =3D NULL;
> + =A0 =A0 =A0 int fd =3D -1, shmid =3D -1;
> + =A0 =A0 =A0 char s[BUFSIZ];
> + =A0 =A0 =A0 FILE *fp;
> + =A0 =A0 =A0 =A0unsigned long i;
> + =A0 =A0 =A0 =A0char *shmaddr =3D NULL;
> +
> + =A0 =A0 =A0 if (opt_shmget) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((shmid =3D shmget(2, (long)(length * 10=
24 * 1024),

So you're going to stomp all over someone else's shm key potentially?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SHM_HUGETLB | IPC_CREAT | SHM_R =
| SHM_W)) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, clea=
nup, "shmget");
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(s, strlen(TESTDIR) + 17, "%s/hugem=
map05/file",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TESTDIR);

YAY! A magic number (-_-)!

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fd =3D open(s, O_CREAT | O_RDWR, 0755);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fd < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL|TERRNO, "ope=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D mmap(ADDR, (long)(length * 1024 * =
1024),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PROTECTION, FLAGS, fd, 0);

Why do you have to specify an ADDR? Why not let the OS do this for you?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (addr =3D=3D MAP_FAILED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, clea=
nup, "mmap");

...

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO|TERRNO, "shm=
at");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 shmctl(shmid, IPC_RMID, NUL=
L);

Why not just add this to cleanup, and merge the tst_resm and tst_brkm calls?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "shared mem=
ory attach failure");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "shmaddr: %p", shmaddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "starting the writes...");

This could be one line.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < (long)(length * 1024 * 10=
24); i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 shmaddr[i] =3D (char)(i);

NO. NO. NO. NO. NO. void* !=3D char !!!

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "starting the check...");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < (long)(length * 1024 * 10=
24); i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (shmaddr[i] !=3D (char)i)

NO. NO. NO. NO. NO. void* !=3D char !!!

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TI=
NFO, "index %lu mismatched",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 i);

...

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 shmctl(shmid, IPC_RMID, NULL);

Writing the same instruction twice screams "put me in cleanup!".

...

> +}
> +
> +static void check_bytes(char *addr)

Huh? What purpose does this really serve in the overall scheme of
things, point being, having a function call to alias tst_resm(TINFO,
...) in only two spots in the code seems kind of silly, as the
function declaration and body is longer than the 2 times tst_resm is
invoked...).

> +{
> + =A0 =A0 =A0 tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
> +}
> +
> +static void write_bytes(char *addr)
> +{
> + =A0 =A0 =A0 unsigned long i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < (long)(length * 1024 * 1024); i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(addr + i) =3D (char)i;

NO. NO. NO. NO. NO. void* !=3D char !!! Pointer arithmetic can be bad as we=
ll...

> +}
> +
> +static void read_bytes(char *addr)
> +{
> + =A0 =A0 =A0 unsigned long i;

Oops... overflow?

> +
> + =A0 =A0 =A0 check_bytes(addr);
> + =A0 =A0 =A0 for (i =3D 0; i < (long)(length * 1024 * 1024); i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*(addr + i) !=3D (char)i) {

Please see above.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "mismatch a=
t %lu\n", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +}
> +
> +/* Lookup a pattern and get the value from file*/
> +int lookup (char *line, char *pattern)
> +{
> + =A0 =A0 =A0 char buf2[BUFSIZ];
> +
> + =A0 =A0 =A0 /* empty line */
> + =A0 =A0 =A0 if (line[0] =3D=3D '\0')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 snprintf(buf2, BUFSIZ, "%s: %%s", pattern);
> + =A0 =A0 =A0 if (sscanf(line, buf2, buf) !=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;

That ain't gonna work so well with variable whitespace.

> + =A0 =A0 =A0 return 1;
> +}
> +
> +void help(void)

usage is more standard than help.

...

> +void checkproc(FILE *fp, char *pattern, int value)
> +{
> + =A0 =A0 =A0 memset(buf, -1, BUFSIZ);
> + =A0 =A0 =A0 rewind(fp);
> + =A0 =A0 =A0 while (fgets(line, BUFSIZ, fp) !=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lookup(line, pattern))

If you're just looking for a string, why not strstr the line?

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
