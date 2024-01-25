Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FBAC47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 10:36:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D50FE3CEBCA
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 11:36:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC6243CB7A1
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:36:37 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AA7601000D90
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:36:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC7F01F867;
 Thu, 25 Jan 2024 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706178995;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86ewqRQMW1/JevaPJvDr4+u+V8+Mu0SZ7TOPfOiZnhQ=;
 b=lDFg0L+z1qhbNR7B+iCQ7bR/cB8vhxkNetU8anznHpFKpdYnFc5U/U7jfNfX00bTAp3Bv6
 a2hOmCqIwnc4mtYvFCX8hEXUi8aJg1tZBY/PO1ydPTgsoIvbYZTLXsVtPlzVP/SmTALgZS
 JTGopjaZi4ulxkwdi9Eu5P0mAd3FMOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706178995;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86ewqRQMW1/JevaPJvDr4+u+V8+Mu0SZ7TOPfOiZnhQ=;
 b=V+uprwDnAgQm1Cyh1eaQQgwsALvv2IDZF+J04bpbxTOm9E5zUn/4HSI3zu9NCEU5JnAkqe
 5cAxcBUtNopS14DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706178995;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86ewqRQMW1/JevaPJvDr4+u+V8+Mu0SZ7TOPfOiZnhQ=;
 b=lDFg0L+z1qhbNR7B+iCQ7bR/cB8vhxkNetU8anznHpFKpdYnFc5U/U7jfNfX00bTAp3Bv6
 a2hOmCqIwnc4mtYvFCX8hEXUi8aJg1tZBY/PO1ydPTgsoIvbYZTLXsVtPlzVP/SmTALgZS
 JTGopjaZi4ulxkwdi9Eu5P0mAd3FMOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706178995;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86ewqRQMW1/JevaPJvDr4+u+V8+Mu0SZ7TOPfOiZnhQ=;
 b=V+uprwDnAgQm1Cyh1eaQQgwsALvv2IDZF+J04bpbxTOm9E5zUn/4HSI3zu9NCEU5JnAkqe
 5cAxcBUtNopS14DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FEA0134C3;
 Thu, 25 Jan 2024 10:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id emLGHbM5smXAaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jan 2024 10:36:35 +0000
Date: Thu, 25 Jan 2024 11:36:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240125103634.GB389091@pevik>
References: <20240125100009.387096-1-pvorel@suse.cz> <ZbIyh-kyBMTE5OA5@yuki>
 <20240125102552.GA389091@pevik> <ZbI3jdbljCoCl-Zi@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZbI3jdbljCoCl-Zi@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.60 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.10)[65.35%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fs_fill: Increase timeout to 5 min
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

> Hi!
> > I'm not sure if increasing to 1 GB makes test run slightly faster.
> > Maybe device size and runtime are related.

> Of course it is, the test fills the whole device with data, the runtime
> should really be a function of the device size.

Right, added and merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
