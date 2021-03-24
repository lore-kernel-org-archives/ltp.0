From: Heiko Carstens <hca@linux.ibm.com>
Date: Wed, 24 Mar 2021 06:53:35 +0100
Subject: [LTP] [PATCH 2/3] s390/vdso: fix arch_data access for
 __arch_get_hw_counter()
In-Reply-To: <20210323215819.4161164-3-hca@linux.ibm.com>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
 <20210323215819.4161164-3-hca@linux.ibm.com>
Message-ID: <YFrT3x7sa49EPYFx@osiris>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 23, 2021 at 10:58:18PM +0100, Heiko Carstens wrote:
> Li Wang reported that clock_gettime(CLOCK_MONOTONIC_RAW, ...) returns
> incorrect values when time is provided via vdso instead of system call:
> 
> vdso_ts_nsec = 4484351380985507, vdso_ts.tv_sec = 4484351, vdso_ts.tv_nsec = 380985507
> sys_ts_nsec  = 1446923235377, sys_ts.tv_sec  = 1446, sys_ts.tv_nsec  = 923235377
> 
> Within the s390 specific vdso function __arch_get_hw_counter() tries
> to read tod clock steering values from the arch_data member of the
> passed in vdso_data structure.
> However only the arch_data member of the first clock source base
> (CS_HRES_COARSE) is initialized. For CS_RAW arch_data is not at all
> initialized, which explains the incorrect returned values.
> 
> It is a bit odd to provide the required tod clock steering parameters
> only within the first element of the _vdso_data array. However for
> time namespaces even no member of the _timens_data array contains the
> required data, which would make fixing __arch_get_hw_counter() quite
> complicated.
> 
> Therefore simply add an s390 specific vdso data page which contains
> the tod clock steering parameters. Everything else seems to be
> unnecessary complex.
> 
> Reported-by: Li Wang <liwang@redhat.com>
> Fixes: 1ba2d6c0fd4e ("s390/vdso: simplify __arch_get_hw_counter()")
> Fixes: eeab78b05d20 ("s390/vdso: implement generic vdso time namespace support")
> Link: https://lore.kernel.org/linux-s390/YFnxr1ZlMIOIqjfq@osiris
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Kconfig                         |  1 -
>  arch/s390/include/asm/vdso.h              |  4 +++-
>  arch/s390/include/asm/vdso/data.h         | 13 ------------
>  arch/s390/include/asm/vdso/datapage.h     | 17 +++++++++++++++
>  arch/s390/include/asm/vdso/gettimeofday.h | 11 ++++++++--
>  arch/s390/kernel/time.c                   |  6 +++---
>  arch/s390/kernel/vdso.c                   | 25 ++++++++++++++++++++---
>  arch/s390/kernel/vdso64/vdso64.lds.S      |  3 ++-
>  8 files changed, 56 insertions(+), 24 deletions(-)
>  delete mode 100644 arch/s390/include/asm/vdso/data.h
>  create mode 100644 arch/s390/include/asm/vdso/datapage.h

FWIW, alternatively to this and the third patch we could also do the
much shorter and simpler variant below. What I personally don't like
is that data is duplicated.
But on the other hand it is much shorter, and the more I think of it
this seems to be the way to go.
Opinions?

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index e37285a5101b..fa095ecf0349 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -80,10 +80,12 @@ void __init time_early_init(void)
 {
 	struct ptff_qto qto;
 	struct ptff_qui qui;
+	int i;
 
 	/* Initialize TOD steering parameters */
 	tod_steering_end = tod_clock_base.tod;
-	vdso_data->arch_data.tod_steering_end = tod_steering_end;
+	for (i = 0; i < CS_BASES; i++)
+		vdso_data[i].arch_data.tod_steering_end = tod_steering_end;
 
 	if (!test_facility(28))
 		return;
@@ -366,6 +368,7 @@ static void clock_sync_global(unsigned long delta)
 {
 	unsigned long now, adj;
 	struct ptff_qto qto;
+	int i;
 
 	/* Fixup the monotonic sched clock. */
 	tod_clock_base.eitod += delta;
@@ -381,8 +384,10 @@ static void clock_sync_global(unsigned long delta)
 		panic("TOD clock sync offset %li is too large to drift\n",
 		      tod_steering_delta);
 	tod_steering_end = now + (abs(tod_steering_delta) << 15);
-	vdso_data->arch_data.tod_steering_end = tod_steering_end;
-	vdso_data->arch_data.tod_steering_delta = tod_steering_delta;
+	for (i = 0; i < CS_BASES; i++) {
+		vdso_data[i].arch_data.tod_steering_end = tod_steering_end;
+		vdso_data[i].arch_data.tod_steering_delta = tod_steering_delta;
+	}
 
 	/* Update LPAR offset. */
 	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) == 0)
