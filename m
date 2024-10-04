Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A62BCFA771
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 12:03:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A61F3C61BF
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 14:03:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7C583C5309
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 14:02:48 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 11B3560209B
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 14:02:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A21721D38;
 Fri,  4 Oct 2024 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728043365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAXuzROJ7EzS5Z4dHjlxotShfMAYgKN34O47stDZX9c=;
 b=nMMbsHoaXlx+Gfu15pbbbktTpPrVABm9HW0h4SS0GyaoQU7RRp1SAvbLHyY75+HXwAhym4
 s8HEf0szEpsDg3ptHEhypbhePmlCUtA56oXVW1nDXM2ioWbjAZShzpFyMRUDtwEwtYprPW
 Xs+tNRSZPTD6vJFGTo9K8HYr2bky+Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728043365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAXuzROJ7EzS5Z4dHjlxotShfMAYgKN34O47stDZX9c=;
 b=S3mXnwLceI+T8PwHqUtxQWuhyWA063bsdccw7/eDOfqN8X5ygyqX1zehFz8WZ3ChD19Y0N
 eegZBMtufrZwFnCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728043365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAXuzROJ7EzS5Z4dHjlxotShfMAYgKN34O47stDZX9c=;
 b=nMMbsHoaXlx+Gfu15pbbbktTpPrVABm9HW0h4SS0GyaoQU7RRp1SAvbLHyY75+HXwAhym4
 s8HEf0szEpsDg3ptHEhypbhePmlCUtA56oXVW1nDXM2ioWbjAZShzpFyMRUDtwEwtYprPW
 Xs+tNRSZPTD6vJFGTo9K8HYr2bky+Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728043365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAXuzROJ7EzS5Z4dHjlxotShfMAYgKN34O47stDZX9c=;
 b=S3mXnwLceI+T8PwHqUtxQWuhyWA063bsdccw7/eDOfqN8X5ygyqX1zehFz8WZ3ChD19Y0N
 eegZBMtufrZwFnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A23413A6E;
 Fri,  4 Oct 2024 12:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rHEACmXZ/2bQOgAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 04 Oct 2024 12:02:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id C005FA0877; Fri,  4 Oct 2024 14:02:40 +0200 (CEST)
Date: Fri, 4 Oct 2024 14:02:40 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <20241004120240.7cl3ycoghgovtnev@quack3>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-13-39558204ddf0@suse.com>
 <Zv6rklWkNJaT8uvJ@yuki.lan>
 <6cac9a7d-3a8c-4502-bd4a-23be491cf0ab@suse.com>
 <Zv-yoVOl1Bn7WZcM@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zv-yoVOl1Bn7WZcM@yuki.lan>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 13/13] Add statmount07 test
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Fri 04-10-24 11:17:21, Cyril Hrubis wrote:
> > That seems to be a valid value, since I get PASS. Kernel bug?
> 
> Looking at kernel it's a bit confusing, the bufsize is supposed to be
> the size of the structure plus the buffer allocated for the string
> reply. Which makes the code more complicated than it could have been if
> these two were separeted properly.
> 
> 
> However we do have:
> 
>        if (kbufsize >= s->bufsize)
>                 return -EOVERFLOW;
> 
> in statmount_string(), so we will trigger the error there if we pass one
> of the requests that is supposed to produce a string reply.

Yes, if STATMOUNT_STRING_REQ is set, the above check should always make
sure bufsize is large enough.

> But there seems to be something strange going on in the
> prepare_kstatmount() as well, we do have:
> 
>         if (ks->mask & STATMOUNT_STRING_REQ) {
>                 if (bufsize == sizeof(ks->sm))
>                         return -EOVERFLOW;
> 
> 		^ This line should probably be if (bufsize <= sizeof(ks->sm))
>                   because we are trying to make sure that the structure is large
> 		  enough that we can write at the offset where the
> 		  string area starts.
> 
> 		  It seems to be guarded by the checks in
> 		  statmount_string() later on as well, so I suppose that we
> 		  will trigger the EOVERFLOW slightly later if this does not
> 		  work though. CCying Jan to have a look.

Yup, this looks confusing to me as well. Christian, is this check indeed
meant to bail early if the buffer obviously is not large enough? Shouldn't
it then be <= as Cyril suggests? I have a feeling I might be missing some
"extensible syscall" magic that does the check bufsize < sizeof(struct)
automatically somewhere but I could not find it...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
