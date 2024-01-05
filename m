Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DDEC47074
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 00:29:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBA9F3CE744
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 01:29:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA45A3CE59F
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 01:29:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CB8E81400755
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 01:29:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1898E1F839;
 Fri,  5 Jan 2024 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704414581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9oyEDpqOG72FAQd0Ir6Kb50We6e1Rgazg9MB2QYxsk=;
 b=g9OEx/dRPH2id/hPqN2iEO+X9p5L1dGXlT2VDKgWeB6oTlfIGvyT5WXx2P7IkXTzyb84gP
 BIJe/LdWedEbaXj4k8+e0WGASWZetY19CdD4bLcP10bxFVHZzUNVEdc0E+jm3pEk7ngmuV
 96W0+5TjRyfZN/UwR/+4BFmbjUIWAVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704414581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9oyEDpqOG72FAQd0Ir6Kb50We6e1Rgazg9MB2QYxsk=;
 b=+hM6QiujP5WIuajKKIrpUUsXBj5vuqIfVGtYa7E+ugbWsgnfFtM4t29LZOcv1qB7m8tzny
 AmZu8epmDFWKPnDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704414581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9oyEDpqOG72FAQd0Ir6Kb50We6e1Rgazg9MB2QYxsk=;
 b=g9OEx/dRPH2id/hPqN2iEO+X9p5L1dGXlT2VDKgWeB6oTlfIGvyT5WXx2P7IkXTzyb84gP
 BIJe/LdWedEbaXj4k8+e0WGASWZetY19CdD4bLcP10bxFVHZzUNVEdc0E+jm3pEk7ngmuV
 96W0+5TjRyfZN/UwR/+4BFmbjUIWAVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704414581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9oyEDpqOG72FAQd0Ir6Kb50We6e1Rgazg9MB2QYxsk=;
 b=+hM6QiujP5WIuajKKIrpUUsXBj5vuqIfVGtYa7E+ugbWsgnfFtM4t29LZOcv1qB7m8tzny
 AmZu8epmDFWKPnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5AED137E8;
 Fri,  5 Jan 2024 00:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h/mxNnRNl2UOUgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 05 Jan 2024 00:29:40 +0000
Date: Fri, 5 Jan 2024 01:29:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240105002939.GA1461871@pevik>
References: <20240105001745.1461744-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240105001745.1461744-1-pvorel@suse.cz>
X-Rspamd-Queue-Id: 1898E1F839
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="g9OEx/dR";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+hM6Qiuj
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.29 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.cz:dkim]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[44.29%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lapi/fsmount.h: Fix headers conflict
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I'm sorry, this is broken, fixed v2 is sent.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
