Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45D606A32D
	for <ltp@archiver.kernel.org>; Thu, 26 Nov 2026 03:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PwYf3oW7
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD4073E981F
	for <ltp@archiver.kernel.org>; Thu, 26 Nov 2026 04:58:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C6843E1541
 for <ltp@lists.linux.it>; Thu, 26 Nov 2026 04:58:27 +0100 (CET)
Received: from mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 617B7200AD1
 for <ltp@lists.linux.it>; Thu, 26 Nov 2026 04:58:27 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=Q+HjHeLOSz4XBosXaGiH0uePQSrtrakBqHiNIDre0Qc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795665506; v=1; x=1796270306;
 b=PwYf3oW7Cy+gnZfQRZaLO2Ch0dACE0m82lOBugCOs19BwOJIEp1FY4R7sraa8wemhqtLyGFb
 ItVJL4Oie5zfaNPaQUFzO6bI/IvTEPxW+HR2aM1OS9ugFjVyebKAZJxGT1RPzBVVhXuxTIvM0xt
 uA/288wmwSZ4N1G2zt+L8GD4=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 7c85f7bab2af02ed;
 Thu, 26 Nov 2026 03:58:26 +0000
X-Mizu-Trace-ID: 7c85f7bab2af02ed
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 11:58:16 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aweuWIKZTvCrjIu2@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, wakel@google.com,
 ltp@lists.linux.it
References: <20261125030529.907385-1-li.wang@linux.dev>
 <20261125030529.907385-4-li.wang@linux.dev>
 <awa-HJF-j8eOjFNw@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <awa-HJF-j8eOjFNw@yuki.lan>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 3/4] tst_kconfig: add module mappings for
 vsock/vsock_loopback
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: wakel@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> One idea I have in my mind is to add ".run_as_nobody" into the tst_test
> structure, which would:
> 
> - run the setup() and cleanup() as root
> - switched to nobody for run()
> 
> I guess that first of all we should check how common is that pattern and
> add the support if needed...

Right, I'll look into it when I'm free and see if it's worth doing.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
