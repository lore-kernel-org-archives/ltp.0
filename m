Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB79C55172
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 04:18:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B0093E720F
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 06:18:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E68C63E2AB5
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 06:18:16 +0200 (CEST)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [91.218.175.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 43B061000965
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 06:18:16 +0200 (CEST)
Date: Tue, 4 Aug 2026 09:12:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785805960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCjj0x6fI/i25cl32qCxJdUztAHBKt49x8caWsa7muI=;
 b=oGVUwOS0BvCOexpPsu6X6PGir4P/FDLd0yQkawFytgwU41tpWj93f35tSy4T+JXpZSoPgW
 CtJImJ8xxdNnuXo1qWKcutD8P301Xeyt+qUOF8Skb/UdihRecB8tQmD/8VpkpVJ4IVmdaS
 QDwkG03rph8IAGo+Pfuvf2KglwcrKbk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <anE7o-2xAPRBGSaV@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, linux-kernel@vger.kernel.org,
 Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Jan Stancek <jstancek@redhat.com>,
 Avinesh Kumar <avinesh.kumar@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 automated-testing@lists.yoctoproject.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Tim Bird <tim.bird@sony.com>,
 Ben Copeland <ben.copeland@linaro.org>, ltp@lists.linux.it
References: <20260803115821.238704-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803115821.238704-1-pvorel@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] MAINTAINERS: Add IRC and patchwork for LTP
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
Cc: Tim Bird <tim.bird@sony.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
