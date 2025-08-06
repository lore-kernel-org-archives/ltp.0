Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F865C87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 14:30:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE5743C8564
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 16:30:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A68043C7B85
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 16:30:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EC6AB600870
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 16:29:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6DBD022409;
 Wed,  6 Aug 2025 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754490598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=noKoJhuNdCz5RFFOmXyFYrs8YqLRV/llUDayO30d06M=;
 b=HWiCRyE1ILB3WqiPndLhZmlf5dj0N1Z2XjKxQ+ZQgD5mz0gkebx9ficc9OJerbn5u16Xfi
 7jhDJI7sdRkxxInM0SQ2GfxfvhNCmdlSmxcaNjrQ7qASYrzB1Qx+0Ncq+GV90amW1hm5mH
 nbAhXRksyS3pW+Srn8llovpbfWiRL+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754490598;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=noKoJhuNdCz5RFFOmXyFYrs8YqLRV/llUDayO30d06M=;
 b=Sl3T30tqjclKLQgLWVguneDo276ds3X4EjRLgcXu2z/YQtTSFJIrbSwiPZ8TsQoDWH38RT
 QPJjtobAskIp4gAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754490598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=noKoJhuNdCz5RFFOmXyFYrs8YqLRV/llUDayO30d06M=;
 b=HWiCRyE1ILB3WqiPndLhZmlf5dj0N1Z2XjKxQ+ZQgD5mz0gkebx9ficc9OJerbn5u16Xfi
 7jhDJI7sdRkxxInM0SQ2GfxfvhNCmdlSmxcaNjrQ7qASYrzB1Qx+0Ncq+GV90amW1hm5mH
 nbAhXRksyS3pW+Srn8llovpbfWiRL+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754490598;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=noKoJhuNdCz5RFFOmXyFYrs8YqLRV/llUDayO30d06M=;
 b=Sl3T30tqjclKLQgLWVguneDo276ds3X4EjRLgcXu2z/YQtTSFJIrbSwiPZ8TsQoDWH38RT
 QPJjtobAskIp4gAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E5F613AA8;
 Wed,  6 Aug 2025 14:29:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fZQfFuZmk2iffgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 06 Aug 2025 14:29:58 +0000
Date: Wed, 6 Aug 2025 16:30:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aJNnF8F-Ob-b9lBc@yuki.lan>
References: <20250805-file_setattr_getattr-v5-0-2bc4d18e0033@suse.com>
 <20250805-file_setattr_getattr-v5-7-2bc4d18e0033@suse.com>
 <aJNlSarKxGE1qBVO@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aJNlSarKxGE1qBVO@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 7/7] Add file_attr04 test
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
> Just curious, does the fd from open_tree() work fine as dirfd or do we
> just get differnt errno? I think second one may be the case, since the
> file descriptor from open_tree() syscall usually behaves a bit strange.

Looks like kernel internally does:

return dentry_open(&path, O_PATH, current_cred());

So I suppose that the fd from open_tree() is actually usable as a dirfd.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
