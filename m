Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDEAC636CC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 13:42:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 966623CC214
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 14:42:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83F313CB15E
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 14:42:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 892A2600920
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 14:42:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A63CC38AEE;
 Tue,  7 Feb 2023 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675777344;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EM0jkCctv6KMMVgX+scDTVfCZ1zmWVIRE/W4/0qfZIM=;
 b=FLMqSkNGMTrqdgO6VKXxxjWVFpanBVg/QmT6Lmr8hehCvAIq/LVm8BBagc8QjclXpJnk2Q
 0OI2sHs2vaK2sD1EgGxwJZtkXrXcJflcHJJErR32eq92OUIj31XSTNDanYGtRbANRJF3wi
 InpgY8Of9/1PS5y1sBtYU3aeoudNAko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675777344;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EM0jkCctv6KMMVgX+scDTVfCZ1zmWVIRE/W4/0qfZIM=;
 b=z99c9qEvtA8wGCoyBbOcozPws25wIYib4Ixv8FNaEYlGniLUMMSjUKAJfH+TmokBebRtS8
 u8qraEbJ32JumIDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69400139ED;
 Tue,  7 Feb 2023 13:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Q+nzFUBV4mN/eAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Feb 2023 13:42:24 +0000
Date: Tue, 7 Feb 2023 14:42:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
Message-ID: <Y+JVPi5jo++joA/g@pevik>
References: <20230207124008.1788759-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230207124008.1788759-1-ycliang@andestech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_pids.c: fix fork failure on small memory
 systems
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

> Running syscalls/msgstress03 on a system with less than ~1 GB of RAM fails:

> 	msgstress03    1  TFAIL  :  msgstress03.c:163:  Fork failed (may be OK if under stress)

> The reason is that besides /proc/sys/kernel/pid_max, /proc/sys/kernel/threads-max
> is another factor determining how many processes a system could create.

> Use the smaller number between pid_max and threads-max as the nprocs.

Makes sense.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW IMHO it'd be better to rewrite
f = popen("ps -eT | wc -l", "r");
to list count of /proc/[0-9]*/ in plain C (TODO for us).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
