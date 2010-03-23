Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NtvuA-0005h6-Sy
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 04:39:50 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ntvu9-0005nb-Rm
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 04:39:50 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2N4Z9WB013621
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 22:35:09 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2N4dimG126712
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 22:39:44 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2MLdh40011622
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 15:39:43 -0600
Date: Tue, 23 Mar 2010 10:09:40 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100323043940.GA4384@linux.vnet.ibm.com>
References: <364299f41003030118x6136dda6u7017054febea4b96@mail.gmail.com>
	<20100303094541.GB23601@linux.vnet.ibm.com>
	<f5a7b3811003030333n4b0b4045sff5795d99cd7da00@mail.gmail.com>
	<364299f41003030342m7bf4a44ey897b7d2ca365a318@mail.gmail.com>
	<f5a7b3811003030349s2d279fcdx8b74cff2e3a875ab@mail.gmail.com>
	<364299f41003030355y5a921691vdde6baafbe8439cd@mail.gmail.com>
	<f5a7b3811003030545l30efa927tb377f113da30a0bd@mail.gmail.com>
	<f5a7b3811003080257n43d1af67o2942f4d8de2dc5b1@mail.gmail.com>
	<20100322082528.GF20606@linux.vnet.ibm.com>
	<f5a7b3811003221150w11edbf02xade0f97ecb98a6ff@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5a7b3811003221150w11edbf02xade0f97ecb98a6ff@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Synchronization required before release the lock:
 sem_post/8-1.c
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Tue, Mar 23, 2010 at 12:20:33AM +0530, naresh kamboju wrote:
> On Mon, Mar 22, 2010 at 1:55 PM, Rishikesh K Rajak
> Hi Rishi,
> > can you send your patch against today's git ?
> please find the patch below and attached to this e-mail.

Hi Naresh,

Still i am not able to apply it cleanly.

In our git repo we are not finding this : =

"
-        /* Step 3 Implementation */
"

Can you pull latest next git branch and then create a patch and send it to =
me?
-Rishi

> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> =

> ---
>  testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> |   11 	6 +	5 -	0 !
>  1 file changed, 6 insertions(+), 5 deletions(-)
> =

> Index: b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8=
-1.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> @@ -175,13 +175,13 @@ int main()
>  	}
>  	fprintf(stderr, "P: child_2: %d forked\n", c_2);
> =

> -        /* Step 3 Implementation */
>  	/* Make sure the two children has been waiting */	=

> -	do {
> +	/*do {
> +		sleep();
>  		sem_getvalue(sem_1, &val);
>  		//printf("val =3D %d\n", val);
>  	} while (val !=3D 1);
> -
> +	*/
>  	c_3 =3D fork();
>  	if (c_3 =3D=3D 0)
>  	{
> @@ -190,12 +190,13 @@ int main()
>  	}
>  	fprintf(stderr, "P: child_3: %d forked\n", c_3);
>  	=

> -        /* Step 3 Implementation */
>  	/* Make sure child 3 has been waiting for the lock */	=

> -	do {
> +	/*do {
> +		sleep();
>  		sem_getvalue(sem_1, &val);
>  		//printf("val =3D %d\n", val);
>  	} while (val !=3D 0);
> +	*/
> =

>  	/* Synchronization required before release the lock */
>  	sleep(1);
> =

> =

> Best regards
> Naresh Kamboju
> >
> > -Rishi
> >>
> >> Best regards
> >> Naresh Kamboju
> >> >
> >> > Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> >> > ---
> >> > =A0testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-=
1.c
> >> > | =A0 =A02 =A01 + =A0 =A0 1 - =A0 =A0 0 !
> >> > =A01 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > Index: b/testcases/open_posix_testsuite/conformance/interfaces/sem_p=
ost/8-1.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post=
/8-1.c
> >> > +++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post=
/8-1.c
> >> > @@ -161,7 +161,6 @@ int main()
> >> > =A0 =A0 =A0 =A0}
> >> > =A0 =A0 =A0 =A0fprintf(stderr, "P: child_1:%d forked\n", c_1);
> >> >
> >> > - =A0 =A0 =A0 sleep(1);
> >> > =A0 =A0 =A0 =A0c_2 =3D fork();
> >> > =A0 =A0 =A0 =A0if (c_2 =3D=3D 0)
> >> > =A0 =A0 =A0 =A0{
> >> > @@ -198,6 +197,7 @@ int main()
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//printf("val =3D %d\n", val);
> >> > =A0 =A0 =A0 =A0} while (val !=3D 0);
> >> > =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 sleep(1);
> >> > =A0 =A0 =A0 =A0/* Ok, let's release the lock */
> >> > =A0 =A0 =A0 =A0fprintf(stderr, "P: release lock\n");
> >> > =A0 =A0 =A0 =A0sem_post(sem);
> >> >
> >> >
> >> > please let me know if you have any issues.
> >> >
> >> > Best regards,
> >> > Naresh Kamboju
> >> >> Thanks,
> >> >> -Garrett
> >> >>
> >> >
> >
> >
> >
> > --
> > Thanks & Regards
> > Rishi
> > LTP Maintainer
> > IBM, LTC, Bangalore
> > Please join IRC #ltp @ irc.freenode.net
> >



-- =

Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
