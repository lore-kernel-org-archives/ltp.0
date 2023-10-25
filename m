Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267A4C25B47
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 08:22:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D7713CEC32
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 10:22:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B736D3C6D29
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 10:22:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF2F41A027B7
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 10:22:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6007D1FF32;
 Wed, 25 Oct 2023 08:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698222136;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6wo6AaEjJ9AwUZ+1Rlfzzl7PlyGHlJJvig+GUHVWf8=;
 b=MHg2rfeVWX0il8JTB0zKShM+SYyovYXuYLsTXAOmtNIAPNdRouQGhEUtBUwvWe78lAjE0i
 SpTdMPgzrtgF332zWlKaJEMAjomahJZY0h8ck+xu1wK3H1cFxtbYJwvBqZStJ1VBJGdKr+
 lmKU7wn/HT9xWs8l3TtSeYPGxjg9Hrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698222136;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6wo6AaEjJ9AwUZ+1Rlfzzl7PlyGHlJJvig+GUHVWf8=;
 b=ZCicbDa/nP0NdmFmB5tNvCm5GKsCKa4VrZeDqhuyRb3w7/pMu+Kdwibquz4UuI1LwjcAa9
 7TrgEBsozsopKEDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C49F138E9;
 Wed, 25 Oct 2023 08:22:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vuXXADjQOGXleAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 08:22:16 +0000
Date: Wed, 25 Oct 2023 10:22:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231025082214.GB294660@pevik>
References: <20231024201135.264768-1-pvorel@suse.cz>
 <20231024201135.264768-2-pvorel@suse.cz> <8734xzuq4g.fsf@suse.de>
 <20231025073952.GA286089@pevik> <ZTjJDtrcyjc3UoMV@rei>
 <20231025081200.GA294660@pevik> <ZTjOcjPzdu_o7UT1@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTjOcjPzdu_o7UT1@rei>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-9.98 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.68)[98.58%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi: Add uinput.h
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
> > Ah, thank you. This is obviously missing.

> I do not think that it's needed at all, the uinput header has been in
> there for more than decade.

Thank you for spotting trivial error.  I only checked up to UAPI introduction
v3.7-rc1 (but we already raised the support to 3.10).  More importantly
include/linux/uinput.h existed since git history (2.6.12-rc2).

I'll remove check in v2.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
