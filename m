Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D95C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 12:20:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D7C83CF965
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:20:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 308DF3CB8E6
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:20:07 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D6161400F47
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:20:06 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08F152202F;
 Tue, 30 Jan 2024 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706617206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sdj/62nwfGZimDaZ7Bw+Ql0Io1+W2UbHc5GysDLWdjM=;
 b=k0+1TlV5ZA4T4B8EmcI8DS/HBJKxZdLFcpyk++O6U1ro/Xz8AjbJfrs9zuBVAtrh2wTvjv
 kLgImLwibCBhMYJuekv1JXZUcpTm0sMJCZCd5MDZ0bB7F4addld0ezCWq7d7maezdQJ0RT
 0tJIZPd/YC/3wzFUbuSNIZiFYJpm9m4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706617206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sdj/62nwfGZimDaZ7Bw+Ql0Io1+W2UbHc5GysDLWdjM=;
 b=x5t5MR3CmxswXUw4P7RXIJ/Ek02vXainrecuZQT65HJBbZ1R317F1SURijFv62tdk9kFqW
 7pd1W/q/sKszLOCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706617206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sdj/62nwfGZimDaZ7Bw+Ql0Io1+W2UbHc5GysDLWdjM=;
 b=k0+1TlV5ZA4T4B8EmcI8DS/HBJKxZdLFcpyk++O6U1ro/Xz8AjbJfrs9zuBVAtrh2wTvjv
 kLgImLwibCBhMYJuekv1JXZUcpTm0sMJCZCd5MDZ0bB7F4addld0ezCWq7d7maezdQJ0RT
 0tJIZPd/YC/3wzFUbuSNIZiFYJpm9m4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706617206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sdj/62nwfGZimDaZ7Bw+Ql0Io1+W2UbHc5GysDLWdjM=;
 b=x5t5MR3CmxswXUw4P7RXIJ/Ek02vXainrecuZQT65HJBbZ1R317F1SURijFv62tdk9kFqW
 7pd1W/q/sKszLOCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C174A13462;
 Tue, 30 Jan 2024 12:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id x7rvLHXpuGWtGgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 12:20:05 +0000
Date: Tue, 30 Jan 2024 13:20:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240130122004.GC766274@pevik>
References: <20240117080446.9663-1-wegao@suse.com>
 <20240117125227.24700-1-wegao@suse.com>
 <20240117125227.24700-2-wegao@suse.com> <Za-X2FD2qfv-xbbe@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Za-X2FD2qfv-xbbe@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[45.51%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] lib: TST_EXP_FAIL_PTR
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

Hi Wei, Cyril,


> Hi!
> > +#define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, ERRNOS, ERRNOS_CNT, ...)       \
> > +	do {                                                                   \
> > +		TESTPTR(SCALL);                                                \
> > +		                                                               \
> > +		TST_PASS = 0;                                                  \
> > +		                                                               \
> > +		if (TST_RET_PTR) {                                             \

> Unfortunatelly there are two types of calls, one returns NULL on a
> failure and the second returns (void *)-1, from the top of my head these
> are mmap(), shmat() and possibly other memory related syscalls.

> So I suppose that this macro needs another parameter for the actual
> value that is returned on a failure:

> #define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ERRNOS, ...)
> 	do {
> 		TESTPTR(SCALL);

> 		...

> 		if (TST_RET_PTR == FAILPTR_VAL) {
> 		...

+1

> The hard question is if we want to pass this parameter explicitly from the
> macros used by the tests, i.e. if each test would need to specify a
> FAIL_PTR_VAL or if we want to pass it in the macros, but that would mean
> that the number of macros will explode again and we would have to figure
> out a good names. So maybe it would be easier to pass them from each
> test.

Names could be _NULL and _VOID, but I understand you want to limit number of
macros.

Wei, I guess testcases/kernel/syscalls/realpath/realpath01.c could use
TST_EXP_FAIL_PTR().

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
