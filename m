Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2BFC88E72
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 09:39:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 089573E7529
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 11:39:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6741D3E74F3
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 11:39:10 +0200 (CEST)
Received: from mta0.migadu.com (out-224.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::e0])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 825901400DC0
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 11:39:07 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=8oLl8H9do5XGaZ5z+VD8/PNeVFHdVBCfuUCkrfOutPQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789637946; v=1; x=1790242746;
 b=g+yAjqgs0T+FgvggbmHQ51JW2dx5tKZILI3A0ZqGz3UoBz6Gita4sbmm1uYG25tax5tS9V7p
 EZFhtuWoPJO5KEdzEJb+PjewP6bleJCLyVXovCXgtyQ4jtlRm5HwPoSvdazpHhEDmLB5MbTvv/0
 XMQKXMkwOIXHigiO99WAxNtQ=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 8196eb2bc6996695;
 Thu, 17 Sep 2026 09:39:06 +0000
X-Mizu-Trace-ID: 8196eb2bc6996695
X-Migadu-Flow: FLOW_OUT
Date: Thu, 17 Sep 2026 17:38:56 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aqu1MPAj3cwERN9u@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Cyril Hrubis <chrubis@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-15-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-15-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 14/36] keyctl20: Test KEYCTL_MOVE displacement
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

> +static void run(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_LINK, key_a, ring_a, 0, 0);
> +	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key_a, ring_a, ring_b, 0));
> +
> +	TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring_b, "user", KEY_DESC), key_a);

TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring_b, "user", KEY_DESC, 0), key_a);


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
