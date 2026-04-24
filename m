Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DCDFE520D
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 11:36:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE2543E535D
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 13:36:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1DF33E4A72
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 13:36:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7793810009AA
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 13:36:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8879C5BCD2;
 Fri, 24 Apr 2026 11:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777030572;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vw8I5Oi0dLgQOZv88UQGFCRxExZBfmoEqgZhuE4h8Yc=;
 b=nUI4ifSLaoCUiSW6IVApiAp55GhhXAwEAfDlo7X86/pIlxWVkytUfFTrVfqt65nx9KyJ6L
 zo1vyKdUma8yQQQmQpoGsZQa/T4NQCT8UEUd8EVjiYSvGIDlpqqnb1hyGCiiKSS+3hRNS7
 YR0l8X9QVZUpxXakJbErtsOJu509o1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777030572;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vw8I5Oi0dLgQOZv88UQGFCRxExZBfmoEqgZhuE4h8Yc=;
 b=2lcRvhDZXhsIyx/tI6PTb6ogaS6Iua5gDmbVOrdC/Ls88/5od/4l/7HGneGDBnOnPR17Jo
 n+RysiMhsxK7f8Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777030568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vw8I5Oi0dLgQOZv88UQGFCRxExZBfmoEqgZhuE4h8Yc=;
 b=K3jmdbWLGf8mvoMTrWY33gGVJoAmw5upjkZyYY9l2mLLhChhjf5UJQSJhL61YnwN1f1aA8
 HWNYnf213zNbvO1gE4a1AH8lwYh5cnx6l137wpOgYWXzOM8g8dVa8xPEFoeMIuYK/SdArB
 dmvsMsRaX77XKxL+3xz1RxAVmiYuXaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777030568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vw8I5Oi0dLgQOZv88UQGFCRxExZBfmoEqgZhuE4h8Yc=;
 b=EUQvDY2BK1+lGEpjorNGrpF1Er0Cmohhaf3QUit06bSldWPCxZjbBd0xTu0W1UJnbaNSPB
 U83ng10AyHQBY+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70D5F593A4;
 Fri, 24 Apr 2026 11:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VpIrGqhV62nWQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 11:36:08 +0000
Date: Fri, 24 Apr 2026 13:36:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260424113607.GA509887@pevik>
References: <20260424093919.500059-2-pvorel@suse.cz>
 <20260424102542.3916-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260424102542.3916-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Update spellings to next-20260423
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

> Hi Petr,

> --- [PATCH 4/4] ---

> On 2026-04-24, Petr Vorel wrote:
> > checkpatch: Enable more checks, disable ENOSYS

> > -# TODO: document reason
> > ---ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,CONCATENATED_STRING
> > +--ignore CONST_STRUCT,VOLATILE,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,MULTIPLE_ASSIGNMENTS

> PREFER_KERNEL_TYPES is already listed in the "kernel specific" --ignore block
> added in patch 3/4. Remove it from this line to avoid the duplicate.

+1 valid!

If that's the only change, I'd amend this commit before merge.

Kind regards,
Petr

+++ .checkpatch.conf
@@ -13,7 +13,7 @@
 --ignore PREFER_KERNEL_TYPES,STRCPY,STRLCPY,STRNCPY
 
 # TODO: document reason
---ignore CONST_STRUCT,VOLATILE,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,MULTIPLE_ASSIGNMENTS
+--ignore CONST_STRUCT,VOLATILE,FILE_PATH_CHANGES,LONG_LINE,MACRO_ARG_REUSE,MULTIPLE_ASSIGNMENTS
 
 # ENOSYS is used in test error macros
 --ignore ENOSYS

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
