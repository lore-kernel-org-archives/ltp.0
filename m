Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8F4C982C1
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 07:43:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7741D3E65AB
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 09:43:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F11F93E65A9
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 09:42:53 +0200 (CEST)
Received: from mta0.migadu.com (out-142.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::8e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 56DB3600958
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 09:42:52 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=XTRIuHykVmmkherCQch7kEsjOC+TKEW09H6Qgdg1Dss=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789630971; v=1; x=1790235771;
 b=S13Vx9/cK+v59kt4xjfTWcY63100oCwkH8M7jmil9d+6C03lpF0QCXaazYkecsFjVn+B50cl
 US/FrkhPdd7IAn/Qi3b5CTtifHsRo873T30bZV0OwZRhp9jqcSAkyPZYWftbslLLJwQ9e36XBdH
 GtaHcqAwwK9dLF8bNXPj7lno=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 100d00aa54770275;
 Thu, 17 Sep 2026 07:42:51 +0000
X-Mizu-Trace-ID: 100d00aa54770275
X-Migadu-Flow: FLOW_OUT
Date: Thu, 17 Sep 2026 15:42:40 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aquYRYCPcpqww_1F@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, Wei Gao <wegao@suse.com>,
 Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>
References: <20260903095255.4925-2-wegao@suse.com>
 <6a9a867b.de81f790.219d91.7092@mx.google.com>
 <ap5n5QV5xneoAFYm@autotest-wegao.qe.prg2.suse.org>
 <20260916113339.GA1756857@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916113339.GA1756857@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11 1/2] lib: Extend tst_assert_ulong() with enum
 flags
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

> => I vote to merge Andrea's solution instead.
> @Cyril @Li WDYT?

Agreed.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
