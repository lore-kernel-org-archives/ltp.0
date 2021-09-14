Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F28C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 05:30:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3D6610A2
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 05:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E3D6610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA52E3C89BB
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 07:30:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC8FC3C1DD3
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 07:30:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C5AD1000EC2
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 07:30:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D6604220AF;
 Tue, 14 Sep 2021 05:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631597434;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyfHcvjl0L7ArE34d+0uBRG/3ixaGxt9VKqczGByq+w=;
 b=ve9IhefHzriDiv2O5b2fzGfIlTZzt6DG0/BUULZ/LagkC/Hv55JuRCN9xjIu+OEgPilPId
 2+aNMvNqsB5nopb2p0p3Fg/3OILzjKslU8LyP9W0n4t5pGrYdfvaNy+j1Ujur/fIm/NYoz
 xTvkz3eyUxx+5JXpqMSuFQCkVfLumaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631597434;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyfHcvjl0L7ArE34d+0uBRG/3ixaGxt9VKqczGByq+w=;
 b=qFM72dKVdz/fh26le5zj7iFfo2L7yUXcitFxyHcgPCandErKDCqzN+2SB9WSZ54XGCuQxX
 orD6Y1dPs7GemDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD10313E4A;
 Tue, 14 Sep 2021 05:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fHRWKHozQGGLTQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Sep 2021 05:30:34 +0000
Date: Tue, 14 Sep 2021 07:30:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Message-ID: <YUAzecuP5rhCUnjN@pevik>
References: <20210913163745.28108-1-bogdan.lezhepekov@suse.com>
 <20210913163745.28108-2-bogdan.lezhepekov@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913163745.28108-2-bogdan.lezhepekov@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] realtime:hrtimer-prio:run_auto: jump to
 current dir
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
Message-ID: <20210914053033.Wff4HHfj8wtGanfwoAvCeF-P38-_y2eYYXAUYtk5g9E@z>

Merged also this one, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
