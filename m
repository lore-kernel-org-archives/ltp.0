Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A416C4167D
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 13:34:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFD823CF3F3
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 14:34:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20EE83CC98D
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 14:34:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F2B151A02366
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 14:34:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A3281FF05;
 Mon, 30 Oct 2023 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698672858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=omuyfOV7KTH5uFz31TpJV/dWKsK9X2+Qb3V4FxrYOGo=;
 b=D3b/eBHOtE0+ylgJUiQvgsBgUMOF/wRpr0dIgwhUB8t2MYZdDznhpp8qkhNgciyVSGZjIe
 g+qp18+BeU5gS6N2iykbe5f7Zd/sWOaxqn1lTggs5WVQh/JIJiugcdxlpsaz64cDNBBtjD
 3SHy3JJ/4B5KCCsDXzFRJ2zZiCnbhhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698672858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=omuyfOV7KTH5uFz31TpJV/dWKsK9X2+Qb3V4FxrYOGo=;
 b=0F7kaf+NNe1pUlkuO2u5YJkoPSPX3yWqLPMmLUzWlEzRQQaRRfS1g3VMaJG2T4/9OX07b7
 6YNHAgbomtKU18Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76771138EF;
 Mon, 30 Oct 2023 13:34:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /PE/HNqwP2VfHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 30 Oct 2023 13:34:18 +0000
Date: Mon, 30 Oct 2023 14:34:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZT-w-P7II2yiaUYm@yuki>
References: <20230904111940.26824-1-andrea.cervesato@suse.de>
 <878r8l2th7.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878r8l2th7.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor timer_getoverrun test using new LTP
 API
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
> Test looks fine apart from the issues I have with any test which fails
> if a different error number is returned. I already started that
> discussion here:
> 
> https://patchwork.ozlabs.org/project/ltp/patch/20230901144433.2526-1-chrubis@suse.cz/#3191079

Since we have decided to solve this problem inside of the TST_EXP_FAIL()
macro this shouldn't block this patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
