Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D68AC28B28
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 05:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741755693; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=u7t312q+tHnjWoaJwkpu4uXQwR4KY9zfRFwAH/X/xSk=;
 b=MFiwB5DgF31ht4paF5raAcmMzWHgyhNX5/wvh22U8VtHvc9yd0W6wGBL9MYcJQW0xwh7Y
 PnXZWkdMdnpbIGfN0u2nA+2C0+1v/KdEYnbuAoXjYqWnb+jA70TsUrT+GSzaFGy5OCPvMNL
 FZYq755IE9vjJCYfnLuQ0OyYlXJ9ANQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A6573C0265
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 06:01:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E89D73C0265
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 06:00:48 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=mcgrof@kernel.org; receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2FA136005C3
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 06:00:47 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D1D235C26EA;
 Wed, 12 Mar 2025 04:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A11BC4CEE3;
 Wed, 12 Mar 2025 05:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741755645;
 bh=gJD35K03DizHx1Ki+npAg0sP1R5X6WsLx/uI7xSKEnc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PB1NraYK0kpGAyMdYcobXBiuXRsgcj3RuWTJDf3JKvNTE+rVQ0N+dNFPCPzCRFQ8M
 M1e0DzBH6Pv38S1eBvkZWlZLaUfi+69OrvleQ7R9MXJGKx8AEB6jEdwBq/EEo2e+a8
 FJKPY9DQkR9cCEvv0vLCtsiUJBJDs+vRNfXL3aZClsUCTgkGzbJQELiwZ23j2J+I84
 9I5WZBtl18MslPwWUCJLuiRXrGhRg8M3jdccmlz1IyzonoaL0bsETyQCp9HQB14Qzq
 FKSrmq2evdYcBfcRVtoKIL5nr3psWFjCL7u0nRbP/xetUk0pZMRApu6kyDuC2Qljt3
 BXJ8/sS1VHVgQ==
Date: Tue, 11 Mar 2025 22:00:43 -0700
To: Li Wang <liwang@redhat.com>
Message-ID: <Z9EU-70DuwqFqD4p@bombadil.infradead.org>
References: <202503101538.84c33cd4-lkp@intel.com>
 <CAEemH2egF6ehr7B_5KDLuBQqoUJ5k7bVZkid-ERDBkxkChi7fw@mail.gmail.com>
 <CAB=NE6UWzyq+qXhGmpH2-6bePE+Zi=dJjBH7y3HeJnYyh6xvtw@mail.gmail.com>
 <CAEemH2c21vrSOKdJvHkyH+UOv-aXefXeFVZuv4-DSZ_P4Z3Mxw@mail.gmail.com>
 <Z8-tV0zJKP7wRAxK@bombadil.infradead.org>
 <CAEemH2d36bY-q-+P_vHKvj+kg6qi2k=y37PRNOr6mkY=pdFQrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d36bY-q-+P_vHKvj+kg6qi2k=y37PRNOr6mkY=pdFQrQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

