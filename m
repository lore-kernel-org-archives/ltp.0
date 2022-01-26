Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C983C433F5
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 22:30:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84C523C96F8
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 23:30:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFC5A3C6912
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 23:30:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15C6060010F
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 23:30:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D9D0A1F37C;
 Wed, 26 Jan 2022 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643236223;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dpH+bQ0CIYJvwb4jNNuK+K7WFREW9id+gEzGDvPAEo8=;
 b=YT7teOYblL0RxKOwz6DrMmBZsphnfNX10XhZMCthjOE8CuU1x5N2qch91TGnCpQK9jL1Pn
 xxRHgZ5H7xnbsnfAukPUvzGjRbs3iFs6xUHTjdqf9EbEKH3vtZ8gKPElhkd7//pm5IT/kc
 WbG/VOVHEFB7jRHXPD2wHwH7zEMxxvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643236223;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dpH+bQ0CIYJvwb4jNNuK+K7WFREW9id+gEzGDvPAEo8=;
 b=btM3/1gHkztKqCingwC5/lFmz0j9qmpB7R7NA9eEVZT6+lbKz77juqp2eyT3c/X/Ce0z9B
 CHbqS3CEEFE63aBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2A4F1330C;
 Wed, 26 Jan 2022 22:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PT62JX/L8WGyUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 22:30:23 +0000
Date: Wed, 26 Jan 2022 23:30:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YfHLfrknwiswYong@pevik>
References: <20220126123547.13298-1-pvorel@suse.cz>
 <20220126123547.13298-5-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220126123547.13298-5-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v2 4/7] realtime/m4: Simplify exp10 check
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Yes, uclibc-ng still haven't defined exp10, thus still needed.
To correct myself, it has been added 5 years ago, in v1.0.27 (2017):
https://cgit.openadk.org/cgi/cgit/uclibc-ng.git/commit/?id=ea38f4d89c9698895b1cf53a5946429dc1d8bbaa.

And even before there was implementation from glibc in v1.0.12 (2016):
https://cgit.openadk.org/cgi/cgit/uclibc-ng.git/commit/?id=12a85731dc5fda3bc01ab19c82678b3bf122d794.

It'd be nice to see if there are toolchains which still use v1.0.12.

Kind regards,
Petr

> Link: https://github.com/linux-test-project/ltp/issues/13

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
