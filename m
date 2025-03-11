Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740CBC282DE
	for <ltp@archiver.kernel.org>; Tue, 11 Mar 2025 03:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741663602; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8gQ1nOg6xmXMbFpmuxltW9AzoTbgVUWTQzOZhMuDNAw=;
 b=D9EredpQUx96DLhaM/6k6lDt4ASBVAjO2j9zDFGm7053OQxRXE2RwPB8gCTI06puuqjal
 wBJ3kVo/skPNIXMPNZT4vzfX24oDTTw7sFIpWDzSqyQ/5ICUdb0AB4Gia5RLSpqzvfJckmc
 urpERDUb5OBHZvsAOX2rrwiWO+QoN2I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 746F63CA30B
	for <ltp@archiver.kernel.org>; Tue, 11 Mar 2025 04:26:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 817AB3C4EA6
 for <ltp@lists.linux.it>; Tue, 11 Mar 2025 04:26:20 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org;
 envelope-from=mcgrof@kernel.org; receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D4E741000348
 for <ltp@lists.linux.it>; Tue, 11 Mar 2025 04:26:19 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B4428A41951;
 Tue, 11 Mar 2025 03:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41605C4CEE9;
 Tue, 11 Mar 2025 03:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741663577;
 bh=rIMjY2dFt+Lt1PyoYuCijFezfQk+o99NGZVJjN+fDUQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pOHVEl2vHwqln/qBGYJOl9jBduAi4KkQUiisN3H6pmLiP/HxPBqF5+0ZPWtY9w6la
 mNrfVDfN+G9JANWRA4prIlgJ450bYErvsPrscMYR5ifP9yqx/L6fhEIjYmtwqpaAvW
 8W1vcmfiW3V9/eN01vw/FCwQUGijwU636aPNqLM9SsrqEcBCXmIwS9V3mAgHOGgV1N
 nngiJ6c3GaAQPvy3E00+Ck0VJLANGxZZbPq5BYigAHTRGZHw1Tncnw+156tUMo0mRs
 aBJ869fkzLkGvuQZlhXMdVoKXFl8SOHwvRLhdd9rg7pyaj0MULorc+x44J3fDsBOFY
 IWLKsapaExR2Q==
Date: Mon, 10 Mar 2025 20:26:15 -0700
To: Li Wang <liwang@redhat.com>
Message-ID: <Z8-tV0zJKP7wRAxK@bombadil.infradead.org>
References: <202503101538.84c33cd4-lkp@intel.com>
 <CAEemH2egF6ehr7B_5KDLuBQqoUJ5k7bVZkid-ERDBkxkChi7fw@mail.gmail.com>
 <CAB=NE6UWzyq+qXhGmpH2-6bePE+Zi=dJjBH7y3HeJnYyh6xvtw@mail.gmail.com>
 <CAEemH2c21vrSOKdJvHkyH+UOv-aXefXeFVZuv4-DSZ_P4Z3Mxw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c21vrSOKdJvHkyH+UOv-aXefXeFVZuv4-DSZ_P4Z3Mxw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [block/bdev] 47dd675323:
 ltp.ioctl_loop06.fail
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 0day robot <lkp@intel.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, linux-block@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>, Hannes Reinecke <hare@suse.de>,
 oe-lkp@lists.linux.dev, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXIgMTEsIDIwMjUgYXQgMDk6NDM6NDJBTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBNb24sIE1hciAxMCwgMjAyNSBhdCAxMToxNeKAr1BNIEx1aXMgQ2hhbWJlcmxhaW4gPG1j
Z3JvZkBrZXJuZWwub3JnPiB3cm90ZToKPiAKPiA+IFRoZXJlJ3MgYSBmaXggZm9yIHRoaXMgYWxy
ZWFkeSBpbiBuZXh0Cj4gPgo+IAo+IE9oPyBXaGljaCBjb21taXQ/CgpPaCBzZWVtcyBsaW51eC1u
ZXh0IGhhc24ndCBiZWVuIHVwZGF0ZWQgaW4gYSBmZXcgZGF5cywgc28geW91IGNhbiB0cnkKdGhp
cyBwYXRjaDoKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDMwNzAyMDQwMy4zMDY4
NTY3LTEtbWNncm9mQGtlcm5lbC5vcmcvCgogIEx1aXMKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
