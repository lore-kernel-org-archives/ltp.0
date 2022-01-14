Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1226C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 13:12:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 559603C9553
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 14:12:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 797B13C8CB7
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 14:12:34 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D8D83100135F
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 14:12:33 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id A6AAD9F7EC;
 Fri, 14 Jan 2022 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1642165952; bh=383WH4NYuzwNlv3Xmg1bOCkOY9VKjHIfWTrCmWBhh74=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=uVzL0FDnwZ75fcwikVtxBB5D3FbpHspif8yCi6CW/mhR4gqC5CtYc/KAhN8+4xFmN
 0uHMzEe9ugBSTSpv3jwsvmMOu7Bwk11qz67PRBE49vCdpNQAmfy0mYrGgSUjSTO6VM
 OMfete767z1+EYnBIcLBv4WGMBrGlct4RrrA5Ot8=
Message-ID: <52627525-6455-4e39-a969-12938e1df05e@jv-coder.de>
Date: Fri, 14 Jan 2022 14:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220114125513.895-1-pvorel@suse.cz>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <20220114125513.895-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] configure.ac: Fix summary for disabled
 metadata
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,


Am 1/14/2022 um 1:55 PM schrieb Petr Vorel:
> Previously with --disable-metadata output didn't mention that metadata
> are disabled and printed config which was not used. Now>
> $ ./configure --disable-metadata

a bit out of context here, but still: The disable-metadata flag is
confusing, because it does not disable metadata entirely. We had to
patch the makefile, to disable build of mateparse. While this is
basically setup correctly for cross compilation, we had some problems,
if the HOSTCC version did not match the CC version.
I am not entirely sure what the problem was, only that we did not care,
because we don't need metaparse end disabling it was simpler than fixing
the build.

Long story short: "--disable-metadata" should completely disable
metadata parsing, not only document generation

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
