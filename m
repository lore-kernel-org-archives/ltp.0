Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DD0C5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 09:59:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DA203CE9C6
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 10:59:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2B073CBE41
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 10:59:23 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 631BB1009BCB
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 10:59:22 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E43043F536;
 Wed,  6 Mar 2024 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709719162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MX+EsXE9iq57feNNX+Owm0IWe1diI1TLjPsZ7EcgHes=;
 b=FfN9YY6WRKGGYXE5tB+AbZsoNfnOMyBTRYA+6d+qPMG4GlK7nTCKJ94FclMbUr1OyyAZa+
 af1uO/NIytzWql3H2n/q4UxngJ/R5uNDYcjW7Yctspdjot0GJrel/n/cGGCgQZIYeRBzGV
 KO46S5PhYOr9Z7gda8n53EJ9m5zADJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709719162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MX+EsXE9iq57feNNX+Owm0IWe1diI1TLjPsZ7EcgHes=;
 b=JFvRH9/jZ7kfkgN7x1upuaSkkD+plOnkR11PCfQqKuHByO2EtKpX3eV4u+t2s9ihi6X3om
 BvwMsVeui8cCeTCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709719161;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MX+EsXE9iq57feNNX+Owm0IWe1diI1TLjPsZ7EcgHes=;
 b=ZKjg+Dh0h0BDPWachFxN2EoS+34T2Z3jSux2Wl7hSyR7hjiUdOHyvwnbxlv98yfD7vngfR
 86/GpBwoD/G95rbMePQpeuF7gHPvE2o9bA+m2ErfX3HIjzZ9mrYkPE5XRAuVT7oFGjBBiM
 X//auu0ezQxv9frqg4UoC6eZlSNCMR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709719161;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MX+EsXE9iq57feNNX+Owm0IWe1diI1TLjPsZ7EcgHes=;
 b=OnpIxm02+LE+VlmGlSnngYWCYjUNstxFJsvrsJN6jyF1L0Eqt/fX8Ay2XYztlPFTD6P+ov
 Mh3aA3OTyrpjOhDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BB9EB13A79;
 Wed,  6 Mar 2024 09:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Fb+3LHk+6GV/LAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 06 Mar 2024 09:59:21 +0000
Date: Wed, 6 Mar 2024 10:59:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20240306095920.GA306177@pevik>
References: <20240301062716.3023-1-wegao@suse.com>
 <20240305141057.8754-1-wegao@suse.com>
 <20240305210421.GA44833@pevik>
 <b2525dbc-a863-477e-9499-82b8f3ad71a7@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b2525dbc-a863-477e-9499-82b8f3ad71a7@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.27 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.97)[94.86%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] libswap.c: Improve calculate swap dev number
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Hi Petr, all,


> > Hi Wei, all,

> > thanks, merged!

> > FYI swapon03 with this patch still fails on SLES 12-SP5 (4.12 based kernel):

> > tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> > tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> > swapon03.c:55: TFAIL: swapon(filename, 0) failed: EPERM (1)
> > swapon03.c:55: TFAIL: swapon(filename, 0) failed: EPERM (1)

> > But that's likely fails even without the patch (going to verify older SLES
> > releases).

> > Kind regards,
> > Petr

> I guess SLES 12-SP5 has backported some patch that modified kernel 
> constant MAX_SWAPFILES value[1]. But ltp doesn't add fallback for SLES 
> like I did for RHEL9.

Very good point, there are some patches.

> I think you can paste your kernel code(include/linux/swap.h), then you 
> or we can figure out what cause this failure.

I'll try to figure out what is missing and post the config (either with patches
or just config). Thanks!

> [1]https://github.com/linux-test-project/ltp/commit/c1b8c011e447088b08787462e0c2ed50cd8c43f3

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
