Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3407FC3ABA3
	for <ltp@archiver.kernel.org>; Fri,  2 May 2025 08:51:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C2C03CBE52
	for <ltp@archiver.kernel.org>; Fri,  2 May 2025 10:51:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD26C3CBC2A
 for <ltp@lists.linux.it>; Fri,  2 May 2025 10:51:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7FF63680458
 for <ltp@lists.linux.it>; Fri,  2 May 2025 10:51:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA6951F388;
 Fri,  2 May 2025 08:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746175867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzwaCT9NB7Hv48hwjzCIsWCYDAC3l0BKodvMQV1/Io4=;
 b=AWfwCbDqecmGav1eoMD8bBWQVjvPN2IqpveTlbADCYOBRtlBLevVJ+G8jRW/xD2y1ch7WL
 LyydqTeU/5j3+tY7bMaCfusKO0kKWOsEWsj0AR5Jf9gQR7zjv02OBYbfWVqnRVCfNsNswa
 CNFc/tniuVoHNNKe4oLwAsC/urg4a9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746175867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzwaCT9NB7Hv48hwjzCIsWCYDAC3l0BKodvMQV1/Io4=;
 b=fUIc2k2zPXUdAu3znMGrxXDC89/W/rR6hotcvoZumR35yZn7N86QhrfZtCGDLls3J8bv57
 +90vmbFjVvNespBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746175867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzwaCT9NB7Hv48hwjzCIsWCYDAC3l0BKodvMQV1/Io4=;
 b=AWfwCbDqecmGav1eoMD8bBWQVjvPN2IqpveTlbADCYOBRtlBLevVJ+G8jRW/xD2y1ch7WL
 LyydqTeU/5j3+tY7bMaCfusKO0kKWOsEWsj0AR5Jf9gQR7zjv02OBYbfWVqnRVCfNsNswa
 CNFc/tniuVoHNNKe4oLwAsC/urg4a9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746175867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzwaCT9NB7Hv48hwjzCIsWCYDAC3l0BKodvMQV1/Io4=;
 b=fUIc2k2zPXUdAu3znMGrxXDC89/W/rR6hotcvoZumR35yZn7N86QhrfZtCGDLls3J8bv57
 +90vmbFjVvNespBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9FF713687;
 Fri,  2 May 2025 08:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cZitKHuHFGgkTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 02 May 2025 08:51:07 +0000
Date: Fri, 2 May 2025 10:51:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aBSHoimhpmTj1l_A@yuki.lan>
References: <20250430130417.43523-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250430130417.43523-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/4] shell loader rewrite to support TST_SETUP
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
> we are getting there, but not yet finished.
> 
> one remaining problem - it requires *full* path in PATH. I wonder what
> basic I'm missing.  The current change requires to use full path
> otherwise execvpe() fails.
> 
> I suppose it is due change cwd due creating temporary directory - it
> fails only with:
> "needs_tmpdir": true
> shell_loader_setup_cleanup.sh does not suffer this problem.
> It's also not dash related, problem is on bash as well.

That is exactly it. The test cannot run scripts that it cannot find so
we need an absolute path to the directory the scripts are in. If you
look at run_tests.sh we do srcdir=$(realpath $(dirname $0)) and prefix
all the paths with that directory.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
