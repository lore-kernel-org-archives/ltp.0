Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B772C5DF97
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 15:24:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 740263CC8C1
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 17:24:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 370FB3C0032
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 17:23:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9AF6D10008F4
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 17:23:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1F801F821;
 Wed, 26 Aug 2026 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787757818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VmCBq95C+hO3eVCDo2YS781bOFlXSWTVEa+OhPmvags=;
 b=IfOxZxPISMSTvD4kG5BMxnNualjXIjd8xevbJSQS2akZfBYP4U+/MZwTOpw4UGA+n5AuY+
 PjC14Gi2Kta+RwrgoA64Wko8wZZ7U+Q45R1489vu5GPR5BEglxgiU9AAiq0SdeXWDtirQz
 harpDt65a3FM7sBqXnuW3hMKmPfgDvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787757818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VmCBq95C+hO3eVCDo2YS781bOFlXSWTVEa+OhPmvags=;
 b=ItTV+DvVkDr9vuSCJQtmiVOJDp2Nu8kwGZtJGg2X+KRxLMT4OmMuToNzjC2eVrs0pjmT9Z
 Cy+zN2IPYFqi/yBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787757813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VmCBq95C+hO3eVCDo2YS781bOFlXSWTVEa+OhPmvags=;
 b=Dh6VNoLQAM2e31B0uKgLRQfOuNIv5B1jmlUR97wbmVX2iVhfrezgM09hMSGfyDAYLIspkX
 FEvuISIfl+iz8L1QyD/2s1DEse3MJV6fpoG4z2IAH2bM4wKtdM1v4GkhAM8mM+XWyoVW9/
 TRFGY4LAKyYdTr0cMuqNiXFz303gOdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787757813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VmCBq95C+hO3eVCDo2YS781bOFlXSWTVEa+OhPmvags=;
 b=Upcve5stcK1YD7uExn+idq2wyXiBj8Ivy6AkFDNr0dMJAD8Y0kqrQEinD+zife8ISUa/3b
 +OB12NN9q5tpA+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B29821361C;
 Wed, 26 Aug 2026 15:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dT5pKvUEj2rJWgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 26 Aug 2026 15:23:33 +0000
Date: Wed, 26 Aug 2026 17:23:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ao8E9xmRqH35vJrz@yuki.lan>
References: <20260826-convert_fallocate_suite-v3-0-1286ede0493d@suse.com>
 <20260826-convert_fallocate_suite-v3-1-1286ede0493d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260826-convert_fallocate_suite-v3-1-1286ede0493d@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] fallocate01: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> -void populate_files(int fd)
> -{
> -	char buf[buf_size + 1];
> -	int index;
> -	int blocks;
> -	int data;
> +	TEST(fallocate(fd, 0, 0, block_size));
> +	if (TST_RET != 0) {
> +		if (TST_ERR == EOPNOTSUPP || TST_ERR == ENOSYS)
> +			tst_brk(TCONF, "fallocate() not supported");

Sigh, looks like we need separate checks for fallocate() with and
without FALLOC_FL_KEEP_SIZE:

tst_test.c:1986: TINFO: === Testing on exfat ===
tst_test.c:1291: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
tst_test.c:1303: TINFO: Mounting /dev/loop0 to /tmp/LTP_falpgaoah/mntpoint fstyp=exfat flags=0
fallocate01.c:92: TPASS: fallocate(DEFAULT_MODE, 393216, 32768) passed
fallocate01.c:97: TPASS: file_stat.st_size == expected_size (425984)
fallocate01.c:101: TPASS: pos == offset + write_offset (409600)
fallocate01.c:103: TPASS: write into the newly allocated region returned 1
fallocate01.c:92: TFAIL: fallocate(FALLOC_FL_KEEP_SIZE, 393216, 32768) failed: EOPNOTSUPP (95)
fallocate01.c:97: TPASS: file_stat.st_size == expected_size (393216)
fallocate01.c:101: TPASS: pos == offset + write_offset (409600)
fallocate01.c:103: TPASS: write into the newly allocated region returned 1


I guess that the easiest solution is to use
TST_EXP_PASS_OR_FAIL(..., EOPNOTSUPP, ...) in the run() function
instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
