Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF36EB64DC
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 12:50:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0AE23CAB7E
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 14:50:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0B453C94AF
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 14:50:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 189C9601408
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 14:50:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E5FA1F8B3;
 Fri, 21 Jul 2023 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689943814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73g13ahtJMdHIIHAl+IvtmoGkp57TiwvShwkYNtTdes=;
 b=fm9uRwvxnpgokZDfErA2SERqdpy2qZJy4HoGcS6M80v5iJ13VhXNxRKx5zDcqIeu2PLQye
 I2TcLEsk+8Y4XWtXUoK4D9mffefq7jonR+pTS9HdDbQGElQOEJ8mcBEUw8kYbeU+RqYAjR
 Y3r4MeoQgrRptySHkA3ARdvXQLraZxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689943814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73g13ahtJMdHIIHAl+IvtmoGkp57TiwvShwkYNtTdes=;
 b=IWfifDjN02pkmiC9FS1aKiqQr4YjUbCCsoYFe/6S3veJRXcjA6QWYclcZx1V4PiqPu2z7n
 CKRIYzcbjTKiuMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48150134BA;
 Fri, 21 Jul 2023 12:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AMEaEAZ/umSLWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 12:50:14 +0000
Date: Fri, 21 Jul 2023 14:50:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20230721125012.GA1421542@pevik>
References: <20230315092552.18127-1-andrea.cervesato@suse.de>
 <20230329055459.GA833475@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230329055459.GA833475@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite eventfd01 using new LTP API
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

Hi Andrea,

> Hi Andrea,

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > +	TST_EXP_FD(eventfd(EVENT_COUNT, EFD_NONBLOCK));
> > +	fd = TST_RET;

> NOTE: we could merge the testsuite now, but if you send soon the patch for
> macros returning TST_RET (you discussed with Cyril at v2), all tests could be
> adapted before merge.

Once you have time, could you please send v4, which uses code proposed by Cyril?

fd = TST_EXP_FD(eventfd(0, EFD_NONBLOCK));

Or, Cyril, if you post your RBT, I can change this before merge. Because the
proposed include/tst_test_macros.h change was merged in 303eb96a3
("tst_test_macros.h: Support return value in TST_* macros") we should finish
this nice work.

Kind regards,
Petr


> Kind regards,
> Petr

[1] https://lore.kernel.org/ltp/ZBwgtsRUnkhzZFxZ@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
