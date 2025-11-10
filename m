Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5E3CCFA13
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 10:33:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 473763CF590
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 11:33:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0862A3CA989
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 11:33:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5CD3360013D
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 11:33:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E488B33748;
 Mon, 10 Nov 2025 10:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762770779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IZS2mw/XfQVaSfw5GPmYaiFiuYJfYu1Cmy4qVNCzloU=;
 b=2mFLBCTm8YD743rATWy0COnFBjx6i+HxdZ5EMkOyNaXz2IT3uav3iSHBVy65lUou+oxlbp
 Yx2osG7xzNiDhIrC6jsAIuKHsXrcXu0F6hrPFehUQPZX5KQpI1cMTsCNDMxs2zKGvIArXP
 bHZjsYmhJnZxmBBlpuGKjTdrKxal+Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762770779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IZS2mw/XfQVaSfw5GPmYaiFiuYJfYu1Cmy4qVNCzloU=;
 b=On6807gyXQvcaGV2QM4Af+ZmhjYg7T63U34k7w0wd7g/0YCXXKHTbIEcl6v7JdiZxpGlnT
 riOUTUJ36ufqJ9Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762770778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IZS2mw/XfQVaSfw5GPmYaiFiuYJfYu1Cmy4qVNCzloU=;
 b=AtY5avEKwzBJN8wCclk4nnfxmfV23vvlhX1WSSuU/eLGRUajtyxWr8Euq5KWHZpZcB+jRq
 nxNahc4cN248LoT9Z+VlmcNywYs2OrISgpeNz9vyf2jj1vnNSEAXXTTrFEYx22HZfnOPVJ
 +zvAPxYmeu9jYziSA1pZ9WmyVjLzhSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762770778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IZS2mw/XfQVaSfw5GPmYaiFiuYJfYu1Cmy4qVNCzloU=;
 b=rddPPFYf3XsN0PhIZmJD2ECKC/eBNYOcAsXQkY+J4XibtkupcXO/8w+aPct9LtVZfu8xbg
 vsW9J/hbGD2dNfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C77F41434C;
 Mon, 10 Nov 2025 10:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E5ZwL1q/EWl3JwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Nov 2025 10:32:58 +0000
Date: Mon, 10 Nov 2025 11:33:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aRG_gvx7AQQt33pf@yuki.lan>
References: <20251106114337.550054-1-piotr.kubaj@intel.com>
 <aQyYnbgewc4AptZJ@yuki.lan> <20251106165012.GA1064259@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251106165012.GA1064259@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] thermal: add new test group
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, Piotr Kubaj <piotr.kubaj@intel.com>,
 daniel.niestepski@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > First of all, the tst_test.sh test library is in maitenance mode and new
> > shell tests should use the tst_loader.sh instead. Have a look at the
> > testcases/kernel/mem/vma/vma05.sh test on how does it look like.
> 
> Piotr, first thank you for submitting a test.
> 
> My wish would be no more shell based test. shell loader is kind of compromise to
> improve existing shell based tests, but I'm not happy to see yet new more tests
> in shell (we in SUSE will be then actively rewriting it into C :( to avoid
> various problems with shell tests).

Honestly for a test that is as simple as this one shell may be fine.
Anything more complex that this should be probably written in C.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
