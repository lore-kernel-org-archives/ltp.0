Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9446CA6010
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DADD23E2FF2
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 11:49:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 131F13C2169
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 11:49:38 +0200 (CEST)
Received: from mta1.migadu.com (out-80.mta1.migadu.com
 [IPv6:2001:41d0:203:375::50])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 56FB91400BCB
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 11:49:37 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=D3fZ01LcIAQ9APpKHxkRug12NGNGhfY0jSJKppWCV4k=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791452976; v=1; x=1792057776;
 b=FgnPjczquFLpNWDC2zfxWWqMZ2uS2wzD6hqc+bLiDxMPg/i6BlxSA42bbLcmArTb11+IytIu
 n6F5HivXeQbX5YYj790E8IbwaA8nrCffP8HEvLEMBdkBJgpTcDGZVRdMXtjMOBohRcQMvvUzqBc
 sv1eLr6J5TF8Kzi2EI5S4VSc=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 3e9e873af7835ef4;
 Thu, 08 Oct 2026 09:49:36 +0000
X-Mizu-Trace-ID: 3e9e873af7835ef4
X-Migadu-Flow: FLOW_OUT
Date: Thu, 8 Oct 2026 17:49:28 +0800
From: Li Wang <li.wang@linux.dev>
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Message-ID: <asdnKDIyq0h0pd6p@linux.dev>
Mail-Followup-To: Huaisheng Ye <yehuaisheng@open-hieco.net>,
 chrubis@suse.cz, pvorel@suse.cz, ltp@lists.linux.it,
 LTP review agent <linuxtestproject.agent@gmail.com>
References: <20260929111527.43833-1-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260929111527.43833-1-yehuaisheng@open-hieco.net>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap10: Treat fd 0 as valid in cleanup
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
Cc: ltp@lists.linux.it, LTP review agent <linuxtestproject.agent@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
