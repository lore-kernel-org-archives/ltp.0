Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F23CC433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 14:09:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545C6610CE
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 14:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 545C6610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD70D3C9158
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 16:09:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A50C3C21FF
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 16:09:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03CD22010EF
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 16:09:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D16992237D;
 Thu,  9 Sep 2021 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631196540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVgg4LMKZ1TqZcRS9uEUk7J69HBHQRNOk0kq7JFfIJI=;
 b=BevOpdN2H1CvQBTQMCiQ+fOnf5ZkYDF1Kl379EfJIWmS8xr7bqczJmV/fuNUNnw2JL7hEA
 nag5amoHY8MR+SZGnpLLDEml8vyJTWQqbtzITerIQvpB03Eq9nJ2IDcdnv6iLqhtXd2N3R
 Nejr1bNgiIOtVJJaTc6JyRuzXH0cq9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631196540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVgg4LMKZ1TqZcRS9uEUk7J69HBHQRNOk0kq7JFfIJI=;
 b=TVP0ycXlo9I8mmaHWIdcMrjz2nuAc+Pj8q8ZdOtzHEQAbTIMXvX6DLwdThQYvQFQpTOWxK
 FPSGxTcSnyc0dtCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B91E113C53;
 Thu,  9 Sep 2021 14:09:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KiWXLXwVOmFILQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 09 Sep 2021 14:09:00 +0000
Date: Thu, 9 Sep 2021 16:09:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YToVi5LHQa7z6CEm@yuki>
References: <878s0ikl6d.fsf@suse.de>
 <20210831114406.8527-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210831114406.8527-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/irq: Add irqbalance01
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
Cc: nhorman@gmail.com, Thomas Gleixner <tglx@linutronix.de>, anton@deadbeef.mx,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210909140915.RgAz9zCNs4kDttcOahCcU0y4bhctdZL3irs5eWd9W4Q@z>

