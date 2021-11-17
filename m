Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1DDC433EF
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 14:00:01 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799956139F
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 14:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 799956139F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62B1A3C87F0
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 14:59:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47D073C87F0
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 14:59:48 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82FE96006DC
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 14:59:47 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 9C999A6E87;
 Wed, 17 Nov 2021 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637157585; bh=sSkAWYuiYt/ZUTmc6h3EGA9B5JOtG+kuP7MpZAB+3jo=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=tFcoEkLUtws6KfN6YZYue5M+ZfLTfj71Ttq5fdNpfdUKfFglfKz8iiHN4cXXXD9g4
 JLJlklx34VVpb+jnf/gttxcINlNE6BeCpLOP4W6Cp1At54iZmJ3u+xBaES32I/c0P4
 DVsL45uoQiY36YMDewhGxhFgLPL4KrGhI7LN9+tE=
Message-ID: <77e0b8b9-5de6-73ab-0f73-e3d95bad0935@jv-coder.de>
Date: Wed, 17 Nov 2021 14:59:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20211117070708.2174932-1-liwang@redhat.com>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <20211117070708.2174932-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: adding .supported_archs field in
 tst_test structure
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 11/17/2021 8:07 AM, Li Wang wrote:
> Testcases for specific arch should be limited on that only being supported
> platform to run, we now involve a .supported_archs to achieve this feature
> in LTP library. All you need to run a test on the expected arch is to set
> the '.supported_archs' array in the 'struct tst_test' to choose the required
> arch list. e.g.
>
>      .supported_archs = (const char *const []){"x86_64", "ppc64", NULL}
>
> This helps move the TCONF info from code to tst_test metadata as well.

while I do like this, I wonder if it wouldn't be better to do this using 
kernel config. IIRC there are config switches
for all architectures. Further more this would allow adding more complex 
conditions in the future.

E.g: I am pretty sure, that there are some syscalls, that have existed 
"forever" in x86_64, but where only added
in a specific version for aarch64. By making the arch a separate option, 
there is no way, to model this.
If it was done in the kernel config check, it could be possible to add 
version and arch checks like
(CONFIG_AARCH64 && CONFIG_VERSION > 5.3) || CONFIG_X86_64

While this probably does not produce a very good error message, it is 
more versatile.

Sorry for this late questioning the whole approach.

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
