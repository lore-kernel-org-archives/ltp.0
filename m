Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514DDFF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 12:13:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8C013E49F6
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:13:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E03833DC1F0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 14:12:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 109EE10009D8
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 14:12:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CFC75BD42;
 Tue, 28 Apr 2026 12:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777378366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twEglyqWiKK3ynbahfxX5QyqFK0OJEkN5vrS7mvzsfo=;
 b=0p5GCRZPGWZtXiM5eQlQt3yOZneBFtB1a1Me1b/MfqL0CeK1rPgB61YfPdhJW1NbjN5/u1
 /yRNl+QgsuMdYi5c7NOR+WDABUcYDSeHxZvri/X1Z/5aPf2BNH0YtAK0aWomRFFydPCHLE
 y2j3UeX9pgp7FOjVq7aZmU81dz2XPZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777378366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twEglyqWiKK3ynbahfxX5QyqFK0OJEkN5vrS7mvzsfo=;
 b=pEAjwI2M1XHn2NnLgJ8+eal+sYlr7jEHamdin25QbPPAZmos+4/HJPeDaqEUfagTKMBixN
 69RaEvO7K1BMgyBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0p5GCRZP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pEAjwI2M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777378366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twEglyqWiKK3ynbahfxX5QyqFK0OJEkN5vrS7mvzsfo=;
 b=0p5GCRZPGWZtXiM5eQlQt3yOZneBFtB1a1Me1b/MfqL0CeK1rPgB61YfPdhJW1NbjN5/u1
 /yRNl+QgsuMdYi5c7NOR+WDABUcYDSeHxZvri/X1Z/5aPf2BNH0YtAK0aWomRFFydPCHLE
 y2j3UeX9pgp7FOjVq7aZmU81dz2XPZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777378366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twEglyqWiKK3ynbahfxX5QyqFK0OJEkN5vrS7mvzsfo=;
 b=pEAjwI2M1XHn2NnLgJ8+eal+sYlr7jEHamdin25QbPPAZmos+4/HJPeDaqEUfagTKMBixN
 69RaEvO7K1BMgyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18AF9593B0;
 Tue, 28 Apr 2026 12:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UzqOAz6k8Gk2GgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Apr 2026 12:12:46 +0000
Date: Tue, 28 Apr 2026 14:12:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <wangli.ahau@gmail.com>
Message-ID: <20260428121240.GA914888@pevik>
References: <20260423084123.657690-1-pvorel@suse.cz>
 <20260423084123.657690-6-pvorel@suse.cz>
 <20260423093834.GA664424@pevik>
 <CANgNiRz_vKp6zKrHoUDKF288Wyr3NW7EBvUJJP+Vu663g3bAOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANgNiRz_vKp6zKrHoUDKF288Wyr3NW7EBvUJJP+Vu663g3bAOQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_SEVEN(0.00)[7];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 8CFC75BD42
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [PATCH v5 5/6] lib: Merge
 functionality of LTP_QUIET into LTP_REPRODUCIBLE_OUTPUT
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
Cc: valgrind-developers@lists.sourceforge.net,
 Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Petr,

> Reviewed-by: Li Wang <li.wang@linux.dev>

> Tiny note: it would be appreciated if your replace all the reviewed-by
> with my new account in this patchset.

Sure, I can do it. I thought they were added as part of your work for Red Hat
(added in March 27, 2026), so that it's kind of RH credit :).

BTW the patch needs fix below (find by AI review), but posted to the 1st commit.

Kind regards,
Petr

diff --git doc/users/setup_tests.rst doc/users/setup_tests.rst
index 491a5b003a..e8f6950fff 100644
--- doc/users/setup_tests.rst
+++ doc/users/setup_tests.rst
@@ -43,7 +43,7 @@ users.
        Shell language: ``TST_NEEDS_DEVICE=1``.
 
    * - LTP_REPRODUCIBLE_OUTPUT
-     - When set to ``1`` or ``y`` uppress printing TCONF, TINFO and TDEBUG
+     - When set to ``1`` or ``y`` suppress printing TCONF, TINFO and TDEBUG
        messages and discards the actual content of the other messages printed
        by the test (suitable for a reproducible output).
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