Hi!
> +static void collect_irq_info(void)
> +{
> +	char *buf = NULL, *c, *first_row;
> +	char path[PATH_MAX];
> +	size_t size = 1024;
> +	size_t ret, row, col;
> +	long acc;
> +	unsigned int cpu_total, mask_pos;
> +	int fd = SAFE_OPEN("/proc/interrupts", O_RDONLY);
> +
> +	nr_cpus = 0;
> +	nr_irqs = 0;
> +
> +	do {
> +		size *= 2;
> +		buf = SAFE_REALLOC(buf, size);
> +		SAFE_LSEEK(fd, 0, SEEK_SET);
> +		ret = SAFE_READ(0, fd, buf, size - 1);
> +	} while (ret >= size - 1);

And actually this does not seem to work as expected for me, it reads
about half of the table, stops shortly before 4096. I guess that we
cannot really read it in one read() like this and that we are supposed
to read it one $PAGE_SIZE at a time instead. So we need a loop that
increases by $PAGE_SIZE and we would pass buf+len to the read, until the
read returns bytes read.

> +	SAFE_CLOSE(fd);
> +
> +	if (ret < 1)
> +		tst_brk(TBROK, "Empty /proc/interrupts?");
> +
> +	buf[ret] = '\0';
> +
> +	/* Count CPUs, header columns are like /CPU[0-9]+/ */
> +	for (c = buf; *c != '\0' && *c != '\n'; c++) {
> +		if (!strncmp(c, "CPU", 3))
> +			nr_cpus++;
> +	}
> +
> +	c++;
> +	first_row = c;
> +	/* Count IRQs, real IRQs start with /[0-9]+:/ */
> +	while (*c != '\0') {
> +		switch (*c) {
> +		case ' ':
> +		case '\t':
> +		case '\n':
> +		case '0' ... '9':
> +			c++;
> +			break;
> +		case ':':
> +			nr_irqs++;
> +			/* fall-through */
> +		default:
> +			while (*c != '\n' && *c != '\0')
> +				c++;
> +		}
> +	}
> +
> +	tst_res(TINFO, "Found %u CPUS, %u IRQs", nr_cpus, nr_irqs);
> +
> +	irq_ids = SAFE_REALLOC(irq_ids, nr_irqs * sizeof(*irq_ids));
> +	irq_stats = SAFE_REALLOC(irq_stats, nr_cpus * (nr_irqs + 1) * sizeof(*irq_stats));
> +	irq_affinity = SAFE_REALLOC(irq_affinity, nr_cpus * nr_irqs * sizeof(*irq_affinity));
> +
> +	c = first_row;
> +	acc = -1;
> +	row = col = 0;
> +	/* Parse columns containing IRQ counts and IRQ IDs into acc. Ignore everything else. */
> +	while (*c != '\0') {
> +		switch (*c) {
> +		case ' ':
> +		case '\t':
> +			if (acc >= 0) {
> +				irq_stats[row * nr_cpus + col] = acc;
> +				acc = -1;
> +				col++;
> +			}
> +			break;
> +		case '\n':
> +			col = 0;
> +			row++;
> +			break;
> +		case '0' ... '9':
> +			if (acc == -1)
> +				acc = 0;
> +
> +			acc *= 10;
> +			acc += *c - '0';
> +			break;
> +		case ':':
> +			irq_ids[row] = acc;
> +			acc = -1;
> +			break;
> +		default:
> +			acc = -1;
> +			while (*c != '\n' && *c != '\0')
> +				c++;
> +			continue;
> +		}
> +
> +		c++;
> +	}
> +
> +	for (col = 0; col < nr_cpus; col++) {
> +		cpu_total = 0;
> +
> +		for (row = 0; row < nr_irqs; row++)
> +			cpu_total += irq_stats[row * nr_cpus + col];
> +
> +		irq_stats[row * nr_cpus + col] = cpu_total;
> +	}
> +
> +	/* Read the CPU affinity masks for each IRQ. See bitmap_string() in the kernel (%*pb) */
> +	for (row = 0; row < nr_irqs; row++) {
> +		sprintf(path, "/proc/irq/%u/smp_affinity", irq_ids[row]);
> +		ret = SAFE_FILE_READAT(0, path, buf, size);
> +		if (ret < 1)
> +			tst_brk(TBROK, "Empty /proc/irq/%u/smp_affinity?", irq_ids[row]);
> +		c = buf;
> +		col = 0;
> +
> +		while (*c != '\0') {
> +			switch (*c) {
> +			case '\n':
> +			case ' ':
> +			case ',':
> +				c++;
> +				continue;
> +			case '0' ... '9':
> +				acc = *c - '0';
> +				break;
> +			case 'a' ... 'f':
> +				acc = 10 + *c - 'a';
> +				break;
> +			default:
> +				tst_res(TINFO, "%u/smp_affnity: %s", irq_ids[row], buf);
> +				tst_brk(TBROK, "Wasn't expecting 0x%02x", *c);
> +			}
> +
> +			for (mask_pos = 0; mask_pos < 4; mask_pos++) {
> +				if (mask_pos + col >= nr_cpus)
> +					break;
> +
> +				irq_affinity[row * nr_cpus + (nr_cpus - 1 - col - mask_pos)] =
> +					(acc & (8 >> mask_pos)) ? ALLOW : DENY;
> +			}
> +
> +			col += mask_pos;
> +			c++;
> +		}
> +	}

Actually having a closer look this whole parsing looks wrong and the
reason why it does not work for me is that my machine has nr_cpus that
is not power of two i.e. 12 in this case and the size of the mask seems
to be rounded to 32 bits when presented in the proc files. I would have
expected that the kernel would choose the closest power of two i.e. 16,
but that does not seem to be the case here.

I guess that it would be actually easier to read the whole affinity into
a string and then parse it from the end instead.

> +	free(buf);
> +}
> +
> +static void print_irq_info(void)
> +{
> +	size_t row, col;
> +	unsigned int count;
> +	enum affinity aff;
> +
> +	for (row = 0; row < nr_irqs; row++) {
> +		tst_printf("%5u:", irq_ids[row]);
> +
> +		for (col = 0; col < nr_cpus; col++) {
> +			count = irq_stats[row * nr_cpus + col];
> +			aff = irq_affinity[row * nr_cpus + col] == ALLOW ? '+' : '-';
> +
> +			tst_printf("%10u%c", count, aff);
> +		}
> +
> +		tst_printf("\n");
> +	}
> +
> +	tst_printf("Total:");
> +
> +	for (col = 0; col < nr_cpus; col++)
> +		tst_printf("%11u", irq_stats[row * nr_cpus + col]);
> +
> +	tst_printf("\n");
> +}
> +
> +static void evidence_of_change(void)
> +{
> +	size_t row, col, changed = 0;
> +
> +	for (row = 0; row < nr_irqs; row++) {
> +		for (col = 0; col < nr_cpus; col++) {
> +			if (!irq_stats[row * nr_cpus + col])
> +				continue;
> +
> +			if (irq_affinity[row * nr_cpus + col] == ALLOW)
> +				continue;
> +
> +			changed++;
> +		}
> +	}
> +
> +	tst_res(changed ? TPASS : TFAIL,
> +		"Heuristic: Detected %zu irq-cpu pairs have been dissallowed",
> +		changed);
> +}
> +
> +static void setup(void)
> +{
> +	collect_irq_info();
> +	print_irq_info();
> +
> +	if (nr_cpus < 1)
> +		tst_brk(TBROK, "No CPUs found in /proc/interrupts?");
> +
> +	if (nr_irqs < 1)
> +		tst_brk(TBROK, "No IRQs found in /proc/interrupts?");
> +}
> +
> +static void run(void)
> +{
> +	collect_irq_info();
> +
> +	evidence_of_change();
> +}
> +
> +static void cleanup(void)
> +{
> +	if (irq_ids)
> +		free(irq_ids);
> +	if (irq_stats)
> +		free(irq_stats);
> +	if (irq_affinity)
> +		free(irq_affinity);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_cpus = 2,
> +};
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
