Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF6EC4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 14:15:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D17E3C8C6C
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 15:15:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66CF03C1BBD
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 15:15:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7FC361A0090C
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 15:15:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6470575AB3;
 Tue, 20 Dec 2022 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671545738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7m72/6PIbdiL51+XEeyYWeI6D0Kwrc6So+lJTbIuO10=;
 b=1cEBa8csca0S1JgrcXUTw7lH+6TCX1VSGIGCe/IkeQrEthB+eJxoeKRMR4F+/gZwsRct5/
 zNjKRDaeG/fNq6hXGFbR/A8Q3Ud+cYr5+GLuWyxigx9tynTNTx5nIIcz1jPC6gcjAfU+SD
 TaOqgQdEdFjJbtjLvprHG4pPlSpKNt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671545738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7m72/6PIbdiL51+XEeyYWeI6D0Kwrc6So+lJTbIuO10=;
 b=zep9jZiaF6PKnIy0vGvBYhGZ7eZaBtLed/5bcARoE8DIJr1vaaLHHRP9gZG7EUwbq0HeMP
 DUuuVP6tGfJCiODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F2191390E;
 Tue, 20 Dec 2022 14:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XwuvEorDoWOgKgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 20 Dec 2022 14:15:38 +0000
Date: Tue, 20 Dec 2022 15:16:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y6HD05Aa9WmWyUhl@yuki>
References: <20221220054549.1757270-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221220054549.1757270-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] set_mempolicy01: cancel the limit of maximum
 runtime
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
> It needs more time for running on multiple numa nodes system.
> Here propose to cancel the limit of max_runtime.
> 
>   ========= test log on 16 nodes system =========
>   ...
>   set_mempolicy01.c:80: TPASS: child: Node 15 allocated 16
>   tst_numa.c:25: TINFO: Node 0 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 1 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 2 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 3 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 4 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 5 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 6 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 7 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 8 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 9 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 10 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 11 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 12 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 13 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 14 allocated 0 pages
>   tst_numa.c:25: TINFO: Node 15 allocated 16 pages
>   set_mempolicy01.c:80: TPASS: parent: Node 15 allocated 16
> 
>   Summary:
>   passed   393210
>   failed   0
>   broken   0
>   skipped  0
>   warnings 0
> 
>   real	6m15.147s
>   user	0m33.641s
>   sys	0m44.553s

Can't we just set the default to 30 minutes or something large enough?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
