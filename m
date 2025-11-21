Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82DACFA76F
	for <ltp@archiver.kernel.org>; Fri, 21 Nov 2025 10:45:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D0F83CE755
	for <ltp@archiver.kernel.org>; Fri, 21 Nov 2025 11:45:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 422AD3CDD1D
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 11:45:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BBD7F6010E3
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 11:45:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 631A820EE9;
 Fri, 21 Nov 2025 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763721908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xawNmsFbrVV/fRrOGcF/KfhTKyb/uPobNKMSXWNi3e8=;
 b=GK6WnvAGdomVo2ZMW404hYQllImW8vTF5JDkHnZHlthodjWzG6Ab6nOwDdZ10xzhuMlft/
 OkuQLmForBA2jVLc/YHoqTjTPE2zJRygERGji/XSlAjiA7u1Iww06BgfWmksOAkK267DEW
 a6ty6HRdVDjvpSPCOt467K4OIsj3JtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763721908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xawNmsFbrVV/fRrOGcF/KfhTKyb/uPobNKMSXWNi3e8=;
 b=SAtuD68MV4T545QJ1pG6chD/p84E/+K4ZoXk+UrXaW+9pMy7ys3qleUyn0U48P8hjpQnlp
 IJdNvGz6Bji113Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763721908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xawNmsFbrVV/fRrOGcF/KfhTKyb/uPobNKMSXWNi3e8=;
 b=GK6WnvAGdomVo2ZMW404hYQllImW8vTF5JDkHnZHlthodjWzG6Ab6nOwDdZ10xzhuMlft/
 OkuQLmForBA2jVLc/YHoqTjTPE2zJRygERGji/XSlAjiA7u1Iww06BgfWmksOAkK267DEW
 a6ty6HRdVDjvpSPCOt467K4OIsj3JtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763721908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xawNmsFbrVV/fRrOGcF/KfhTKyb/uPobNKMSXWNi3e8=;
 b=SAtuD68MV4T545QJ1pG6chD/p84E/+K4ZoXk+UrXaW+9pMy7ys3qleUyn0U48P8hjpQnlp
 IJdNvGz6Bji113Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C8823EA61;
 Fri, 21 Nov 2025 10:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vTm+DbRCIGkOPAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Nov 2025 10:45:08 +0000
Date: Fri, 21 Nov 2025 11:45:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251121104506.GA25561@pevik>
References: <20251120163550.333241-1-pvorel@suse.cz>
 <aSBBzVaq4gJ6JfrK@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aSBBzVaq4gJ6JfrK@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] readahead02: Sleep 1.5 msec to fix problem on
 bare metal
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

> Hi!
> > This fixes ppc64le bare metal. It looks like kernel needs some time to
> > update counters.

> In this case I think that something is needed for the kernel to actually
> do some readahead. The readahead() syscall is supposed to initiate
> readahead but kernel will need some time for the actual readahead to
> happen. And how much time will depend on the I/O speed and saturation of
> the I/O bus/disk.

> Adding a short sleep is a good start. However I'm afraid that we will
> need a bit more complex solution to this problem. Maybe do a short
> sleep, check the cache size and if it increased more than some
> threshold, sleep again.

> Something as:

> 	int retries = MAX_RETRIES;
> 	unsigned long cached_prev, cached_cur = get_cached_size();

> 	do {
> 		usleep(SHORT_SLEEP);

> 		cached_prev = cached_cur;
> 		cached_cur = get_cached_size();

> 		if (cached_cur < cached_prev)
> 			break;

> 		if (cached_cur-cached_prev < CACHE_INC_THRESHOLD)
> 			break;

> 	} while (retries-- > 0);

Yeah, few loops with shorter usleep() and proactive checking is for sure way
better than single usleep(). Will you please have time to send the above as a
patch? I'll test it for you.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
