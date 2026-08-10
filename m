Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E951C5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 10:10:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8206D3CE39B
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 12:10:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBFEC3CC291
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 12:10:27 +0200 (CEST)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1F2741A00661
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 12:10:25 +0200 (CEST)
Date: Mon, 10 Aug 2026 18:10:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1786356623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=szZFBNux2MHtFdUq21uZBrQYXHra58kYXwP2L1c7Qq0=;
 b=KXj0bjyVJFqP2IZ2soDo+gH10S5xagdesffN644jxTLnNbIzv6asos9p927r7uKswdSnHW
 8vhJVdjrx5+TcNdfJaJhjCEIyjyIkWmLNxusIAm7oVe0j/WdYnrabJNq/t3VuqhMptoSrh
 Dx/Tok+AFj3n42N0AnB9cvklUCQR7I4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Wake Liu <wakel@google.com>, Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <anmjiYgCDToNhlxI@linux.dev>
Mail-Followup-To: Wake Liu <wakel@google.com>,
 Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
References: <20260807110541.8702-1-linuxtestproject.agent@gmail.com>
 <20260807234935.3248935-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260807234935.3248935-1-wakel@google.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] lib: Use backoff polling to wait for loop
 device nodes
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

Hi Wake, All,

I have merged v6 to keep things tidy. Thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
