Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2A9C5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 09:13:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBD4D3E6BF0
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 11:13:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D31F3E21F9
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 11:12:59 +0200 (CEST)
Received: from mta0.migadu.com (out-150.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::96])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9297510007DC
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 11:12:58 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=XX6yxQND5TfhaqEaZizimV1Igl+SyYSrgHAm1ntUqgo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786612378; v=1; x=1787217178;
 b=OGk5Gmh8SaX3jRAqc4DYhK0XPJ1291xtwRrB27lqeIH+uhHSoORW2zoZuL2vMpEexVyKTEBE
 C20jycuYxoV9D23fHQ35y0Ga8voen2E1M3ogBkzRXFk4/u5PhkUWdCYG0FnWMxZ4SSlEbQkjrAV
 v6k3tELJPzh+OrM43IiLlE0M=
X-Envelope-To: ltp@lists.linux.it
Received: from localhost (60.247.5.98)
 by smtp.migadu.com with ESMTPS id 7d8c41bce4afb7ed;
 Thu, 13 Aug 2026 09:12:58 +0000
X-Migadu-Flow: FLOW_OUT
Date: Thu, 13 Aug 2026 17:12:46 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>, Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <an2Kjkp02wyB3B1M@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>,
 Avinesh Kumar <avinesh.kumar@suse.com>, Li Wang <liwang@hygon.cn>,
 ltp@lists.linux.it, Andrea Cervesato <andrea.cervesato@suse.com>
References: <20260813023216.79848-1-li.wang@linux.dev>
 <95979fc4-682a-4fa5-8833-28f9b9573be8@suse.com>
 <20260813062654.GA1801742@pevik> <an1oDw9Q8yp_66Zh@linux.dev>
 <20260813065036.GA1812963@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260813065036.GA1812963@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscall: set FORK in tst_sig for some old tests
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh, Petr,

> > Patch merged! Thanks~
> 
> Thanks for fixing it!

> very nit: there could have been
> Reported-by: Avinesh Kumar <avinesh.kumar@suse.com>

That's true, apologies for my carelessness.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
