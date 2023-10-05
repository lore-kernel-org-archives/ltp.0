Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDF1E92705
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 14:24:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A7393CF78D
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 16:24:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24B1C3CD990
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 16:24:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 404211402F97
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 16:24:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D1421F45E
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 14:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696515866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzW+/TxEs1SVx5mrsvXaLi+j9YVZ3FwxqIlAGK+SXd8=;
 b=1wl59oqE4oN5FpENu73DP1cbx+Uj7TH3iUpoDorMBnmkq4Mbzo5QIu1q0/v5Bfr4RDXUba
 HEhUib48K1sBpj143VOeTc4cjIPGcAyrxcmZQh250652/MQS5C6kYZnJ7NRbykXAR7kqSr
 M0mnQGHShhquzVHIwdpk7g6cGBuL8O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696515866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzW+/TxEs1SVx5mrsvXaLi+j9YVZ3FwxqIlAGK+SXd8=;
 b=MjXHC0yrPiw/YH5CZ7knsPYbYAN6nIINAATQJajVaGOJyjq6mrmYSndqL88JKAmtnyTyjN
 EG6BQWG5dz4/w/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EE00139C2
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 14:24:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id drQZEhrHHmWdLQAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Thu, 05 Oct 2023 14:24:26 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu, 05 Oct 2023 16:24:25 +0200
Message-ID: <24951859.XGBpkceEbW@linux-9lzf>
In-Reply-To: <20231005134911.26758-1-andrea.cervesato@suse.de>
References: <20231005134911.26758-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] Rewrite the gettid() testing suite
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Am Donnerstag, 5. Oktober 2023, 15:49:09 CEST schrieb Andrea Cervesato:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Rewrite gettid01 and create a new gettid02 test in order to check all
> gettid() basic functionalities, according with its manual.
> 
> Andrea Cervesato (2):
>   Rewrite gettid01 test
>   Add gettid02 test
> 
>  runtest/syscalls                            |   1 +
>  testcases/kernel/syscalls/gettid/.gitignore |   1 +
>  testcases/kernel/syscalls/gettid/Makefile   |   4 +-
>  testcases/kernel/syscalls/gettid/gettid01.c | 105 ++++----------------
>  testcases/kernel/syscalls/gettid/gettid02.c |  68 +++++++++++++
>  5 files changed, 93 insertions(+), 86 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/gettid/gettid02.c

Looks generally good to merge.

I'm only wondering whether the goto in the 2nd test could be avoided. After 
all it might even be a benefit to get an info for all the wrongly equivalent 
thread IDs (and not just the first).

Then it would also make sense to use `int j = i + 1;` in the inner loop to 
avoid duplicate/redundant commutative comparisons. And then you could actually 
also drop the `i == j` check.




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
