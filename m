Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF97C001DF
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 10:38:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EA1D3CB993
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 12:38:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 580BC3C8B93
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 12:38:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9B59F600C77
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 12:38:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECF0522353;
 Tue, 25 Jul 2023 10:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690281521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLww3t6tqvG4CdPkOKidfPq2XK8wM/iKEwx+6T4OhOY=;
 b=15VNj75AE7qTlAzHoC+ru8Xcv+y/1dSEOtKRVFQW7MTh1OPgZCg2yAjkvcf5DQRi/KTZEz
 rHqey1jFyU9fSuuAoha1xuC9ui7rgy+Qzf8i8biuyIhl43CDtJO1bG7nhAPM4hhmVG+mlb
 mer9WgR5Yfvxh3WuqvlM1axnh7DGB00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690281521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLww3t6tqvG4CdPkOKidfPq2XK8wM/iKEwx+6T4OhOY=;
 b=Dc+DbzcwZ8e3GSRjztQt11nlEXfVYg0Ox2qPiw5iq2tbk6RCd1flbfdYGU11kH3GvvSJHY
 YCHDz7q9JZbPPjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D881D13342;
 Tue, 25 Jul 2023 10:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rZFdMzGmv2RSAgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 25 Jul 2023 10:38:41 +0000
Date: Tue, 25 Jul 2023 12:39:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZL-mb1nXfwpAklYr@yuki>
References: <20230719113906.22317-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230719113906.22317-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pipe08: Remove the test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This test scenario of verifying SIGPIPE signal is being covered in
> syscalls/write05.c test.

Hmm, this one is actually hard to figure out. Indeed the write test
implmenents the SIGPIPE case, however it would make more sense to have
the SIGPIPE test in syscalls/pipe/ directory instead. I guess that any
kernel developer that would like to use LTP for testing changes in
pipe() implementation would rather want to have the test under pipe/
directory.

Maybe we should keep the pipe08 test and remove the case from the
write05 test instead? Or should we keep both?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
