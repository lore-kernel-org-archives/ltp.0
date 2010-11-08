Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFZa6-0000SS-5W
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 21:48:50 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFZa5-00043w-2n
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 21:48:50 +0000
Received: by wwb29 with SMTP id 29so518079wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Nov 2010 13:48:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509752323.1389371288852590538.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1509752323.1389371288852590538.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Mon, 8 Nov 2010 13:48:43 -0800
Message-ID: <AANLkTikF7H=urGWh8pJDYse1cpgeK0m+8UoNfO5B2qL4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v3] functional testing for Kernel Samepage Merging
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

On Wed, Nov 3, 2010 at 11:36 PM, CAI Qian <caiqian@redhat.com> wrote:
> Basic tests were to start several programs with same and different
> memory contents and ensure only to merge the ones with the same
> contents. When changed the content of one of merged pages in a
> process and to the mode "unmerging", it should discard all merged
> pages there. Also tested it is possible to disable KSM. There are
> also command-line options to specify the memory allocation size, and
> number of processes have same memory contents so it is possible to
> test more advanced things like KSM + OOM etc. KSM statistics numbers
> look like hard to predict, so only check the ranges.

Can you provide documentation that describes the functionality under test?

> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> v3: fixed expected values based on the feedback from KSM developers;
> =A0 =A0fixed madvise return code; replaced malloc with mmap calls to bett=
er
> =A0 =A0align page boundaries; added additional memory content verification
> =A0 =A0after each run.
>
> v2: fixed stupid mistakes about memory content assignment.
>
> =A0testcases/kernel/mem/ksm/Makefile | =A0 22 ++
> =A0testcases/kernel/mem/ksm/ksm01.c =A0| =A0634 +++++++++++++++++++++++++=
++++++++++++
> =A02 files changed, 656 insertions(+), 0 deletions(-)
> =A0create mode 100644 testcases/kernel/mem/ksm/Makefile
> =A0create mode 100644 testcases/kernel/mem/ksm/ksm01.c
>
> diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm=
/Makefile
> new file mode 100644
> index 0000000..d3eb6ef
> --- /dev/null
> +++ b/testcases/kernel/mem/ksm/Makefile
> @@ -0,0 +1,22 @@
> +#
> +# =A0Copyright (c) International Business Machines =A0Corp., 2001

Please fix the copyright date and owner.

...

> + * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
> + * =A0 =A0distrub the testing as they also change some ksm tunables depe=
nds

*disturb

> + * =A0 =A0on current workloads.

How does one do this manually? Documentation?

> + * The test steps are:
> + * - Check ksm feature and backup current run setting.
> + * - Change run setting to 1 - merging.
> + * - 3 memory allocation programs have the memory contents that 2 of
> + * =A0 them are all 'a' and one is all 'b'.
> + * - Check ksm statistics and verify the content.
> + * - 1 program changes the memory content from all 'a' to all 'b'.
> + * - Check ksm statistics and verify the content.
> + * - All programs change the memory content to all 'd'.
> + * - Check ksm statistics and verify the content.
> + * - Change one page of a process.
> + * - Check ksm statistics and verify the content.
> + * - Change run setting to 2 - unmerging.
> + * - Check ksm statistics and verify the content.
> + * - Change run setting to 0 - stop.

...

> + =A0 =A0 =A0 /* Check looping state if -i option given */
> + =A0 =A0 =A0 for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Reset Tst_count in case we are looping. =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tst_count =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(ksmtest());

There's no sense in running this through the TEST macro if you aren't
going to use TEST_RETURN or TEST_ERRNO.

> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 cleanup();
> + =A0 =A0 =A0 return 0;

...

> + =A0 =A0 =A0 memory =3D malloc(num * sizeof(**memory));

Why are you referencing memory twice and then allocating heap memory
to the pointer to memory? Seems really leaky.

> + =A0 =A0 =A0 if (memory =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "malloc");
> +
> + =A0 =A0 =A0 if ((child[0] =3D fork()) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, cleanup, "fork");
> + =A0 =A0 =A0 else if (child[0] =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "child 0 stops.");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (raise(SIGSTOP) =3D=3D -1)

a.

