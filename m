Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF0DC87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 14:09:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1F383C4C99
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 16:09:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 017533C300C
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 16:09:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 21B48100040E
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 16:09:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 25F9B21236;
 Tue,  5 Aug 2025 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754402965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+KRYftAmqBkeDrb58V/aeKwHh0N2/Q3wsiLF5klzeE=;
 b=DDl79rQgTHj/38K+ZjWUvIRdxqaUwPhyMNmYIaq3tNiG2lBqMmtzwgHpgQndRJ/GLXBWEO
 WNbcdMryVADMioenbZYR67qoN26iGxbpdKn4bNh/aga2E9VYO2XJezQUnQRr+/Ks+TcE/D
 VPROdWdC4WhX58KCM8NNdwQmXuc57Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754402965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+KRYftAmqBkeDrb58V/aeKwHh0N2/Q3wsiLF5klzeE=;
 b=qXiIxFDVktJY259NlF2W5qW45kyL/iPEJCFfZ8tN41uW1rbFNRBdWWk4RpSpddkAAhNJbR
 1yJPskehOfWSMJAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754402965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+KRYftAmqBkeDrb58V/aeKwHh0N2/Q3wsiLF5klzeE=;
 b=DDl79rQgTHj/38K+ZjWUvIRdxqaUwPhyMNmYIaq3tNiG2lBqMmtzwgHpgQndRJ/GLXBWEO
 WNbcdMryVADMioenbZYR67qoN26iGxbpdKn4bNh/aga2E9VYO2XJezQUnQRr+/Ks+TcE/D
 VPROdWdC4WhX58KCM8NNdwQmXuc57Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754402965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+KRYftAmqBkeDrb58V/aeKwHh0N2/Q3wsiLF5klzeE=;
 b=qXiIxFDVktJY259NlF2W5qW45kyL/iPEJCFfZ8tN41uW1rbFNRBdWWk4RpSpddkAAhNJbR
 1yJPskehOfWSMJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11BCB13AA8;
 Tue,  5 Aug 2025 14:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fAkkA5UQkmiyKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Aug 2025 14:09:25 +0000
Date: Tue, 5 Aug 2025 16:10:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aJIQxfXgqjjwgnSg@yuki.lan>
References: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
 <20250805-file_setattr_getattr-v4-7-08e23354abc8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250805-file_setattr_getattr-v4-7-08e23354abc8@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 7/7] Add file_attr04 test
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
> +static void test_invalid_fd(struct tst_fd *fd)
> +{
> +	memset(attr, 0, sizeof(*attr));

We should properly skip the valid DIR fd with:

	if (fd->type == TST_FD_DIR) {
		tst_res(TCONF, "Skipping DIR fd");
		return;
	}

I suppose that you get ENOENT because the file attributes are not
supported on the filesystem on /tmp and that it may pass on xfs.

> +	if (tst_variant) {
> +		TST_EXP_FAIL_ARR(file_getattr(
> +			fd->fd, FILENAME,
> +			attr, FILE_ATTR_SIZE_LATEST,
> +			0), exp_errnos, ARRAY_SIZE(exp_errnos));
> +	} else {
> +		TST_EXP_FAIL_ARR(file_setattr(
> +			fd->fd, FILENAME,
> +			attr, FILE_ATTR_SIZE_LATEST,
> +			0), exp_errnos, ARRAY_SIZE(exp_errnos));
> +	}
> +}


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
