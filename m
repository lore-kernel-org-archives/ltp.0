Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1875C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 08:09:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB48E3E4B32
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 10:09:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9084B3C0E9E
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:09:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E46621000EA6
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:09:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AE1D73545;
 Tue, 30 Jun 2026 08:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782806962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9TQGpeHfxWJmr1qATxaAflRxFoK34lPDq2i095hwrT4=;
 b=RWpLhdXGNsi+DyYH68XT38w0OV9pLaXduHCGCjtMCi2xsXOo1AWorNZ+aMb6Ph/5I5lrdU
 JH7dEgK8y8Iyyx4DazRn3Dg0oSBYTdv4NoOz+d54KQmscLQMWrUBpmkD1nxL6GOGMa9Rvi
 5ujPpB4JDO7fyUrc2rdQALFcd8WBCXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782806962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9TQGpeHfxWJmr1qATxaAflRxFoK34lPDq2i095hwrT4=;
 b=NTm8BbIIBt52/FzuKwf0q7BVn8Ngiw/vgx/D7V8iW2Mpv4MCRie8KENz3MeZZNwBE4Ql7Q
 vcNoqjpyszqmn9DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782806962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9TQGpeHfxWJmr1qATxaAflRxFoK34lPDq2i095hwrT4=;
 b=RWpLhdXGNsi+DyYH68XT38w0OV9pLaXduHCGCjtMCi2xsXOo1AWorNZ+aMb6Ph/5I5lrdU
 JH7dEgK8y8Iyyx4DazRn3Dg0oSBYTdv4NoOz+d54KQmscLQMWrUBpmkD1nxL6GOGMa9Rvi
 5ujPpB4JDO7fyUrc2rdQALFcd8WBCXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782806962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9TQGpeHfxWJmr1qATxaAflRxFoK34lPDq2i095hwrT4=;
 b=NTm8BbIIBt52/FzuKwf0q7BVn8Ngiw/vgx/D7V8iW2Mpv4MCRie8KENz3MeZZNwBE4Ql7Q
 vcNoqjpyszqmn9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46751779A8;
 Tue, 30 Jun 2026 08:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NMJIELJ5Q2rCfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jun 2026 08:09:22 +0000
Date: Tue, 30 Jun 2026 10:09:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <20260630080916.GA225459@pevik>
References: <20260630071639.2248082-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260630071639.2248082-1-wakel@google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test.sh: Replace GNU word boundary \b with \<
 in grep
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
Cc: ttritton@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Terence, Wake,

> The regex word boundary extension '\b' is a GNU extension and is not
> supported by Toybox and lightweight POSIX regex implementations
> (such as Bionic libc), causing grep to fail with:

>     grep: bad regex '^[^#]*\bTST_': trailing backslash (\)

Thanks, merged.

> Replace '\b' with '\<' to ensure shell tests run correctly on
> lightweight environments such as Android (Toybox).

Out of curiosity, in the end you plan to use LTP shell tests? Although skipped
tests did not mention any shell test, we did not expect you'd be running it.
FYI tst_test.sh (aka "new API") is being slowly replaced by new "shell loader"
API [2] (or tests are rewritten in C).

I also wonder if you use our new runner kirk already [3].

Kind regards,
Petr

[1] https://android.googlesource.com/platform/external/ltp/+/refs/heads/main/android/skipped-tests.txt
[2] https://linux-test-project.readthedocs.io/en/latest/developers/api_shell_tests.html
[3] https://github.com/linux-test-project/kirk

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
