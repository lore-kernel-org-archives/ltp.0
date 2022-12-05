Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B38C4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 10:31:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8789F3CC228
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 11:31:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 841013CB362
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 11:31:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 340711026532
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 11:31:23 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 68D51201FB;
 Mon,  5 Dec 2022 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670236281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qAqTJXKvr+W6jt9pf/lkePoDuC4+OLPuGGwgBfu1YiQ=;
 b=Se3yJilcH5Vs0wnFc7EeXQKVgFUk8j5gBpsMD4ZWIWKj3kyE5y9W27eqm/rLaHFg/JRBPX
 vlwm3L9s/M/SmD1MuVzZjU0E+st04OfaDS5TpmkoF8YmBRXTnpVqoKJSV80A2Zqk1f3saf
 O9E6xal4vWJmSf1A17x0cB/00O3/aaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670236281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qAqTJXKvr+W6jt9pf/lkePoDuC4+OLPuGGwgBfu1YiQ=;
 b=34vT/zAzVBq/yUyoK8pXsx5Xna+G0rgSdqMx0WtULlRbGWzHRsUTgTS6fJCp5J+5y4mPz1
 Wb+qr7no/kg5bFAQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 150202C141;
 Mon,  5 Dec 2022 10:31:21 +0000 (UTC)
References: <20221130150738.745960-1-tudor.cretu@arm.com>
 <20221130150738.745960-3-tudor.cretu@arm.com> <Y4d1/tCohb7fxZkM@yuki>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 05 Dec 2022 10:30:05 +0000
Organization: Linux Private Site
In-reply-to: <Y4d1/tCohb7fxZkM@yuki>
Message-ID: <874juauop3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/3] safe_open,
 safe_openat: Fix undefined behaviour in vararg handling
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz

Still not sure I prefer this over the macro approach, but merged,
thanks!


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
