Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5192C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 09:29:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 629133CAFE0
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 11:29:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAF0C3CAD6A
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 11:29:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C82B314002DE
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 11:29:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7DAC3395C;
 Mon, 17 Oct 2022 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665998954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIJzO+2ozZoUpb/NysEDr3rNmt2oH8yaBP5F7Mh/7vU=;
 b=Oy9Jk/kVKfdv58hlAgPTfJ6x6aoy3RDzydz0JGPIOeVz1FmWexSqFIJCDWxxElL6Ed6Swq
 nDQ78TrQNmRC1nEt7LIVekT6LABPwED/P2L2JKP4mehuQpV9TEUrGHA1zjigKHbYHvHZKM
 qA40VtpcdXnfqQSCeqiAFKt95ljN7qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665998954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIJzO+2ozZoUpb/NysEDr3rNmt2oH8yaBP5F7Mh/7vU=;
 b=cS0eFkjQBqbyrGLFbWtNm8dPJksr3L/ryUV5ly+6aIHOwNgCSunaa8SAaE61hknfwlMze1
 spPUa7jL7A5PO8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E5C513398;
 Mon, 17 Oct 2022 09:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /B+iImogTWNYRAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Oct 2022 09:29:14 +0000
Date: Mon, 17 Oct 2022 11:30:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y00g0NZYO8pVvC6M@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-2-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221016125731.249078-2-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 01/29] Hugetlb: Migrating libhugetlbfs
 brk_near_huge
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Test Description:
> Certain kernels have a bug where brk() does not perform the same checks
> that a MAP_FIXED mmap() will, allowing brk() to create a normal page VMA in
> a hugepage only address region. This can lead to oopses or other badness.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 163 ++++++++++++++++++
>  testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  75 ++++++++
>  testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   5 +
>  5 files changed, 245 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index f719217ab..f7ff81cb3 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -3,6 +3,7 @@ hugemmap02 hugemmap02
>  hugemmap04 hugemmap04
>  hugemmap05 hugemmap05
>  hugemmap06 hugemmap06
> +hugemmap07 hugemmap07
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index ff2910533..df5256ec8 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -4,6 +4,7 @@
>  /hugetlb/hugemmap/hugemmap04
>  /hugetlb/hugemmap/hugemmap05
>  /hugetlb/hugemmap/hugemmap06
> +/hugetlb/hugemmap/hugemmap07
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> new file mode 100644
> index 000000000..06fd0b86c
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + *
> + * Test Name: brk near hugepage
> + *
> + * Test Description: Certain kernels have a bug where brk() does not perform
> + * the same checks that a MAP_FIXED mmap() will, allowing brk() to create a
> + * normal page VMA in a hugepage only address region. This can lead to oopses
> + * or other badness.

