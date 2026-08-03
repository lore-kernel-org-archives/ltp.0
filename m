Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F09C5518E
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 09:44:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 999963E5588
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:44:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 123763E0E7A
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:44:34 +0200 (CEST)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 63BB01A00616
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:44:32 +0200 (CEST)
Date: Mon, 3 Aug 2026 17:44:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785750271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hpIPY5XgG09IGMRpKUXxubxfWuSRRSP30xdDqbWMGRQ=;
 b=MJx8NJin5j7DHl54xrwQdBOEgsjmVr2WoMmCIWG2Iqwwtvt/HvKkAQipt42rKEx2sQfR8M
 6yMn/trrxTfWzNgLsVc8jEbVn2hvSkP5hl1fGfPdNVXIAx/02PQE+tBqrLwN4baoXeO+WV
 LazjE+sViKUdFyW+m1E0BYGa+P/r83w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>, Petr Vorel <pvorel@suse.cz>
Message-ID: <anBi9ybOfNzbxALE@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
 ltp@lists.linux.it, Jan Stancek <jstancek@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Avinesh Kumar <akumar@suse.de>, Martin Doucha <mdoucha@suse.cz>,
 Wei Gao <wegao@suse.com>
References: <anBdxCKHlpedf2rf@yuki.lan>
 <6a705f30.cfe55ba5.e6eae.189a@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a705f30.cfe55ba5.e6eae.189a@mx.google.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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

Andrea Cervesato wrote:

> > I would keep it around at least for a year or two, I sometimes look up
> > old patches there.
> 
> that looks like a really long period of time. lore.kernel.org/ltp/
> is not enough?

I guess Cyril means to look back the history of patch discussion when needed.
 
Or, can we tar the mail discussion for recent years and store it somewhere?

Anyway, for the patch:

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
