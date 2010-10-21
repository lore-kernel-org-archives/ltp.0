Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P8rU6-0005LJ-Kh
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 09:30:54 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8rU5-0005QK-L5
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 09:30:54 +0000
Received: by wyb40 with SMTP id 40so4798973wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Oct 2010 02:30:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <122866027.1125401287647034456.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <761398766.1125341287646854846.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<122866027.1125401287647034456.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Thu, 21 Oct 2010 02:30:47 -0700
Message-ID: <AANLkTimCsPK0qPNnWwbi3uUDuBSebD=XTVGWa12J_ZHo@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix sched_getaffinity01 failure
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

On Thu, Oct 21, 2010 at 12:43 AM, Caspar Zhang <czhang@redhat.com> wrote:
> Hi all, when I'm using LTP, sometimes the
> test syscalls/sched_getaffinity01 fails by
> giving the following output:
>
> sched_getaffinity01 =A0 =A00 =A0TINFO =A0: =A0system has 4 processor(s).
> sched_getaffinity01 =A0 =A00 =A0TINFO =A0: =A0cpusetsize is 128
> sched_getaffinity01 =A0 =A00 =A0TINFO =A0: =A0mask.__bits[0] =3D 15
> sched_getaffinity01 =A0 =A01 =A0TPASS =A0: =A0sched_getaffinity() succeed=
 ,this process 29494 is running processor: 0
> sched_getaffinity01 =A0 =A02 =A0TPASS =A0: =A0sched_getaffinity() succeed=
 ,this process 29494 is running processor: 1
> sched_getaffinity01 =A0 =A03 =A0TPASS =A0: =A0sched_getaffinity() succeed=
 ,this process 29494 is running processor: 2
> sched_getaffinity01 =A0 =A04 =A0TPASS =A0: =A0sched_getaffinity() succeed=
 ,this process 29494 is running processor: 3
> sched_getaffinity01 =A0 =A05 =A0TPASS =A0: =A0sched_getaffinity(0, len, (=
cpu_set_t *)-1): TEST_ERRNO=3DEFAULT(14): Bad address
> sched_getaffinity01 =A0 =A06 =A0TPASS =A0: =A0sched_getaffinity(0, 0, mas=
k): TEST_ERRNO=3DEINVAL(22): Invalid argument
> sched_getaffinity01 =A0 =A07 =A0TFAIL =A0: =A0sched_getaffinity(getpid() =
+ 1, len, mask): TEST_ERRNO=3D???(0): Success
>
> Seems that using ``getpid() + 1'' is not
> always correct, so I use another non-existed
> pid to replace ``getpid() + ''.
>
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
>
> ---
> =A0.../sched_getaffinity/sched_getaffinity01.c =A0 =A0 =A0 =A0| =A0 =A05 =
++---
> =A01 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinit=
y01.c b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
> index 7dfb0ec..aaa646d 100644
> --- a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
> +++ b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
> @@ -41,7 +41,7 @@
> =A0#include<stdio.h>
> =A0#include<sys/types.h>
> =A0#include<unistd.h>
> -#define _GNU_SOURCE
> +#define _GNU_SOURCE
> =A0#define __USE_GNU
> =A0#include<sched.h>
> =A0#include<string.h>
> @@ -201,11 +201,10 @@ realloc:
> =A0#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0QUICK_TEST(sched_getaffinity(0=
, len, (cpu_set_t *)-1));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0QUICK_TEST(sched_getaffinity(0=
, 0, mask));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 QUICK_TEST(sched_getaffinity(ge=
tpid() + 1, len, mask));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 QUICK_TEST(sched_getaffinity(65=
535, len, mask));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPU_FREE(mask);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 cleanup();
> =A0 =A0 =A0 =A0tst_exit();
> =A0}

    Please try the modified version on git HEAD.
Cheers,
-Garrett

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
