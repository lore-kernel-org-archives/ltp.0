Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1DFC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:45:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FCD23E9747
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 11:44:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44F2C3E5507
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:44:43 +0200 (CEST)
Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AE0F3601D0C
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:44:42 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=mHz3Xp99ngB03oDUJWIbnkH8/sZrwthNzs8me8QWMlQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788515082; v=1; x=1789119882;
 b=lSrYj8zOs0mNkcsq2baNBvi+NwWQXEfXreL1qgsiTHMbl95BlptTYeJDmgp5Wt34PYgrJ1Qk
 lFQ/wgySSb5JvDEIVU6CC70nd3ZZgtFKigNofjL742fYNNrkk2kzEkns0euW8D7e0DoBz3ojMuk
 OMMWD6QlIq2CnfrRn1RVTtTk=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 52ce7cd7ec835da4;
 Fri, 04 Sep 2026 09:44:42 +0000
X-Mizu-Trace-ID: 52ce7cd7ec835da4
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 17:44:35 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <apqTA2QG3LdEVX5F@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260904-min_kernel-v2-1-9991d3fb3c18@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-min_kernel-v2-1-9991d3fb3c18@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Check minimal supported kernel version
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Define the minimal supported kernel version in tst_kvercmp.h so that
> the documentation fetches it dynamically and the core library aborts
> unsupported kernels with TCONF during test setup.

The description doesn't match the code.
Other than that, it looks good to me.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
