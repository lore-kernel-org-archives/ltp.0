Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95166C982D7
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 17:01:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 341FC3EAE1A
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 19:01:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2271D3E920A
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 19:01:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA5706008A9
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 19:01:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D41421AA2;
 Fri, 18 Sep 2026 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789750875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVbpljRFyqdeDoq/MfwtFd+AhlD4KCCyKNcOIuDG0kI=;
 b=xroGOI/X8+m5JkjJBQR0g5aQ2LZ2GwxXXg079itVaDNiOzg/9dtG2cZ7Tjuud/rqb5RQn2
 qGgJl6Wk8ex57txmzC8zsw182q3WbBkm6zzL/Q13L0Zr66d45bT20nhEOQu4uDDA7PDiIq
 UgD6/AGeximQKfWZ5cIS/dRytYA+6jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789750875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVbpljRFyqdeDoq/MfwtFd+AhlD4KCCyKNcOIuDG0kI=;
 b=zdn4s+kGFx91k5M5guRDCuLQNZyK0lRLSdQfDY7Z9ZyIoz+MXU4+4CF/g/eWXTBtjtEhBs
 fRkDsV9yuZSy3XDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789750871;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVbpljRFyqdeDoq/MfwtFd+AhlD4KCCyKNcOIuDG0kI=;
 b=CIXqThgcf1ihlJaDQnVDJFeewgY7MQDvLRXp8gh0ka7jXoX8nY89PFyeeDetMqnxvIZRY3
 27gc0rBMGwqZkHIp9Pt2QBihOfP7QLmuPtdi1ySSfvZvumgr58P1bGkDuGrDcRrB/AQdmM
 3OChzDmRUt7CwdVRw8ae6JN085o5Bu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789750871;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVbpljRFyqdeDoq/MfwtFd+AhlD4KCCyKNcOIuDG0kI=;
 b=OYhSqlrijPj7gpV8i7GbBYIAr+Tz1DPGY/QIenpm/1PWj9TDJzneeLdKa9u0xa76ALCx6q
 BNHLWdC/pktK9CCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD8BD133CF;
 Fri, 18 Sep 2026 17:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s2h5IlZurWrTHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Sep 2026 17:01:10 +0000
Date: Fri, 18 Sep 2026 19:01:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260918170108.GD1973373@pevik>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-28-pvorel@suse.cz>
 <aq1WHcDZqhKIU54T@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aq1WHcDZqhKIU54T@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 27/36] keyctl31: Test KEYCTL_PKEY_ENCRYPT and
 KEYCTL_PKEY_DECRYPT
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

Hi Cyril,

> > +static const char plaintext[] = "LTP_PKEY_ENCRYPT_DECRYPT_TEST_32";
> > +#define PLAINTEXT_SIZE	(sizeof(plaintext) - 1)
> > +static unsigned char ciphertext[CIPHERTEXT_SIZE];
> > +static unsigned char decrypted[CIPHERTEXT_SIZE];

> Shouldn't these two be in the guarded buffers as well? I would say that
> it's pretty much important that the kernel does not touch anything
> outside of these arrays during encryption/decryption.

In the end I stopped here. To be honest I was not sure if array should be passed
with pointer (I suppose) or without to the struct tst_buffers. Because we don't
use it like this anywhere in the code.

Also, not only this keyctl31.c and keyctl36.c, but maybe also keyctl25.c and
keyctl27.c could be using it.

We have still few tests to merge keyctl31.c to keyctl37.c (the last 2 are really
on Andrea). Ideally you do the final changes. Feel free to use andrea/keyctl.v4
in my fork (that way you will not have to download the patches manually).

Kind regards,
Petr

> Otherwise:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
