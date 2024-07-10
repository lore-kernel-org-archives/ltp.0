Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FEFC3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 15:33:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD2413D3824
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:32:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E7793D3819
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:32:45 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A021C1A01982
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:32:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C9DC121BE5;
 Wed, 10 Jul 2024 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720625563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tlbkVnvdYaiucbf0/PjORwdUevHalEWp4aV8AgYKqQI=;
 b=3YM3BeqqEUm6plRlb9TO8XbY8c30ymqUwliX6ov/Ny/uGhxyg0ENxPleZTMDvLz6jdcCGN
 34s0z25+St4cVph84z+osrLltjpWixO36RrFvDuS7jUXdlqcLn2EYXz6Cotbp47ya8+KYo
 j3PzhTzemlPPdvbgjFREE0CCaLVztoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720625563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tlbkVnvdYaiucbf0/PjORwdUevHalEWp4aV8AgYKqQI=;
 b=IIhthAAtMgsNUIOsrIl17xQaPTxEuHMMWpqU29fmEbPGIOXfAGmmUMXT7MWO+vb0jYjTQy
 K1eQKOvPm/cUKDDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720625563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tlbkVnvdYaiucbf0/PjORwdUevHalEWp4aV8AgYKqQI=;
 b=3YM3BeqqEUm6plRlb9TO8XbY8c30ymqUwliX6ov/Ny/uGhxyg0ENxPleZTMDvLz6jdcCGN
 34s0z25+St4cVph84z+osrLltjpWixO36RrFvDuS7jUXdlqcLn2EYXz6Cotbp47ya8+KYo
 j3PzhTzemlPPdvbgjFREE0CCaLVztoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720625563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tlbkVnvdYaiucbf0/PjORwdUevHalEWp4aV8AgYKqQI=;
 b=IIhthAAtMgsNUIOsrIl17xQaPTxEuHMMWpqU29fmEbPGIOXfAGmmUMXT7MWO+vb0jYjTQy
 K1eQKOvPm/cUKDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BDF2137D2;
 Wed, 10 Jul 2024 15:32:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tRyAFZupjmYDUQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 10 Jul 2024 15:32:43 +0000
Date: Wed, 10 Jul 2024 17:32:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240710153241.GA300319@pevik>
References: <20240624071723.23480-1-mataotao@uniontech.com>
 <CAEemH2eFmg7CUwLhA97O22cvdxKks7yy4cPcCx_uE6mg3GYjtg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eFmg7CUwLhA97O22cvdxKks7yy4cPcCx_uE6mg3GYjtg@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] shell: add echo command check
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
Cc: mataotao <mataotao@uniontech.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mataotao,

> Hi Mataotao,

> First, thank you for creating new tests for LTP.

Thank you!

> But from what I know LTP now is mainly a face-to-Linux Kernel side test
> suite,
> rather than the userspace or command line test (it had some but slowly being
> removed from the test suite).

+1, these would be better placed in coreutils or the shell project you target.

> 'echo' is daily popular used but belongs to the coreutils package, it's not
> the core
Also, 'echo' is not only binary from coreutils, but also a shell builtin.
Moreover, 'echo' is known for various incompatibility across implementations
(printf is suggested to be used if compatibility is needed).

Kind regards,
Petr

> of kernel part. I guess maintainers have no passion for reviewing patch
> like this:(.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
