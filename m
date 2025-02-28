Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23511C282C6
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 17:43:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5A6B3C9ECB
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 18:43:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 085B13C9DD9
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:43:29 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9FC236161BF
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:43:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6E7C21163;
 Fri, 28 Feb 2025 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740764606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY6+yAAMCuEdpkqjeF8DFczRBQZDjxHeNepXHJKVFQs=;
 b=LJWhY1DesYNSPiOdmEBqSLkC0RV5MSdt7bbGKe70fLJfqw0VqdU/8hw7Vgr2X8RW5WGxaX
 o+ny0TwVXyjgp47g0JX02SY22tF85lTp4D1iF1vpSH0pdKVgW7NXd1I4IU2XBVl2usDHe6
 mWSqRVp4Gy7YNykxXaXX1OSafxDgJNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740764606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY6+yAAMCuEdpkqjeF8DFczRBQZDjxHeNepXHJKVFQs=;
 b=YVndCiEwqegoXvc2HqQhpNlRdkE2l5uvpcTeBSZFRgFfVziQ3zrldjaPzhCpRLvPvhmWAa
 7ROXtQiAzo/dO4Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740764606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY6+yAAMCuEdpkqjeF8DFczRBQZDjxHeNepXHJKVFQs=;
 b=LJWhY1DesYNSPiOdmEBqSLkC0RV5MSdt7bbGKe70fLJfqw0VqdU/8hw7Vgr2X8RW5WGxaX
 o+ny0TwVXyjgp47g0JX02SY22tF85lTp4D1iF1vpSH0pdKVgW7NXd1I4IU2XBVl2usDHe6
 mWSqRVp4Gy7YNykxXaXX1OSafxDgJNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740764606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY6+yAAMCuEdpkqjeF8DFczRBQZDjxHeNepXHJKVFQs=;
 b=YVndCiEwqegoXvc2HqQhpNlRdkE2l5uvpcTeBSZFRgFfVziQ3zrldjaPzhCpRLvPvhmWAa
 7ROXtQiAzo/dO4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 943E51344A;
 Fri, 28 Feb 2025 17:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lXy2Ir71wWcCdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Feb 2025 17:43:26 +0000
Date: Fri, 28 Feb 2025 18:43:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250228174325.GA3278043@pevik>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250228172439.3276777-3-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/5] lib: Allow test to have positional args
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Similar to $TST_POS_ARGS in shell API. This will be used in
> testcases/lib/tst_run_shell.c.

OK this does not work for ash (busybox sh on Alpine):
https://github.com/pevik/ltp/actions/runs/13593238811/job/38004158999

*** Testing LTP test -h option ***
*** Running 'shell_loader.sh -h' (exp: TPASS) ***
tst_test.c:758: TBROK: Unexpected argument(s) 'shell_loader.sh' (1 + 1 < 3)

*** Testing LTP test -i option ***
tst_test.c:758: TBROK: Unexpected argument(s) 'shell_loader.sh' (1 + 1 < 4)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
