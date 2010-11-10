Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PG1nb-0007ZB-NB
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 03:56:39 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PG1nZ-0007Ny-Eb
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 03:56:39 +0000
Received: by wyb34 with SMTP id 34so217173wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Nov 2010 19:56:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1206967940.2804651289359947848.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <1824167242.2804331289359263862.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1206967940.2804651289359947848.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Tue, 9 Nov 2010 19:56:30 -0800
Message-ID: <AANLkTikvbUkjbvVSHQKcn+4AcxGFYBAx436GpRLoadS+@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix sysconf failure in RHEL4
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Tue, Nov 9, 2010 at 7:32 PM, Caspar Zhang <czhang@redhat.com> wrote:
> Hi all,
>
> I met a strange error (only) in RHEL4, syscalls/sysconf
> failed the last test case because of the variable `actual'
> was not evaluated by `errno':
>
> sysconf01 =A0 56 =A0TFAIL =A0: =A0sysconf correctly failed, but expected =
errno (22) !=3D actual (0)
>
> I remov the var `actual' and use `errno' directly, seems it
> works. Re-test under RHEL4/5/6 and all of them pass the test.
>
> I have no idea why errno value couldn't be assigned to
> `actual', either not sure whether my patch works on other
> non-Red Hat distos. Please have a look at this patch if
> you want, thanks.
>
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
>
> ---
> =A0testcases/kernel/syscalls/sysconf/sysconf01.c | =A0 =A09 ++++-----
> =A01 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/sysconf/sysconf01.c b/testcases/ke=
rnel/syscalls/sysconf/sysconf01.c
> index 783c6f5..42246f0 100644
> --- a/testcases/kernel/syscalls/sysconf/sysconf01.c
> +++ b/testcases/kernel/syscalls/sysconf/sysconf01.c
> @@ -153,19 +153,18 @@ int main()
>
> =A0 =A0 =A0 =A0/* 56 */
> =A0 =A0 =A0 =A0{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int retval, actual;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int retval;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0errno =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D sysconf(INVAL_FLAG);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 actual =3D errno;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (retval !=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "sysconf =
succeeded for invalid flag (%i), "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " retval=
=3D%d errno=3D%d: %s",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0INVAL_FL=
AG, retval, actual, strerror(actual));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (actual !=3D EINVAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0INVAL_FL=
AG, retval, errno, strerror(errno));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (errno !=3D EINVAL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "sysconf =
correctly failed, but expected "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"errno (=
%i) !=3D actual (%i)", EINVAL, actual);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"errno (=
%i) !=3D actual (%i)", EINVAL, errno);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "The inval=
id sysconf key was trapped "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0"appropriately");

Hmmm... well, for starters the definitions aren't the same:

           extern int * __error();
           #define errno (* __error())

I wonder if that has to do something with it... try out the following progr=
am:

#define _GNU_SOURCE 1
#include <errno.h>
#include <stdio.h>

int
main(void)
{
    open(NULL, 0);
    int actual =3D errno;
    printf("%i %d %i %d\n", actual, actual, errno, errno);
    return (0);
}

It spit out this on FreeBSD at least:

$ gcc -Wall -o test_errno_assignment test_errno_assignment.c
$ ./test_errno_assignment
14 14 14 14

HTH,
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
