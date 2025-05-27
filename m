Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB4AC54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 08:58:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D73043C57AF
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 10:58:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C6AE3C535B
 for <ltp@lists.linux.it>; Tue, 27 May 2025 10:58:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 55C52140BB91
 for <ltp@lists.linux.it>; Tue, 27 May 2025 10:58:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE51621A8F;
 Tue, 27 May 2025 08:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748336282;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oO82SX8/kWs6p+of0g5Qr5E9ILa05la7LjoQE64kFXA=;
 b=O+GTF0vk3pDlhbe10YZvNA1Q5fpWBKjJMNDORs0LbUh6vkbtjNA/DHXxDhCwszdzGQaA2I
 Tsd62ez3mtPLOgfMy2NOlpvYvsnHTOeBwYdMMPInU1NwhkzBUUq92YnbMlTx9JzS38rfun
 RFCNqeWauGVbg/ynXHCiyJjaK9OTCaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748336282;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oO82SX8/kWs6p+of0g5Qr5E9ILa05la7LjoQE64kFXA=;
 b=QIkuLvmY3GFmsr5Bitcc1Ob0mmsqX4iaYBRPU9oeLyU0dd3peDs43/CGyOnrjy9/SuGOBn
 m296q/VPw4T3oEBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748336281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oO82SX8/kWs6p+of0g5Qr5E9ILa05la7LjoQE64kFXA=;
 b=qxt9KO5zR2BZSuRUGs+fSEnKG96R8adAvyiX7S2jqfqFNMUnRSuvJF4xsx/P7dO2kC+a5o
 ailTNgSlEOoUNaRhfaTC4xzpBLmNKUkhh2KGXVb3X4Dqaq638PT3kbOb2a3tWzd5fhYRD8
 kV4AtKef/sQHNIf8Vs+VTTpeZPbntfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748336281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oO82SX8/kWs6p+of0g5Qr5E9ILa05la7LjoQE64kFXA=;
 b=L+OAQCuJFKM+4XoQn6SRP+bKYybsS3Ylt81OGVF/nm6gGxwLw2eslgpcAwwHakhIaL8psF
 OCus9l7gPfkMo0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80B1E1388B;
 Tue, 27 May 2025 08:58:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 25dgHpl+NWjxTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 May 2025 08:58:01 +0000
Date: Tue, 27 May 2025 10:58:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250527085800.GB173684@pevik>
References: <20250516151028.1254207-1-wegao@suse.com>
 <20250526143551.1321709-1-wegao@suse.com>
 <20250526095456.GA118123@pevik> <aDRkbKVKCawsnBlR@yuki.lan>
 <20250526161309.GA152789@pevik> <aDV2pqgZGmKKeJWC@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aDV2pqgZGmKKeJWC@yuki.lan>
X-Spamd-Result: default: False [-4.50 / 50.00]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP doc: test examples [was: Re: [PATCH v2] fsconfig04.c:
 Check FSCONFIG_SET_PATH]
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
Cc: "Ricardo B. Marliere" <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> > Thanks! I forget the rewrite allows this nice syntax.

> > We should have (after the release) some examples somewhere (not sure if
> > the docs in @filesystems in include/tst_test.h could be extended or we can dare
> > to have static page with examples as we had in the old API - might be easier to
> > search).

> I would say that the documentation for the tst_test structure is already
> too long.

> > And/or C API tests in lib/newlib_tests/.

> Having small C examples in newlib_tests

Add test for .filesystems
https://github.com/linux-test-project/ltp/issues/1243

> and then rendering them into
> examples section into the documentation would be awesome.

Render examples from newlib_tests into docs
https://github.com/linux-test-project/ltp/issues/1244

Feel free to modify them both.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
