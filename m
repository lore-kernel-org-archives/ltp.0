Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8195C07E98
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 11:51:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C9273CDA4C
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 12:51:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B5543CD9FC
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:51:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BEC46100099D
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:50:44 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 558C41F74B;
 Tue, 28 Nov 2023 11:50:43 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FB68133B5;
 Tue, 28 Nov 2023 11:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id RvsRDhPUZWVefgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 11:50:43 +0000
Date: Tue, 28 Nov 2023 12:50:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Geetika <geetika@linux.ibm.com>
Message-ID: <20231128115041.GB369141@pevik>
References: <20231003133703.98552-1-geetika@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231003133703.98552-1-geetika@linux.ibm.com>
X-Spamd-Bar: +++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Rspamd-Queue-Id: 558C41F74B
X-Spamd-Result: default: False [11.76 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_SPAM_SHORT(2.57)[0.857]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_NOT_FQDN(0.50)[]; ARC_NA(0.00)[];
 R_SPF_SOFTFAIL(4.60)[~all]; DMARC_NA(1.20)[suse.cz];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; NEURAL_SPAM_LONG(3.50)[1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH] Migrating the
 libhugetlbfs/testcases/straddle_4GB.c
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

Hi Geetika,

Please have look at my comments at your previous patch [1] [2], these changes
apply a lot for your patches as well.

[1] https://lore.kernel.org/ltp/20231128111024.GA364870@pevik/
[2] https://lore.kernel.org/ltp/20231128112254.GA367506@pevik/


> Test Description:
> This test tries to allocate hugepages to cover a memory range
> that straddles the 4GB boundary.

> Signed-off-by: Geetika <geetika@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap40.c  | 145 ++++++++++++++++++
>  testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  42 +++++
>  4 files changed, 189 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c

> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..da37dc815 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>  hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
> +hugemmap40 hugemmap40
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 7258489ed..dd1858a4a 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -34,6 +34,7 @@
>  /hugetlb/hugemmap/hugemmap30
>  /hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugemmap/hugemmap32
> +/hugetlb/hugemmap/hugemmap40
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c
> new file mode 100644
> index 000000000..1ba070831
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Copyright (C) 2006 Hugh Dickins <hugh@veritas.com>
> + */
> +
> +/*\
> + * [Description]
> + * This test tries to allocate hugepages to cover a memory range
> + * that straddles the 4GB boundary.
> + * Scenario 1 : mmap without MAP_FIXED
> + * Scenario 2 : mmap with MAP_FIXED
This will be badly formatted (it will not be list, but inline).

How about:

/*\
 * [Description]
 *
 * Test tries to allocate hugepages to cover a memory range that straddles the
 * 4GB boundary, using mmap(2) with and without MAP_FIXED.
 */
> + */
> +
> +#define MAPS_BUF_SZ 4096
> +#define FOURGB (1UL << 32)
> +#define MNTPOINT "hugetlbfs/"
> +#define HUGETLBFS_MAGIC	0x958458f6

Could you please add this magic definition to include/tst_fs.h
(as a separate patch), we store all magic there.

> +#define _LARGEFILE64_SOURCE /* Need this for statfs64 */
We would probably define it in Makefile

hugemmap40: CFLAGS += -D_LARGEFILE64_SOURCE

> +
> +#include "hugetlb.h"
> +
> +static long hpage_size;
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
> +	if (ret == 0) {
> +		tst_res(TINFO, "Couldn't find address %p in /proc/self/maps\n", p);
Please remove "\n", it's already added in tst_res().
> +		return -1;
> +	}
> +	/* looks like a filename? */
> +	if (name[0] != '/')
> +		return 0;
> +
> +	/* Truncate the filename portion */
> +
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
> +		}
> +		if (test_addr_huge(p + hpage_size) != 1) {
> +			tst_brk(TFAIL, "2nd Mapped address is not hugepage");
> +			goto windup;
> +		}
> +		memset(p, 0, hpage_size);
> +		memset(p + hpage_size, 0, hpage_size);
> +		tst_res(TPASS, "Mapping without MAP_FIXED at %lx... completed", straddle_addr);
> +	} else {
> +		tst_res(TINFO, "Got %p instead, never mind, let's move to mapping with MAP_FIXED\n", p);
> +		munmap(p, 2*hpage_size);
> +	}
> +	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
Maybe use .tcnt = 2, in struct tst_test and separate these 2 cases into it's
wonf functions?

You would either use:
static void run_test(unsigned int n)

With that you would reduce code duplicity and make test function smaller.

Also, sometimes we use test struct (pointer to the function and description, see
e.g. testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c).

...
> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
Maybe add this change as a separate commit?

Kind regards,
Petr

> @@ -130,3 +130,45 @@ int do_readback(void *p, size_t size, char *desc)
>  	}
>  	return 0;
>  }
> +
> +#define MAPS_BUF_SZ 4096
> +int read_maps(unsigned long addr, char *buf)
> +{
> +        FILE *f;
> +        char line[MAPS_BUF_SZ];
> +        char *tmp;
> +
> +        f = fopen("/proc/self/maps", "r");
> +        if (!f) {
> +                tst_res(TFAIL, "Failed to open /proc/self/maps: %s\n", strerror(errno));
> +                return -1;
> +        }
> +
> +        while (1) {
> +                unsigned long start, end, off, ino;
> +                int ret;
> +
> +                tmp = fgets(line, MAPS_BUF_SZ, f);
> +                if (!tmp)
> +                        break;
> +
> +                buf[0] = '\0';
> +                ret = sscanf(line, "%lx-%lx %*s %lx %*s %ld %255s",
> +                             &start, &end, &off, &ino,
> +                             buf);
> +                if ((ret < 4) || (ret > 5)) {
> +                        tst_res(TFAIL, "Couldn't parse /proc/self/maps line: %s\n",
> +                                        line);
> +                        fclose(f);
> +                        return -1;
> +                }
> +
> +                if ((start <= addr) && (addr < end)) {
> +                        fclose(f);
> +                        return 1;
> +                }
> +        }
> +
> +        fclose(f);
> +        return 0;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
