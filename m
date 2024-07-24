Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2428BC3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:06:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B25D23D1C1F
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:06:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56FDF3D1B17
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:05:57 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C66D01018981
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:05:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E446D1F796;
 Wed, 24 Jul 2024 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721811955;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDmjkDUpROpBunCtu9LsRUpH5iLoZyWcv2yhAULe/t8=;
 b=aWIlgzm36p2+IBC8MMVwdk4DjoEN+bXI3kHl/hxh4vQ8qUWOcYc3DX5i+O9eDV/LwOHkKX
 qUbW4RXcOIuddT9vjlLftQxkxFEYoDp0RLAi2PJ8e2/mcAVf0GjWXU2kUZFqGrRlDm8AoX
 kqkfR0BqgWXmezX1XQ2rpr/Dk4IX42o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721811955;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDmjkDUpROpBunCtu9LsRUpH5iLoZyWcv2yhAULe/t8=;
 b=YXv5xwIVd//0yST9aDeEgXkBoL4JgMdriuu7iojzRzgTAa+zqHo/orkHwWYd6NdhFZL/IV
 vEEuJvSMNo9SYsCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721811955;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDmjkDUpROpBunCtu9LsRUpH5iLoZyWcv2yhAULe/t8=;
 b=aWIlgzm36p2+IBC8MMVwdk4DjoEN+bXI3kHl/hxh4vQ8qUWOcYc3DX5i+O9eDV/LwOHkKX
 qUbW4RXcOIuddT9vjlLftQxkxFEYoDp0RLAi2PJ8e2/mcAVf0GjWXU2kUZFqGrRlDm8AoX
 kqkfR0BqgWXmezX1XQ2rpr/Dk4IX42o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721811955;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDmjkDUpROpBunCtu9LsRUpH5iLoZyWcv2yhAULe/t8=;
 b=YXv5xwIVd//0yST9aDeEgXkBoL4JgMdriuu7iojzRzgTAa+zqHo/orkHwWYd6NdhFZL/IV
 vEEuJvSMNo9SYsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADCC01324F;
 Wed, 24 Jul 2024 09:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cp3FKPPDoGbjUQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jul 2024 09:05:55 +0000
Date: Wed, 24 Jul 2024 11:05:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240724090548.GA930789@pevik>
References: <ZqC-69CoVPMRsJLv@yuki>
 <5C233D16-A52A-47E0-AFD0-3D5E88B9F00B@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5C233D16-A52A-47E0-AFD0-3D5E88B9F00B@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add tst_tmpdir_path() and tst_tmpdir_mkpath()
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

Hi Andrea, all,

> Yeah this is the case.
> The problem comes when tst_tmpdir_path() is used without giving .needs_tmpdir and the pointer to tmpdir is not initialised.

Thanks for clarifying it, I see Cyril already posted a suggestion for fixing.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
