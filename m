Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BEBE7717F
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 21:34:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C0023ECFC6
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 22:34:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 410CE3ECF94
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 22:33:55 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AAD4F600CE6
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 22:33:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B9E7210E4;
 Tue, 17 Dec 2024 21:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734471233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0oBbkUrGx2wzFVWnn0usE+Bm5JxuOtiEgpB6z1loMrU=;
 b=HlH1/8di55zMrIXwLhRljjZeENJ8OyPI4Ikfqbagr5D6Y4tapaZDtRKL+Qju/em5ZWGScE
 j6j9bQ8v7SRCe95hS+qUsl/aLQXcKhHTCujvvoekvXpeTUHH3QO807d92n9ALl/nXwvgmH
 6HOd8OtGHi9lL3TwslJKamwcTNOsJNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734471233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0oBbkUrGx2wzFVWnn0usE+Bm5JxuOtiEgpB6z1loMrU=;
 b=jo39aTKL0jHYLrLQepHA9CIPVJ73ur8Z7f5TrUXaFV7dFBy8mXoYPgnZFkpoVdK6XZ+Psk
 V/I5A659IzJtsUBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="HlH1/8di";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jo39aTKL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734471233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0oBbkUrGx2wzFVWnn0usE+Bm5JxuOtiEgpB6z1loMrU=;
 b=HlH1/8di55zMrIXwLhRljjZeENJ8OyPI4Ikfqbagr5D6Y4tapaZDtRKL+Qju/em5ZWGScE
 j6j9bQ8v7SRCe95hS+qUsl/aLQXcKhHTCujvvoekvXpeTUHH3QO807d92n9ALl/nXwvgmH
 6HOd8OtGHi9lL3TwslJKamwcTNOsJNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734471233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0oBbkUrGx2wzFVWnn0usE+Bm5JxuOtiEgpB6z1loMrU=;
 b=jo39aTKL0jHYLrLQepHA9CIPVJ73ur8Z7f5TrUXaFV7dFBy8mXoYPgnZFkpoVdK6XZ+Psk
 V/I5A659IzJtsUBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9C77132EA;
 Tue, 17 Dec 2024 21:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9pLXN0DuYWeWDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 17 Dec 2024 21:33:52 +0000
Date: Tue, 17 Dec 2024 22:33:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20241217213351.GA29863@pevik>
References: <20241217145041.44600-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241217145041.44600-1-pvorel@suse.cz>
X-Rspamd-Queue-Id: 2B9E7210E4
X-Spamd-Result: default: False [-3.47 / 50.00]; BAYES_HAM(-2.76)[98.94%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ip_tests.sh: Iprove grep count
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

typo in the subject, I'll fix it before merge:
s/Iprove/Improve/

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