T24gVHVlLCBNYXIgMTEsIDIwMjUgYXQgMDk6MDk6MDhQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBUdWUsIE1hciAxMSwgMjAyNSBhdCAxMTozM+KAr0FNIEx1aXMgQ2hhbWJlcmxhaW4gPG1j
Z3JvZkBrZXJuZWwub3JnPiB3cm90ZToKPiAKPiA+IE9uIFR1ZSwgTWFyIDExLCAyMDI1IGF0IDA5
OjQzOjQyQU0gKzA4MDAsIExpIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIE1vbiwgTWFyIDEwLCAyMDI1
IGF0IDExOjE14oCvUE0gTHVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtlcm5lbC5vcmc+Cj4gPiB3
cm90ZToKPiA+ID4KPiA+ID4gPiBUaGVyZSdzIGEgZml4IGZvciB0aGlzIGFscmVhZHkgaW4gbmV4
dAo+ID4gPiA+Cj4gPiA+Cj4gPiA+IE9oPyBXaGljaCBjb21taXQ/Cj4gPgo+ID4gT2ggc2VlbXMg
bGludXgtbmV4dCBoYXNuJ3QgYmVlbiB1cGRhdGVkIGluIGEgZmV3IGRheXMsIHNvIHlvdSBjYW4g
dHJ5Cj4gPiB0aGlzIHBhdGNoOgo+ID4KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI1MDMwNzAyMDQwMy4zMDY4NTY3LTEtbWNncm9mQGtlcm5lbC5vcmcvCj4gCj4gCj4gLS0tIGEv
YmxvY2svYmRldi5jCj4gKysrIGIvYmxvY2svYmRldi5jCj4gQEAgLTE4MSw2ICsxODEsOCBAQCBF
WFBPUlRfU1lNQk9MKHNldF9ibG9ja3NpemUpOwo+IAo+ICBpbnQgc2Jfc2V0X2Jsb2Nrc2l6ZShz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBpbnQgc2l6ZSkKPiAgewo+ICsgICAgICAgaWYgKCEoc2It
PnNfdHlwZS0+ZnNfZmxhZ3MgJiBGU19MQlMpICYmIHNpemUgPiBQQUdFX1NJWkUpCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiAwOwo+ICAgICAgICAgaWYgKHNldF9ibG9ja3NpemUoc2ItPnNfYmRl
dl9maWxlLCBzaXplKSkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gLi4uCj4gCj4gCj4g
VGhhbmtzLCBidXQgbG9va2luZyBhdCB0aGUgY29kZSBjaGFuZ2UsIHNlZW1zIGZpbGVzeXN0ZW1z
IHdpdGggRlNfTEJTCj4gKGUuZy4sIGJjYWNoZWZzLCBYRlMpIGNhbiBzdGlsbCBtb3VudCBsYXJn
ZXIgYmxvY2sgc2l6ZXMgcHJvcGVybHkuIElPVywKPiB0aGUgdGVzdCBpb2N0bF9sb29wMDYgc3Rp
bGwgZmFpbGVkIG9uIFJIRUw5IChYRlMpIHBsYXRmb3JtLgoKVGhlIHRlc3QgZG9lcyBub3QgZmFp
bCBiZWNhdXNlIHRoZSBmaWxlc3lzdGVtIGJlaW5nIHVzZWQsIHRoZSB0ZXN0IGZhaWxzCmJlY2F1
c2UgaXQgZXhwZWN0cyBzZXR0aW5nIHRoZSBibG9jayBzaXplID4gUEFHRV9TSVpFIHdpbGwgZmFp
bCBmb3IgdGhlCmxvb3AgYmFjayBkZXZpY2UgaXQgaXMgY3JlYXRpbmcgYW5kIHRoZW4gc2V0dGlu
ZyB0aGUgYmxvY2sgc2l6ZSBmb3IgaXQuCgpUaGVyZSBhcmUgdHdvIHRlc3RzIHdoaWNoIGZhaWw6
CgogICogc2V0IGJsb2NrIHNpemUgPiBQQUdFX1NJWkUgd2l0aCBMT09QX1NFVF9CTE9DS19TSVpF
CiAgKiBzZXQgYmxvY2sgc2l6ZSA+IFBBR0VfU0laRSB3aXRoIExPT1BfQ09ORklHVVJFCgpJdCBl
eHBlY3RzIHRvIGZhaWwuIFRoZSBuZXcgd29yayBlbmFibGVzIHRoZSBibG9jayBsYXllciB0byBz
dXBwb3J0CmJsb2NrIHNpemVzID4gUEFHRV9TSVpFIG9uIGJsb2NrIGRldmljZXMsIGVzc2VudGlh
bGx5IHRoYXQgdGhlIGxvZ2ljYWwKb3IgcGh5c2ljYWwgYmxvY2sgc2l6ZSBjYW4gYmUgPiBQQUdF
X1NJWkUuIFRoYXQgaXMgc3VwcG9ydGVkIG5vdy4KCj4gSXMgdGhhdCBleHBlY3RlZD8gT3IsIHNo
b3VsZCB3ZSBhZGp1c3QgdGhlIHRlc3RjYXNlIGZvciBGUyB3aXRoIEZTX0xCUwo+IGFzIGV4Y2Vw
dGlvbj8KCkNvbnRyYXJ5IHRvIGZpbGVzeXN0ZW1zLCBibG9jayBkcml2ZXJzIHVzZSBub3cgaW1w
bGljaXRseSB1c2UKYmxrX3ZhbGlkYXRlX2xpbWl0cygpIHRocm91Z2ggcXVldWVfbGltaXRzX2Nv
bW1pdF91cGRhdGUgdG8gdmFsaWRhdGUKcXVldWUgbGltaXRzLCBidXQgUEFHRV9TSVpFIGlzIG5v
IGxvbmdlciBhbiBpc3N1ZS4gSW4gdGhlIGxvb3AgYmFjayBkcml2ZXIKY2FzZSB3ZSBoYXZlIHRo
ZW46Cgppb2N0bCBMT09QX0NPTkZJR1VSRSAtLT4gbG9vcF9jb25maWd1cmUoKSAKCWxpbSA9IHF1
ZXVlX2xpbWl0c19zdGFydF91cGRhdGUobG8tPmxvX3F1ZXVlKTsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAKCWxvb3BfdXBkYXRlX2xpbWl0cyhsbywgJmxpbSwgY29uZmlnLT5ibG9ja19zaXpl
KTsgCgppb2N0bCBMT09QX1NFVF9CTE9DS19TSVpFIC0tPiBsb29wX3NldF9ibG9ja19zaXplKCkK
CWxpbSA9IHF1ZXVlX2xpbWl0c19zdGFydF91cGRhdGUobG8tPmxvX3F1ZXVlKTsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAKCWxvb3BfdXBkYXRlX2xpbWl0cyhsbywgJmxpbSwgYXJnKTsgCgpJ
IGRvbid0IHNlZSBhbnl0aGluZyB3cm9uZyB3aXRoIHRoZSBsb29wIGRyaXZlciBzdXBwb3J0aW5n
IGxvZ2ljYWwgYmxvY2sKc2l6ZXMgPiBQQUdFX1NJWkUsIGZyb20gYSBxdWljayBsb29rLCBidXQg
aXQgZG9lcyBub3QgbWF0dGVyLiBJZiB0ZXN0cwpleGlzdHMgd2hpY2ggYXJlIHZlcmlmeWluZyB5
b3UgKmNhbid0KiBkbyBpdCwgdGhlbiB3ZSdyZSBib3VuZCB0byBnZXQKb3RoZXIgc2ltaWxhciBy
ZXBvcnRzLiBxdWV1ZV9saW1pdHNfY29tbWl0X3VwZGF0ZSgpIGNhbGxzCmJsa192YWxpZGF0ZV9i
bG9ja19zaXplLiBJIGp1c3Qgc2VudCBhIGZpeC4KClRoYW5rcyBmb3IgdGhlIHJlcG9ydC4KCiAg
THVpcwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
