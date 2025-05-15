Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C063C2D0CD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 19:32:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCB143CC52A
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 21:32:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 024163CC148
 for <ltp@lists.linux.it>; Thu, 15 May 2025 21:31:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A97F206C4C
 for <ltp@lists.linux.it>; Thu, 15 May 2025 21:31:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB9731F829;
 Thu, 15 May 2025 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747337515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BL2McbeXJ8N0GBRtpcb2zwXZGmdMwUKb4iNzeYoZr7I=;
 b=mfi66cIQmh4lAUookReUfSZzN91B5+5qMCK4KxzHtcqUUw4Q6M6USniafQY5z/kI0m0QY9
 W1gtEju8mv/Z2GhdHLiMLSKobHgdpgeeuEcILo2pSygGaO7Fb7kg4RceKvX/YQBSIb4tDa
 x3/WrvbMy7KLBe97kVSipLMcpN0OLXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747337515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BL2McbeXJ8N0GBRtpcb2zwXZGmdMwUKb4iNzeYoZr7I=;
 b=Z89QRZ3mb5WLnnd3D9JNAD3AEo/aODuND/BiKAB980xYHPkB1au03WvjKelIQw1jQP45K7
 xiINTe+Uo/qnCkBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747337515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BL2McbeXJ8N0GBRtpcb2zwXZGmdMwUKb4iNzeYoZr7I=;
 b=mfi66cIQmh4lAUookReUfSZzN91B5+5qMCK4KxzHtcqUUw4Q6M6USniafQY5z/kI0m0QY9
 W1gtEju8mv/Z2GhdHLiMLSKobHgdpgeeuEcILo2pSygGaO7Fb7kg4RceKvX/YQBSIb4tDa
 x3/WrvbMy7KLBe97kVSipLMcpN0OLXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747337515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BL2McbeXJ8N0GBRtpcb2zwXZGmdMwUKb4iNzeYoZr7I=;
 b=Z89QRZ3mb5WLnnd3D9JNAD3AEo/aODuND/BiKAB980xYHPkB1au03WvjKelIQw1jQP45K7
 xiINTe+Uo/qnCkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A7F6139D0;
 Thu, 15 May 2025 19:31:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wchKEitBJmgCCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 May 2025 19:31:55 +0000
Date: Thu, 15 May 2025 21:31:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250515193153.GA501284@pevik>
References: <20250515135934.498583-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250515135934.498583-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Add LTP_ENABLE_DEBUG to doc
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

> Based on Cyril's patch:
> https://patchwork.ozlabs.org/project/ltp/patch/20250515103146.14950-1-chrubis@suse.cz/
> https://lore.kernel.org/ltp/20250515103146.14950-1-chrubis@suse.cz/

And that is exactly the reason why patch fails to build in CI
(patch is not applicable without Cyril's patch).

Here is the verification this simple patch does not fail to build:
https://github.com/pevik/ltp/actions/runs/15053601640
https://github.com/pevik/ltp/actions/runs/15053601653

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
