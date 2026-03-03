Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8E5EDA682
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 15:11:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E42A3DAC8A
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 16:11:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCCA93CD7CC
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 16:10:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4DF6B140033A
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 16:10:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 024E13F785;
 Tue,  3 Mar 2026 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772550648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xSbW0B/UfO9Com5Ghj7khrZ/P9vX3+Clwy6KZuADbQ4=;
 b=WZ3JnMP+EPJhzYDkJPCEbOqs0JdK/L6kDrao9cX67f8XZrr3dZqOl5C12RozxA+KRc31QL
 T2KCtBY+q962/kC48iNNJ9N336v8TTCu3y1W2wW/WSmUPRQ9f66+gxEEgzskGeWb70mc1G
 rpS0ucFFQQHJUsslO7jPm+Z/8ajYMjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772550648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xSbW0B/UfO9Com5Ghj7khrZ/P9vX3+Clwy6KZuADbQ4=;
 b=kH2Dx2CB3xPi4oTtzWidm4WglVtfHsiRNrx9cFoBKpdTXQ4np8/mX2VaaKl3hLY+1Gd5cE
 sesh07JheqLY/zAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WZ3JnMP+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kH2Dx2CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772550648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xSbW0B/UfO9Com5Ghj7khrZ/P9vX3+Clwy6KZuADbQ4=;
 b=WZ3JnMP+EPJhzYDkJPCEbOqs0JdK/L6kDrao9cX67f8XZrr3dZqOl5C12RozxA+KRc31QL
 T2KCtBY+q962/kC48iNNJ9N336v8TTCu3y1W2wW/WSmUPRQ9f66+gxEEgzskGeWb70mc1G
 rpS0ucFFQQHJUsslO7jPm+Z/8ajYMjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772550648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xSbW0B/UfO9Com5Ghj7khrZ/P9vX3+Clwy6KZuADbQ4=;
 b=kH2Dx2CB3xPi4oTtzWidm4WglVtfHsiRNrx9cFoBKpdTXQ4np8/mX2VaaKl3hLY+1Gd5cE
 sesh07JheqLY/zAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E52AF3EA69;
 Tue,  3 Mar 2026 15:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IApwNvf5pmkuPAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 03 Mar 2026 15:10:47 +0000
Date: Tue, 3 Mar 2026 16:10:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <aab6ARSEiksAxyJ-@yuki.lan>
References: <20250925061314.1015138-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250925061314.1015138-1-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 024E13F785
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH]  [PATCH] Add hugemmap37,
 migrated task-size-overrun.c from libhugetlbfs v2
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
Cc: ltp@lists.linux.it, Pavithra <pavrampu@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + *[Descripiton]
> + *
> + * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/task-size-overrun.c
> + *
> + * This test verifies the behavior of mmap across the TASK_SIZE boundary.
> + * It checks whether mmap with and without MAP_FIXED correctly handles
> + * mappings that straddle the TASK_SIZE boundary.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <errno.h>
> +#include <assert.h>
> +
> +#include "hugetlb.h"
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_safe_macros.h"
> +
> +#define MAPS_BUF_SZ 4096
> +#define _LARGEFILE64_SOURCE
> +#define MNTPOINT "hugetlbfs/"
> +#define ALIGN(x, a) (((x) + (a) - 1) & ~((a) - 1))

We have LTP_ALIGN() macro in the test library.

> +static long hpage_size;
> +static int fd;
> +
> +static unsigned long find_last_mapped(void)
> +{
> +	char line[MAPS_BUF_SZ];
> +	char *tmp;
> +	unsigned long start, end, off, ino;
> +	FILE *f;
> +
> +	f = SAFE_FOPEN("/proc/self/maps", "r");
> +	do {
> +		tmp = fgets(line, MAPS_BUF_SZ, f);
> +	} while (tmp);
> +	SAFE_FCLOSE(f);
> +
> +	tst_res(TINFO, "Last map: %s", line);
> +	SAFE_SSCANF(line, "%lx-%lx %*s %lx %*s %ld %*s", &start, &end, &off, &ino);
> +	tst_res(TINFO, "Last map: at 0x%lx-0x%lx\n", start, end);
> +	return end;
> +}
> +
> +static unsigned long find_task_size(void)
> +{
> +	unsigned long low, high; /* PFNs */
> +	void *p;
> +
> +	low = find_last_mapped();
> +	if (!low || ((low % getpagesize()) != 0))
> +		tst_brk(TBROK, "Bogus stack end address, 0x%lx!?", low);

The last mapping in /proc/self/maps on my systems is [vsyscall] which is
mapped at the end of the address space. I guess that we need to take
last line from the file that is not [vsyscall] (and perhaps there are
other special cases on some architectures but that can be fixed later).

> +	low = low / getpagesize();
> +
> +	/* This sum should get us (2^(wordsize) - 2 pages) */
> +	high = (unsigned long)(-2 * getpagesize()) / tst_get_hugepage_size();

I do not get this at all. We are trying to figure out TASK_SIZE how
exactly do we figure out the upper bound from hugepage size?

> +	tst_res(TINFO, "Binary searching for task size PFNs 0x%lx..0x%lx\n", low, high);
> +
> +	while (high > low + 1) {
> +		unsigned long pfn = (low + high) / 2;
> +		unsigned long addr = pfn * getpagesize();
> +
> +		assert((pfn >= low) && (pfn <= high));

As long as I can tell this assert is never triggered.

> +		p = mmap((void *)addr, getpagesize(), PROT_READ,
> +			   MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
> +		if (p == MAP_FAILED) {
> +			tst_res(TINFO | TERRNO, "Map failed at 0x%lx", addr);
> +			high = pfn;
> +		} else {
> +			tst_res(TINFO, "Map succeeded at 0x%lx\n", addr);
> +			SAFE_MUNMAP(p, getpagesize());
> +			low = pfn;
> +		}
> +	}
> +
> +	return low * getpagesize();
> +}
> +
> +static void run_test(void)
> +{
> +	void *p;
> +	unsigned long task_size;
> +	unsigned long straddle_addr;
> +
> +	task_size = find_task_size();
> +	tst_res(TINFO, "TASK_SIZE = 0x%lx\n", task_size);
> +
> +	straddle_addr = task_size - hpage_size;
> +	straddle_addr = ALIGN(straddle_addr, hpage_size);
> +
> +	tst_res(TINFO, "Mapping without MAP_FIXED at %lx...", straddle_addr);
> +	errno = 0;
> +	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
> +		 MAP_SHARED, fd, 0);
> +	if (p == (void *)straddle_addr)
> +		tst_res(TFAIL, "Apparently suceeded in mapping across TASK_SIZE boundary");
> +
> +	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
> +	errno = 0;
> +	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
> +		 MAP_SHARED|MAP_FIXED, fd, 0);
> +	if (p != MAP_FAILED)
> +		tst_res(TFAIL, "Apparently suceeded in mapping across TASK_SIZE boundary");
> +
> +	tst_res(TPASS, "Test passed!");
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = getpagesize();
> +	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {3, TST_NEEDS},
> +};
> -- 
> 2.43.5
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
