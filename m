Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7462FC5AD49
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 10:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBBBA3C25B4
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 12:09:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D6533C25B4
 for <ltp@lists.linux.it>; Mon, 26 May 2025 12:09:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 78242600A09
 for <ltp@lists.linux.it>; Mon, 26 May 2025 12:09:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C56051F769;
 Mon, 26 May 2025 10:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748254169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2ktGnyyxHzpvffIEzwSktBxGHaP0X6C3sqcqIJbSjs=;
 b=dit0qRaXtlBqOmpkyffNqjMu22h2kZ2Y06/ZBU7Z/yxPwdoZ6chdRXuQVUIiT/K436fSlS
 pZ7B7EAd0SH47NwO/15wCqKfbjyF/y8m9xAAQEQViDkAa7cbs5aY2iCtpIH7G5FyLYppDD
 k+jEeks3kneJ/uccnkb2nxBqWANi19E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748254169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2ktGnyyxHzpvffIEzwSktBxGHaP0X6C3sqcqIJbSjs=;
 b=nUhRQAqRXkvh3lZpcAVCsMMGZpP2Qjd7aBDTCv/0y4ooCrlClr798iVUlt5eamPL2P9Uzf
 unSgT7tVpsV+sgAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748254169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2ktGnyyxHzpvffIEzwSktBxGHaP0X6C3sqcqIJbSjs=;
 b=dit0qRaXtlBqOmpkyffNqjMu22h2kZ2Y06/ZBU7Z/yxPwdoZ6chdRXuQVUIiT/K436fSlS
 pZ7B7EAd0SH47NwO/15wCqKfbjyF/y8m9xAAQEQViDkAa7cbs5aY2iCtpIH7G5FyLYppDD
 k+jEeks3kneJ/uccnkb2nxBqWANi19E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748254169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2ktGnyyxHzpvffIEzwSktBxGHaP0X6C3sqcqIJbSjs=;
 b=nUhRQAqRXkvh3lZpcAVCsMMGZpP2Qjd7aBDTCv/0y4ooCrlClr798iVUlt5eamPL2P9Uzf
 unSgT7tVpsV+sgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1F8F13964;
 Mon, 26 May 2025 10:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TllKKtk9NGg+bgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 May 2025 10:09:29 +0000
Date: Mon, 26 May 2025 12:09:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aDQ99Xzb36XAoLGz@yuki.lan>
References: <20250521095302.13845-1-chrubis@suse.cz>
 <20250522173111.GA19708@pevik> <aC9jOhqDkRwGp9-T@rei>
 <20250522192612.GA26060@pevik> <20250522195707.GB26060@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250522195707.GB26060@pevik>
X-Spamd-Result: default: False [-1.30 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: LTP_SINGLE_FS_TYPE fix fuse blacklist
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
> Also, what if both are set? Should it be mutually exclusive?

I suppose so, we should just error out in that case. Let me send v2.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
