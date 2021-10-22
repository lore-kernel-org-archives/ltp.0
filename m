Return-Path: <SRS0=vXB5=PK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E287CC433F5
	for <ltp@archiver.kernel.org>; Fri, 22 Oct 2021 11:29:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52F1610A4
	for <ltp@archiver.kernel.org>; Fri, 22 Oct 2021 11:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A52F1610A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C74A3C6325
	for <ltp@archiver.kernel.org>; Fri, 22 Oct 2021 13:29:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6DE33C0E64
 for <ltp@lists.linux.it>; Fri, 22 Oct 2021 13:29:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62D6B60179A
 for <ltp@lists.linux.it>; Fri, 22 Oct 2021 13:29:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 65A5E1FD59;
 Fri, 22 Oct 2021 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634902158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2Ec/crJPdN4fKUqznBa5M4NvJAO9Ltw1OUlwWHCFhg=;
 b=e7wY7qRkh3Pn87VLO/ED+4pQaKpTDJtkPoChsV7mgRHkEHAO56mqglkcRv2BZG+UJ3oqI9
 QC7b9L73n1+qpNDpRouRe/xfFH9HtOV8PwKWIXubIJ/9RrSkHZp9wGc9Iv47AKtxT//Fa/
 JSIhzCzd8P804AsT4rO7hrGdoU92D1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634902158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2Ec/crJPdN4fKUqznBa5M4NvJAO9Ltw1OUlwWHCFhg=;
 b=16ZZxe6mwgD1mr6StZ1dg6jrMyTQY38Pod36uxX6SzcQUtTDxwsOoYyJ/+4TOEyYVBaqD3
 S6T0o2cWWIVnfaCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BB4913CD4;
 Fri, 22 Oct 2021 11:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PqWrDI6gcmFuIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 22 Oct 2021 11:29:18 +0000
Date: Fri, 22 Oct 2021 13:29:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YXKgjCFoS3ykchcH@pevik>
References: <20211018154800.11013-1-chrubis@suse.cz>
 <20211018154800.11013-8-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211018154800.11013-8-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/7] docparse/Makefile: Do not abort on missing
 generators
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Since we want to use the metadata.json in the testrunner it must bte
nit: typo s/bte/be

> build unconditionally.
According to docs:
  --with-metadata-generator=asciidoc|asciidoctor
  --disable-metadata      Disable metadata generation (both HTML and PDF,
                          default no)
  --disable-metadata-html Disable metadata HTML generation (default no)
  --enable-metadata-pdf   Enable metadata PDF generation (default no)

I'd like to have single option which does not create HTML and PDF (thus does not
require asciidoc|asciidoctor. I wonder if we could change build system to keep
--disable-metadata, build always docparse and json as we need, but with
./configured --disable-metadata just not run HTML and PDF generation?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
