Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985F1C28B30
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 05:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741931867; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RuMan52on3Lk+MyGRTE5IfKeXy0fn4LBGUTtycR5wVQ=;
 b=jAMa2O/h9ok3tssu/qdhgRFeSaO6KKEvv9GzX4hh4w7sBpCz0e6n7gthbPOqhP+guVtay
 Qjo2eMSOXnWAV8NgmrSX9BlXV2iDWNXLzls5IDNeDpcIYYdlJfuNfDXLy2mTXloxqcbdQVU
 y+Tyc9BH4FbmXwisBYXipfGupztugzQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7E403CA5B7
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 06:57:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E62EC3CA100
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 06:57:25 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=mcgrof@kernel.org; receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6BA52140021B
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 06:57:25 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4B1DB5C06D3;
 Fri, 14 Mar 2025 05:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DABC4CEE5;
 Fri, 14 Mar 2025 05:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741931842;
 bh=nk2FBUt1ltOIVhh1KhPrpUz71HAGSVq/KWAqErt0tDg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cNGG9eo9ApMv3FboCLjuCLOXBhjzEnsAUtyZB/1IXS2vMBHuVd1eN9EQt+IvEk0Zf
 fBWO6oiLYX3TKrAbwKigAQgCQxQ8Enha5Zrv2kwUQMYnPm3bHFPKlqZ+4/D/vNLKVU
 KcOxa40qSz8O6rtBbZHf9nzEq2PPZoIiF2t2XWXvz4AzkH0EIESLSg2Y0NXIhBCXHQ
 HI0oYOXSEBqUp63ETNvzMaslMR3D3Kc38JXFqgc7KwI603svbL8RP5yOM3ZnAGF2fy
 XC2YnfoQc70f+WBy7WQQQ9I2bxFl18Rb3lIaG4TAnQmMQk3ZEBIrLRoe2nEZP3ICB7
 HJp3R+DEBFc1w==
Date: Thu, 13 Mar 2025 22:57:21 -0700
To: Li Wang <liwang@redhat.com>
Message-ID: <Z9PFQR51mFwIEj0m@bombadil.infradead.org>
References: <20250313092445.164616-1-liwang@redhat.com>
 <Z9NjTtX3o15YDZ1w@bombadil.infradead.org>
 <CAEemH2cTkjGzYgvL3vw3+9MRPtxYfVTCmgexFWAVh5Q00J0oKg@mail.gmail.com>
 <Z9PEHuBTVFlWZ9dM@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9PEHuBTVFlWZ9dM@bombadil.infradead.org>
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

