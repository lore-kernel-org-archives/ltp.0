Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF625C54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 11:16:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 749343E71D4
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 13:16:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C03C83E2D15
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:16:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 14C2814002B4
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:16:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F392040F6;
 Fri, 31 Jul 2026 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785496585;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3l2oHk0MtSgeLKEFTdTj9zeodCRTO+KPml7ASN69qq8=;
 b=q131NLvD6tDEcfo6PXxTCybWoLf+o8/Jy7DMafSC3l1mPj2ly21PrX/AIpFj6qbbj7Mcsf
 N0NPXS5N1w/HIRjtqXEBt0t/zykVSaGx9wfCBoYP+WTZhPih8kQ0QRTKNubq6yQeXX9x7U
 /ylWNHqJVJOoZKa5AWy8wfGhp2xF46s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785496585;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3l2oHk0MtSgeLKEFTdTj9zeodCRTO+KPml7ASN69qq8=;
 b=xDZXtrakVfLNDvPydmQJw02rH50tIl9bALfgoTokDXsvaZpzxVqWTSdoE/tcpPYbWFZsbx
 QUK0WKTQ70Lw/jCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qXBAu3es;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5gL0kkH7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785496580;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3l2oHk0MtSgeLKEFTdTj9zeodCRTO+KPml7ASN69qq8=;
 b=qXBAu3es8mcGMRU8lWzHCJ/bjkMBQ5iTIsbGpEfatlAAKXvqFCMvE6n0rzgYUePLJm5Q2S
 x28puwXYv+5+We9h/Fo/6vMn9Q4MRpaaGgYSl+wGfiiOvBe3lNvy6W7B2+zX0jkFUtQ2Wz
 q5pjR0ToFm7sGFPlWw5uk3NU3yiW/yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785496580;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3l2oHk0MtSgeLKEFTdTj9zeodCRTO+KPml7ASN69qq8=;
 b=5gL0kkH7qzmM5txJ9FgXhUEXtPxCWIZByzkHjNBDHN26qUkMmtd2+zReq9/8tEiLIPeLod
 k01vRXPn5Z4NAtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C101C779B0;
 Fri, 31 Jul 2026 11:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5MaeLQSEbGpjPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jul 2026 11:16:20 +0000
Date: Fri, 31 Jul 2026 13:16:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260731111619.GB192663@pevik>
References: <6a6207ef.8c9cee7f.1e6be1.04d9@mx.google.com>
 <6a68578c.53cb9477.64730.32f1@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a68578c.53cb9477.64730.32f1@mx.google.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: F392040F6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add test for CVE 2026-53362
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

Hi Andrea, Martin,

> Merged, Thanks!

> With suggested changes

FYI Andrea by accident added unrelated testcases/cve/cve-2026-43499.md and
testcases/cve/refluxfs (binary file!) which obviously weren't part of Martin's
patch [1]. I removed that in 2a002a2c7b [2].

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20260721153917.64722-1-mdoucha@suse.cz/
[2] https://github.com/linux-test-project/ltp/commit/2a002a2c7b0a5433f22d2684c50a60ed12ccff70


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