This description has to be in a separate ascii-doc formatted comment
that starts with /*\

> + * HISTORY
> + *  Written by David Gibson & Adam Litke
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +
> +#include "hugetlb.h"
> +#include "tst_safe_stdio.h"
> +
> +static char *verbose;
> +static int  fd = -1;
> +static char hfile[MAXPATHLEN];
> +static long hpage_size;
> +
> +static int arch_has_slice_support(void)
> +{
> +#ifdef __powerpc64__
> +	char mmu_type[16];
> +	FILE *fp;
> +
> +	fp = SAFE_POPEN("cat /proc/cpuinfo | grep MMU | awk '{ print $3}'", "r");
> +	if (fscanf(fp, "%s", mmu_type) < 0)
> +		tst_brk(TBROK, "Failed to determine MMU type");
> +
> +	pclose(fp);
> +	return strcmp(mmu_type, "Hash") == 0;
> +#elif defined(__powerpc__) && !defined(PPC_NO_SEGMENTS)
> +	return 1;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +#ifdef __powerpc64__
> +static void *next_chunk(void *addr)
> +{
> +	if (!arch_has_slice_support())
> +		return PALIGN(addr, SAFE_READ_MEMINFO("Hugepagesize:")*1024);
> +
> +	if ((unsigned long)addr < 0x100000000UL)
> +		/* 256M segments below 4G */
> +		return PALIGN(addr, 0x10000000UL);
> +	/* 1TB segments above */
> +	return PALIGN(addr, 0x10000000000UL);
> +}
> +#elif defined(__powerpc__) && !defined(PPC_NO_SEGMENTS)
> +static void *next_chunk(void *addr)
> +{
> +	return PALIGN(addr, 0x10000000UL);
> +}
> +#elif defined(__ia64__)
> +static void *next_chunk(void *addr)
> +{
> +	return PALIGN(addr, 0x8000000000000000UL);
> +}
> +#else
> +static void *next_chunk(void *addr)
> +{
> +	return PALIGN(addr, SAFE_READ_MEMINFO("Hugepagesize:")*1024);
> +}
> +#endif
> +
> +static void run_test(void)
> +{
> +	void *brk0, *hugemap_addr, *newbrk;
> +	char *p;
> +	int err;
> +
> +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> +	SAFE_UNLINK(hfile);

> +	brk0 = sbrk(0);
> +	if (verbose)
> +		tst_res(TINFO, "Initial break at %p", brk0);
> +
> +	hugemap_addr = next_chunk(brk0) + hpage_size;
> +
> +	p = SAFE_MMAP(hugemap_addr, hpage_size, PROT_READ|PROT_WRITE,
> +			MAP_PRIVATE|MAP_FIXED, fd, 0);
> +	if (p != hugemap_addr) {
> +		tst_res(TFAIL, "mmap() at unexpected address %p instead of %p\n", p,
> +		     hugemap_addr);
> +		goto fail;

Can we just do return here instead. The failure has been reported there
is no point in calling tst_brk(TBROK, ...) as well.

> +	}
> +
> +	err = test_addr_huge((void *)p);
> +	if (err != 1) {
> +		tst_res(TFAIL, "Mapped address is not hugepage");
> +		goto fail;
> +	}

I do not get why we even need this check. We map a file located on
hugetlbfs and then we stat it and check that it indeed is on hutetlbfs.
What did we expect to fail here? I would say that the mmap() with right
path is enough to make sure that the file is created on hugetlbfs.

> +	newbrk = next_chunk(brk0) + getpagesize();
> +	err = brk((void *)newbrk);
> +	if (err == -1) {
> +		/* Failing the brk() is an acceptable kernel response */
> +		tst_res(TPASS, "Failing the brk is an acceptable response");
> +	} else {
> +		/* Suceeding the brk() is acceptable iff the new memory is
> +		 * properly accesible and we don't have a kernel blow up when
> +		 * we touch it.
> +		 */
> +		memset(brk0, 0, newbrk-brk0);
> +		tst_res(TPASS, "Succeding brk is acceptable, as memset confirms that "
> +				"new memory is properly accessible without kernel blow up");
> +	}
> +	SAFE_MUNMAP(p, hpage_size);
> +	SAFE_CLOSE(fd);

Shouldn't we brk() back to the original brk0? Does the test work with -i 2?

> +	return;
> +fail:
> +	tst_brk(TBROK, "Once failed, No point in continuing the test");
> +}
> +
> +static void setup(void)
> +{
> +	if (tst_hugepages < 1)
> +		tst_brk(TCONF, "Not enough hugepages for testing.");
> +
> +	if (!Hopt)
> +		Hopt = tst_get_tmpdir();
> +	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> +
> +	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
> +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +	umount2(Hopt, MNT_DETACH);

We whould umount here only if we actually have mounted something.

> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.options = (struct tst_option[]) {
> +		{"v", &verbose, "Turns on verbose mode"},
> +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
> +		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
> +		{}
> +	},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {1, TST_REQUEST},
> +};
> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> index 1204f21d2..d215c69dd 100644
> --- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> @@ -29,15 +29,19 @@
>   *	getipckey()
>   *	getuserid()
>   *	rm_shm()
> + *	read_maps()
> + *	test_addr_huge()
>   */
>  
>  #define TST_NO_DEFAULT_MAIN
> +#define _GNU_SOURCE
>  #include <sys/types.h>
>  #include <sys/ipc.h>
>  #include <sys/shm.h>
>  #include <sys/time.h>
>  #include <pwd.h>
>  #include "hugetlb.h"
> +#include "tst_safe_stdio.h"
>  
>  key_t shmkey;
>  
> @@ -111,3 +115,74 @@ void rm_shm(int shm_id)
>  		tst_res(TINFO, "id = %d", shm_id);
>  	}
>  }
> +
> +#define MAPS_BUF_SZ 4096
> +#define HUGETLBFS_MAGIC 0x958458f6
> +
> +int read_maps(unsigned long addr, char *buf)
> +{
> +	FILE *f;
> +	char line[MAPS_BUF_SZ];
> +	char *tmp;
> +
> +	f = SAFE_FOPEN("/proc/self/maps", "r");
> +
> +	while (1) {
> +		unsigned long start, end, off, ino;
> +		int ret;
> +
> +		tmp = fgets(line, MAPS_BUF_SZ, f);
> +		if (!tmp)
> +			break;
> +
> +		buf[0] = '\0';
> +		ret = sscanf(line, "%lx-%lx %*s %lx %*s %ld %255s",
> +			     &start, &end, &off, &ino,
> +			     buf);
> +		if ((ret < 4) || (ret > 5)) {
> +			tst_res(TWARN, "Couldn't parse /proc/self/maps line: %s\n",
> +			      line);
> +			SAFE_FCLOSE(f);
> +			return -1;
> +		}
> +
> +		if ((start <= addr) && (addr < end)) {
> +			SAFE_FCLOSE(f);
> +			return 1;
> +		}
> +	}
> +
> +	SAFE_FCLOSE(f);
> +	return 0;
> +}
> +
> +int test_addr_huge(void *p)
> +{
> +	char name[256];
> +	char *dirend;
> +	int ret;
> +	struct statfs64 sb;
> +
> +	ret = read_maps((unsigned long)p, name);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0) {
> +		tst_res(TWARN, "Couldn't find address %p in /proc/self/maps\n", p);
> +		return -1;
> +	}
> +
> +	/* looks like a filename? */
> +	if (name[0] != '/')
> +		return 0;
> +
> +	/* Truncate the filename portion */
> +	dirend = strrchr(name, '/');
> +	if (dirend && dirend > name)
> +		*dirend = '\0';
> +
> +	ret = statfs64(name, &sb);
> +	if (ret)
> +		return -1;
> +
> +	return (sb.f_type == HUGETLBFS_MAGIC);
> +}
> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> index f75109f3e..c522314eb 100644
> --- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> @@ -20,6 +20,9 @@
>  #include "old_tmpdir.h"
>  #include "mem.h"
>  
> +#define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
> +#define PALIGN(p, a) ((void *)ALIGN((unsigned long)(p), (a)))
> +
>  #define SHM_RD	0400
>  #define SHM_WR	0200
>  #define SHM_RW	(SHM_RD|SHM_WR)
> @@ -39,5 +42,7 @@ extern key_t shmkey;			/* an IPC key generated by ftok() */
>  int getipckey(void);
>  int getuserid(char *user);
>  void rm_shm(int shm_id);
> +int test_addr_huge(void *p);
> +int read_maps(unsigned long addr, char *buf);
>  
>  #endif /* hugetlb.h */
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
