Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8DFC02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 11:03:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43D343C7B70
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:03:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A9F13C7A3B
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:02:57 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1B03A14320DA
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:02:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 096BC21234;
 Wed, 15 Jan 2025 11:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736938973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jefwJznE1/u7kilgtFJskr75QPbxsaJetxk+FWnMgxA=;
 b=HI6mw1+hNaijV5USCh5JnFEwCk6JAWpfpWgpTqVIXTpfi+GRtMSeQgly4JeRQaDtGGd2XL
 nCK75GIDHtVghkXjF5ci+mnQj72vvonFR5dMDA6QPSqSzH2YnBt+l7zzkH4QyFKwJuU/IO
 F4oZuBAkUcH2C68eatWaQo68jJJQMbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736938973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jefwJznE1/u7kilgtFJskr75QPbxsaJetxk+FWnMgxA=;
 b=jprxTr+PIx/43hC4IYcq0Ex1MpAGW+OpCmJjoB1E+Ui/xDtsKSBGV8N/chT7M+5l4kotMS
 wA72HHeBWpNwH6Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736938971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jefwJznE1/u7kilgtFJskr75QPbxsaJetxk+FWnMgxA=;
 b=LnZTZUITP/sVmDUvz6T5XxWyKibHwM6hpV/TiUw9KPKABMg/UQm0zynHLX27JJMf/9pz7L
 nfFIRs4YBREo6L7nnVHTNCD7vePgssWZRsbnM6axuPo5DrDp2bLozIFjJ3bhjs3w6nbFPe
 Fq/HSDusrUAsnIaRTzVr5dFbXOPo6KI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736938971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jefwJznE1/u7kilgtFJskr75QPbxsaJetxk+FWnMgxA=;
 b=rz1m+gtkvVECZtYSewIslamnQyp9X/a0/sXwLvtEOyNNJV87QTRzKgYHHX5XYq29kzBO1j
 0mgw/udY2EofxCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECB0B13A6F;
 Wed, 15 Jan 2025 11:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wKrvONqVh2cfMwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 15 Jan 2025 11:02:50 +0000
Date: Wed, 15 Jan 2025 12:02:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4eVyQM2kiYrz3f8@yuki.lan>
References: <20241211001418.392890-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241211001418.392890-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, tst_test.sh:url,
 yuki.lan:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Fix TBROK => TWARN evaluation
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
This I suppose got broken in:

commit 55bfa08e179de16773f19b703de70262896383ea
Author: Petr Vorel <pvorel@suse.cz>
Date:   Thu Dec 14 15:00:10 2023 +0100

    tst_test.sh/tst_brk(): Convert only TBROK to TWARN in cleanup


The original code only only depended on TST_DO_EXIT being set. I guess
that the easiest fix here would be actually to revert that patch. That
is because we mostly call the cleanup from _tst_do_exit() which sets the
TST_DO_EXIT before it calls _tst_do_cleanup(). The only place where we
call _tst_do_cleanup() wihout the TST_DO_EXIT is inside of the
_tst_run_iterations(), if we wanted to convert TBROK to TWARN in that
case we can simply do:

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index cfdae0230..ac1caebcb 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -820,6 +820,7 @@ _tst_run_iterations()
                _tst_i=$((_tst_i-1))
        done

+       TST_DO_EXIT=1
        _tst_do_cleanup

        if [ "$TST_MOUNT_FLAG" = 1 ]; then


And possibly change the TST_DO_EXIT to TST_TBROK_TO_TWARN as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
