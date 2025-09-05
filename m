Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD9CCA0FED
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 09:02:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F7C63CB462
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 11:02:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53E953C2D89
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 11:02:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 237D16002B4
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 11:02:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6B074DCF1;
 Fri,  5 Sep 2025 09:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1757062920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlPzYVcbxtCTiRHWqQBnrH7dsYh9WP9D79GRwe695WE=;
 b=iN1Ooe8h6cM9ucEuUM3wHhFpHEU9pPy4RF8W9KFxle2YkD3vXaAhwCuuFtHGYku/PKcso3
 oacmOcr6VPJDZXMF7jT0EKTcZTVKzdnQagFuIurXn+JrAxDLE1135nUq7k7/xkBuNWra4z
 tYlqT2CWpA/EaMmLC4S5cXRCwNNgc7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1757062920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlPzYVcbxtCTiRHWqQBnrH7dsYh9WP9D79GRwe695WE=;
 b=BMB/ND2E3axoFc14rjB0MUTWtXxjviO0f/GpLmVaYngUdQ61o3HARiqlGX2If4cD+Fqsl7
 x0ziNT2iBUkao9Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1757062920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlPzYVcbxtCTiRHWqQBnrH7dsYh9WP9D79GRwe695WE=;
 b=iN1Ooe8h6cM9ucEuUM3wHhFpHEU9pPy4RF8W9KFxle2YkD3vXaAhwCuuFtHGYku/PKcso3
 oacmOcr6VPJDZXMF7jT0EKTcZTVKzdnQagFuIurXn+JrAxDLE1135nUq7k7/xkBuNWra4z
 tYlqT2CWpA/EaMmLC4S5cXRCwNNgc7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1757062920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlPzYVcbxtCTiRHWqQBnrH7dsYh9WP9D79GRwe695WE=;
 b=BMB/ND2E3axoFc14rjB0MUTWtXxjviO0f/GpLmVaYngUdQ61o3HARiqlGX2If4cD+Fqsl7
 x0ziNT2iBUkao9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA4E8139B9;
 Fri,  5 Sep 2025 09:02:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LFMNKQinumg3JAAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 05 Sep 2025 09:02:00 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 05 Sep 2025 11:02:00 +0200
Message-ID: <12744365.O9o76ZdvQC@thinkpad>
In-Reply-To: <aLVzVyaVhr4IHkyd@yuki.lan>
References: <aLVzVyaVhr4IHkyd@yuki.lan>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 CTE_CASE(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

On Monday, September 1, 2025 12:20:07 PM CEST Cyril Hrubis wrote:
> Hi!
> It's about the time we start to prepare for the September release. As
> usuall I will go over the patches in the patchwork in the next week or
> two. If there is something that you think should be part of the release,
> please point it out so that I can have a look ASAP.
> 
> 
Hi,

I sent a patch [1] for using tst_kconfig_check() for the tests which are
affected by new POSIX_AUX_CLOCKS=y config. I guess it should be included
in the release.

Thanks,
Avinesh

[1] https://patchwork.ozlabs.org/project/ltp/patch/20250905084608.11958-1-akumar@suse.de/



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
