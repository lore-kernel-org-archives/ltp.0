Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF03C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 17:28:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36C8E3CA119
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 18:28:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8D603C574A
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 18:28:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F7651A01A64
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 18:28:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CBD4219A4;
 Fri, 18 Feb 2022 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645205306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQOHjyTBPu8j9QPXguzY+Qe34ivmvNjjP4GAcKs02+g=;
 b=cyhcK4QWcwUzw2Q4e3TQgqhJ8A8l4iT/8+j5O6PJw1cHSSNWhytr7wbTMCm3O8MxvFg0Dt
 52Pm256efz1narEhnARQIoFz32H/mQijfD1cY3T0EZc3lC7Yfh3EQJGDp9/DbYfuWlaBhZ
 UwQ1l96WbQVjbsGAQelnP3TgrHkhnWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645205306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQOHjyTBPu8j9QPXguzY+Qe34ivmvNjjP4GAcKs02+g=;
 b=xmIdTVjSmceSRq5weFoCzWSr4Ye0VodhhL5PnWS6otTizKg2KuB63CD2+JglNWrQ4ae7XM
 yzsy6hjYrntwWvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DF9913C9C;
 Fri, 18 Feb 2022 17:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l6vZATrXD2KqWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 17:28:26 +0000
Date: Fri, 18 Feb 2022 18:28:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Yg/XOGiHJ1cUiktp@pevik>
References: <20220218164845.11501-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220218164845.11501-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 
 =?utf-8?b?W1JGQ8WKW0RPX05PVF9NRVJHRV1bUEFUQ0ggdjIgMS8xXSBu?=
 =?utf-8?q?etstress=3A_Fix_race_between_SETSID=28=29_and_exit=280=29?=
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

using TST_CHECKPOINT_{WAIT,WAKE}() somehow causes server to run server_run()
(which shouldn't be run), I have no idea why. Maybe using pthread with it
triggers some library bug which was there but hidden?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
