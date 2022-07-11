Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35758C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 06:55:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08E763CA695
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 08:55:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E4473C8BCB
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 08:55:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9345F1A006BB
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 08:55:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BED671FF6C;
 Mon, 11 Jul 2022 06:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657522501;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcQm/x7fzqlljLD1Uiy+/zhLSDNvozibLdt//5bWI0s=;
 b=m3QM8ey8Uen0z5hjtHVBmq5slfI8SI4qp3AiUKsr4aPsQRbTffTPH+89fRqFauveg6QUre
 JOunLZ6Am8RWNB1v/3VX6me6oFv+xvBlIVnxMM/3CBvi7dDfvi++8Lrwb0ZNFl76RMtbck
 htxlnyBgFU4IPRXB840IopKku1Qzvk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657522501;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcQm/x7fzqlljLD1Uiy+/zhLSDNvozibLdt//5bWI0s=;
 b=Hx6whoNKchS84e8ZfgjNugCzazJ2j73CZ2hAO227SaCvFdFUomCMFRH+vToDngwJC4Xwmq
 g2gEjLP1DJW/Z0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 973AE13524;
 Mon, 11 Jul 2022 06:55:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UDVcI0XJy2LlewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 11 Jul 2022 06:55:01 +0000
Date: Mon, 11 Jul 2022 08:54:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YsvJQ/plHHomtnvl@pevik>
References: <20220706155817.28340-1-akumar@suse.de> <62C6452F.907@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <62C6452F.907@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] dup07.c: Rewrite using new LTP API
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

Hi Avinesh, Xu,

> Hi Avinesh

> I did't look this cleanup patch, but I see the old code is same as 
> dup202.c(This case covers more situation, ie using chmod). Maybe we can 
> just add a test_variant to use dup  syscall in dup202.c?

> Then remove this case directly.

+1, yes, the code in both tests indeed does the same.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
