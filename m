Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B841CC433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 15:53:01 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D8260F11
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 15:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2D8260F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7713E3CA4A1
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 17:52:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35D903C1D5D
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 17:52:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4FC22600F4E
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 17:52:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B4FD22149;
 Tue, 14 Sep 2021 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631634768;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w5C7mP6vWfBz/4J3u0Y5ZHfk5EiQ/EUIv77QhhTTJDQ=;
 b=tVIIZTsIadzN7hpXtYx06we22ogCVxU81S0gHJYL4hH1AhClUonhf5q/YUFnlaSfQkxMvT
 6PyhVvUMaqu8cDu05vH4gE/3RwcjginlfU/G6hc7mnYjsMSVdIfoLxzaf6I2/6Te+Pp+o6
 mM3cDIA5iBGw735moER1A4bfyHKdN6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631634768;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w5C7mP6vWfBz/4J3u0Y5ZHfk5EiQ/EUIv77QhhTTJDQ=;
 b=mXab0B5e/J9Eb+8h3TJDhauIKFcM6SpqO+oUYR5QENNKfdL+48ijdLrl/otH0SCTbmTFX7
 82hp6iS9y0eahTAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26F6B13451;
 Tue, 14 Sep 2021 15:52:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 900oA1DFQGFaJQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Sep 2021 15:52:48 +0000
Date: Tue, 14 Sep 2021 17:52:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Message-ID: <YUDFTmk/0OaSLXq1@pevik>
References: <20210914122425.85129-1-naresh.kamboju@linaro.org>
 <YUCah4R0SBDKZvPQ@pevik>
 <e1873210-6d75-703d-f468-c4b826e20d54@bell-sw.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1873210-6d75-703d-f468-c4b826e20d54@bell-sw.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] runtest/smoketest: Remove intermittent failed
 test case route4-change-dst
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210914155246.vjqr0ZpN_7iBzESePlRecRK5JbaU6iQFRh_jdeXVmY0@z>

...
> > Did 75184c30a ("lib/tst_net.sh: disable ipv6_dad work on test interfaces")
> > fixed your problem? I'd actually like to route4-change-dst in smoketest to
> > have it as a detection DAD issue is working.

> 75184c30a is fixing ipv6. From the log, it seems the error happens
> in ping, when it once again tried to bind to 10.0.0.2 as a source
> address (with -I option)...

Ah, right, I'm sorry for overlooking this.
I squashed commits (reason to add ping tests is because we removed route test),
updated commit message and merged.

Thank you both!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
