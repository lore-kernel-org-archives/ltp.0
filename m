Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68ABCD6134
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 09:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 384F83CD6EB
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 11:59:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D22E93C62DB
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 11:59:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2078A6003BE
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 11:59:22 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3F8981F38A
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 09:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696931962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6idEtb5oyIUC+05/HMQQE24X121wapGGXvG6neIpE8=;
 b=j/8uLwbKbAxuUkLfx5FGXj2U2udZZxtHv92sJoAUTBsS79nVuv/EocogDtSq3n09GWMxlP
 ertNJNGMYN4Q7uG898VIqOzGwiIC06OuwGfCbUxNrFHQ9qNhmyrTrroyTb2J6iRCv+QftV
 MjG97k+5sMY/VD2RWqq3KfeaWeAAbmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696931962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6idEtb5oyIUC+05/HMQQE24X121wapGGXvG6neIpE8=;
 b=bMFmnj5ynqPBPKqQxxUV6MJ29HE2PUr6cu5+I8iu8HvF+owXSic0fw8MGymkRvqq14vR6D
 oigacyVXp8HQDyAw==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E3C092C3EB;
 Tue, 10 Oct 2023 09:59:21 +0000 (UTC)
References: <20231005144335.16509-1-andrea.cervesato@suse.de>
 <2700810.mvXUDI8C0e@linux-9lzf>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Marius Kittler <mkittler@suse.de>
Date: Tue, 10 Oct 2023 10:55:47 +0100
Organization: Linux Private Site
In-reply-to: <2700810.mvXUDI8C0e@linux-9lzf>
Message-ID: <87sf6iztl4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] Rewrite the gettid() testing suite
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Pushed patchset, thanks!

Re-added the original copyright based on Petr's comments on another
patch.

IMO it is not worth debating whether the test is a derivative work or
not when it is GPL. There is no need to keep the test history however
that is in the Git log.

Marius Kittler <mkittler@suse.de> writes:

> LGTM
>
> Reviewed-by: Marius Kittler <mkittler@suse.de>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
