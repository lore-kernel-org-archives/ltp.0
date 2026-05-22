Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC49CCD5BAC
	for <ltp@archiver.kernel.org>; Fri, 22 May 2026 09:01:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08C313CD59B
	for <ltp@archiver.kernel.org>; Fri, 22 May 2026 11:01:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC2253CD516
 for <ltp@lists.linux.it>; Fri, 22 May 2026 11:00:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 893E410006C2
 for <ltp@lists.linux.it>; Fri, 22 May 2026 11:00:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3C3A6BC64;
 Fri, 22 May 2026 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779440456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aeZL/5WSr1TInTXsItPDNCdJcopnJY/NaexC3nS4NeY=;
 b=NI3i5NLdmrKvhTUzNdF3QuFFvtQBgDQkFZJSoJRl8XwRzOOFkFCoFZi5fvaClG/jZwdmfw
 /ClW8Nl04728FhsXdDKqogKtnCtELUDbFMUpxGrLrOl94YQIkYwAYMTZPIFfKbZNOh1S5P
 7LGdq/bTyx1+Go1D0uEOUAL51XNsHBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779440456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aeZL/5WSr1TInTXsItPDNCdJcopnJY/NaexC3nS4NeY=;
 b=UkQorXYlLsTN0GoTYyrYdY0h+OOFUXUUemRnJHwQWldOStegmnrUuQZE2p/vIOL5ZSFIli
 Pjroq3XUruzEbdDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eXxmuQRz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nPz8SAJf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779440455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aeZL/5WSr1TInTXsItPDNCdJcopnJY/NaexC3nS4NeY=;
 b=eXxmuQRz658WYhldTd3YC/sX+m+xyOwFkUkwqFQQ7xsu02Sixck955YKPj5UxEr8AG+BOK
 SkYx6ugJNCESMPQWb4GIQgqHZQLqRI5IyaHJqeT4ZDmEiB2Fs4WINzBxT8mBwI1KXe2KKz
 oibkIJY6Jp6MH7Dc++Ehrpd3UA+n65E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779440455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aeZL/5WSr1TInTXsItPDNCdJcopnJY/NaexC3nS4NeY=;
 b=nPz8SAJf3GGEZKd5VV7LSap7pJgOxb7ehsHB2lTbt5HBlXX7QOfKl2G4xLjPhFOUnT6lQc
 7yXs6zpbLQLu9HBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D191F593A8;
 Fri, 22 May 2026 09:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +1hhMkcbEGpjLAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 22 May 2026 09:00:55 +0000
Date: Fri, 22 May 2026 11:00:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ahAbOy1KY2lRhegN@yuki.lan>
References: <69fb0616.df0a0220.22cc2d.40d2@mx.google.com>
 <17e62d0f-2573-46d6-957a-0ad37f977c5b@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17e62d0f-2573-46d6-957a-0ad37f977c5b@suse.cz>
X-Rspamd-Queue-Id: E3C3A6BC64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 internal_greylist_whitelist(0.00)[2a07:de40:b281:104:10:150:64:97];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] icmp_rate_limit01: Fix rate limit change on older
 kernels
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
> >> @@ -257,6 +262,7 @@ static struct tst_test test = {
> >>   	},
> >>   	.save_restore = (const struct tst_path_val[]) {
> >>   		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
> >> +		{"/proc/sys/net/ipv4/icmp_msgs_burst", "50", TST_SR_TBROK},
> > 
> > Shouldn't we use TST_SR_SKIP_MISSING here instead of TBROK?
> 
> Hi,
> this .save_restore line references the icmp_msgs_burst sysfile in global 
> network namespace which exists on all kernels since v3.18 if they have 
> IPv4 support enabled. I guess we should add CONFIG_INET to 
> .needs_kconfigs but otherwise the .save_restore is correct.

Sounds good to me. Feel free to add my Reviewed-by: to a patch with
CONFIG_INET in the .needs_kconfigs

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
