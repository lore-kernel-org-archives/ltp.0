Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B741C38142
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 09:21:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F26A3CC6E6
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 10:21:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BC593CB39C
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 10:20:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1994D600C77
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 10:20:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 13F3620195;
 Fri, 27 Jan 2023 09:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674811252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0eqcLPfdGA2hjXnui6MxNd+t7ghCJnNsbclc1N3Z2U=;
 b=g1liDUPgjvx2dQLU7nGHkD1gHwdmCiLlo0tQQB71CMY92VLsP7dRCVcwOyis17wc/HsiIb
 6PDMOC2gcVYMfFtc9fJQNoBVBWegrMNd3NyDFRguF8kI1KjgQ4L7YnhyF2+XrMySwS6z47
 PdWYdI3Y+AvEV9DL4MpVyHwbHlRe1Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674811252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0eqcLPfdGA2hjXnui6MxNd+t7ghCJnNsbclc1N3Z2U=;
 b=Kl1vR2eZDUs/Q6aCKkJsgGx3B2wuJsO2pFP/W4nOaEeuLdF9CMG4oqQ3kMMROwzCVo4nfZ
 06lHWMog67wpSqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C80F01336F;
 Fri, 27 Jan 2023 09:20:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1M+qLHOX02NaGAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 27 Jan 2023 09:20:51 +0000
Date: Fri, 27 Jan 2023 10:20:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y9OXRJk1x5VnsmF6@rei>
References: <20230125222703.19943-1-pvorel@suse.cz>
 <20230125222703.19943-2-pvorel@suse.cz>
 <87edrh0zy2.fsf@linux.ibm.com> <Y9MGHKXel5kjwoTT@pevik>
 <87sffwq32u.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87sffwq32u.fsf@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] hugemmap15: Compile with -O
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I tested with clang with -O, it fails. So yeah it is not turning off
> relevant optimization.

There seems to be pragma to turn off optimizations only for clang, can
you try if adding:

#pragma clang optimize off

to the source and removeing the -O0 from the Makefile works?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
