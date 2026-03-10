Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE05EB104A
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 11:21:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA8D63E57EB
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 12:21:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74A523CD52A
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 12:20:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 998BE60094C
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 12:20:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2E184D1FD;
 Tue, 10 Mar 2026 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773141645;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aGz8LjXkfLrmD1J0Vz44esjI2rZqkWmm3u0CWkArEp4=;
 b=ldF8hL7uMi71FB9kwCfHmOaT0xTiJDIJWLGQw5e2FgnuajoZzVGYmI6/sRUv+JKuda/V+k
 U+27ek+3w5QpNq3Dx64bHQnGAPXSSEYsJiwcqCsnI8oC2Kn2LExkBEKFeSkLs8POkM1Dra
 SRULEdbwGe8KX6vy8qPSRBba0vgDdXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773141645;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aGz8LjXkfLrmD1J0Vz44esjI2rZqkWmm3u0CWkArEp4=;
 b=dbmWvE+5v3vI+LjDY95ocHB5znUU+w1QbWh+v6+MyTpQF3z7yGCjjme4gCm8DEniPv1jfv
 xZdZ79tvg2u+CNBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773141644;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aGz8LjXkfLrmD1J0Vz44esjI2rZqkWmm3u0CWkArEp4=;
 b=r+a+4cWH8W/kUT/J+3uyVjPopsja+uaE4nCFiFFtnPhe6fQZPr4Eo9yGpoC/hTZwzhJ1W0
 VDqXHozbSkMvc/Zg+Et8IAhNFuJ8i3YH1gcExlWdKdkFQ5hnkXSF8BQ9+xmUSA89JQs5aF
 zTGrvffxjcwJrNvfPwuAjoQ6h38zJ10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773141644;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aGz8LjXkfLrmD1J0Vz44esjI2rZqkWmm3u0CWkArEp4=;
 b=MNUPjtfLxHnxUfRdHdmoLsDDe0W20umGcZZYFNwSWX4Wiu5QHvjM+dn0Jqxd8KIyVKt2OZ
 Yjm6TE1l8/oos6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8D563F419;
 Tue, 10 Mar 2026 11:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RpNbK4z+r2mZSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Mar 2026 11:20:44 +0000
Date: Tue, 10 Mar 2026 12:20:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260310112039.GA44580@pevik>
References: <20260309144236.GA28075@pevik>
 <69aedf8b.050a0220.24143c.7ce1@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69aedf8b.050a0220.24143c.7ce1@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] agents: Add AI agent configuration for code
 reviews
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> > https://linux-test-project.readthedocs.io/en/latest/developers/ground_rules.html
> > Ideally text would be just in a single document.

> I was thinking the same, but at the moment I don't know how to combine
> these two things. One is a documentation oriented format, the other is a
> list of rules for the agent.

No problem, thanks for considering it. I was also thinking about mentioning the
rules in the Patch review [1] in the Maintainers section. Probably the rules for
AI review might be different from review doing by humans, but at least mention
that we have some rules for AI might be useful for the maintainers who read the
Patch review page.

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/maintainers/patch_review.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
