Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0729CE7D12
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 12:09:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E3EF3C58FE
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 14:09:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDF973C58D8
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 14:09:13 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A7B43100041D
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 14:09:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 28AB31F7FB;
 Tue,  1 Oct 2024 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727784550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oe5szFMMxsjnDg70279WiFT6nQX/+2FGNPxDf8pJBrc=;
 b=TdwfDPU7HNBbqO33L0LTiqfB+8KJ49U11OIUCLbRmuiBDfs0hxDH0nJtxZ1zITxyleehpA
 m0Wzg3LuMMoIW6pmudAUfS5UUF6SeT7LFkEXpmDdN/SdHkEKEXkpb15Eac2g4o4pHEm0NH
 TBmgRdU6Rd7T71T4NCH3ZWVraOsyj3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727784550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oe5szFMMxsjnDg70279WiFT6nQX/+2FGNPxDf8pJBrc=;
 b=Iv0XzHNxAsQszfTX0Z9CNylYERNJvrGuPvAwWoVWOU28W+JFwt5K0XNnkbJiq4dln2n9su
 0Tiltmdx6L/f4xAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TdwfDPU7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Iv0XzHNx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727784550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oe5szFMMxsjnDg70279WiFT6nQX/+2FGNPxDf8pJBrc=;
 b=TdwfDPU7HNBbqO33L0LTiqfB+8KJ49U11OIUCLbRmuiBDfs0hxDH0nJtxZ1zITxyleehpA
 m0Wzg3LuMMoIW6pmudAUfS5UUF6SeT7LFkEXpmDdN/SdHkEKEXkpb15Eac2g4o4pHEm0NH
 TBmgRdU6Rd7T71T4NCH3ZWVraOsyj3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727784550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oe5szFMMxsjnDg70279WiFT6nQX/+2FGNPxDf8pJBrc=;
 b=Iv0XzHNxAsQszfTX0Z9CNylYERNJvrGuPvAwWoVWOU28W+JFwt5K0XNnkbJiq4dln2n9su
 0Tiltmdx6L/f4xAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01FAD13A73;
 Tue,  1 Oct 2024 12:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vzcOOGXm+2aTcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 01 Oct 2024 12:09:09 +0000
Date: Tue, 1 Oct 2024 14:08:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZvvmJb62EivSVMCA@yuki.lan>
References: <20240927100135.12271-1-chrubis@suse.cz>
 <4942786.OV4Wx5bFTl@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4942786.OV4Wx5bFTl@localhost>
X-Rspamd-Queue-Id: 28AB31F7FB
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] realtime: Install run.sh script
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
Pushed, thanks for the review.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
