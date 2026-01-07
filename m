Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD353CF6BF4
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 08:10:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 718C53C2EB7
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 09:10:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2718F3C2CC4
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 09:10:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B97BD2001AF
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 09:09:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 98A855BCE4;
 Wed,  7 Jan 2026 08:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767773398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FXjuEgSU6LNlnzu5GYYn8hdYWE1zWEx6epBpJhroWvk=;
 b=parT/pEU3ZWjmvdIshUHw87ypVajiuj5UybwQJxq1Sjarx5WyjOO45MNGRPLqnPufSGTTk
 kstiIDK71NrOVcJomomdHNVwi4Yzc4JFpFaetI5k5ZRMxZthAeivujBm5ua9aFht2knVf1
 M9eBs9UQD6zw4c1ECANDLPb0Ahn2aMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767773398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FXjuEgSU6LNlnzu5GYYn8hdYWE1zWEx6epBpJhroWvk=;
 b=JUudVadlJPItSp1SVBHa9e1LJnFqbwqCW6JEI02HbAdQ/f1yvsUS/U5wIOZ1yuZShfJVBH
 5KABXUE3AVZ6HqBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767773398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FXjuEgSU6LNlnzu5GYYn8hdYWE1zWEx6epBpJhroWvk=;
 b=parT/pEU3ZWjmvdIshUHw87ypVajiuj5UybwQJxq1Sjarx5WyjOO45MNGRPLqnPufSGTTk
 kstiIDK71NrOVcJomomdHNVwi4Yzc4JFpFaetI5k5ZRMxZthAeivujBm5ua9aFht2knVf1
 M9eBs9UQD6zw4c1ECANDLPb0Ahn2aMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767773398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FXjuEgSU6LNlnzu5GYYn8hdYWE1zWEx6epBpJhroWvk=;
 b=JUudVadlJPItSp1SVBHa9e1LJnFqbwqCW6JEI02HbAdQ/f1yvsUS/U5wIOZ1yuZShfJVBH
 5KABXUE3AVZ6HqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78C9B3EA63;
 Wed,  7 Jan 2026 08:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ruGEHNYUXmkaTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 08:09:58 +0000
Date: Wed, 7 Jan 2026 09:09:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260107080957.GD727950@pevik>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
 <20251223020836.9439-3-wegao@suse.com> <aVzdrAgv9qdxZSt_@yuki.lan>
 <aV36R8E-KMD_dTf8@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aV36R8E-KMD_dTf8@autotest-wegao.qe.prg2.suse.org>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/4] tst_test.c: Add tst_cmd_present check if a
 command is present
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

Hi all,

...
> > For a third time, when we get here we asked for something that haven't
> > been tested for so we should tst_brk() here!

> I think you may have missed my earlier explanation of why we should avoid using tst_brk() here.
> https://lore.kernel.org/ltp/aT-5tkQkM_g2VZ35@autotest-wegao.qe.prg2.suse.org/

Wei, I got your point but IMHO you're wrong. I replied to the thread to keep
discussion on the same place.
https://lore.kernel.org/ltp/20260107080545.GC727950@pevik/

Kind regards,
Petr

> > -- 
> > Cyril Hrubis

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
