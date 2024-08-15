Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCCCC52D7D
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 10:16:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AA6B3D21C2
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 12:16:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49F663D1F66
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 12:15:46 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9C4A51A00FA3
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 12:15:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 31ACD2283C;
 Thu, 15 Aug 2024 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723716943;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1iV3iOYqu0F/yPNrZr/cUBpmMbQH6GFnYmqt5+pnCc=;
 b=ZpuNki5/Lk7+IDF36CoYMu+Cw2TdqBYKdgEkEVbIKVKOwB/YAt1SJfCyEktoM1KPOqCXP6
 Ifq3biKWEA1o61VN3Q+cO3AItaCjLLMZftIxeu8rI3K1cB/XUtcpH5XjJf/iN1qg4MQRaY
 /du6QClLifZT5pYvaCZMOi83+0S3R48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723716943;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1iV3iOYqu0F/yPNrZr/cUBpmMbQH6GFnYmqt5+pnCc=;
 b=SioJ3xDyAmvuZdBhNqCs0Cyxw677HNu08wsIESte0X/qHv5+BxL9dmgtRndzGLvxyiBjZt
 ACUhQaa67DjCn7DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723716942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1iV3iOYqu0F/yPNrZr/cUBpmMbQH6GFnYmqt5+pnCc=;
 b=x6uKBom2HkzQB+2IuzJEz6G1xKYmtCCvi64RIRMAaOAaN+YRHnyDJH0Rg48jIm21lilg0M
 +5x0JuJylmTK+as4AWZkNXvhJH0fdsG/vMLn023CRShXx4WJpDAYLGmSSPBwWK6+KE5JBa
 +dRwwdB1LfV2D0lCmIyGeVM80mkHvzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723716942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1iV3iOYqu0F/yPNrZr/cUBpmMbQH6GFnYmqt5+pnCc=;
 b=/gwB4XWzNXyghTb62RUtunElJyHdhgBGatyRw6HhKWAA+rMw6NI+TP3l8SvNdAP2hBl6ed
 LpDv+rtoKto5pECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B14C21342D;
 Thu, 15 Aug 2024 10:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MPyxKU3VvWbKJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 Aug 2024 10:15:41 +0000
Date: Thu, 15 Aug 2024 12:15:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andreas Schwab <schwab@suse.de>
Message-ID: <20240815101535.GA446806@pevik>
References: <mvm34n6aziu.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <mvm34n6aziu.fsf@suse.de>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/perf_event_open01: Allow EINVAL
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

Hi Andreas,

> A request for an unsupported perf event can also result in EINVAL.

Thanks for fixing LTP!
Yes, man page mentions this.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Out of curiosity, what are you fixing?
(Which kernel, arch, which event gives that).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
