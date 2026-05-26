Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985A6CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 14:17:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A9043E62BD
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 16:17:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDC283C01A4
 for <ltp@lists.linux.it>; Tue, 26 May 2026 16:16:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C48C140097E
 for <ltp@lists.linux.it>; Tue, 26 May 2026 16:16:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E237A6B2EE;
 Tue, 26 May 2026 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779805008;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wk9UCw/hPKGqmLA8AT977OoqE+WxzykO0iKWoTBBYJA=;
 b=YnAvvBJc/y7YsE7hqh9i+g5hKhqgNmrulCg6aiV6T1fyPK3WsIxXJDVmmt37LkphFHXBZJ
 brN8POTZzObPmKgYz27KxPvqlFOwbq0FJg75J2c/UDPW6kk5szCCut4c020ASdFb+slwLQ
 gvr3/bHYe+S8cyomfGJ9HOd9E0Mh0ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779805008;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wk9UCw/hPKGqmLA8AT977OoqE+WxzykO0iKWoTBBYJA=;
 b=cy+UjAYMIxMLuFZbkL+15++aSQg1JPCSLeQZy+fgb/H9SfNLW1Y13THGJzCvA01QYKKKAh
 zRvisg0zbkhgKXCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779805008;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wk9UCw/hPKGqmLA8AT977OoqE+WxzykO0iKWoTBBYJA=;
 b=YnAvvBJc/y7YsE7hqh9i+g5hKhqgNmrulCg6aiV6T1fyPK3WsIxXJDVmmt37LkphFHXBZJ
 brN8POTZzObPmKgYz27KxPvqlFOwbq0FJg75J2c/UDPW6kk5szCCut4c020ASdFb+slwLQ
 gvr3/bHYe+S8cyomfGJ9HOd9E0Mh0ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779805008;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wk9UCw/hPKGqmLA8AT977OoqE+WxzykO0iKWoTBBYJA=;
 b=cy+UjAYMIxMLuFZbkL+15++aSQg1JPCSLeQZy+fgb/H9SfNLW1Y13THGJzCvA01QYKKKAh
 zRvisg0zbkhgKXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAA155A24B;
 Tue, 26 May 2026 14:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EVKyKlCrFWqRIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 May 2026 14:16:48 +0000
Date: Tue, 26 May 2026 16:16:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260526141647.GB176931@pevik>
References: <20260526083406.357092-1-chrubis@suse.cz>
 <20260526083406.357092-3-chrubis@suse.cz>
 <20260526134533.GC215060@pevik> <ahWnL1wIVzaXrhhi@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahWnL1wIVzaXrhhi@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/inotify{07,
 08}: Fix TBROK on older kernels
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
> > Maybe later after the release we could think about about shorten this with
> > definitions. I'm ok if you consider this as not useful.

> I was thinking about this, but I wanted to have minimal fix before the
> release. We can rethink the SAFE_WRITE and SAFE_READ API later on.

Good. Sure I agree with minimal changes as these are pre-release fixes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
