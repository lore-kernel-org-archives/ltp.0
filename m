Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B651C55838
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 02:45:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 511363E94A8
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 04:45:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A94F93E2D22
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 04:44:54 +0200 (CEST)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7A7791A001D6
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 04:44:52 +0200 (CEST)
Date: Wed, 5 Aug 2026 10:44:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785897891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCjj0x6fI/i25cl32qCxJdUztAHBKt49x8caWsa7muI=;
 b=pO9D79k4tVVPNdmS3A9jF7eRKlRxHaaO1nc5K3jTobO8glFZ9zwsjLoJeZ9hsM+HuxM9xb
 nUWq6i/o2Bk88hzRg7zEqBdx+RXf5RnDXY1qOq/pbdFOZlWmjCHMAAT+sJoZ2Knof7iumn
 jV2e8DPG6sbG6UOw2z+sq3vGQmGcePQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <anKjnh5bpOIltGde@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260804132857.552304-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804132857.552304-1-chrubis@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_res(): Fix TDEBUG | TERRNO
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

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
