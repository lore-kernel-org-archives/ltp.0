Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9B7C61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:48:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 256E33D2321
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:48:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D68F3CB52D
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:48:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 970A4600A6F
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:48:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC11622018;
 Fri, 28 Aug 2026 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787910482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqDr6yGbyLfv2XkHfx7PkH2+JEdYAo5GBNPFdiwg7n0=;
 b=jq9r5legep+MHke/dTaba3PXg5c9xZ2uqXsiRQlnBYAPLynlEMiYELv1OjTxNdaFGPQaOz
 lAcefTP5kmPcLUhgptWp3pq9+dMBwEnTUxym3+AYtIO3Rkbp9RcVg+xmLJAJxWr4g4wFce
 aT/oGOQJExV9HJ6iuvFWSBGEEm55OWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787910482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqDr6yGbyLfv2XkHfx7PkH2+JEdYAo5GBNPFdiwg7n0=;
 b=L9oKDcOCYkIjs9Vtjg/wNTWq+xCBDl4t7iAkMMrTaSlAvUWeSVAQOTldc3LQe4fdTGJTgC
 GfDx+pw2c9eQp5CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787910477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqDr6yGbyLfv2XkHfx7PkH2+JEdYAo5GBNPFdiwg7n0=;
 b=szlYn9DOqkVrHYdpA0+EKroSwGJr5CH8fQBIijCWdNkkWprNjokF1Tk0clVfCVkBtq4erv
 ePFigDue5SX2RQyQwJiO5xY99jFAxZtBlB/1P7e4G271eljAHvTSBkbb6VF2jUR47AJOrF
 OT/6YQ6sxaZ4lVuOq4oOo9CLPX23W80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787910477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqDr6yGbyLfv2XkHfx7PkH2+JEdYAo5GBNPFdiwg7n0=;
 b=zBZXmujLCessmgSlc4lvPMusAuHt73fcQL7R9n3CSkcqn/VABTTXI4KShzoVquxSAO/nGn
 yoqZCERDunT1A4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FC9613674;
 Fri, 28 Aug 2026 09:47:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 46X8Jk1ZkWpVDQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Aug 2026 09:47:57 +0000
Date: Fri, 28 Aug 2026 11:48:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <apFZVNffUt7v9t5V@yuki.lan>
References: <20260809174900.1847247-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260809174900.1847247-1-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] hugetlb/hugemmap: add hugemmap33 to test
 hugetlbfs quota accounting
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

Hi!
> +static void verify_quota_stat(long tot, long free, long avail)
> +{
> +	struct statfs s;
> +
> +	SAFE_STATFS(MNTPOINT, &s);
> +
> +	if ((long)s.f_blocks != tot || (long)s.f_bfree != free || (long)s.f_bavail != avail) {
> +		tst_res(TFAIL, "Bad quota counters: total=%li free=%li avail=%li, expected %li %li %li",
> +			(long)s.f_blocks, (long)s.f_bfree, (long)s.f_bavail,
> +			tot, free, avail);
> +		return;
> +	}
> +	tst_res(TPASS, "Quota counters are correct: total=%li free=%li avail=%li",
> +		tot, free, avail);
> +}
> +
> +static void do_map(unsigned long size, int mmap_flags, int action_flags,
> +		   int expected)
> +{
> +	int fd;
> +	char *a = MAP_FAILED, *b, *c = MAP_FAILED;
> +	char path[PATH_MAX];
> +
> +	snprintf(path, sizeof(path), "%s/test_file_%d", MNTPOINT, getpid());
> +	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
> +	SAFE_UNLINK(path);
> +
> +	TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0));
> +	a = TST_RET_PTR;
> +	if (a == MAP_FAILED) {
> +		if (expected == QUOTA_FAIL && TST_ERR == ENOMEM) {
> +			tst_res(TPASS | TERRNO, "mmap failed as expected due to quota");
> +			SAFE_CLOSE(fd);
> +			return;
> +		}
> +		tst_res(TFAIL | TERRNO, "mmap failed unexpectedly");
> +		SAFE_CLOSE(fd);
> +		return;
> +	}
> +
> +	if (expected == QUOTA_FAIL) {
> +		tst_res(TFAIL, "mmap succeeded but quota exhaustion was expected");
> +		goto cleanup_a;
> +	}
> +
> +	if (action_flags & ACTION_TOUCH) {
> +		for (b = a; b < a + size; b += hpage_size)
> +			*b = 1;
> +	}
> +
> +	if (action_flags & ACTION_COW) {
> +		TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0));
> +		c = TST_RET_PTR;
> +		if (c == MAP_FAILED) {
> +			if (expected == QUOTA_COW_FAIL && TST_ERR == ENOMEM) {
> +				tst_res(TPASS | TERRNO, "COW mmap failed as expected due to quota");
> +				goto cleanup_a;
> +			}
> +			tst_res(TFAIL | TERRNO, "COW mmap failed unexpectedly");
> +			goto cleanup_a;
> +		}
> +
> +		if (expected == QUOTA_COW_FAIL) {
> +			tst_res(TFAIL, "COW mmap succeeded but quota exhaustion was expected");
> +			goto cleanup_c;
> +		}
> +
> +		if (*c != 1) {
> +			tst_res(TFAIL, "Data mismatch when setting up COW");
> +			goto cleanup_c;
> +		}
> +		*c = 0;
> +		SAFE_MUNMAP(c, size);
> +	}
> +
> +	if (expected == QUOTA_OK)
> +		tst_res(TPASS, "Quota test passed as expected");
> +
> +	SAFE_MUNMAP(a, size);
> +	SAFE_CLOSE(fd);
> +	return;
> +
> +cleanup_c:
> +	SAFE_MUNMAP(c, size);
> +cleanup_a:
> +	SAFE_MUNMAP(a, size);
> +	SAFE_CLOSE(fd);
> +}

I think that it would be much more readable if this was split into
several functions. It would make sense to split this into three
different functions one function verify_quota_ok() verify_quota_fail()
and verify_quota_cow_fail().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
