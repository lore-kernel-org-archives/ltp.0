Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F559C25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 13:21:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAE923D098F
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 15:21:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E269A3D0988
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 15:21:40 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B7E62600702
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 15:21:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDD011F80B;
 Wed,  5 Jun 2024 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717593695;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIsBkj5J0nXb8BVrMkh5Wmdv+BBKyNi9LNGwpZLtIKc=;
 b=PXlymoUrd9Bqs55d2dW6T/QveGm5JJ8b3cAKIP+zR/yKCh/ItE1HO2lAJTZiyP2nwa6ST1
 4twaypLwQjg1FuHp22sgpo5lHAW9PBByqtG5l86LrzuxfpLiqHIFnbiVoyeQmtl64FzuEl
 fezQaeHtbQZZFbERtO42xFwql4y/xFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717593695;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIsBkj5J0nXb8BVrMkh5Wmdv+BBKyNi9LNGwpZLtIKc=;
 b=65Hhqj2oHPz5A6ss6MRBWMdXnHklUKqBIZKEYEe4Q6RpRKxwvxEmhdIV97Nu3/SLGAXX0v
 JvhU19Lfzn42xFCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717593695;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIsBkj5J0nXb8BVrMkh5Wmdv+BBKyNi9LNGwpZLtIKc=;
 b=PXlymoUrd9Bqs55d2dW6T/QveGm5JJ8b3cAKIP+zR/yKCh/ItE1HO2lAJTZiyP2nwa6ST1
 4twaypLwQjg1FuHp22sgpo5lHAW9PBByqtG5l86LrzuxfpLiqHIFnbiVoyeQmtl64FzuEl
 fezQaeHtbQZZFbERtO42xFwql4y/xFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717593695;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIsBkj5J0nXb8BVrMkh5Wmdv+BBKyNi9LNGwpZLtIKc=;
 b=65Hhqj2oHPz5A6ss6MRBWMdXnHklUKqBIZKEYEe4Q6RpRKxwvxEmhdIV97Nu3/SLGAXX0v
 JvhU19Lfzn42xFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CBC413AA1;
 Wed,  5 Jun 2024 13:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DVaFIF9mYGaoHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jun 2024 13:21:35 +0000
Date: Wed, 5 Jun 2024 15:21:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240605132134.GA393734@pevik>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <20240605065755.GB348321@pevik> <20240605073806.GA355314@pevik>
 <8aef8014-e4ea-407d-9b88-423449612665@suse.cz>
 <20240605121142.GA387399@pevik> <20240605122741.GB387399@pevik>
 <ad6558e0-e834-4b35-923a-7b519384f436@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad6558e0-e834-4b35-923a-7b519384f436@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Cc: Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 05. 06. 24 14:27, Petr Vorel wrote:
> > Hi Martin,

> > Also I wonder if having functionality for .all_filesystems + .needs_rofs
> > wouldn't be useful. @Cyril @Martin WDYT?

> > Also, there is fallback when prepare_and_mount_ro_fs() fails to use block
> > device. Although, I don't see the read only mount flags added in this fallback,
> > IMHO MS_RDONLY is only in prepare_and_mount_ro_fs(), therefore the fallback is
> > read write and we even didn't get TWARN, just plain TINFO (it should be either
> > TWARN or TINFO with "WARNING:" at least).

> It would be useful and prepare_device() implements everything that's needed
> for it but there's a bug in do_setup() which creates a conflict between the
> two attributes. The .all_filesystems attribute forces .needs_device but a
> few lines below that is a check that .needs_rofs and .needs_device are not
> set at the same time. This can be fixed.

Thanks for info, I'll have look into it.

Anyway, you all agreed that splitting the test is needed either way.
And because of other thing Martin found (the third unfixed SAFE_OPEN() in
verify_unlink()) I'm setting this as changes requested.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
