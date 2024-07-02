Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56FAC3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 13:57:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 473033D3EDE
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 15:57:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0CA63CCE0D
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:57:43 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 11D1A204B65
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:57:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 022CA21B04;
 Tue,  2 Jul 2024 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719928660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RunkkfgwXbeDF4EBts3wzN5M7oSQ5NOnWBhWEa4bY/0=;
 b=l2Ma/boKf18Ujz1vg442nBidPdEI+bph/4o7/7CIwbahOwlX99upaxhKqSgrhoUDMTdjEG
 YqjQR9OLHZE8n2L5NL2Vl6VMaZZTcnoDJnBEz5vF3ziXe2zOthpxWMFfPBRrECofGPnbe/
 jiHPxq3MZaWuOpOKI21i3S0C8x+JuZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719928660;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RunkkfgwXbeDF4EBts3wzN5M7oSQ5NOnWBhWEa4bY/0=;
 b=igqyiT6ctrAUv/OG/MJKfWQhfrA+J+dF3fp/fCQHml8QN/pBwJ6GfsvpG7NLAkJ/cG2F98
 f3QFvEbMm4jPcRAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719928660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RunkkfgwXbeDF4EBts3wzN5M7oSQ5NOnWBhWEa4bY/0=;
 b=l2Ma/boKf18Ujz1vg442nBidPdEI+bph/4o7/7CIwbahOwlX99upaxhKqSgrhoUDMTdjEG
 YqjQR9OLHZE8n2L5NL2Vl6VMaZZTcnoDJnBEz5vF3ziXe2zOthpxWMFfPBRrECofGPnbe/
 jiHPxq3MZaWuOpOKI21i3S0C8x+JuZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719928660;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RunkkfgwXbeDF4EBts3wzN5M7oSQ5NOnWBhWEa4bY/0=;
 b=igqyiT6ctrAUv/OG/MJKfWQhfrA+J+dF3fp/fCQHml8QN/pBwJ6GfsvpG7NLAkJ/cG2F98
 f3QFvEbMm4jPcRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7D8213A9A;
 Tue,  2 Jul 2024 13:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BKCkN1MHhGYBCgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 02 Jul 2024 13:57:39 +0000
Date: Tue, 2 Jul 2024 15:57:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZoQHSwgeD--VPnAQ@yuki>
References: <20240702-unlink09-v4-0-d8df24772a76@suse.com>
 <20240702-unlink09-v4-1-d8df24772a76@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240702-unlink09-v4-1-d8df24772a76@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] Fix unlink09 test
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
> +static void setup_inode_flag(const int fd, const int flag, const int reset)

I find it a bit strange when we pass reset flag, since I would expect
that if we pass non-zero to this function the flag would be set not
reset.

If you are find with it I will change the reset flag in to set flag and
reverse the logic before pushing the changes...

> +{
> +	int attr;
> +
> +	SAFE_IOCTL(fd, FS_IOC_GETFLAGS, &attr);
> +
> +	if (reset)
> +		attr &= ~flag;
> +	else
> +		attr |= flag;
> +
> +	SAFE_IOCTL(fd, FS_IOC_SETFLAGS, &attr);
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
