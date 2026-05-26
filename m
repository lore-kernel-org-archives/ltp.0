Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8270ACD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:04:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D92FC3E62BF
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 17:04:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E79F3C0354
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:04:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D11FA1A0035E
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:04:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F31A67436;
 Tue, 26 May 2026 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779807848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uv20Ry/C7dSACjCTcQa/IizDppzVFAS7Zq4IBA7ObYM=;
 b=aQqrTWiMQk9YeK8D7vGv7f1r6t2SnuaI9MTY1QOPU6CbYxEVgUq58xPvZGiPN9bHT//4/W
 0GUmcB3iK6OK/6O8DI3KvDa1dyn7yR2xGGnQV5zxt7lDJZ577sNEE2ss9qZpVB1u8JQoMz
 +U+VpLFH1k4s5OaJyJLtcPAUBYRCYFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779807848;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uv20Ry/C7dSACjCTcQa/IizDppzVFAS7Zq4IBA7ObYM=;
 b=MnzPuxkU0UiyEg/S54tTk9bSwheXAz6KeAxb0v2oCP1rd8/3KF2oYwNwAcT0goQP+zn4Lc
 FRvuHlyuuFzKvwBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779807848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uv20Ry/C7dSACjCTcQa/IizDppzVFAS7Zq4IBA7ObYM=;
 b=aQqrTWiMQk9YeK8D7vGv7f1r6t2SnuaI9MTY1QOPU6CbYxEVgUq58xPvZGiPN9bHT//4/W
 0GUmcB3iK6OK/6O8DI3KvDa1dyn7yR2xGGnQV5zxt7lDJZ577sNEE2ss9qZpVB1u8JQoMz
 +U+VpLFH1k4s5OaJyJLtcPAUBYRCYFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779807848;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uv20Ry/C7dSACjCTcQa/IizDppzVFAS7Zq4IBA7ObYM=;
 b=MnzPuxkU0UiyEg/S54tTk9bSwheXAz6KeAxb0v2oCP1rd8/3KF2oYwNwAcT0goQP+zn4Lc
 FRvuHlyuuFzKvwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 464635A279;
 Tue, 26 May 2026 15:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ju6FEGi2FWrxUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 26 May 2026 15:04:08 +0000
Date: Tue, 26 May 2026 17:03:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ahW2UizhslyT-_XY@yuki.lan>
References: <20260526083406.357092-1-chrubis@suse.cz>
 <20260526083406.357092-3-chrubis@suse.cz>
 <20260526134533.GC215060@pevik> <ahWnL1wIVzaXrhhi@yuki.lan>
 <20260526141647.GB176931@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260526141647.GB176931@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Good. Sure I agree with minimal changes as these are pre-release fixes.

Pushed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
