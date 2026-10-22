Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C31606A320
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cpY8vcDa
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 925F73CFDD0
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 03:28:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B2CD3CFD25
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 03:27:53 +0200 (CEST)
Received: from mta0.migadu.com (out-229.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::e5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9623C1400351
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 03:27:50 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=FigYNB0uMl3dPTcKz9Bk4j3D6T2nxXJlIWca0SnIFZ0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792632470; v=1; x=1793237270;
 b=cpY8vcDaZYOboPY13tx/AzKfYsluOrrq0rPSWqciOjBqDarN+rWzy863JW1QtObPB8EQrzQg
 oL35FcmZ3BJR6YTCfeybln45l9UDLuvEXmUte08P12tZ3G85a7VkawcvISGyi2SUl/BY2FTdDQj
 K8bVlXtuGxcPap1If/uVkrOg=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id d812e62797bd98be;
 Thu, 22 Oct 2026 01:27:50 +0000
X-Mizu-Trace-ID: d812e62797bd98be
X-Migadu-Flow: FLOW_OUT
Date: Thu, 22 Oct 2026 09:27:38 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <atlmihR-r3zIF3MH@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Xiaochen Shen <shenxiaochen@open-hieco.net>
References: <20261021031816.166499-1-li.wang@linux.dev>
 <20261021031816.166499-2-li.wang@linux.dev>
 <atihuztAXCPk1kGr@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <atihuztAXCPk1kGr@yuki.lan>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] sys_hwmon01: always report a result
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> >     v2:
> >         - rename attr_exists() to sysfs_attr_exists() (Xiaochen)
> >         - flatten the final result reporting with an early return (Xiaochen)
> >         - fix a preexisting off-by-one in the inN channel loop (Xiaochen)
> 
> It's very minor however unrelated fixes should be ideally done in a
> separate patches.

+1

> Feel free to push with my Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> with the off-by-one split into separate patch.

Patchset merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
