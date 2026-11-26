Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EA606A32C
	for <ltp@archiver.kernel.org>; Thu, 26 Nov 2026 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lZIJTLHN
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C06073CF33F
	for <ltp@archiver.kernel.org>; Thu, 26 Nov 2026 04:13:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13C053C774A
 for <ltp@lists.linux.it>; Thu, 26 Nov 2026 04:12:49 +0100 (CET)
Received: from mta0.migadu.com (out-196.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::c4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 99EB3600B3B
 for <ltp@lists.linux.it>; Thu, 26 Nov 2026 04:12:47 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=CylPqtZViydQaun40sbI+QM2aRp+iHAenisTOF+hiC4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795662767; v=1; x=1796267567;
 b=lZIJTLHNMnRVQSeo3O/AtfyznIFSep3OsoB5QNpIYW2avB4QrRiBoVDwqecOIqkCobrVGng3
 xNgDOkyrnSlhEx2CQPufVyT7GcyRtn7i9nohOFiwSECYwHbEMbPPMawSRc0hatcwYLFuxKaFYlQ
 ZpQHoItaya5bSTFjOcYRiauo=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 475376a19ed4431e;
 Thu, 26 Nov 2026 03:12:47 +0000
X-Mizu-Trace-ID: 475376a19ed4431e
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 11:12:36 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <awei0yliGsjIDqZ5@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, wakel@google.com,
 ltp@lists.linux.it
References: <20261125030529.907385-1-li.wang@linux.dev>
 <20261125030529.907385-3-li.wang@linux.dev>
 <awa9GnSOwUvDo-HE@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <awa9GnSOwUvDo-HE@yuki.lan>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/4] tst_kconfig: load and unload kernel
 modules for CONFIG_*=m
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

> Hi!
> > +void tst_kconfig_module_unload(void)
> > +{
> > +	const char *name;
> > +
> > +	if (!loaded_module_count)
> > +		return;
> 
> This if is not really needed here.

Good point, patchset merged with your suggetion, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
