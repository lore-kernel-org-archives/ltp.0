Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A88C6FA99
	for <ltp@archiver.kernel.org>; Mon,  6 Mar 2023 15:11:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DC023CDAF9
	for <ltp@archiver.kernel.org>; Mon,  6 Mar 2023 16:11:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC7823C4D54
 for <ltp@lists.linux.it>; Mon,  6 Mar 2023 16:11:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7B95B20033C
 for <ltp@lists.linux.it>; Mon,  6 Mar 2023 16:11:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D28F223A0;
 Mon,  6 Mar 2023 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678115489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwdnOGdcsbpmmVllQu6wZx/fpa97gvLI3sCliaFlOSs=;
 b=xkV+TKbUNTUlA3fD3UIEMK3mXDxH1mfqgC7HqCDsIAIEsBnNdv7g2wI4Xg+eiMEq2a2/Wd
 EhshgEIzK7hfjqOSrniUoDmIWimkBQ9bLCBYpG5jWuVXX2I8n9H6gOcCiKqwCewsOe3ZXu
 myk1d9vLod0dcYZMUXj9neKv+eKXPjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678115489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwdnOGdcsbpmmVllQu6wZx/fpa97gvLI3sCliaFlOSs=;
 b=MLQChrgTXVmyFn0/H8fRbX/60vJBET3rJbijwYK8reFoTT/QYL3+9zXsVyrtBdpkazJAxN
 04S5l7C708AaoYCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 638DC13A66;
 Mon,  6 Mar 2023 15:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zOWMFqECBmQyIgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 06 Mar 2023 15:11:29 +0000
Date: Mon, 6 Mar 2023 16:12:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Message-ID: <ZAYC8TNhPkjT9BMX@yuki>
References: <20230303075258.1066-1-zhaogongyi@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230303075258.1066-1-zhaogongyi@bytedance.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ltp-pan: Send SIGKILL instead of SIGALRM to kill
 the child process
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
> When PAN stop Alarm was received, and the testcase blocked the signal SIGALRM,
> PAN will be hung up until the testcase exit. So it is necessary to send SIGKILL
> instead of SIGALRM to kill the running process.

The ltp-pan is deprecated and the latest LTP release included runltp-ng; a
modern replacement for the runltp script + ltp-pan. Have you tried
runltp-ng?

It's not worth investing time into ltp-pan that will be eventually
removed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
