Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E64C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 15:04:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30BDD3C8D8E
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 16:04:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D89C83C8C37
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 16:04:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 45A711A00802
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 16:04:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A9FE1F381;
 Tue, 14 Dec 2021 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639494278;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIDwkTXwJXBpo7UfugT2TpanLvL6pHiAO1agcwUxDfI=;
 b=YRRuUi7Yqhr64az2fP16RYhJ8RjmPDEtne1mzMPBoDxg1wezs4pBGc03FBKKu1Ko6OA3iX
 E6mxtjLs3sHkLCGIUsOYew3yDBRH6Jt+1KBgda2G1JpObt9H66T+lEqQ28Qe0DsXmqH/Kh
 /wcOg09PX72PQ7LItIIr5FoulfNk22Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639494278;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIDwkTXwJXBpo7UfugT2TpanLvL6pHiAO1agcwUxDfI=;
 b=nF8cYdqMG7kMTN9FcN3w9cgCrLYmW1ZSgvoth51RW7+QPsyjR2P47alvxHrTz5E5ey8+cu
 ju0j3j8NdWlLEmCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4432213DF1;
 Tue, 14 Dec 2021 15:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QAuZDoayuGEuWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Dec 2021 15:04:38 +0000
Date: Tue, 14 Dec 2021 16:04:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YbiyhLnljUy2K7Mv@pevik>
References: <20211213160437.32353-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213160437.32353-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactoring dio_append.c using LTP API
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

Info for myself: this patch requires "Add io_read_eof in common.h utilities" [1]

I wonder what I'm missing:
./dio_append
tst_test.c:1409: TINFO: Timeout per run is 0h 05m 00s
dio_append.c:69: TINFO: Parent append to file
common.h:45: TBROK: open(dio_append,16449,0666) failed: EINVAL (22)
common.h:98: TINFO: child 10949 reading file
common.h:98: TINFO: child 10953 reading file
common.h:98: TINFO: child 10940 reading file
common.h:98: TINFO: child 10941 reading file
common.h:98: TINFO: child 10944 reading file
common.h:98: TINFO: child 10946 reading file
common.h:98: TINFO: child 10951 reading file
common.h:98: TINFO: child 10942 reading file
common.h:98: TINFO: child 10948 reading file
common.h:98: TINFO: child 10939 reading file
common.h:98: TINFO: child 10943 reading file
common.h:98: TINFO: child 10950 reading file
common.h:98: TINFO: child 10947 reading file
common.h:98: TINFO: child 10945 reading file
common.h:98: TINFO: child 10952 reading file
common.h:98: TINFO: child 10954 reading file

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0

> +++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
...
> +static void run(void)
> +{
> +	char *filename = "dio_append";
nit: having the same name as the binary filename is a bit confusing.
(sure will work even run as ./dio_append due use of .needs_tmpdir).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20211213121417.21825-1-andrea.cervesato@suse.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
