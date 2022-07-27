Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23542C19F21
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 05:42:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 792603C2297
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 07:42:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AF313C0211
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 07:42:23 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A4F7600273
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 07:42:22 +0200 (CEST)
Received: from [10.40.94.2] (unknown [91.26.40.236])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 788809FE82;
 Wed, 27 Jul 2022 05:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1658900541; bh=BOeKwZK8LZSWlQ78eVCpqUuKNPEiod6poQ8VEe7dAfU=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=Pm17EH2AdDOoXxKNVNWC/QCpuNZ4g+VF/qYsHdp52Haz8ufU8WbqM83rW6wncwKg7
 Boy4zesOs7BShzgHyuyU6aBqkTjETaNJFyghmIe/3OcKO3/+RZ5mL4FR1rJXxjmUlY
 il2z9jiQ47bB35MHRNi3bGm2VeSXHzVOZxcVgN2g=
Message-ID: <cadd0a8c-51a3-0ced-f0d7-eeaf15999f98@jv-coder.de>
Date: Wed, 27 Jul 2022 07:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220627125321.1560677-1-lkml@jv-coder.de>
 <20220627125321.1560677-3-lkml@jv-coder.de> <87czekrseu.fsf@suse.de>
 <874jzwrrvg.fsf@suse.de> <b33360f5-96ba-f7c3-9e86-f7966c260eb9@jv-coder.de>
 <87zghoq9km.fsf@suse.de>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <87zghoq9km.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] openposix: Setup autoconf and fix
 installation layout
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
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard

Am 7/5/2022 um 9:37 AM schrieb Richard Palethorpe:
> Hello Joerg,
> 
> Joerg Vehlow <lkml@jv-coder.de> writes:
> 
> OK, so things are being installed twice and it is generally a
> mess. This looks like a good cleanup.
> 
> However this really needs to be explained in the patchset. There
> needs to be a clear description of where things have moved from and
> to. In particular what someone needs to do if this breaks their test
> runner scripts. This can then be copied into the LTP release notes.

I think this is explained now in v2 in the commit message.

> BTW IIRC we generate runtest files for the open posix tests and the test
> runner handles them almost like normal LTP tests. We don't use any of
> those scripts either.
I was not able to find anything like this.

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
