Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810F7C48BC3
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 22:18:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6E4C3D13BE
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 23:18:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 838B83C8C9B
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 23:18:16 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7318220650D
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 23:18:14 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D6471F827;
 Mon, 19 Feb 2024 22:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708381093;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2SQqIPdZFF2eco3os/MmsVIW7y2W7brK7fQKsaaIvY=;
 b=wZtNarM3Uj+AmdgcduB/UUdHthsqXB0qIWw6vi4Q4+LXAPbfs4SY7WYa4zTifaGqBVZRah
 y5FN8lH1LbpoA8siL1qk4PUx2PiqAGvgQJfgJUkldWoSzu71EuRzeRVuF5UkiKeFJC6UoD
 KAwX2j6vzg/bXy5XCxsfVqY5jtc+8S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708381093;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2SQqIPdZFF2eco3os/MmsVIW7y2W7brK7fQKsaaIvY=;
 b=QDOkoq3dNcDe55dYUNPInIZyOZorEzQ7KX3w4yHQqIL+Iv0YuhTzKauHPgMMpVAYop3Add
 +1IheCHk7kkGWhAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708381093;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2SQqIPdZFF2eco3os/MmsVIW7y2W7brK7fQKsaaIvY=;
 b=wZtNarM3Uj+AmdgcduB/UUdHthsqXB0qIWw6vi4Q4+LXAPbfs4SY7WYa4zTifaGqBVZRah
 y5FN8lH1LbpoA8siL1qk4PUx2PiqAGvgQJfgJUkldWoSzu71EuRzeRVuF5UkiKeFJC6UoD
 KAwX2j6vzg/bXy5XCxsfVqY5jtc+8S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708381093;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2SQqIPdZFF2eco3os/MmsVIW7y2W7brK7fQKsaaIvY=;
 b=QDOkoq3dNcDe55dYUNPInIZyOZorEzQ7KX3w4yHQqIL+Iv0YuhTzKauHPgMMpVAYop3Add
 +1IheCHk7kkGWhAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 696AB13585;
 Mon, 19 Feb 2024 22:18:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 27/DGKXT02V+cAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 19 Feb 2024 22:18:13 +0000
Date: Mon, 19 Feb 2024 23:18:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Shirisha G <shirisha@linux.ibm.com>
Message-ID: <20240219221811.GC1067220@pevik>
References: <20231213084753.61762-1-shirisha@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213084753.61762-1-shirisha@linux.ibm.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.960]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[30.42%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add hugemmap41(Migrating the
 libhugetlbfs/testcases/slbpacaflush.c test)
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

Hi Shirisha,

> +void check_online_cpus(int online_cpus[], int nr_cpus_needed)
> +{
> +	char cpu_state, path_buf[64];
> +	int total_cpus, cpu_idx, fd, ret, i;
> +
> +	total_cpus = get_nprocs_conf();
> +	cpu_idx = 0;
> +
> +	if (get_nprocs() < nr_cpus_needed)
> +		tst_res(TFAIL, "Atleast online %d cpus are required", nr_cpus_needed);
s/Atleast/At least/
(or better: "minimum %d online cpus" ..., but I'm not a native speaker.)

Also test should exit when not enough online CPU, right? (it's a test
requirement not a subject of testing). Therefore tst_brk(TCONF, ...) should be
used instead of tst_res(TFAIL).

And shouldn't this be a setup function (i.e. run only once, before test starts -
test itself can be run more times, eg 3x with -i3).

> +
> +	for (i = 0; i < total_cpus && cpu_idx < nr_cpus_needed; i++) {
> +		errno = 0;
> +		sprintf(path_buf, SYSFS_CPU_ONLINE_FMT, i);
> +		fd = open(path_buf, O_RDONLY);
> +		if (fd < 0) {
> +			/* If 'online' is absent, the cpu cannot be offlined */
> +			if (errno == ENOENT) {
> +				online_cpus[cpu_idx] = i;
> +				cpu_idx++;
> +				continue;
> +			} else {
> +				tst_res(TFAIL, "Unable to open %s: %s", path_buf,
> +				     strerror(errno));
> +			}
> +		}
> +
> +		ret = read(fd, &cpu_state, 1);
> +		if (ret < 1)
> +			tst_res(TFAIL, "Unable to read %s: %s", path_buf,
> +			     strerror(errno));
> +
> +		if (cpu_state == '1') {
> +			online_cpus[cpu_idx] = i;
> +			cpu_idx++;
> +		}
> +
> +		if (fd >= 0)
> +			SAFE_CLOSE(fd);
> +	}
> +
> +	if (cpu_idx < nr_cpus_needed)
> +		tst_res(TFAIL, "Atleast %d online cpus were not found", nr_cpus_needed);
Also here tst_brk(TCONF, ...)
> +}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
