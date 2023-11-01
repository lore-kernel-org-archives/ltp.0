Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315D6C4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 09:59:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 302AA3CE9D0
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 10:59:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00DAF3CC8EA
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 10:59:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0FF86100036C
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 10:59:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD061219B1;
 Wed,  1 Nov 2023 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698832769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qAx+Hqh29nRwul5JfWPUqnZ4oKJ8gRnE6rq1kT8rFE=;
 b=lKuHhjhG4/4h7eWzlA2p2Lq+2NvBCZ8GwuQqq/UzE8Bu9vj9tixb6T9R9zj+pL4bEYq/LM
 sMJzlxhPuR3h84xfo154yoYTyHRDwYPL2oF8gPNkUbQWjqdH8FViCyhiAQuDGeg/1Uje7z
 L7++xzzqcfiPtlQbNrDkfh8eReyN6Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698832769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qAx+Hqh29nRwul5JfWPUqnZ4oKJ8gRnE6rq1kT8rFE=;
 b=PsakvirS7pWuKiG+KcsLy30yiyv2/V4JiaDFWBkeCOpC7YXnlSDh1Dmi7d6SyJhFSNdqaW
 OvLMQadlca26e0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A75441348D;
 Wed,  1 Nov 2023 09:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3273JoEhQmXxEwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 01 Nov 2023 09:59:29 +0000
Date: Wed, 1 Nov 2023 11:00:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZUIhoTxcEaa9TEE9@yuki>
References: <875y33vsks.fsf@suse.de> <87lebpu02a.fsf@suse.de>
 <87msvxst71.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87msvxst71.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 1st of November 09:00 UTC
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> 3. I'll be more aggressive in adding changes requested. Most of the
                                ^
				In patchwork
>    responsibility is with contributors to remember to resubmit their own
>    patches.

I guess that it's not clear to anyone without the context.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
