Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P5sZV-0005Qw-RL
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 04:04:09 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5sZT-0007le-Ji
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 04:04:09 +0000
Received: by iwn2 with SMTP id 2so2596438iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Oct 2010 21:04:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <92362031.267291286935348328.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <50821116.267171286935261958.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<92362031.267291286935348328.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 12 Oct 2010 21:04:02 -0700
Message-ID: <AANLkTincW00Z7y+9j9PeYFN9nPs2VqrFHGLHGaEa29zd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2] mmap/munmap /dev/zero
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
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

You've filled in some of the blanks, but there are some that are still
missing...

On Tue, Oct 12, 2010 at 7:02 PM,  <caiqian@redhat.com> wrote:
> v2: incorporate comments from Mike and Garrett.
>
> Add a new test to mmap/munmap /dev/zero. A common way of malloc()/free() =
anonymous memory on Solaris.

The first sentence should standalone as the summary, like:

Add a new test to mmap/munmap /dev/zero [fill in reason why it's being
tested -- try to summarize in less than 80 columns].

Right now it's a dangling modifier.

The second sentence is a fragment; you are describing the process, but
not describing the important actors or involved parties in the process
(in particular on the Linux side).

There's also little context between the two sentences, so it's
confusing to the end reader.

> Anyway,

You can remove Anyway,

> mmap()

memory mapping

> of

unnecessary particle.

> /dev/zero results in calling map_zero() which on RHEL5 maps the ZERO_PAGE=
 in every pte within that virtual address range.

PTE is an acronym (please capitalize).

> Since a application is also multi-threaded the subsequent munmap() of /de=
v/zero results is TLB shootdowns to all other CPUs.

Why isn't the test multithreaded then? How do you measure the poor
performance resulting from all of the anonymous page TLB shootdowns?

> When this happens thousands or millions of times the application performa=
nce is terrible.

Well, TLB shootdown hurts no matter how many times it occurs, so I
wouldn't doubt that thousands or millions or times would hurt more.

> The mapping ZERO_PAGE in every pte within that virtual address range was =
an optimization to make the subsequent pagefault

Ok. I think I have an idea of what you're trying to achieve based on
this statement, but I'm not quite sure. Are you saying that anonymous
mapped pages without data should have an equivalent address to a
shared zeroed out page? If so how do you know what the master zeroed
out page is? Why aren't any memory address comparisons being performed
below? Where's the performance trend data to prove that the feature
delivers as per its claimed performance benefits?

> times faster on RHEL5 that.

How much faster?

> has been removed/changed upstream.

Reference?

> Signed-off-by: CAI Qian <caiqian@redhat.com>

...

> +#include "test.h"
> +#include "usctest.h"
> +#include <errno.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <stdio.h>

It's not linux style (BSD style(9) to be exact), but could you at
least sort the headers by:

sys/ system headers -> non-sys/ system headers -> `user defined' headers

in alphabetical order...? it's much easier to read.

> +#define SIZE (5*1024*1024)

Why 5MB?

> +char *TCID =3D "mmap10";
> +int TST_TOTAL =3D 1;
> +extern int Tst_count;
> +
> +/* main setup function of test */
> +void setup(void);
> +/* cleanup function for the test */
> +void cleanup(void);
> +int mmapzero(void);
> +
> +int main(int argc, char *argv[])
> +{
> + =A0 =A0 =A0 /* loop counter */
> + =A0 =A0 =A0 int lc;
> + =A0 =A0 =A0 /* message returned from parse_opts */
> + =A0 =A0 =A0 char *msg;
> +
> + =A0 =A0 =A0 msg =3D parse_opts(argc, argv, (option_t *) NULL, NULL);
> + =A0 =A0 =A0 if (msg !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL, "OPTION PARSING ERROR=
 - %s", msg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Perform global setup for test */
> + =A0 =A0 =A0 setup();
> +
> + =A0 =A0 =A0 /* Check looping state if -i option given */
> + =A0 =A0 =A0 for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Reset Tst_count in case we are looping. =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tst_count =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(mmapzero());
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_RETURN !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "mmapzero()=
 failed with %ld.",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST_RETURN=
);

TEST_RETURN is an integer, not a long integer, correct (hence the %ld
could be a %d)?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TPASS, "mmapzero()=
 completed successfully.");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 cleanup();
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int mmapzero(void)
> +{
> + =A0 =A0 =A0 char *x;
> + =A0 =A0 =A0 int n;
> +
> + =A0 =A0 =A0 x =3D mmap("/dev/zero", SIZE+SIZE-4096, PROT_READ|PROT_WRIT=
E,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> + =A0 =A0 =A0 if (x =3D=3D MAP_FAILED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "mmap: %s", strerror(errno)=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 x[SIZE] =3D 0;
> + =A0 =A0 =A0 n =3D fork();
> + =A0 =A0 =A0 if (n =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "fork: %s", strerr=
or(errno));

tst_brkm(TBROK|TERRNO, cleanup, "fork failed");

etc, would be better than using tst_brkm with strerror.

> + =A0 =A0 =A0 else if (n =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (munmap(x + SIZE+4096, SIZE-4096*2) =3D=
=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "munmap: %s=
", strerror(errno));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _exit(0);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 n =3D fork();
> + =A0 =A0 =A0 if (n =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "fork: %s", strerr=
or(errno));
> + =A0 =A0 =A0 else if (n =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (munmap(x + SIZE+4096, SIZE-4096*2) =3D=
=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "munmap: %s=
", strerror(errno));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _exit(0);

    What are you trying to achieve by munmap'ing the same section of
memory in a forked process [twice] and the parent process in the end?
They're 3 anonymous COW backed pages because you specified MAP_PRIVATE
| MAP_ANONYMOUS ...

> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n =3D fork();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (n =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "f=
ork: %s", strerror(errno));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (n =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (munmap(x + SIZE+4096, S=
IZE-4096*2) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TF=
AIL, "munmap: %s", strerror(errno));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _exit(0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (munmap(x, SIZE+SIZE-4096) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "munmap: %s", strerror(errn=
o));
> + =A0 =A0 =A0 while (waitpid(-1, NULL, WNOHANG) > 0);
> + =A0 =A0 =A0 return 0;

    This test isn't written according to the description. Please
better address what you're trying to achieve so that we might be able
to help you reach a conclusion.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
