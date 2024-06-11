Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8A5C27C5E
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 11:41:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09F613D0B99
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 13:41:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B03EE3CA1E7
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 13:40:50 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2936D200922
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 13:40:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E3E77206B7;
 Tue, 11 Jun 2024 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718106048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zNE/4IIE+j3xn7hIalt3jDwFo9GJh/rShpIIYyM5yS0=;
 b=VReA0P8gXNZorq82/5ok9vs929Hfb2grpHOsSOF4xCzrFEYWCPLYNZ5ZoBz+6kL69q9gKi
 QM39RqPWafQM2Wj6UoLotIroPRUNP3IKMg/xwIOzGZvolS56t/oOO/x95c/Hl2Y4s4NROQ
 2fgLLoH2ec7GTd7X1EdWBPuxiOvzh8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718106048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zNE/4IIE+j3xn7hIalt3jDwFo9GJh/rShpIIYyM5yS0=;
 b=J9FTs0FZ15Hp9gQh+xxEDk7P960tpEBEjLjdeSUTmh2CwASL0zYrgihxA6efiMe1RvaF0Z
 9Ruo+ZsU8834qhCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718106047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zNE/4IIE+j3xn7hIalt3jDwFo9GJh/rShpIIYyM5yS0=;
 b=vVZRkEn8kVR/lujCZ8F42qBPnp4BQkGfBcRi4d6UxCp0ALoivFudsLEnD3aJqqw4F4lEl5
 yBHMYK6QUWyFvaH6cAitVz04usNMvFInaGw4D+iEC4x9PjeGLCTb25dXPVP/F8fINlPKCv
 jLMElNKeU5PvP4nkSxdAqAmPW/uURG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718106047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zNE/4IIE+j3xn7hIalt3jDwFo9GJh/rShpIIYyM5yS0=;
 b=7GZaMxaX9fcasJl0jE8v0VeDJyqQlB4RcxRpNJZMxhrPEVxkPCgaFaynVELu45ysVwJjj2
 nAc0jtPaj4ng2jCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4F3813A55;
 Tue, 11 Jun 2024 11:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5J3qMr83aGa7HAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 11 Jun 2024 11:40:47 +0000
Date: Tue, 11 Jun 2024 13:40:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: xufeifei <xufeifei1@oppo.com>
Message-ID: <Zmg3veXx0s0b5B4H@yuki>
References: <20240611034058.12611-1-xufeifei1@oppo.com>
 <20240611034058.12611-2-xufeifei1@oppo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240611034058.12611-2-xufeifei1@oppo.com>
X-Spamd-Result: default: False [-3.77 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.18)[-0.900]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Reduce loop count to meet need of low performance
 terminals
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> --- a/runtest/sched
> +++ b/runtest/sched
> @@ -9,7 +9,7 @@ trace_sched01           trace_sched -c 1
>  cfs_bandwidth01 cfs_bandwidth01 -i 5
>  hackbench01 hackbench 50 process 1000
>  hackbench02 hackbench 20 thread 1000
> -starvation starvation
> +starvation starvation -l 100000

Are you sure that your kernel isn't affected by the bug the test checks
for? The test timeouts on a buggy kernel.

How long does the test run if you disable timeouts (by setting static
int timeout = -1 in the source)?

Also what kind of system it is? How fast is the CPU?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
