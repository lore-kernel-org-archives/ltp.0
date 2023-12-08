Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F422BC4167B
	for <ltp@archiver.kernel.org>; Fri,  8 Dec 2023 16:02:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FC073CF980
	for <ltp@archiver.kernel.org>; Fri,  8 Dec 2023 17:02:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC9E63CB9D4
 for <ltp@lists.linux.it>; Fri,  8 Dec 2023 17:02:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A5C001000D23
 for <ltp@lists.linux.it>; Fri,  8 Dec 2023 17:02:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 64ED421C85;
 Fri,  8 Dec 2023 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702051328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KHikjFSWCPmHcvGBUvAvrcgxQ26GofhlKblZtHqS6ho=;
 b=ek7e1GDZuHkmzlqhisQA3pw7dyt7IPodmP6XFuUlP8LRAMe0FweyQGTjcUj69lhQSaCdV3
 HoLKOaiUxU+vmK+rrAYSHr0CsZHUThExyLhX7cA9nMIx97OxwMfS+Bag/DohQ2PwnvaiV7
 cwCTxJo9yzG40NGihK4qL6SEAVBoXn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702051328;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KHikjFSWCPmHcvGBUvAvrcgxQ26GofhlKblZtHqS6ho=;
 b=SugbpGUkRUOlR0kPdZ7kKcFPYZDnwYn4YtMO3Cx8bxbz9ODBqFVd+4IQufwDTADUFo+0vk
 TPDhRvKOMv/lgWAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702051328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KHikjFSWCPmHcvGBUvAvrcgxQ26GofhlKblZtHqS6ho=;
 b=ek7e1GDZuHkmzlqhisQA3pw7dyt7IPodmP6XFuUlP8LRAMe0FweyQGTjcUj69lhQSaCdV3
 HoLKOaiUxU+vmK+rrAYSHr0CsZHUThExyLhX7cA9nMIx97OxwMfS+Bag/DohQ2PwnvaiV7
 cwCTxJo9yzG40NGihK4qL6SEAVBoXn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702051328;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KHikjFSWCPmHcvGBUvAvrcgxQ26GofhlKblZtHqS6ho=;
 b=SugbpGUkRUOlR0kPdZ7kKcFPYZDnwYn4YtMO3Cx8bxbz9ODBqFVd+4IQufwDTADUFo+0vk
 TPDhRvKOMv/lgWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53FA513335;
 Fri,  8 Dec 2023 16:02:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YSV7EwA+c2URBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 08 Dec 2023 16:02:08 +0000
Date: Fri, 8 Dec 2023 17:02:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZXM-KwDvvNOpm64O@yuki>
References: <20231011160822.578637-1-pvorel@suse.cz>
 <20231011160822.578637-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011160822.578637-4-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[27.49%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] libltpswap: TCONF on EPERM
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +		if (fibmap == 1) {
> +			if (errno == EINVAL)
> +				tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
> +			if (errno == EPERM)
> +				tst_brk(TCONF, "No permission for swapon() on %s", fstype);

I'm not sure if we actually need to print the filesystem type in the
case that we do not have a permission to do swapon.

Also this kind of works because the fibmap ioctl() fails as well,
however I guess that this should really be:

	if (errno == EPERM)
		tst_brk(TCONF, "Permission denied for swapon()");
	else if (fibmap == 1 && errno == EINVAL)
		tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
	else
		tst_brk(TFAIL | TTERNO, ...);

> +		} else {
>  			tst_brk(TFAIL | TTERRNO, "swapon on %s failed", fstype);
> +		}
>  	}
>  
>  	TEST(tst_syscall(__NR_swapoff, filename, 0));
> -- 
> 2.42.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
