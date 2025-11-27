Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E9CD11183
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 11:33:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B72CC3CD226
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 12:33:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F0473C81BB
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 12:33:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4686320006B
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 12:33:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C39513369A;
 Thu, 27 Nov 2025 11:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764243193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2FAOMbSgNOCzWvhow+3b/yGdVZm4zmbswA4OEKWZi0=;
 b=sDrauh0+0PYpaVgEZrjDMaaS7Qc/fmU4MNTGB34D9Ll26GJxCvS0hCt+Ga3mdFVGD8XqrG
 vJiCs4wAh1HL41MjPWU5S1pg96Wk2ECp9/rQnEHNE/ieE9kwdBmWIBHRG9jt64WdRXpEvW
 TK3RUrwuB2eLWkRhCUeLDY31shzfsUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764243193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2FAOMbSgNOCzWvhow+3b/yGdVZm4zmbswA4OEKWZi0=;
 b=Pjvw95VpBt5RzDr0AtWbd9p/boF44rwUTRlemXXhwfnGdX+TNjRhXZ+WlCO4xBip3eWvSM
 FbIK4TLZ1xG+SsAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764243191;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2FAOMbSgNOCzWvhow+3b/yGdVZm4zmbswA4OEKWZi0=;
 b=IKcBg6oB0np/KtfRNjok5G0IwbsN6J2BTYVbdQYqSJDa/Jkp+AAs822tYNV+gKMgaS/xB8
 RRptT6l/UxRNtR7FQovG3lxmPSWOyMBp1C/eK/ruzrpfV4KY1P8G6he8Xv+rbhnIoNVXHE
 rZyfDrUrEr8MArow/Ob4oIVL6E2vrD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764243191;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2FAOMbSgNOCzWvhow+3b/yGdVZm4zmbswA4OEKWZi0=;
 b=3ZarZPJkZEcrHTaQGq7bLztxoQWiOEBZqxj8Hguy+cXs1pGM7w+ko4+cXf0doAHExdRqNj
 ALYIFzm+zD1yxfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACF963EA63;
 Thu, 27 Nov 2025 11:33:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yQZYKfc2KGnOXQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 11:33:11 +0000
Date: Thu, 27 Nov 2025 12:33:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <20251127113310.GB227467@pevik>
References: <20251127072231.2104445-1-pavrampu@linux.ibm.com>
 <20251127072231.2104445-3-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251127072231.2104445-3-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[man7.org:url,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,linux-test-project.readthedocs.io:url];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] [PATCH] [PATCH] Migrating the
 libhugetlbfs/testcases/straddle_4GB.c v3
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra, Geetika,

I very briefly looked into the original source file (I'd personally put that
link into the commit message).

> This testcase attempts to map a memory range that straddles the 4GB boundary using mmap() with and without the MAP_FIXED flag.

> Changes in v3:

FYI I tried to search in the mailing history [2] [3], but I found only v1, sent
by Geetika. Is there any other discussion than I found?

[1] https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/straddle_4GB.c
[2] https://lore.kernel.org/ltp/?q=straddle_4GB.c
[3] https://lore.kernel.org/ltp/?q=hugemmap40

> - Added magic definition to include/tst_fs.h as separate patch.
> - Moved CFLAGS to make file.
> - Added read_maps definition to separate patch.
> - Removed \n from tst_res

> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c
> new file mode 100644
> index 000000000..7b4ad7b05
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Copyright (C) 2006 Hugh Dickins <hugh@veritas.com>
> + */
> +
> +/*\
> + * [Description]
nit: we don't use "[Description]" any more, because /*\ is enough for parsing
comments.
Please remove the line.

> + *
> + * Test tries to allocate hugepages to cover a memory range that straddles the
> + * 4GB boundary, using mmap(2) with and without MAP_FIXED.
nit: Could you please use :man2:`mmap` (this converts to a man page link [4] in
our docs, see e.g. stack_clash [5]).

[4] https://man7.org/linux/man-pages/man2/mmap.2.html
[5] https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html#stack-clash

> + */
> +
> +#define MAPS_BUF_SZ 4096
> +#define FOURGB (1UL << 32)
FYI we also have TST_GB in include/tst_fs.h.

> +#define MNTPOINT "hugetlbfs/"
> +
> +#include "hugetlb.h"
> +
> +static unsigned long hpage_size;
> +static int fd = -1;
> +static unsigned long straddle_addr;
> +
> +static int test_addr_huge(void *p)
> +{
> +	char name[256];
> +	char *dirend;
> +	int ret;
> +	struct statfs64 sb;
> +
> +	ret = read_maps((unsigned long)p, name);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret == 0) {
> +		tst_res(TINFO, "Couldn't find address %p in /proc/self/maps", p);
Having this as info message which is later followed by tst_brk(TFAIL) is is not
optimal. I suspect test is unnecessary complicated, but I'm not sure now how to
improve it.

> +		return -1;
> +	}
> +
> +	/* looks like a filename? */
> +	if (name[0] != '/')
> +		return 0;
> +
> +	/* Truncate the filename portion */
> +
nit: empty line above, please remove it.
> +	dirend = strrchr(name, '/');
> +	if (dirend && dirend > name)
> +		*dirend = '\0';
> +
> +	ret = statfs64(name, &sb);
> +	if (ret)
> +		return -1;
I guess we really need statfs64() not just statfs(), right?
In case of the failure test should quit with tst_brk(TBROK | TERRNO, "...").

