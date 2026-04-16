Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921CDF8D765
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 18:12:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11C653E7528
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 20:12:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1A173E5B61
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:11:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CB7B4600054
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:11:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9617A5BD43;
 Thu, 16 Apr 2026 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776363099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TXcdpZFXvNB30vDclYCiENmQ7byh92bfM7GZQ0+WZYE=;
 b=kznwaYq+UrhoEqNMUdsU39cy6KmphXyo5c2fLff94XHMJ3IjZGlx+WSo7bOjP1N4i5i0NJ
 heIAUskhgJX+/OF8jkh2vmVuJJWjEwSIJGZoqVtROyMgsWfX51M8J9WUuNCONbBFEeS943
 jcyxl3OYc3YUt/92TV90YidOa7LB/sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776363099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TXcdpZFXvNB30vDclYCiENmQ7byh92bfM7GZQ0+WZYE=;
 b=NzRk5GKWTiVTGc2LCWKfk0GlV/8Fl71U0mFHuA1zYtojpczDDab8OcgsfcpJwFG4s3/zY6
 kfk+2J8Rc8PLpQAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776363099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TXcdpZFXvNB30vDclYCiENmQ7byh92bfM7GZQ0+WZYE=;
 b=kznwaYq+UrhoEqNMUdsU39cy6KmphXyo5c2fLff94XHMJ3IjZGlx+WSo7bOjP1N4i5i0NJ
 heIAUskhgJX+/OF8jkh2vmVuJJWjEwSIJGZoqVtROyMgsWfX51M8J9WUuNCONbBFEeS943
 jcyxl3OYc3YUt/92TV90YidOa7LB/sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776363099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TXcdpZFXvNB30vDclYCiENmQ7byh92bfM7GZQ0+WZYE=;
 b=NzRk5GKWTiVTGc2LCWKfk0GlV/8Fl71U0mFHuA1zYtojpczDDab8OcgsfcpJwFG4s3/zY6
 kfk+2J8Rc8PLpQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C245593A3;
 Thu, 16 Apr 2026 18:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jUJoCVsm4WnobgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Apr 2026 18:11:39 +0000
Date: Thu, 16 Apr 2026 20:11:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260416181129.GB303991@pevik>
References: <CANgNiRztOnor2mgLyfGxiCE01qyBwcsnZcrv1ZUi14KeFzctQw@mail.gmail.com>
 <20260416144626.6037-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260416144626.6037-1-always.starving0@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include/lapi: add leaf Makefile
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

Hi Jinseok,

> Hi,

> Thanks for the review!
Yw.

> If we switch to generic_trunk, the current directory is not checked;
> only subdirectories are traversed.

FYI by this I meant this change (part of more changes stated previously):

diff --git include/Makefile include/Makefile
index 6b31b046e4..84cd4ed6e3 100644
--- include/Makefile
+++ include/Makefile
@@ -24,4 +24,4 @@ ac-maintainer-clean:: ac-clean

 vpath %.h $(abs_srcdir)

-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk

> For example, running `make check` in include/ will descend into
> include/lapi, and running `make check` in include/lapi will descend
> into include/lapi/syscalls.

And with that change make check in include works:

ltp/include $ make check-tst_fs.h
CHECK include/tst_fs.h
tst_fs.h:83: CHECK: 'swtich' may be misspelled - perhaps 'switch'?
tst_fs.h:157: WARNING: please, no spaces at the start of a line
tst_fs.h:157: WARNING: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
make: [../include/mk/rules.mk:69: check-tst_fs.h] Error 1 (ignored)

ltp/include/lapi $ make check-tls.h
CHECK include/lapi/tls.h
tls.h:1: WARNING: Improper SPDX comment style for 'tls.h', please use '/*' instead
tls.h:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
tls.h:35: WARNING: do not add new typedefs
tls.h:49: WARNING: Missing a blank line after declarations
tls.h:56: WARNING: Missing a blank line after declarations
make: [../../include/mk/rules.mk:69: check-tls.h] Error 1 (ignored)

Kind regards,
Petr

> Thanks,
> Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
