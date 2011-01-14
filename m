Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PdcxB-0006e9-7C
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 06:16:05 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pdcx9-0007Fj-Sm
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 06:16:05 +0000
Received: by wyb40 with SMTP id 40so2421644wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Jan 2011 22:15:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D2EB02C.2050109@cn.fujitsu.com>
References: <4D2EB02C.2050109@cn.fujitsu.com>
Date: Thu, 13 Jan 2011 22:15:57 -0800
Message-ID: <AANLkTim-+iQr5JJ-RFPNr8GEjBiR4Tm9A8euGrtG-jpr@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [POSIX][PATCH] Fix a building error at pthread_join cases.
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jan 12, 2011 at 11:56 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> Fix building error of pthread_join cases.
>
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
>
> ---
> =A0.../interfaces/pthread_join/threads_scenarii.c =A0 =A0 | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthrea=
d_join/threads_scenarii.c b/testcases/open_posix_testsuite/conformance/inte=
rfaces/pthread_join/threads_scenarii.c
> index 479b28c..ee9ccbb 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/=
threads_scenarii.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/=
threads_scenarii.c
> @@ -225,7 +225,6 @@ void scenar_init()
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (scenarii[ i ].schedpar=
am =3D=3D -1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sp.sched_p=
riority =3D sched_get_priority_min(old);
> ->>>>>>> origin
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D pthread_attr_setsc=
hedparam(&scenarii[ i ].ta, &sp);
>
> @@ -487,4 +486,4 @@ int main (int argc, char *argv[])
>
> =A0 =A0 =A0 =A0PASSED;
> =A0}
> -#endif
> \ No newline at end of file
> +#endif

    This removes the conflicts marker, but it didn't fix a functional
issue with the change. I'm vetting other files you've noted to fix
issues.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
