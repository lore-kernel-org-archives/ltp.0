Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FE5C47DD9
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 10:05:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39EF93CFB97
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 11:05:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FC3C3C02E6
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 11:05:32 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2CB36601E85
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 11:05:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 491935FC72;
 Fri, 22 Mar 2024 10:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711101931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goblrd8GGg4xuxRRzcJMkK7YtTeQzNThb6ltekT3zHE=;
 b=Psyt0BG1N9jXLvPM38cOoCPX89b4SvLfyg6f2BY720w7B+C3qRlb5d0aQadaaoxf1x67Ra
 9ExBu7AZ+LYvfrrP7QXN0mxyBbwwQGIJ1W8FXWHqutKl97sfObswdxeSO9B0HNbpTeXTDz
 RAkUkspxJef0rCk9gfKXWAlqCyhRNhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711101931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goblrd8GGg4xuxRRzcJMkK7YtTeQzNThb6ltekT3zHE=;
 b=wfr6ye31MqpR7D3VWQg0bDXGQDkOGkMX2gavmq7/wyGd9emxx4QIKBTp/bTKl8uiU06n+A
 dbCW3Z84AlcIwGCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711101931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goblrd8GGg4xuxRRzcJMkK7YtTeQzNThb6ltekT3zHE=;
 b=Psyt0BG1N9jXLvPM38cOoCPX89b4SvLfyg6f2BY720w7B+C3qRlb5d0aQadaaoxf1x67Ra
 9ExBu7AZ+LYvfrrP7QXN0mxyBbwwQGIJ1W8FXWHqutKl97sfObswdxeSO9B0HNbpTeXTDz
 RAkUkspxJef0rCk9gfKXWAlqCyhRNhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711101931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goblrd8GGg4xuxRRzcJMkK7YtTeQzNThb6ltekT3zHE=;
 b=wfr6ye31MqpR7D3VWQg0bDXGQDkOGkMX2gavmq7/wyGd9emxx4QIKBTp/bTKl8uiU06n+A
 dbCW3Z84AlcIwGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2928F13688;
 Fri, 22 Mar 2024 10:05:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5owmCetX/WWgUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 22 Mar 2024 10:05:31 +0000
Date: Fri, 22 Mar 2024 11:05:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240322100525.GC604328@pevik>
References: <20240322090435.11756-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240322090435.11756-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-1.80)[93.82%];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Refactor fork14 using new LTP API
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

Hi Andrea,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!
Waiting for Cyril to have final look.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
