Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F32C5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:46:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC7FB3E5A12
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:46:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 218F83CFEB3
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:45:46 +0200 (CEST)
Received: from mta0.migadu.com (out-171.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ab])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D6AB1A0079B
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:45:44 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=K/NPAcLpmUcFQN2js6aHLFB9KypNGGUJL694Kz/M/HU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786603542; v=1; x=1787208342;
 b=ZbS18UchgNuh10+sMTrjvGSLIa0QhGpx9mvBmoZlSxzdQ4lHE5oDm8cxB11LA2SN+aM7yuaj
 Tgn9Mh8bKYgGzuvfluMlaMoCC/hZHijIrlC6pxmYJh053jBXp53gjQ/U8KWePnlmyejvRjn5NJw
 3cwKsIJk1oIxMOGbMFbxiBEo=
X-Envelope-To: ltp@lists.linux.it
Received: from localhost (2408:8409:18c0:1f4d:457:b937:2f7c:bd8c)
 by smtp.migadu.com with ESMTPS id 5690b794fbbf9155;
 Thu, 13 Aug 2026 06:45:42 +0000
X-Migadu-Flow: FLOW_OUT
Date: Thu, 13 Aug 2026 14:45:35 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <an1oDw9Q8yp_66Zh@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>,
 Avinesh Kumar <avinesh.kumar@suse.com>, Li Wang <liwang@hygon.cn>,
 ltp@lists.linux.it, Andrea Cervesato <andrea.cervesato@suse.com>
References: <20260813023216.79848-1-li.wang@linux.dev>
 <95979fc4-682a-4fa5-8833-28f9b9573be8@suse.com>
 <20260813062654.GA1801742@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260813062654.GA1801742@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

Hi Petr, All,

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>

Patch merged! Thanks~

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
