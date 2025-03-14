Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A75BC28B2F
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 05:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741931576; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LbgnK+L0hLTLPjfg4dDHzwVijGdrPdfJAMnq473Mj/E=;
 b=ZakS6wodwodjud6f+A7XMeNhwgr1zwPgR3lGqgsZdcugg+0FZpjq8codZcZXQE/e8nsed
 b9GNnM9ebSRVlCJ46WvIqiDLsV/c0E2//E0I2HpDnIwdn+IYEpzV9k6QT/DvbfHizQlHDGl
 cIdFBpsjSfK0mRSjChO/fDY/Glyml34=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E71983CA100
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 06:52:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7800C3CA100
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 06:52:35 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3;
 helo=nyc.source.kernel.org; envelope-from=mcgrof@kernel.org;
 receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CE711400253
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 06:52:33 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1EE8BA487EB;
 Fri, 14 Mar 2025 05:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F866C4CEE3;
 Fri, 14 Mar 2025 05:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741931551;
 bh=v3PIBycSNH+oPFCS7dfZCh9lkLp2iLF6iF3d3ur/2J8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fPeULFGNBwRXX95kbqMWHovyWjG2DL6QE1bVeGTzfLgE80T7gALR4aIhN1vQtJuj1
 l+hDST2bpZo0OJPAzLF4YBNGpeyDLX0K9N15zFZBohE6bseiPCKjfd5yd4SVpQ4Mh/
 jb4MNt8+4JIQ75C4CbB2SN/r/jBSCToDn+KN4vORxiQvmQfelwFrv/dcOkFCBKnGX2
 Nfq4/5br7gidBRRuThxANZQdMO7DG4zovdPyPBRR51EwZPi+eO0kq6aYYre+ns42qw
 xqRHEPAEyMkCs4KSkhDTidmw3Pr6j5QXXqT59lYm4MXrWHy4CqLmLMQoa4PBMqVsPh
 gmBj91O7nwyLA==
Date: Thu, 13 Mar 2025 22:52:30 -0700
To: Li Wang <liwang@redhat.com>
Message-ID: <Z9PEHuBTVFlWZ9dM@bombadil.infradead.org>
References: <20250313092445.164616-1-liwang@redhat.com>
 <Z9NjTtX3o15YDZ1w@bombadil.infradead.org>
 <CAEemH2cTkjGzYgvL3vw3+9MRPtxYfVTCmgexFWAVh5Q00J0oKg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cTkjGzYgvL3vw3+9MRPtxYfVTCmgexFWAVh5Q00J0oKg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_loop06: update loopback block size
 validation
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
Cc: Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMTQsIDIwMjUgYXQgMTA6MjQ6NTJBTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBIaSBMdWlzLAo+IAo+IE9uIEZyaSwgTWFyIDE0LCAyMDI1IGF0IDY6NTnigK9BTSBMdWlzIENo
YW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4gd3JvdGU6Cj4gCj4gPiBPbiBUaHUsIE1hciAx
MywgMjAyNSBhdCAwNToyNDo0NVBNICswODAwLCBMaSBXYW5nIHdyb3RlOgo+ID4gPiBUaGUga2Vy
bmVsIGNvbW1pdCA0N2RkNjc1MyAoImJsb2NrL2JkZXY6IGxpZnQgYmxvY2sgc2l6ZSByZXN0cmlj
dGlvbnMgdG8KPiA+IDY0ayIpCj4gPiA+IG5vdyBzdXBwb3J0cyBibG9jayBzaXplcyBsYXJnZXIg
dGhhbiBQQUdFX1NJWkUsIHdpdGggYSBuZXcgdXBwZXIgbGltaXQgb2YKPiA+ID4gQkxLX01BWF9C
TE9DS19TSVpFICg2NEspLiBCdXQgaW9jdGxfbG9vcDA2IHN0aWxsIGFzc3VtZXMgdGhhdCBQQUdF
X1NJWkUKPiA+IGlzIHRoZQo+ID4gPiBtYXhpbXVtIGFsbG93ZWQgYmxvY2sgc2l6ZSwgY2F1c2lu
ZyBmYWlsdXJlcyBvbiBuZXdlciBrZXJuZWxzKD49IDYuMTQpOgo+ID4KPiAKPiBXZWxsLCB0aGlz
IHNvdW5kcyBsaWtlIHdlIG5lZWQgdG8gZ28gYmFjayB0byBwYXRjaCB2MToKPiAgIGh0dHBzOi8v
bGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDI1LU1hcmNoLzA0MjU5OS5odG1sCj4gCj4g
Tm90ZTogTFRQIGhhcyBhIGZ1bmN0aW9uIHRzdF9rdmVyY21wKCkgZm9yIGNvbXBhcmluZyBrZXJu
ZWwgdmVyc2lvbnMuCgpDbG9zZS4KCkJMS19NQVhfQkxPQ0tfU0laRSBtYXkgY2hhbmdlIGluIHRo
ZSBmdXR1cmUgc28gdGhlIG9ubHkgcmVhbCB3YXkgdG8KdGVzdCBmb3IgYW4gaW52YWxpZCBibG9j
ayBzaXplIGlzIGhhdmluZyBhIGNoZWNrIGZvciBsaW51eC9ibGtkZXYuaC4KCkkgc2VlIGNvbW1p
dCA3Yzg0ZmE3MTBmNzUgKCJpb3ByaW86IHVzZSBpb3ByaW8uaCBrZXJuZWwgaGVhZGVyIGlmIGl0
CmV4aXN0cyIpIGlzIGFuIGV4YW1wbGUgb2YgdXNpbmcgYSBrZXJuZWwgaGVhZGVyIGZpbGUuIEkg
dGhpbmsgc2ltaWxhcgp0aGluZyBjYW4gYmUgZG9uZSB0byB1c2UgbGludXgvYmxrZGV2LmggYW5k
IGlmIHlvdSBkb24ndCBoYXZlCkhBVkVfTElOVVhfQkxLREVWX0ggdGhlbiB5b3UgY2FuIGRlZmlu
ZSBCTEtfTUFYX0JMT0NLX1NJWkUgdG8gNjRrIGZvcgpmb3Igb2xkZXIga2VybmVscy4KCkEgbW9y
ZSBhcHByb3ByaWF0ZSBpbnZhbGlkIHZhbHVlIHdvdWxkIGJlIEJMS19NQVhfQkxPQ0tfU0laRSAq
IDIgYXMKbm9uIHBvd2VyIG9mIDIgdmFsdWVzIHdpbGwgYmUgb3V0cmlnaHQgZGlzYWxsb3dlZC4K
CiAgTHVpcwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
