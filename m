Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99807CA0FF0
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 12:56:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EF293CD16F
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 14:56:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45FEB3CCD37
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 14:56:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A8FFF1A00445
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 14:56:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 27B5420830;
 Fri, 29 Aug 2025 12:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756472162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vTgeuQTH9eUOFJ7XeJivosU/kZ4ntYA6fKQHNLeMFJM=;
 b=bAjveNQdD9ZNbuT+S5Y95oHQx8FTVGF7r3jjMYANIqxrqjYZJeHr0liiQlt8+poF+A0VFy
 CJdq87sWOKhjHwMIW8DCBeGywgtqk2ch+Rd7UjKTJUUiPpo2hmCnGs9Zxq/2eUZR9MaXLk
 QoSxHa18VFTEEQmq72A8iWFSuPuqAf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756472162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vTgeuQTH9eUOFJ7XeJivosU/kZ4ntYA6fKQHNLeMFJM=;
 b=AKiTf6YUIoraLJNL6k3/tVR7ZUQT4yk2VzfWqCytNuprlunnzR7IlBbVivT7kDMCn38rI2
 HmHTej3f0A4Ij2Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756472162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vTgeuQTH9eUOFJ7XeJivosU/kZ4ntYA6fKQHNLeMFJM=;
 b=bAjveNQdD9ZNbuT+S5Y95oHQx8FTVGF7r3jjMYANIqxrqjYZJeHr0liiQlt8+poF+A0VFy
 CJdq87sWOKhjHwMIW8DCBeGywgtqk2ch+Rd7UjKTJUUiPpo2hmCnGs9Zxq/2eUZR9MaXLk
 QoSxHa18VFTEEQmq72A8iWFSuPuqAf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756472162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vTgeuQTH9eUOFJ7XeJivosU/kZ4ntYA6fKQHNLeMFJM=;
 b=AKiTf6YUIoraLJNL6k3/tVR7ZUQT4yk2VzfWqCytNuprlunnzR7IlBbVivT7kDMCn38rI2
 HmHTej3f0A4Ij2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1694E13326;
 Fri, 29 Aug 2025 12:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YmgtA2KjsWjrdAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 29 Aug 2025 12:56:02 +0000
Date: Fri, 29 Aug 2025 14:55:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aLGjXEcSFhzqLiUd@rei.lan>
References: <20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com>
 <20250828-open_tree_attr-v1-2-f339a0e51e22@suse.com>
 <aLDhgFRA8ppAmYlH@localhost> <aLFzZ6xGsZh3CO64@yuki.lan>
 <9f626db7-5bf0-4376-8b4a-a643569f41ab@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9f626db7-5bf0-4376-8b4a-a643569f41ab@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mount_setattr01: add open_tree_attr variant
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
> > The tst_variant was implemented exactly for the case where we have
> > different syscalls doing the same job. In this case a shortcut was added
> > that does open_tree + mount_setattr in a single syscall, so using
> > variants is very reasonable choice.
> 
> Is it a free for all to merge the patch?

And does it work correctly on kernels older than 6.15? I do not see any
checks for the open_tree_attr() syscall availability.

Apart from that there are a few minor things to fix, I will do a proper
review.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
