Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31B5CC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 03:19:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63B3D3E7429
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 05:18:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF85B3E7429
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 05:18:42 +0200 (CEST)
Received: from mta0.migadu.com (out-90.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::5a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D73101400BE5
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 05:18:38 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=lP4/QmWMPCQiMftXpV5zKKxerEHF19+g/6c4d+OQcUg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791947917; v=1; x=1792552717;
 b=PGW9g786cUjNhv0GlOmzHJTtAJbtpRFtMncs4R5+QCbIIcztiWVAUJmiVKXJWSSybxHllZkf
 mfl/DOvFWtlSYNZaWiVHsuu0yvrmWyZwDwjtSCAkW+cjPtJm27yKeHnyklkqAlsHNCIFp9UZBcv
 kc+EVfMpz0a9/VrRlqqV47PU=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id b6a87a0324a1df88;
 Wed, 14 Oct 2026 03:18:37 +0000
X-Mizu-Trace-ID: b6a87a0324a1df88
X-Migadu-Flow: FLOW_OUT
Date: Wed, 14 Oct 2026 11:18:27 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <as70g8dWFN1ZF4Ph@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 ltp@lists.linux.it
References: <20261010033622.68927-2-li.wang@linux.dev>
 <oxUvYO8wV14vdPyltlLgB09i0ZBYZcJfi9qY@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <oxUvYO8wV14vdPyltlLgB09i0ZBYZcJfi9qY@localhost.localdomain>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] lib: add module is loaded check
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

Hi Andrea,

> Hi Li,
> 
> > +
> > +bool tst_module_is_loaded(const char *mod_name)
> > +{
> > +	char line[4096];
> > +	size_t mod_len = strlen(mod_name);
> > +	FILE *file;
> > +
> > +	file = fopen("/proc/modules", "r");
> > +	if (!file)
> > +		return false;
> 
> why not using SAFE_FILE_LINES_SCANF() ?

file_lines_scanf() uses a fixed format string, and with
`arg_count == 0` (e.g. `"%s %*s"` with only suppressed
conversions) it cannot distinguish a matching line from a
non-matching one, because vsscanf returns 0 in both cases.

On top of that, /proc/modules needs to walk every line and
compare against a module name that is passed in at runtime
and may need the '-' to '_' normalization. So it is not a
good fit here; a plain fopen()/fgets() loop is clearer.

One more concern: /proc/modules may not exist at all on some
platforms. When the kernel is built with CONFIG_MODULES=n
there is no module support and /proc/modules is absent, and
some container runtimes also do not provide it. With that
would trigger tst_brkm(TBROK) and abort the test

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
