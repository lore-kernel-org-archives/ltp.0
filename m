Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A03ECA6007
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 09:10:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 259E93E49EF
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 11:10:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A27F3C23B2
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 11:10:00 +0200 (CEST)
Received: from mta0.migadu.com (out-94.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::5e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1D871400527
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 11:09:57 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=rs1r63Xt/A8FFyKe53j6r+HaIysqZzslm9ktmaeLt2A=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791450596; v=1; x=1792055396;
 b=ioupvWiUTC9qVIT+SfST59XDXZy6JjI/7ewkh1fy/daV+e05WWmPAdxEVqFyc6KXDmiNeDqs
 nk4LDVKBKqQbO748qnNC7OHIhQ2bzTu8hTxax1c0DgGPggv0+APdptO8Cgku0HCzrQn5BRZYNfO
 sGImZp+GswUPxi473+C+A0SY=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id f17263712bbd5e54;
 Thu, 08 Oct 2026 09:09:56 +0000
X-Mizu-Trace-ID: f17263712bbd5e54
X-Migadu-Flow: FLOW_OUT
Date: Thu, 8 Oct 2026 17:09:50 +0800
From: Li Wang <li.wang@linux.dev>
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Message-ID: <asdd3iGIWDstN4lT@linux.dev>
Mail-Followup-To: Huaisheng Ye <yehuaisheng@open-hieco.net>,
 chrubis@suse.cz, pvorel@suse.cz, ltp@lists.linux.it
References: <20260929072412.20979-1-yehuaisheng@open-hieco.net>
 <20260929072412.20979-3-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260929072412.20979-3-yehuaisheng@open-hieco.net>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] hugemmap10: Add private MAP_NORESERVE test
 mode
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Huaisheng Ye wrote:

> Add -n to apply MAP_NORESERVE only to private mappings. Shared
> mappings retain their original flags and reservation behavior.
> 
> Use the private mapping flags for both the reservation probe and test
> mappings. As a result, private_resv and its TDEBUG report describe whether
> the private mappings actually in use create a hugetlb reservation at
> mmap() time. This is true both for the kernel default and when -n forces
> fault-time reservations.
> 
> The option lets the test exercise the fault-time private reservation path
> used by upstream kernels without booting an older kernel.

The new mode is useful, but it should also be added to runtest/hugetlb,
otherwise the fault-time path is never exercised by the default test run:

--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -13,6 +13,7 @@ hugemmap07 hugemmap07
 hugemmap08 hugemmap08
 hugemmap09 hugemmap09
 hugemmap10 hugemmap10
+hugemmap10 hugemmap10 -n

> 
> Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
> ---
>  .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> index b22e11f41..1a5b0fd2f 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> @@ -31,6 +31,8 @@
>  
>  static long hpage_size;
>  static int private_resv;
> +static int private_noreserve;

The private_noreserve variable looks redundant. We can simply use
private_noreserve_opt directly, since it is already NULL when -n is
not given and non-NULL when it is.

	if (private_noreserve_opt && (flags & MAP_TYPE) == MAP_PRIVATE)
		return flags | MAP_NORESERVE;

> +static char *private_noreserve_opt;
>  
>  #define NR_SLOTS	2
>  #define SL_SETUP	0
> @@ -90,6 +92,16 @@ static int mapping_creates_reservation(int flags)
>  	return (flags & MAP_SHARED) || private_resv;
>  }
>  
> +/* Exercise the fault-time reservation path used by older kernels. */
> +static int private_mmap_flags(int flags)
> +{
> +	if (private_noreserve &&
> +	    (flags & MAP_TYPE) == MAP_PRIVATE)
> +		return flags | MAP_NORESERVE;
> +
> +	return flags;
> +}

We need to add the MAP_TYPE definition to lapi/mmap.h to avoid
compilation failures on systems where glibc (<sys/mman.h>)
doesn't support it.

#ifndef MAP_TYPE
#define MAP_TYPE 0x0f
#endif

> +
>  static unsigned long read_allowed_free_hugepages(void)
>  {
>  	char path[PATH_MAX];
> @@ -155,7 +167,8 @@ static int kernel_has_private_reservations(void)
>  	read_meminfo_huge(&t, &f, &r, &s);
>  	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
>  
> -	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE,
> +		      private_mmap_flags(MAP_PRIVATE), fd, 0);
>  
>  	read_meminfo_huge(&nt, &nf, &nr, &ns);
>  
> @@ -283,8 +296,9 @@ static int map_(int s, int hpages, int flags, char *desc, int line)
>  	map_size[s] = hpages * hpage_size;
>  	if (creates_reservation)
>  		allowed_free = read_allowed_free_hugepages();
> -	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE, flags,
> -				map_fd[s], 0);
> +	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE,
> +			private_mmap_flags(flags),
> +			map_fd[s], 0);
>  	touched[s] = 0;
>  
>  	et = prev_total;
> @@ -533,7 +547,10 @@ static void setup(void)
>  {
>  	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
>  	SAFE_FILE_PRINTF(PATH_VM_OVERCOMMIT_HPAGES, "%lu", tst_hugepages);

> +	private_noreserve = !!private_noreserve_opt;
Drop this line.

>  	private_resv = kernel_has_private_reservations();
> +	tst_res(TDEBUG, "MAP_PRIVATE mmap() %s a hugetlb reservation",
> +		private_resv ? "creates" : "does not create");
>  }
>  
>  static void cleanup(void)
> @@ -543,6 +560,11 @@ static void cleanup(void)
>  
>  static struct tst_test test = {
>  	.needs_root = 1,
> +	.options = (struct tst_option[]) {
> +		{"n", &private_noreserve_opt,
> +		 "Map private VMAs with MAP_NORESERVE"},
> +		{}
> +	},
>  	.mntpoint = MNTPOINT,
>  	.needs_hugetlbfs = 1,
>  	.save_restore = (const struct tst_path_val[]) {
> -- 
> 2.52.0
> 

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