switch ((child[0] =3D fork()) {
case -1:
    /* BUSTED */
    break;
case 0:
    /* CHILD */
    break;
default:
    /* PARENT */
    break;
}

    Is generally a bit easier to follow.
b. Why not use kill(2)?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, clea=
nup, "kill");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "child 0 continues...");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Avoid THP allocation which can't ksm ATM=
. */

What does THP mean and why not just spell out ATM as "at the moment"?
Less acronyms -> less confusion :).

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "child 0 allocates %d MB fi=
lled with 'c'.",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memory[0] =3D malloc(size * sizeof(*memory)=
);

More leaky memory?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memory[0] =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, clea=
nup, "malloc");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < size; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memory[0][j] =3D mmap(NULL,=
 MB,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 PROT_READ|PROT_WRITE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memory[0][j] =3D=3D NUL=
L)

I think you meant MAP_FAILED, not NULL.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TB=
ROK|TERRNO, cleanup, "mmap");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (madvise(memory[0][j], M=
B, MADV_MERGEABLE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TB=
ROK|TERRNO, cleanup,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "madvise");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < MB; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memory[0][j=
][i] =3D 'c';

You could just use memset.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "child 0 stops.");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (raise(SIGSTOP) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, clea=
nup, "kill");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "child 0 continues...");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 verify('c', 0, 0, size, 0, MB);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "child 0 changes memory con=
tent to 'd'.");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < size; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < MB; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memory[0][j=
][i] =3D 'd';

memset here too.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Unmerge. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "child 0 stops.");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (raise(SIGSTOP) =3D=3D -1)

kill? here too.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, clea=
nup, "kill");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "child 0 continues...");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 verify('d', 0, 0, size, 0, MB);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Stop. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "child 0 stops.");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (raise(SIGSTOP) =3D=3D -1)

kill? here too.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, clea=
nup, "kill");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "child 0 continues...");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(0);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((child[1] =3D fork()) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, cleanup, "fork");
> + =A0 =A0 =A0 else if (child[1] =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "child 1 stops.");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (raise(SIGSTOP) =3D=3D -1)

Same comments as above about kill and fork-switch.

...

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (waitpid(child[k], &status, WUNTRACED) =
=3D=3D -1)

Do WUNTRACED | WNOHANG and sleep each iteration in the loop to avoid
chewing up the CPU?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, clea=
nup, "waitpid");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!WIFSTOPPED(status))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "child %d w=
as not stopped.", k);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tst_resm(TINFO, "resume all children.");
> + =A0 =A0 =A0 for (k =3D 0; k < num; k++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (kill(child[k], SIGCONT) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, clea=
nup,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "kill child=
[%d]", k);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 sleep(5);
> + =A0 =A0 =A0 tst_resm(TINFO, "check!");
> + =A0 =A0 =A0 check("run", NULL, 1);
> + =A0 =A0 =A0 check("pages_shared", NULL, 2);
> + =A0 =A0 =A0 check("pages_sharing", "pages_volatile", size * num * 256 -=
 2);
> + =A0 =A0 =A0 check("pages_unshared", NULL, 0);
> + =A0 =A0 =A0 check("sleep_millisecs", NULL, 0);
> + =A0 =A0 =A0 check("pages_to_scan", NULL, size * 256 * num);

A lot of this logic is unnecessarily duplicated below; please move it
out into a function.

...

> + =A0 =A0 =A0 TEST_CLEANUP;
> + =A0 =A0 =A0 tst_rmdir();

Do you really need a temporary test directory? If not, I'd just drop
cleanup and set all references to it in tst_brkm to NULL.

> + =A0 =A0 =A0 tst_exit();
> +}

...

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL, "stat=
");

TBROK | TERRNO please.

...

> + =A0 =A0 =A0 tst_resm(TINFO, "child %d verifies memory content.", proc);
> + =A0 =A0 =A0 for (j =3D start; j < end; j++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D start2; i < end2; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memory[proc][j][i] !=3D=
 value)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TF=
AIL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "child %d has %c at %d,%d,%d.",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 proc, memory[proc][j][i], proc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 j, i);

memcmp'ing a fixed buffer should be considerably faster verifying
values byte by byte.

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
