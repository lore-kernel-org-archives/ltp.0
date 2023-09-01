Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C7CCA0FE6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:36:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCF613CED55
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 14:36:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7183E3CBB92
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:35:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 291CF6009C0
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:35:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 21DC61F86C;
 Fri,  1 Sep 2023 12:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693571751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XsPGJ88LEdrKF6OkIR8vq1i6gn72iJTT2+aniWx96WM=;
 b=0ZT+30ccj93l443fFjMKNbA5u8OdlnFQVcbIbvOr8N53l3MjklAzn09D2sZwe9Qc64FZ85
 2CxtdckPrj8dhzE7fg1zptRvxRQsH382FEPvbTa1qjHhI9+3SxKr6jWg09nZULoakjsWRi
 JMMEhrtpc/WlZ7+BI21PR0tIL3Hh1bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693571751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XsPGJ88LEdrKF6OkIR8vq1i6gn72iJTT2+aniWx96WM=;
 b=dUMvaTgv8GR2JKPJwsI0Gr2VkKB+U0VlWRPIx44WeHYVVfkIrRK8yPZXtetwFbaFbIIKLu
 z+PwCT8yhhv6eaCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED4011358B;
 Fri,  1 Sep 2023 12:35:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TCL8OKba8WSbJwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 01 Sep 2023 12:35:50 +0000
Date: Fri, 1 Sep 2023 14:36:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZPHayoB7_I6Xy8-k@yuki>
References: <20230829073821.2580-1-andrea.cervesato@suse.de>
 <ZO8d3GO_jFgNAXNY@rei> <20230901103758.GC323151@pevik>
 <ZPHWK_Msrqbpmvtt@yuki> <20230901123126.GA343678@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230901123126.GA343678@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add process_madvise01 test
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
> BTW I wonder if we should add 'vmstat' or 'cat /proc/meminfo' to ver_linux.

cat /proc/meminfo sounds like a good idea.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
