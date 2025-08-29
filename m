Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668B7CA0FF0
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 13:15:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E66313CD0E4
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 15:15:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B9573C0DEA
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 15:14:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0CE93100048B
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 15:14:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16A3F20830;
 Fri, 29 Aug 2025 13:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756473293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NiUL8wCV90mcByCdfN7h+ohHLKX468hsmSD7Wi2QGxw=;
 b=KdsXmxCbHvvPPo9q3136h8vCeDUkCbY3NuTxunrgUmHiZUv8JWwIHzVVk0mPChnFE/k+sq
 gZ2Ho1vhPhBW94GoPLt++pkZju4esdNlfLZWEgE/nSR3e0/jlbNkw1Qs1gOseq3MRLQ4D6
 byqqgMjY9OVVnBPppHJak2CjfhZqrak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756473293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NiUL8wCV90mcByCdfN7h+ohHLKX468hsmSD7Wi2QGxw=;
 b=zXokhJikEkkJljs2Z0/MzVja9wl+vpUcIP+jN+JDlK4GaSs8S/hUbyxsGz+1u1zwxYCKlX
 wn7AzLYOgCDxZ4CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756473293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NiUL8wCV90mcByCdfN7h+ohHLKX468hsmSD7Wi2QGxw=;
 b=KdsXmxCbHvvPPo9q3136h8vCeDUkCbY3NuTxunrgUmHiZUv8JWwIHzVVk0mPChnFE/k+sq
 gZ2Ho1vhPhBW94GoPLt++pkZju4esdNlfLZWEgE/nSR3e0/jlbNkw1Qs1gOseq3MRLQ4D6
 byqqgMjY9OVVnBPppHJak2CjfhZqrak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756473293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NiUL8wCV90mcByCdfN7h+ohHLKX468hsmSD7Wi2QGxw=;
 b=zXokhJikEkkJljs2Z0/MzVja9wl+vpUcIP+jN+JDlK4GaSs8S/hUbyxsGz+1u1zwxYCKlX
 wn7AzLYOgCDxZ4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0D1413326;
 Fri, 29 Aug 2025 13:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /+d4OcynsWgFewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 29 Aug 2025 13:14:52 +0000
Date: Fri, 29 Aug 2025 15:15:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aLGn8AxqpNyL8MSD@yuki.lan>
References: <20250527114757.14704-1-chrubis@suse.cz>
 <20250602150647.GA331929@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250602150647.GA331929@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Move tst_get_supported_fs_types() to private
 header
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
> > +/*
> > + * Returns NULL-terminated array of kernel-supported filesystems.
> > + *
> > + * @skiplist A NULL terminated array of filesystems to skip.
> > + */
> > +const char **tst_get_supported_fs_types(const char *const *skiplist);
> 
> BTW I suppose as a "private" header is not supposed to be used in in test programs
> we don't want to use kerneldoc, right?

Do we? There should be some kind of documentation even for internal
functions and I do not see a reson to use a different format. Having
kerneldoc vs doxygen is confusing enough for me adding third format
wouldn't help.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
