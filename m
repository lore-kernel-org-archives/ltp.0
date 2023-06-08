Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0E6C77B7A
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 00:55:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7795E3CE6C4
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 02:55:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E1D33CC9C8
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 02:55:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6FD0C60070C
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 02:55:03 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9C6E16117E;
 Thu,  8 Jun 2023 00:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4FEC4339B;
 Thu,  8 Jun 2023 00:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686185701;
 bh=W7b3q9WsOk2hTRlrweoWCUg7OK54/BI2hX077AHKHQA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eYJeYrQdJFy/BXrSJv9F5uFbAnhMUwvlM5m0NZzXV5T7FNfVWVk1o9d12oTsE3hVH
 BI3aS9NFngX+9a8XEvmCV9IX4VpcPejld31i8RG1wtMRsbLrRNCrJWrTiZSol+c9ln
 HRYXkC9fdWfJsWKedlbujilKS0G31jli4Ea9aCxrqL94M7HtdMNzsrOB0BIH7OZKvf
 TaNfj14/8ftHWkVM0JIxNQft0Nsn9vIrxmP3JE92qJsqFZQoT6eQd5XGEE8F9bIUMm
 COZBQj5kovQy8CDJVcDFnuoZQajx/2c3oUAbFVyXTaokW3Jd8wVbe+EKO3I5Hx/43q
 r5zEtaFmVktLQ==
Message-ID: <0347361d-1676-3fb3-da73-da54657ad8f9@kernel.org>
Date: Thu, 8 Jun 2023 09:54:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Linus Walleij <linus.walleij@linaro.org>
References: <20230605044131.798383-1-dlemoal@kernel.org>
 <20230605044131.798383-3-dlemoal@kernel.org>
 <CACRpkdaBinsAofvQgLZ5u8ScR0+yWPnQCf6E7CPtn598PN0eoQ@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CACRpkdaBinsAofvQgLZ5u8ScR0+yWPnQCf6E7CPtn598PN0eoQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ioprio: Use IOPRIO_PRIO_NUM to check prio
 range
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNi83LzIzIDE1OjQ0LCBMaW51cyBXYWxsZWlqIHdyb3RlOgo+IE9uIE1vbiwgSnVuIDUsIDIw
MjMgYXQgNjo0MeKAr0FNIERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+IHdyb3Rl
Ogo+IAo+PiBVc2UgdGhlIG1hY3JvIElPUFJJT19QUklPX05VTSBpbiBwcmlvX2luX3JhbmdlKCkg
dG8gY2hlY2sgdGhlIHVwcGVyCj4+IGJvdW5kIG9mIHRoZSB2YWxpZCByYW5nZSBmb3IgcHJpb3Jp
dHkgbGV2ZWxzLiBTaW1pbGFybHksIGluIHRoZSB0ZXN0Cj4+IGNhc2UgaW9wcmlvX3NldDAzLCB1
c2UgdGhpcyBtYWNybyB0byBjaGVjayBmb3IgZmFpbHVyZXMgd2hlbiB0aGUgdXNlcgo+PiBhdHRl
bXB0cyB1c2luZyBhIHByaW9yaXR5IGxldmVsIG91dCBvZiByYW5nZS4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4KPiAKPiBSZXZpZXdlZC1i
eTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPgoKVGhhbmtzIExpbnVz
ICEKCk1heSBJIGFsc28gYXNrIGZvciB5b3VyIHJldmlldyBvZiB0aGUga2VybmVsIGlvcHJpbyBB
UEkgcGF0Y2ggPwpJdCBpcyBoZXJlOgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxv
Y2svMjAyMzA1MzAwNjEzMDcuNTI1NjQ0LTEtZGxlbW9hbEBrZXJuZWwub3JnLwoKPiAKPiBZb3Vy
cywKPiBMaW51cyBXYWxsZWlqCgotLSAKRGFtaWVuIExlIE1vYWwKV2VzdGVybiBEaWdpdGFsIFJl
c2VhcmNoCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
