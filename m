Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A470C606A319
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=R1FaEMg5
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A3283CFE18
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 03:47:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA4ED3CFD25
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 03:47:34 +0200 (CEST)
Received: from mta0.migadu.com (out-225.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::e1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 07A4B140042B
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 03:47:32 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=uE1wgcjVtEFM+6ezYSmbR500wdDZ7H3P0PwJClFet8g=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792633652; v=1; x=1793238452;
 b=R1FaEMg52FlagMguZ63KPU6t/a/SeZkRBxBj+5I2Y1SLSxfL0dm4zbuYJA++kQcfwrPEp+am
 BYXJvZfnlUl86mtJbA+mBMF4F90r6K3kD6nPn3cNmvuZ434YZ73m55AbE+/QiDtg5p3u8zp7rSX
 9jrPN/T1538AERl2Oq6ifLBk=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id f08f9a24f97926de;
 Thu, 22 Oct 2026 01:47:32 +0000
X-Mizu-Trace-ID: f08f9a24f97926de
X-Migadu-Flow: FLOW_OUT
Date: Thu, 22 Oct 2026 09:47:25 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Xiaochen Shen <shenxiaochen@open-hieco.net>
Message-ID: <atlrLUd_ophJPoZR@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Xiaochen Shen <shenxiaochen@open-hieco.net>
References: <20261021031816.166499-1-li.wang@linux.dev>
 <20261021031816.166499-2-li.wang@linux.dev>
 <atihuztAXCPk1kGr@yuki.lan> <atlmihR-r3zIF3MH@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <atlmihR-r3zIF3MH@linux.dev>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Feel free to push with my Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> > with the off-by-one split into separate patch.
> 
> Patchset merged, thanks!

Oops, I fixed the off-by-one but pushed without creating a
new commit, sorry about that.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
