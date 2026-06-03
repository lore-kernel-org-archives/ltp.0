Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6067ACD6E64
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 09:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D95353E560A
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:59:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 927223C0926
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:59:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A7CC41A0045C
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:59:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A6DE86A7FB;
 Wed,  3 Jun 2026 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780480746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MCS+3YartUzRmgakRPM6xFo3cCLJxDmXiVqbRsKkDFE=;
 b=mEfWte/P9HoIhZzuL7erm4jcpn5aqK7sucRt28WivHRTAKZvsJOTJqDAp7By6Ls3t669Af
 4bnz6zQKRDG9B4Q2RQD+va9qDyi/MwSZpbDCwnZYLeW79aAJ0bMRMGMeZF7fTX+SRU6om1
 Mwi+WBWYI+mwdh+N0/rI1jzzcWW5cvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780480746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MCS+3YartUzRmgakRPM6xFo3cCLJxDmXiVqbRsKkDFE=;
 b=AXyqKD53PpWCJ7oHVjWRTxT+VC92glc2kRB5sUykRn4l/cS6QnGSe0/SGCYAQ+dE921lfP
 FXYDv1WTJPihbmBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780480746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MCS+3YartUzRmgakRPM6xFo3cCLJxDmXiVqbRsKkDFE=;
 b=mEfWte/P9HoIhZzuL7erm4jcpn5aqK7sucRt28WivHRTAKZvsJOTJqDAp7By6Ls3t669Af
 4bnz6zQKRDG9B4Q2RQD+va9qDyi/MwSZpbDCwnZYLeW79aAJ0bMRMGMeZF7fTX+SRU6om1
 Mwi+WBWYI+mwdh+N0/rI1jzzcWW5cvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780480746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MCS+3YartUzRmgakRPM6xFo3cCLJxDmXiVqbRsKkDFE=;
 b=AXyqKD53PpWCJ7oHVjWRTxT+VC92glc2kRB5sUykRn4l/cS6QnGSe0/SGCYAQ+dE921lfP
 FXYDv1WTJPihbmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 923B55A4DD;
 Wed,  3 Jun 2026 09:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id erGOIur6H2padQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jun 2026 09:59:06 +0000
Date: Wed, 3 Jun 2026 11:59:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: XiaoLei Wu <wxl18715129466@gmail.com>
Message-ID: <ah_65vifTFw0LNy0@yuki.lan>
References: <20260602064442.718507-1-wxl18715129466@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260602064442.718507-1-wxl18715129466@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/unlink09: report unsupported inode flags
 as TCONF
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
> If FS_IOC_GETFLAGS fails with ENOTTY, the filesystem does not support
> inode flags. This is an unsupported test configuration rather than a
> broken test setup, so report TCONF instead of TBROK.

This happens on ntfs3 as well right?

I suppose that this will be fixed if we had the change I've proposed for
the test library in the skiplist handling for the other patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
