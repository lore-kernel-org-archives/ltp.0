Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7B0CA5FF1
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 06:58:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 989433E3052
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 08:58:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3AA43E2C45
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 08:58:34 +0200 (CEST)
Received: from mta1.migadu.com (out-251.mta1.migadu.com
 [IPv6:2001:41d0:203:375::fb])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E79491A00162
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 08:58:30 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=Sf4J1Zt5YUOVwFbtFgJ15275v7ojIKjIMP1O1EKd1Pg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791356309; v=1; x=1791961109;
 b=tKtlGo/sl5wni6SbH7yJ0cdcKOVAU3SVVoPxIE7U6YAoYluujqqKK+jMm4RKDFYgI4XQhplA
 huc6nWxFtZDETYYBS7NEappEluSSOFD1RvPD2Vv5lFW1j0iTWVL+Usp9JhBCxt8yfBICNIS+s5v
 uccLM7intCt6Uq9N7xtr6KBk=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 43f66c513f05aea0;
 Wed, 07 Oct 2026 05:51:38 +0000
X-Mizu-Trace-ID: 43f66c513f05aea0
X-Migadu-Flow: FLOW_OUT
Date: Wed, 7 Oct 2026 13:51:31 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <asXd40hgsavyhBcw@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20261006-fix_simple_bugs_core_lib-v1-0-c94199a46ec5@suse.com>
 <20261006-fix_simple_bugs_core_lib-v1-3-c94199a46ec5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261006-fix_simple_bugs_core_lib-v1-3-c94199a46ec5@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] tst_kconfig: Prevent stack buffer overread
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

On Tue, Oct 06, 2026 at 03:02:39PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> kconfig_parse_line() stops scanning value characters only at
> whitespace. Because isspace('\0') is false, lines without trailing
> whitespace cause an out-of-bounds stack read past the terminating
> NUL byte.
> 
> Stop scanning when reaching NUL or whitespace.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
