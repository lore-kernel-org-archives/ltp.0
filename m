Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F35C636CC
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 17:34:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4407D3CBF80
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 18:34:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC5F33C1047
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 18:33:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D53DC200346
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 18:33:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CAE2D1FEC6;
 Mon, 13 Feb 2023 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676309636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26uqpcJpOoMJ32OBgkzaYYLjC5ORFfsiFzb3iRs8BTk=;
 b=3MSgQeXvB2IYBEHotj3fpaTYkciq6+4fRlBnAudPHNyvC1fhVx0famM1NkeunX1hi+KoCm
 ewQRlqWgPe4xZVqKMDKSjiyJ907SoRuPYtvsmFpbcybxrYS06mBzvwXSqGQBfXVh773ZYn
 pwpBqBlNPhNn218qg7TklnIuaDSA47U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676309636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26uqpcJpOoMJ32OBgkzaYYLjC5ORFfsiFzb3iRs8BTk=;
 b=t1kk5sbdvfymiTGf0Gw/Xz3WvwLzS3ezgHruuE0NwTYBGRcEbFl4NN3ncUXa/2jRo/e7DX
 h6OySx+8e+0hMrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79DA51391B;
 Mon, 13 Feb 2023 17:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fGx3GIR06mOdYwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Feb 2023 17:33:56 +0000
Date: Mon, 13 Feb 2023 18:33:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
Message-ID: <Y+p0guL0/bQwDf/i@pevik>
References: <20230213134104.229241-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230213134104.229241-1-ycliang@andestech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib/tst_pid.c: Count used pid by traversing
 /proc
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

Hi Leo,

> Use "ps -eT | wc -l" to calculate the number of used pid
> could have an incorrectly larger result because "ps -eT"
> may list the same pid multiple times (with different SPID).

> Instead, we could count used pid by traversing /proc
> directory and count the subdirectories that have name
> composed of digits.

> Increase PIDS_RESERVED to avoid fork failure.

Thank you!
Waiting little longer before merging to give others change to have look.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
