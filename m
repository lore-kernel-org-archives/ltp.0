Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1C410A62DA
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 14:16:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A72AC3CD1A3
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 15:16:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BF1B3C572F
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 15:16:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 365B81A011DF
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 15:16:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2CC404D2B5;
 Thu, 26 Mar 2026 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774534579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgSS5on+SV3+UAbcatQ03SjfZtSq1TAbcu1vpwox4tc=;
 b=gXEw8+SILTTMUOMiDpEE2DN9IJ0Q4xsMJhstALfh2m1KG4Vwbj4SklHkfkIqAntTzeLArL
 bIlI5AOmF6Hu4z1la2H/q0ubF+ikliQEBwHRX5C40+HYqTk0Q8aC4ej+w/gOZsCuTnexvH
 CN0v/ODhMFsGlWhbl9us/xZ/KNFUCsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774534579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgSS5on+SV3+UAbcatQ03SjfZtSq1TAbcu1vpwox4tc=;
 b=xICiiWWpAf34G9aA8QWntNhG3LVfW6uZ6XqXWBzYXf5qTt/pApht3cyEf6AY6opNpBaBHX
 TFYs88s1LwvcyeDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774534579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgSS5on+SV3+UAbcatQ03SjfZtSq1TAbcu1vpwox4tc=;
 b=gXEw8+SILTTMUOMiDpEE2DN9IJ0Q4xsMJhstALfh2m1KG4Vwbj4SklHkfkIqAntTzeLArL
 bIlI5AOmF6Hu4z1la2H/q0ubF+ikliQEBwHRX5C40+HYqTk0Q8aC4ej+w/gOZsCuTnexvH
 CN0v/ODhMFsGlWhbl9us/xZ/KNFUCsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774534579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgSS5on+SV3+UAbcatQ03SjfZtSq1TAbcu1vpwox4tc=;
 b=xICiiWWpAf34G9aA8QWntNhG3LVfW6uZ6XqXWBzYXf5qTt/pApht3cyEf6AY6opNpBaBHX
 TFYs88s1LwvcyeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0812D4A0A3;
 Thu, 26 Mar 2026 14:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KU6QOrI/xWkMGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 26 Mar 2026 14:16:18 +0000
Date: Thu, 26 Mar 2026 15:16:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <acU_qVvxBoi-D-Nj@yuki.lan>
References: <20260205135724.23772-1-chrubis@suse.cz>
 <20260205174756.GA338897@pevik> <aYWfNaJeXqut0Isb@redhat.com>
 <20260206082303.GA364017@pevik>
 <CAEemH2fDFBzoMvkZ_ZDPFCZVyMn2Dq0Ro6xBLTELRTK24Ey6eg@mail.gmail.com>
 <acU-LbVnVWoNwvwm@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acU-LbVnVWoNwvwm@yuki.lan>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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
> > This is something worth thinking about carefully, btw, next week is
> > our spring festival hoday. I maybe reply you a bit later :).
> 
> Did we reach any conclusion here?

We already have the fix in LTP, I should have checked. 

> I think that we should implement different debug levels in LTP and drop
> LTP_QUIET in the process. Does that sounds reasonable?

So maybe LTP_QUIET can be replaced with debug level 0?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