> +
> +	return (sb.f_type == HUGETLBFS_MAGIC);
> +}
> +
> +static void run_test(void)
> +{
> +	void *p;
> +
> +	/* We first try to get the mapping without MAP_FIXED */
> +	tst_res(TINFO, "Mapping without MAP_FIXED at %lx...", straddle_addr);
> +	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
> +			MAP_SHARED, fd, 0);
> +	if (p == (void *)straddle_addr) {
> +		/* These tests irrelevant if we didn't get the straddle address*/
> +		if (test_addr_huge(p) != 1) {
> +			tst_brk(TFAIL, "1st Mapped address is not hugepage");
> +			goto windup;
FYI tst_brk() quits testing (test executes only cleanup function. You need to
use tst_res(TFAIL, ...).

> +		}
> +		if (test_addr_huge(p + hpage_size) != 1) {
> +			tst_brk(TFAIL, "2nd Mapped address is not hugepage");
> +			goto windup;
> +		}
> +		memset(p, 0, hpage_size);
> +		memset(p + hpage_size, 0, hpage_size);
> +		tst_res(TPASS, "Mapping without MAP_FIXED at %lx... completed", straddle_addr);
> +	} else {
> +		tst_res(TINFO, "Got %p instead, never mind, let's move to mapping with MAP_FIXED", p);
> +		munmap(p, 2*hpage_size);
We have SAFE_MUNMAP().
> +	}
> +
> +	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
> +	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
> +				MAP_SHARED|MAP_FIXED, fd, 0);
> +
> +	if (p == MAP_FAILED) {
> +		/* this area crosses last low slice and first high slice */
> +		unsigned long below_start = FOURGB - 256L*1024*1024;
> +		unsigned long above_end = 1024L*1024*1024*1024;
> +
> +		if (tst_mapping_in_range(below_start, above_end) == 1) {
> +			tst_res(TINFO, "region (4G-256M)-1T is not free");
> +			tst_res(TINFO, "mmap() failed: %s", strerror(errno));
> +			tst_res(TWARN, "Pass Inconclusive!");
I don't understand "Pass Inconclusive!". Could it be just described what happen?

We have TERRNO which we use instead strerror(). Instead of all 3 tst_res()
mesagess above I would use something like:
			tst_res(TFAIL | TERRNO, "region (4G-256M)-1T is not free");

> +			goto windup;
> +		} else
> +			tst_res(TFAIL, "mmap() FIXED failed: %s", strerror(errno));
I also don't understand "FIXED". I guess it was supposed to be "mmap() with MAP_FIXED failed".
Does it even make sense to continue on mmap() failure? The original test does,
but I'm not sure if that's ok.

very nit: if you use { } on if, they should be also on else.
} else {
> 		tst_res(TFAIL | TERRNO, "mmap() failed: %s", strerror(errno));
}


> +	}
> +
The code below uses wrong indent
> +		if (p != (void *)straddle_addr) {
> +			tst_res(TINFO, "got %p instead", p);
> +			tst_res(TFAIL, "Wrong address with MAP_FIXED");
> +			goto windup;
> +		}
> +
> +		if (test_addr_huge(p) != 1) {
> +			tst_brk(TFAIL, "1st Mapped address is not hugepage");
> +			goto windup;
> +		}
> +
> +		if (test_addr_huge(p + hpage_size) != 1) {
> +			tst_brk(TFAIL, "2nd Mapped address is not hugepage");
> +			goto windup;
> +		}
> +		memset(p, 0, hpage_size);
> +		memset(p + hpage_size, 0, hpage_size);
Why is this memset() for? If needed for testing, shouldn't it be at the
beginning?

> +		tst_res(TPASS, "Mapping with MAP_FIXED at %lx... completed", straddle_addr);
> +
> +windup:
> +	SAFE_MUNMAP(p, 2*hpage_size);
> +}
> +
> +static void setup(void)
> +{
> +	straddle_addr = FOURGB - hpage_size;
> +	hpage_size = tst_get_hugepage_size();
> +	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);

> +	if (hpage_size > FOURGB)
> +		tst_brk(TCONF, "Huge page size is too large!");
I suppose the original check is really needed.

The original test does this check for this:

static inline long check_hugepagesize()
{
	long __hpage_size = gethugepagesize();
	if (__hpage_size < 0) {
		if (errno == ENOSYS)
			CONFIG("No hugepage kernel support\n");
		else if (errno == EOVERFLOW)
			CONFIG("Hugepage size too large");
		else
			CONFIG("Hugepage size (%s)", strerror(errno));
	}
	return __hpage_size;
}

Kind regards,
Petr

[6] https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/hugetests.h#L126-L138

> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.hugepages = {2, TST_NEEDS},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
