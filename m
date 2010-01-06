Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSOAr-0005tH-P1
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 05:11:13 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSOAq-00086q-Q9
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 05:11:13 +0000
Received: by pwj11 with SMTP id 11so11776329pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 05 Jan 2010 21:11:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B4403EA.7020600@cn.fujitsu.com>
References: <4B4403EA.7020600@cn.fujitsu.com>
Date: Tue, 5 Jan 2010 21:11:06 -0800
Message-ID: <364299f41001052111v40edbb44tdce22dd0355968f4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix the bug of the smaller cpu_set_t's length in
	getcpu01
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
To: miaox@cn.fujitsu.com
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

On Tue, Jan 5, 2010 at 7:30 PM, Miao Xie <miaox@cn.fujitsu.com> wrote:
> getcpu01 test failed because the len of cpu_set_t in the glibc is smaller=
 than
> the length of the cpumask in the kernel. So we must use the dynamically s=
ized CPU sets instead
> of the standard cpu_set_t.
>
> This patch fix this problem.
> Before using this patch, the test result is following:
> getcpu01 =A0 =A01 =A0TFAIL =A0: =A0sched_getaffinity:errno:22
>
> After using this patch, the test result is following:
> getcpu01 =A0 =A01 =A0TPASS =A0: =A0getcpu() returned proper cpuid:3, node=
 id:0
>
> Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
> ---
> =A0testcases/kernel/syscalls/getcpu/getcpu01.c | =A0 66 +++++++++++++++++=
++++++----
> =A01 files changed, 56 insertions(+), 10 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kern=
el/syscalls/getcpu/getcpu01.c
> index 9b4e52e..c13e0e7 100644
> --- a/testcases/kernel/syscalls/getcpu/getcpu01.c
> +++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
> @@ -77,12 +77,16 @@ int sys_support =3D 0;
> =A0int sys_support =3D 0;
> =A0#endif
>
> +#if !(__GLIBC_PREREQ(2, 7))
> +#define CPU_FREE(ptr) free(ptr)
> +#endif
> +
> =A0void cleanup(void);
> =A0void setup(void);
> =A0static inline int getcpu(unsigned int *, unsigned int *, void *);
> =A0unsigned int set_cpu_affinity();
> =A0unsigned int get_nodeid(unsigned int);
> -unsigned int max_cpuid(cpu_set_t *);
> +unsigned int max_cpuid(size_t, cpu_set_t *);
>
> =A0char *TCID =3D "getcpu01";
> =A0int TST_TOTAL =3D 1;
> @@ -189,18 +193,56 @@ void setup(void)
> =A0unsigned int set_cpu_affinity()
> =A0{
> =A0 =A0 =A0 =A0unsigned cpu_max;
> - =A0 =A0 =A0 cpu_set_t set;
> - =A0 =A0 =A0 if (sched_getaffinity(0, sizeof(cpu_set_t), &set) < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "sched_getaffinity:errno:%d=
", errno);
> + =A0 =A0 =A0 cpu_set_t *set;
> + =A0 =A0 =A0 size_t size;
> + =A0 =A0 =A0 int nrcpus =3D 1024;
> +#if __GLIBC_PREREQ(2, 7)
> +realloc:
> + =A0 =A0 =A0 set =3D CPU_ALLOC(nrcpus);
> +#else
> + =A0 =A0 =A0 set =3D malloc(sizeof(cpu_set_t));
> +#endif
> + =A0 =A0 =A0 if (set =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "CPU_ALLOC:errno:%d", errno=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> +
> +#if __GLIBC_PREREQ(2, 7)
> + =A0 =A0 =A0 size =3D CPU_ALLOC_SIZE(nrcpus);
> + =A0 =A0 =A0 CPU_ZERO_S(size, set);
> +#else
> + =A0 =A0 =A0 size =3D sizeof(cpu_set_t);
> + =A0 =A0 =A0 CPU_ZERO(set);
> +#endif
> + =A0 =A0 =A0 if (sched_getaffinity(0, size, set) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPU_FREE(set);
> +#if __GLIBC_PREREQ(2, 7)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (errno =3D=3D EINVAL && nrcpus < (1024 <=
< 8)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nrcpus =3D nrcpus << 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto realloc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +#else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (errno =3D=3D EINVAL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "NR_CPUS of=
 the kernel is more than 1024, so we'd better use a newer glibc(>=3D 2.7)");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "sched_geta=
ffinity:errno:%d", errno);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 cpu_max =3D max_cpuid(&set);
> - =A0 =A0 =A0 CPU_ZERO(&set);
> - =A0 =A0 =A0 CPU_SET(cpu_max, &set);
> - =A0 =A0 =A0 if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0) {
> + =A0 =A0 =A0 cpu_max =3D max_cpuid(size, set);
> +#if __GLIBC_PREREQ(2, 7)
> + =A0 =A0 =A0 CPU_ZERO_S(size, set);
> + =A0 =A0 =A0 CPU_SET_S(cpu_max, size, set);
> +#else
> + =A0 =A0 =A0 CPU_ZERO(set);
> + =A0 =A0 =A0 CPU_SET(cpu_max, set);
> +#endif
> + =A0 =A0 =A0 if (sched_setaffinity(0, size, set) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPU_FREE(set);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "sched_setaffinity:errno:%=
d", errno);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 CPU_FREE(set);
> =A0 =A0 =A0 =A0return cpu_max;
> =A0}
>
> @@ -208,11 +250,15 @@ unsigned int set_cpu_affinity()
> =A0* Return the maximum cpu id
> =A0*/
> =A0#define BITS_PER_BYTE 8
> -unsigned int max_cpuid(cpu_set_t * set)
> +unsigned int max_cpuid(size_t size, cpu_set_t * set)
> =A0{
> =A0 =A0 =A0 =A0unsigned int index, max =3D 0;
> - =A0 =A0 =A0 for (index =3D 0; index < sizeof(cpu_set_t) * BITS_PER_BYTE=
; index++)
> + =A0 =A0 =A0 for (index =3D 0; index < size * BITS_PER_BYTE; index++)
> +#if __GLIBC_PREREQ(2, 7)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (CPU_ISSET_S(index, size, set))
> +#else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (CPU_ISSET(index, set))
> +#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max =3D index;
> =A0 =A0 =A0 =A0return max;
> =A0}

    Is this documented in your distro's manpage?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
