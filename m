Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57514C02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 11:16:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB41F3C7BCA
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:16:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B748A3C4D06
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:15:50 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B7D5461957B
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:15:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2CB88211D4;
 Thu, 16 Jan 2025 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737026147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D1RZu0DOyuU/jpQrokpeRyXXb9txRvcyF1KaNXkqbR0=;
 b=NLQ/OBcrAtjNwGrIFeZWoMNbeoASei+9MkuC2fwXGabI7Bs791020wkvpkGuqOKT/nIG5L
 KvbpTut/gc0ugHGRiVNS9clAgx21fp6wnLO+jIgzaH2p+6c9O2D+auG/QybFj+OvnYFooK
 EniDZYRlFv5zLLCM4MaZHtPHhHyv16I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737026147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D1RZu0DOyuU/jpQrokpeRyXXb9txRvcyF1KaNXkqbR0=;
 b=McC3mp7hQKZ90i9N5eYzRriE08qoIJwaI+wWp6FaaIHtzCtydajesTpDrY/Nyx8ajFpP+r
 7cS1NNRWafqc1xCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737026146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D1RZu0DOyuU/jpQrokpeRyXXb9txRvcyF1KaNXkqbR0=;
 b=DBaqmxS0XbrMsQH/Kexj2c4FYU2ZAVk49iObwnHfVc5WiUaOiQTjhwphUwxOEjN1eKrTbn
 zN1KZ5BxxCCcncd7si0VWE2oOgMQUC/ChgHy2AQYJ0w4bqYGAXPaUp/I2M7HtzflJt9Sl7
 XGn1unlCMNGAC8Zt2z95KCN0OOAO0RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737026146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D1RZu0DOyuU/jpQrokpeRyXXb9txRvcyF1KaNXkqbR0=;
 b=Rwt6JiqNsJtJpBYHciHZ2v0bPl2aGKbI8neU+ND6hx6/3imdCpHZidTWdYi5kP2jxi/JPf
 JXAbrjlUCIJiuwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1042213332;
 Thu, 16 Jan 2025 11:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tVbRAmLqiGdaOwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Jan 2025 11:15:46 +0000
Date: Thu, 16 Jan 2025 12:15:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4jqWbkdTsfVmfZL@yuki.lan>
References: <20250109150336.25235-1-chrubis@suse.cz>
 <20250109161851.GB355678@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250109161851.GB355678@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] safe_macros: Fix confusing safe_read() failure
 output
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
> > In the case that we read() less bytes than expected in the strict mode
> > we used the same tst_brk() as for the case when read() fails. However
> > for short reads the errno is in an udefined state and we possibly end up
> > with confusing TBROK message. Andrea reported EACESS ernno in the TBROK
> nit: s/ernno/errno/
> 
> > message on a short read() while developing tests.
> 
> Good catch!
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Pushed, thanks.

> FYI safe_write() also has TERRNO in len_strict.
> 
> Kind regards,
> Petr
> 
> +++ lib/safe_macros.c
> @@ -554,7 +554,7 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
>  
>  		if (len_strict == SAFE_WRITE_ALL) {
>  			if ((size_t)rval != nbyte)
> -				tst_brkm_(file, lineno, TBROK | TERRNO,
> +				tst_brkm_(file, lineno, TBROK,
>  					cleanup_fn, "short write(%d,%p,%zu) "
>  					"return value %zd",
>  					fildes, buf, nbyte, rval);

I guess that we are missing check for invalid return value from write()
as well and return in the rval == -1 branch, we probably need to add:

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index b224a5861..3d3e7c693 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -551,6 +551,14 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
                        tst_brkm_(file, lineno, TBROK | TERRNO,
                                cleanup_fn, "write(%d,%p,%zu) failed",
                                fildes, buf, nbyte);
+                       return rval;
+               }
+
+               if (rval < 0) {
+                       tst_brkm_(file, lineno, TBROK, cleanup_fn,
+                                 "invalid write() return value %zi",
+                                 rval);
+                       return rval;
                }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
