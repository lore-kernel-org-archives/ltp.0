Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4D6C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 03:29:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90DFE3E9030
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 05:29:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9702F3E7074
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 05:29:17 +0200 (CEST)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [95.215.58.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B2A7610009F0
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 05:29:16 +0200 (CEST)
Date: Fri, 7 Aug 2026 11:28:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1786073355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYEBxujDknH+G3XBFNxwehVnHk+U/DQCBkMs9a+Ysd8=;
 b=rNKHMrpbzLEYU2I102r8+CVxaDKRmiJWaWhjILifqS4luVq8L8VAEmiaxAWVVdK0cG4IMP
 QC6lsJsMLXQ8Eu7KNUoHblFqfpXVCw+jfAHcl8DOVeVE+LgXQTi0YcsSCenrgDl+/UrXhU
 iRS+qcLzOQLH5+X41c8L/BbuugDVZzE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Xuewen Wang <wangxuewen@kylinos.cn>
Message-ID: <anVQ5fT9VHpVSAyH@linux.dev>
Mail-Followup-To: Xuewen Wang <wangxuewen@kylinos.cn>, ltp@lists.linux.it
References: <20260807014416.1453266-1-wangxuewen@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260807014416.1453266-1-wangxuewen@kylinos.cn>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] memcg/functional: fix memcg_failcnt
 intermittent timeout by disabling swap
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

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
