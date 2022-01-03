Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04719C433F5
	for <ltp@archiver.kernel.org>; Mon,  3 Jan 2022 11:33:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 553A33C7443
	for <ltp@archiver.kernel.org>; Mon,  3 Jan 2022 12:33:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E2423C313C
 for <ltp@lists.linux.it>; Mon,  3 Jan 2022 12:33:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82B7F600763
 for <ltp@lists.linux.it>; Mon,  3 Jan 2022 12:33:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B4A9212B5;
 Mon,  3 Jan 2022 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641209622;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbjMscBANbMqZgp8lvTwSIVQ/dDA2ob09p0w/zIa9xs=;
 b=fmMr2wJtVxhgcPLgb8CZeLpZuUMMoi0Gm4njk6MurXm/3paHcJwD8baLz5erlduw1865M0
 pwkRhetdw+E5q3qZC3a22MYW1LOsG6lAUFVTdySfrQIQjBrLzuYfZKeJSHUCrAYEvs5DHa
 COVzuIc0W4uFqLLQ30tOs6Oo3pQ98W8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641209622;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbjMscBANbMqZgp8lvTwSIVQ/dDA2ob09p0w/zIa9xs=;
 b=l/M7qopiqL0v4OyIeZDsU7u45IXEYHn72Cphipmr1Af7Q5xNaA+mIWPqUfMDn7P6xrurhB
 yO0gYdYE0Teg87BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7161313A88;
 Mon,  3 Jan 2022 11:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MJ0JGhbf0mFCCAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jan 2022 11:33:42 +0000
Date: Mon, 3 Jan 2022 12:33:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: sujiaxun <sujiaxun@uniontech.com>
Message-ID: <YdLfFF9/WD7rloYG@pevik>
References: <20211221024325.21828-1-sujiaxun@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211221024325.21828-1-sujiaxun@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [v3,
 1/2] syscalls/sched_get_priority_min01: Convert to new
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

Hi sujiaxun,

thanks, patchset merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
