Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44FD606A31B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RtCUUOfZ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 673FF3EA60A
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:13:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59E6E3EA602
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:12:54 +0200 (CEST)
Received: from mta1.migadu.com (out-71.mta1.migadu.com
 [IPv6:2001:41d0:203:375::47])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 94B471A00906
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:12:51 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=UuKNW69xJheBrEID5nyOhTZz8LRF2Eg1qbxeikiU8pk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792491170; v=1; x=1793095970;
 b=RtCUUOfZ+QMC6xAVd9RRi6n9mJaMCRZnIkjvKpJyiDXdMsRz4yc7+/G4tS4ZkGBMH9FheCxf
 VP39zVxMuLlAAM0s8yYMLtzLybDpMcx9UIp2TJJpClLcog4/l/ZzoJ6rjha18SnwnFfxnz+nfdf
 6jk/mYzQq1HYu2SitbvqaLVM=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id f7bd12bc284fa2f5;
 Tue, 20 Oct 2026 10:12:50 +0000
X-Mizu-Trace-ID: f7bd12bc284fa2f5
X-Migadu-Flow: FLOW_OUT
Date: Tue, 20 Oct 2026 18:12:46 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <atc-WE90VUyeFO9U@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Xiaochen Shen <shenxiaochen@open-hieco.net>
References: <20261020080033.123660-1-li.wang@linux.dev>
 <atc5USFImqRKPt82@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <atc5USFImqRKPt82@yuki.lan>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sys_hwmon01: always report a result
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
> >  #include "tst_test.h"
> >  #include "tst_sysfs_assert.h"
> > @@ -56,39 +58,67 @@
> >  
> >  #define MAX_CHANNELS 32
> >  
> > +static unsigned int checked;
> > +
> > +static int sysfs_attr_exists(const char *fmt, ...)
> > +{
> > +	char path[PATH_MAX];
> > +	va_list va;
> > +
> > +	va_start(va, fmt);
> > +	vsnprintf(path, sizeof(path), fmt, va);
> > +	va_end(va);
> > +
> > +	return tst_sysfs_exists(path);
> > +}
> 
> Uff, the tst_sysfs_attr_exists() does work with printf-like parameters.
> 
> What do we need the this wrapper for?

Indeed, I missed that it already takes printf-like parameters.
 
> > +#define CHECK_RANGELL(lo, hi, ...) do { \
> > +	if (sysfs_attr_exists(__VA_ARGS__)) { \
> > +		checked++; \
> > +		TST_SYSFS_ASSERT_RANGELL_SILENT(lo, hi, __VA_ARGS__); \
> > +	} \
> > +} while (0)
> > +
> > +#define CHECK_BOOL(...) do { \
> > +	if (sysfs_attr_exists(__VA_ARGS__)) { \
> > +		checked++; \
> > +		TST_SYSFS_ASSERT_BOOL_SILENT(__VA_ARGS__); \
> > +	} \
> > +} while (0)
> 
> What about we add the counter into the sysfs library instead?
> 
> If we add:
> 
> void tst_sysfs_cnt_reset(void);
> 
> unsigned int tst_sysfs_cnt_get(void);
> 
> We can call the tst_sysfs_cnt_rest() at the start of the test function,
> and get the counter at the end.

Good idea, that's cleaner on all fronts: the CHECK_* wrappers and the
extra existence probe go away entirely (the current version stats each
attribute twice), and any other SILENT-only sysfs test gets the same
fix for free.

I'll split v3 into two patches: one adding
tst_sysfs_cnt_reset()/tst_sysfs_cnt_get() with the counter bumped in
the SILENT assertions when the attribute exists, and the hwmon test on
top of it.

One question: should the counter count attributes that exist and get
checked regardless of pass/fail, or only passing ones? I'd go with the
former, since failures already produce TFAIL results on their own.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
