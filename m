Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26F5CCD199
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 13:15:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 812C43CEDE5
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 15:15:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B74533CEB66
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 15:14:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 181251000D21
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 15:14:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 726D51F8A8;
 Thu, 16 Oct 2025 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760620484;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7cvdhx60qnIzSoquw+4J4Ws9IlOK6ZImZ8Macxyig4=;
 b=h6LtBc9eYOOMtWPKcxH1ssDknz8NwaHWQRWYC+CjXaN35oEzEl7xYizgx6WWDY4Xwix+5w
 RtmP7SRyNBfDcY40HHmAZSHjpqb1im5CoOznxyFi9Nx1eIdH564rkWWayIdQdZvZr5MN42
 TnQ9K27z7Hw2N6pR9fJ423gSGWmfR8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760620484;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7cvdhx60qnIzSoquw+4J4Ws9IlOK6ZImZ8Macxyig4=;
 b=B53cWV2rAhamAI/yJ/mKMHPv6YbD8LP/GJe8RA/Ef/snyrdQL9cuEGFEm9fev1bf1Eldr/
 IaZvWmCrRwVmRfBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760620484;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7cvdhx60qnIzSoquw+4J4Ws9IlOK6ZImZ8Macxyig4=;
 b=h6LtBc9eYOOMtWPKcxH1ssDknz8NwaHWQRWYC+CjXaN35oEzEl7xYizgx6WWDY4Xwix+5w
 RtmP7SRyNBfDcY40HHmAZSHjpqb1im5CoOznxyFi9Nx1eIdH564rkWWayIdQdZvZr5MN42
 TnQ9K27z7Hw2N6pR9fJ423gSGWmfR8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760620484;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7cvdhx60qnIzSoquw+4J4Ws9IlOK6ZImZ8Macxyig4=;
 b=B53cWV2rAhamAI/yJ/mKMHPv6YbD8LP/GJe8RA/Ef/snyrdQL9cuEGFEm9fev1bf1Eldr/
 IaZvWmCrRwVmRfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96E951340C;
 Thu, 16 Oct 2025 13:14:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HssKHcPv8GjYNgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Oct 2025 13:14:43 +0000
Date: Thu, 16 Oct 2025 15:14:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20251016131437.GB281409@pevik>
References: <20251016100800.270043-1-pvorel@suse.cz>
 <19eebba9-2e6d-48fe-b690-195fe9d90942@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <19eebba9-2e6d-48fe-b690-195fe9d90942@suse.cz>
X-Spamd-Result: default: False [-2.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; SUBJECT_HAS_CURRENCY(1.00)[];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] prepare_lvm.sh: Use $TMPDIR as a default
 for $LVM_DIR
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

Hi Martin,

> Hi,
> thanks for the fix.

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

Thanks for your review, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
