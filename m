Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D767E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 09:42:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03DFD3C2165
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 10:42:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6226C3C189A
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 10:42:39 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BDE561401627
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 10:42:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 53F5E210E4;
 Thu,  9 Jan 2025 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736415757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fB2L/LF/WubY3DvvvcYVLlVt1zOCyqeehNS4ccE6aSM=;
 b=1aO2PWqXxCidQ7qnsftyVF2ZZsk2BYNRByqaxy/9ns4RbDZiIDn1t6XDIfzdcxGOEqknYc
 M0qlLXl4naOXhvOtJh4niVaPp+UBp1tE5bSg0ZX6OZD3bOpCx2Uac64OacAO+be7fPps0C
 CsFflBYRedcEYIrYK7c1M7Y3Ynx3dG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736415757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fB2L/LF/WubY3DvvvcYVLlVt1zOCyqeehNS4ccE6aSM=;
 b=z5qn7TaQf1+FWc4M8YDCNNpmKz0kxC5JtwWHzcTgZaAThJIvEp8TqH/irOwQAaBFbV37S9
 Ub+RooZOXTqPW6Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736415757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fB2L/LF/WubY3DvvvcYVLlVt1zOCyqeehNS4ccE6aSM=;
 b=1aO2PWqXxCidQ7qnsftyVF2ZZsk2BYNRByqaxy/9ns4RbDZiIDn1t6XDIfzdcxGOEqknYc
 M0qlLXl4naOXhvOtJh4niVaPp+UBp1tE5bSg0ZX6OZD3bOpCx2Uac64OacAO+be7fPps0C
 CsFflBYRedcEYIrYK7c1M7Y3Ynx3dG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736415757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fB2L/LF/WubY3DvvvcYVLlVt1zOCyqeehNS4ccE6aSM=;
 b=z5qn7TaQf1+FWc4M8YDCNNpmKz0kxC5JtwWHzcTgZaAThJIvEp8TqH/irOwQAaBFbV37S9
 Ub+RooZOXTqPW6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D89013876;
 Thu,  9 Jan 2025 09:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PrxnBQ2af2fnAgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jan 2025 09:42:37 +0000
Date: Thu, 9 Jan 2025 10:42:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20250109094235.GA184406@pevik>
References: <20241219065700.3153237-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241219065700.3153237-1-maxj.fnst@fujitsu.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] set_tid_address01: refactor with new LTP API
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

Hi Ma Xinjian, Avinesh,

...
> +	TEST(tst_syscall(__NR_set_tid_address, &newtid));
> +	if (TST_RET == getpid())
> +		tst_res(TPASS, "set_tid_address call succeeded: as expected %ld", TST_RET);
> +	else
> +		tst_res(TFAIL | TTERRNO, "set_tid_address call failed: expected %d, but got %ld", getpid(), TST_RET);

I wanted to replace this with:

TST_EXP_EQ_LI(tst_syscall(__NR_set_tid_address, &newtid), getpid());

But that TST_EXP_EQ_LI() not use TTERRNO.

Maybe use this?

	TST_EXP_PID(tst_syscall(__NR_set_tid_address, &newtid));
	TST_EXP_EQ_LI(TST_RET, getpid());

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
