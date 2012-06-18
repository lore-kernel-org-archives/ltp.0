Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanpai.chen@gmail.com>) id 1SgXfG-0002Gn-6r
	for ltp-list@lists.sourceforge.net; Mon, 18 Jun 2012 08:50:26 +0000
Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SgXfA-0002RL-9o
	for ltp-list@lists.sourceforge.net; Mon, 18 Jun 2012 08:50:26 +0000
Received: by bkcjm2 with SMTP id jm2so4388649bkc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Jun 2012 01:50:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4f45f838.8aa82a0a.6cc7.334fSMTPIN_ADDED@mx.google.com>
References: <y>
	<4f45f838.8aa82a0a.6cc7.334fSMTPIN_ADDED@mx.google.com>
Date: Mon, 18 Jun 2012 16:50:13 +0800
Message-ID: <CANj_sbCqCAUF5fmRe9z+8mVGc8UzJFoCMkczeLEAzBS2=MUczQ@mail.gmail.com>
From: Andrew Yan-Pai Chen <yanpai.chen@gmail.com>
Subject: Re: [LTP] [PATCH] getrusage04: add opportunity to increase the max
 [us]time increment
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
To: Filippo ARCIDIACONO <filippo.arcidiacono@st.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Feb 23, 2012 at 4:23 PM, Filippo ARCIDIACONO
<filippo.arcidiacono@st.com> wrote:
> From: Filippo Arcidiacono <filippo.arcidiacono@st.com>
>
> On slow systems it could be needed to increase the max value [us]time
> increment beetween two getrusage calls.
>
> Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
> Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
> ---
> =A0testcases/kernel/syscalls/getrusage/getrusage04.c | =A0 42 +++++++++++=
++++++---
> =A01 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcase=
s/kernel/syscalls/getrusage/getrusage04.c
> index 3bdd3b0..92f8361 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage04.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
> @@ -54,11 +54,22 @@ int TST_TOTAL =3D 1;
>
> =A0#define BIAS_MAX =A0 =A0 =A01000
> =A0#define RECORD_MAX =A0 =A020
> +#define FACTOR_MAX =A0 =A010
>
> =A0#ifndef RUSAGE_THREAD
> =A0#define RUSAGE_THREAD 1
> =A0#endif
>
> +static int opt_factor;
> +static char *factor_str;
> +static long factor_nr =3D 1;
> +
> +option_t child_options[] =3D {
> + =A0 =A0 =A0 { "m:", &opt_factor, &factor_str },
> + =A0 =A0 =A0 { NULL, NULL, =A0 =A0 =A0 =A0 NULL }
> +};
> +
> +static void fusage(void);
> =A0static void busyloop(long wait);
> =A0static void setup(void);
> =A0static void cleanup(void);
> @@ -69,8 +80,9 @@ int main(int argc, char *argv[])
> =A0 =A0 =A0 =A0unsigned long ulast, udelta, slast, sdelta;
> =A0 =A0 =A0 =A0int i, lc;
> =A0 =A0 =A0 =A0char *msg;
> + =A0 =A0 =A0 char msg_string[BUFSIZ];
>
> - =A0 =A0 =A0 msg =3D parse_opts(argc, argv, NULL, NULL);
> + =A0 =A0 =A0 msg =3D parse_opts(argc, argv, child_options, fusage);
> =A0 =A0 =A0 =A0if (msg !=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(TBROK, NULL, "OPTION PARSING ERRO=
R - %s", msg);
>
> @@ -80,6 +92,11 @@ int main(int argc, char *argv[])
>
> =A0 =A0 =A0 =A0setup();
>
> + =A0 =A0 =A0 if (opt_factor)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 factor_nr =3D SAFE_STRTOL(cleanup, factor_s=
tr, 0, FACTOR_MAX);
> +
> + =A0 =A0 =A0 tst_resm(TINFO, "Using %ld as multiply factor for max [us]t=
ime increment (1000+%ldus)!", factor_nr, BIAS_MAX * factor_nr);
> +
> =A0 =A0 =A0 =A0for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tst_count =3D 0; i =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ulast =3D 0, slast =3D 0;
> @@ -95,14 +112,20 @@ int main(int argc, char *argv[])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(T=
INFO, "utime:%12luus; stime:%12luus",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0usage.ru_utime.tv_usec,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0usage.ru_stime.tv_usec);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (udelta =
> 1000+BIAS_MAX)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_brkm(TFAIL, cleanup,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "utime increased > 1000us:"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (udelta =
> 1000+(BIAS_MAX * factor_nr)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 sprintf(msg_string,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "utime increased > %ldus:",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 1000 + BIAS_MAX * factor_nr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_brkm(TFAIL, cleanup, msg_string,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" delta =3D %luus", udelta);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sdelta =
> 1000+BIAS_MAX)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_brkm(TFAIL, cleanup,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "stime increased > 1000us:"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sdelta =
> 1000+(BIAS_MAX * factor_nr)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 sprintf(msg_string,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "stime increased > %ldus:",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 1000 + BIAS_MAX * factor_nr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_brkm(TFAIL, cleanup, msg_string,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" delta =3D %luus", sdelta);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ulast =3D usage.ru_utime.t=
v_usec;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0slast =3D usage.ru_stime.t=
v_usec;
> @@ -113,6 +136,11 @@ int main(int argc, char *argv[])
> =A0 =A0 =A0 =A0tst_exit();
> =A0}
>
> +static void fusage(void)
> +{
> + =A0 =A0 =A0 printf(" =A0-m n =A0 =A0use n as multiply factor for max [u=
s]time increment (1000+(1000*n)us), default value is 1\n");
> +}
> +
> =A0static void busyloop(long wait)
> =A0{
> =A0 =A0 =A0 =A0while (wait--)
> --
> 1.5.5.6
>
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

Hi folks,

How to determine the value of factor_nr?
We are running the test on a very slow system (ARMv5, 33MHz)
Even factor_nr is set to 10, the test still get failed with the
following message:

getrusage04    0  TINFO  :  utime:       60000us; stime:      360000us
getrusage04    0  TINFO  :  utime:       60000us; stime:      370000us
getrusage04    0  TINFO  :  utime:       60000us; stime:      390000us
getrusage04    1  TFAIL  :  stime increased > 11000us:

BTW, how can we guarantee that s/udelta is always less than
1000+(BIAS_MAX * factor_nr)us?
What if the kernel is busy handling interrupts?

Thanks.

--
Regards,
Andrew

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
