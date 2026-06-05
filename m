Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767A1CD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 05:18:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CCEA3E2FF9
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 07:18:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 122673CE102
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 07:18:39 +0200 (CEST)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CD94E1400DA9
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 07:18:36 +0200 (CEST)
Date: Fri, 5 Jun 2026 13:18:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780636710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MztvAHFH1rNay59mXfvkZy4oh/e3+nO4KtRhD5HIMX8=;
 b=mD4fochYPJdGSMZcZzzZSP921YSs281b5d1fN7bY66nNdCxSTYZqrkwMe8jytzMvHR+EdZ
 4emhzzgBafFQ8GYgxg75DASrCsNihlF95G0iWPxtx3dNjeikcrJ3rYqG5rM1Gi+mhOliqb
 iGtOMXFRVHGL57h3dZElLzXCKA+o3JA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aiJcIGxsXxx5TYno@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260604094200.21643-1-li.wang@linux.dev>
 <aiFKatipB8ypAsdf@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aiFKatipB8ypAsdf@yuki.lan>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] lib: Introduce tst_path_defs.h to
 consolidate system paths
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

> Maybe we can drop the NET here as well, the IPV4 is descriptive enough.
> e.g. PATH_IPV4_ICMP_RATELIMIT

Patch merged with the _NET_ string and trailing slash
(LTP-AI suggests) dropped. Thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
