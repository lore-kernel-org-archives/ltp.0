Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7792AEB64DD
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 14:51:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8240D3CDC79
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 16:51:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09943C02F7
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 16:50:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 864876003C2
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 16:50:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46A64218A8;
 Fri, 21 Jul 2023 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689951054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WPUG3enuMWHyGGLe2gIKxrpHyQkwqWa4uELMsev7G8A=;
 b=jE+CeBtnkJdKpkPF9ynZ50HZRfd59NC+55Ot2JJOvIGU6OY72a1Dw6ESsB4u5G/g+Jfgrt
 c97Jog7ORyAAbmCSRSaP7Ldx4uXj2EJaSEX7pDBvCDG+ptf6A1jcgAPEuQuPam/i29R0EG
 WB+LGfwVJhx1soYbjz3u/LquYYWNRok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689951054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WPUG3enuMWHyGGLe2gIKxrpHyQkwqWa4uELMsev7G8A=;
 b=I6i5GvGFrGNyoY34eBsBUJlTslEJpkWsnhRcKOh/N9cY2E9u+UTVB7xm5a4hz2AbmRa45t
 anvDPvAI+PXbDDBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30B90134BA;
 Fri, 21 Jul 2023 14:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HbLcCk6bumRdGQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Jul 2023 14:50:54 +0000
Date: Fri, 21 Jul 2023 16:51:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZLqbjAUAjk49BXQY@yuki>
References: <20230315092552.18127-1-andrea.cervesato@suse.de>
 <20230329055459.GA833475@pevik> <20230721125012.GA1421542@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230721125012.GA1421542@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite eventfd01 using new LTP API
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
> Or, Cyril, if you post your RBT, I can change this before merge. Because the
> proposed include/tst_test_macros.h change was merged in 303eb96a3
> ("tst_test_macros.h: Support return value in TST_* macros") we should finish
> this nice work.

The changes looks good, so feel free to merge with the minor fix.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