T24gVGh1LCBNYXIgMTMsIDIwMjUgYXQgMTA6NTI6MzFQTSAtMDcwMCwgTHVpcyBDaGFtYmVybGFp
biB3cm90ZToKPiBPbiBGcmksIE1hciAxNCwgMjAyNSBhdCAxMDoyNDo1MkFNICswODAwLCBMaSBX
YW5nIHdyb3RlOgo+ID4gSGkgTHVpcywKPiA+IAo+ID4gT24gRnJpLCBNYXIgMTQsIDIwMjUgYXQg
Njo1OeKAr0FNIEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJuZWwub3JnPiB3cm90ZToKPiA+
IAo+ID4gPiBPbiBUaHUsIE1hciAxMywgMjAyNSBhdCAwNToyNDo0NVBNICswODAwLCBMaSBXYW5n
IHdyb3RlOgo+ID4gPiA+IFRoZSBrZXJuZWwgY29tbWl0IDQ3ZGQ2NzUzICgiYmxvY2svYmRldjog
bGlmdCBibG9jayBzaXplIHJlc3RyaWN0aW9ucyB0bwo+ID4gPiA2NGsiKQo+ID4gPiA+IG5vdyBz
dXBwb3J0cyBibG9jayBzaXplcyBsYXJnZXIgdGhhbiBQQUdFX1NJWkUsIHdpdGggYSBuZXcgdXBw
ZXIgbGltaXQgb2YKPiA+ID4gPiBCTEtfTUFYX0JMT0NLX1NJWkUgKDY0SykuIEJ1dCBpb2N0bF9s
b29wMDYgc3RpbGwgYXNzdW1lcyB0aGF0IFBBR0VfU0laRQo+ID4gPiBpcyB0aGUKPiA+ID4gPiBt
YXhpbXVtIGFsbG93ZWQgYmxvY2sgc2l6ZSwgY2F1c2luZyBmYWlsdXJlcyBvbiBuZXdlciBrZXJu
ZWxzKD49IDYuMTQpOgo+ID4gPgo+ID4gCj4gPiBXZWxsLCB0aGlzIHNvdW5kcyBsaWtlIHdlIG5l
ZWQgdG8gZ28gYmFjayB0byBwYXRjaCB2MToKPiA+ICAgaHR0cHM6Ly9saXN0cy5saW51eC5pdC9w
aXBlcm1haWwvbHRwLzIwMjUtTWFyY2gvMDQyNTk5Lmh0bWwKPiA+IAo+ID4gTm90ZTogTFRQIGhh
cyBhIGZ1bmN0aW9uIHRzdF9rdmVyY21wKCkgZm9yIGNvbXBhcmluZyBrZXJuZWwgdmVyc2lvbnMu
Cj4gCj4gQ2xvc2UuCj4gCj4gQkxLX01BWF9CTE9DS19TSVpFIG1heSBjaGFuZ2UgaW4gdGhlIGZ1
dHVyZSBzbyB0aGUgb25seSByZWFsIHdheSB0bwo+IHRlc3QgZm9yIGFuIGludmFsaWQgYmxvY2sg
c2l6ZSBpcyBoYXZpbmcgYSBjaGVjayBmb3IgbGludXgvYmxrZGV2LmguCj4gCj4gSSBzZWUgY29t
bWl0IDdjODRmYTcxMGY3NSAoImlvcHJpbzogdXNlIGlvcHJpby5oIGtlcm5lbCBoZWFkZXIgaWYg
aXQKPiBleGlzdHMiKSBpcyBhbiBleGFtcGxlIG9mIHVzaW5nIGEga2VybmVsIGhlYWRlciBmaWxl
LiBJIHRoaW5rIHNpbWlsYXIKPiB0aGluZyBjYW4gYmUgZG9uZSB0byB1c2UgbGludXgvYmxrZGV2
LmggYW5kIGlmIHlvdSBkb24ndCBoYXZlCj4gSEFWRV9MSU5VWF9CTEtERVZfSCB0aGVuIHlvdSBj
YW4gZGVmaW5lIEJMS19NQVhfQkxPQ0tfU0laRSB0byA2NGsgZm9yCj4gZm9yIG9sZGVyIGtlcm5l
bHMuCj4gCj4gQSBtb3JlIGFwcHJvcHJpYXRlIGludmFsaWQgdmFsdWUgd291bGQgYmUgQkxLX01B
WF9CTE9DS19TSVpFICogMiBhcwo+IG5vbiBwb3dlciBvZiAyIHZhbHVlcyB3aWxsIGJlIG91dHJp
Z2h0IGRpc2FsbG93ZWQuCgpXaGlsZSBhdCBpdCwgYmUgc3VyZSB0byBzY2FsZSB0c3RfZmlsbF9m
aWxlKCJ0ZXN0LmltZyIsIDAsIDEwMjQsIDEwMjQpCihJIHRoaW5rIHRoYXQgaXMgYnM9MTAyNCwg
Y291bnQ9MTAyNCwgc28gMSBNaUIgZmlsZSBzaXplKSBzbyB0aGF0IHlvdQp0YWtlIGludG8gY29u
c2lkZXJhdGlvbiB0aGUgQkxLX01BWF9CTE9DS19TSVpFIHNvIHRoYXQgdGhlIGZpbGUgc2l6ZQp3
aWxsIGJlIGF0IGxlYXN0IG1heWJlIDEwICogQkxLX01BWF9CTE9DS19TSVpFIG9yIHNvbWV0aGlu
ZyBzZW5zaWJsZS4KCkJlY2F1c2UgYXMgc29vbiBhcyB3ZSBjYW4gc3VwcG9ydCBhIEJMS19NQVhf
QkxPQ0tfU0laRSBvZiAyIE1pQiB0aGlzCnRlc3Qgd2lsbCBhbHNvIGZhaWwgYWdhaW4uCgogIEx1
aXMKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
