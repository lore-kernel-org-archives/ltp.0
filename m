Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBEDC47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 13:19:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DBF23CE423
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 14:19:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DE843CB828
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 14:19:29 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org;
 envelope-from=srs0=sanw=iv=linux-m68k.org=gerg@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7934C60156B
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 14:19:27 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4F34F61AB6;
 Thu, 11 Jan 2024 13:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C866C433F1;
 Thu, 11 Jan 2024 13:19:20 +0000 (UTC)
Message-ID: <d602919e-2cfb-455a-8a90-76f649d92b39@linux-m68k.org>
Date: Thu, 11 Jan 2024 23:19:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Landley <rob@landley.net>
References: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
 <CAMuHMdX5ACKVBQvEwMi7KHZkSVGZPJoocEC1wosfB7zc0u2mbA@mail.gmail.com>
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdX5ACKVBQvEwMi7KHZkSVGZPJoocEC1wosfB7zc0u2mbA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] Call for nommu LTP maintainer [was:
 Re: [PATCH 00/36] Remove UCLINUX from LTP]
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, Jonathan Corbet <corbet@lwn.net>,
 Linux-sh list <linux-sh@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "buildroot@buildroot.org" <buildroot@buildroot.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDExLzEvMjQgMjM6MTEsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToKPiBIaSBSb2IsCj4g
Cj4gT24gV2VkLCBKYW4gMTAsIDIwMjQgYXQgODoxN+KAr1BNIFJvYiBMYW5kbGV5IDxyb2JAbGFu
ZGxleS5uZXQ+IHdyb3RlOgo+PiBZb3UgY2FuJ3QgZm9yaygpIG9uIG5vbW11IGJlY2F1c2UgY29w
aWVzIG9mIHRoZSBtYXBwaW5ncyBoYXZlIGRpZmZlcmVudAo+PiBhZGRyZXNzZXMsIG1lYW5pbmcg
YW55IHBvaW50ZXJzIGluIHRoZSBjb3BpZWQgbWFwcGluZ3Mgd291bGQgcG9pbnQgaW50byB0aGUg
T0xECj4+IG1hcHBpbmdzIChiZWxvbmdpbmcgdG8gdGhlIHBhcmVudCBwcm9jZXNzKSwgYW5kIGZp
eGluZyB0aGVtIHVwIGlzIDEwMCUKPj4gZXF1aXZhbGVudCB0byB0aGUgImdhcmJhZ2UgY29sbGVj
dGlvbiBpbiBDIiBwcm9ibGVtLiAoSXQncyBBSS1jb21wbGV0ZS4gT2YgdGhlCj4+IEMzUE8ga2lu
ZCwgbm90IHRoZSAiYXV0b2NvcnJlY3Qgd2l0aCBzeW50YXggY2hlY2tpbmciIGtpbmQuKSBQZW9w
bGUgZ2V0IGh1bmcgdXAKPj4gb24gdGhlICJpdCB3b3VsZCBiZSB2ZXJ5IGluZWZmaWNpZW50IHRv
IGRvIHRoYXQgYmVjYXVzZSBubyBjb3B5LW9uLXdyaXRlIgo+PiBwcm9ibGVtIGFuZCBtaXNzIHRo
ZSAidGhlIGNoaWxkIGNvdWxkbid0IEZVTkNUSU9OIGJlY2F1c2UgaXRzIHBvaW50ZXIgdmFyaWFi
bGVzCj4+IGFsbCBjb250YWluIHBhcmVudCBhZGRyZXNzZXMiIHByb2JsZW0uCj4gCj4gQWN0dWFs
bHkgeW91IGNhbiBpbXBsZW1lbnQgZm9yaygpLCBpZiB5b3UgdGVhY2ggdGhlIGNvbXBpbGVyIHRv
IHVzZQo+IHNlcGFyYXRlIHN0YWNrcyBmb3IgcmV0dXJuIGFkZHJlc3NlcyBhbmQgZGF0YToKPiAg
ICAtIFRoZSBmaXJzdCBzdGFjayB3b3VsZCBjb250YWluIG9ubHkgYWJzb2x1dGUgYWRkcmVzc2Vz
LCB0byBiZQo+ICAgICAgcmVsb2NhdGVkIGFmdGVyIGNvcHlpbmcsCj4gICAgLSBUaGUgc2Vjb25k
IHN0YWNrIHdvdWxkIGNvbnRhaW4gaW50ZWdlcnMgYW5kIHJlbGF0aXZlIHBvaW50ZXJzCj4gICAg
ICAoc2VlIEZEUElDIGJlbG93KSwgd2hpY2ggZG8gbm90IG5lZWQgcmVsb2NhdGlvbiBhZnRlciBj
b3B5aW5nLgo+IAo+PiBUaGUgT1RIRVIgZnVuIHRoaW5nIGFib3V0IG5vbW11IGlzIHlvdSBjYW4n
dCBydW4gY29udmVudGlvbmFsIEVMRiBiaW5hcmllcywKPj4gYmVjYXVzZSBldmVyeXRoaW5nIGlz
IGxpbmtlZCBhdCBmaXhlZCBhZGRyZXNzLiBTbyB5b3UgbWlnaHQgYmUgYWJsZSB0byBydW4gT05F
Cj4+IGluc3RhbmNlIG9mIHRoZSBwcm9ncmFtIGFzIHlvdXIgaW5pdCB0YXNrLCBhc3N1bWluZyB0
aG9zZSBhZGRyZXNzZXMgd2VyZQo+PiBhdmFpbGFibGUgZXZlbiB0aGVuLCBidXQgYXMgc29vbiBh
cyB5b3UgdHJ5IHRvIHJ1biBhIHNlY29uZCBvbmUgaXQncyBhIGNvbmZsaWN0Lgo+Pgo+PiBUaGUg
cXVpY2sgYW5kIGRpcnR5IHdvcmsgYXJvdW5kIGlzIHRvIG1ha2UgUElFIGJpbmFyaWVzLCB3aGlj
aCBjYW4gcmVsb2NhdGUKPj4gZXZlcnl0aGluZyBpbnRvIGF2YWlsYWJsZSBzcGFjZSwgd2hpY2gg
d29ya3MgYnV0IGRvZXNuJ3Qgc2NhbGUuIFRoZSBwcm9ibGVtIHdpdGgKPj4gRUxGIFBJRSBpcyB0
aGF0IGV2ZXJ5dGhpbmcgaXMgbGlua2VkIGNvbnRpZ3VvdXNseSBmcm9tIGEgc2luZ2xlIGJhc2Ug
cG9pbnRlciwKPj4gbWVhbmluZyB5b3VyIHRleHQsIHJvZGF0YSwgZGF0YSwgYW5kIGJzcyBzZWdt
ZW50cyBhcmUgYWxsIG9uZSBsaW5lYXIgYmxvYi4gU28gaWYKPj4geW91IHJ1biB0d28gaW5zdGFu
Y2VzIG9mIGJhc2gsIHlvdSd2ZSBsb2FkZWQgdHdvIGNvcGllcyBvZiB0aGUgdGVzdCBhbmQgdGhl
Cj4+IHJvZG9hdGEuIFRoaXMgZmlsbHMgdXAgeW91ciBtZW1vcnkgZmFzdC4KPj4KPj4gQU5EIFBJ
RSByZXF1aXJlcyBjb250aWd1b3VzIG1lbW9yeSwgd2hpY2ggbm9tbXUgaXMgYmFkIGF0IHByb3Zp
ZGluZyBiZWNhdXNlIGl0Cj4+IGhhcyBubyBwYWdlIHRhYmxlcyB0byByZW1hcCBzdHVmZi4gV2l0
aCBhbiBtbXUgaXQgY2FuIGNvYWxlc2NlIHNjYXR0ZXJlZAo+PiBwaHlzaWNhbCBwYWdlcyBpbnRv
IGEgdmlydHVhbGx5IGNvbnRpZ3VvdXMgcmFuZ2UsIGJ1dCB3aXRob3V0IGFuIG1tdSB5b3UgY2Fu
Cj4+IGhhdmUgcGxlbnR5IG9mIG1lbW9yeSBmcmVlIGJ1dCBpbiB0aW55IGNodW5rcywgbm9uZSBi
aWcgZW5vdWdoIHRvIHNhdGlzZnkgYW4KPj4gYWxsb2NhdGlvbiByZXF1ZXN0Lgo+Pgo+PiBTbyB0
aGV5IGludmVudGVkIEZEUElDLCB3aGljaCBpcyBFTEYgd2l0aCBGT1VSIGJhc2UgcG9pbnRlcnMu
IEVhY2ggbWFqb3Igc2VjdGlvbgo+PiAocm9kYXRhLCB0ZXh0LCBkYXRhLCBhbmQgYnNzKSBoYXMg
aXRzIG93biBiYXNlIHBvaW50ZXIsIHNvIHlvdSBuZWVkIHRvIGZpbmQKPj4gc21hbGxlciBjaHVu
a3Mgb2YgbWVtb3J5IHRvIGxvYWQgdGhlbSBpbnRvIChhbmQgdGh1cyBpdCBjYW4gd29yayBvbiBh
IG1vcmUKPj4gZnJhZ21lbnRlZCBzeXN0ZW0pLCBBTkQgaXQgbWVhbnMgdGhhdCB0d28gaW5zdGFu
Y2VzIG9mIHRoZSBzYW1lIHByb2dyYW0gY2FuCj4+IHNoYXJlIHRoZSByZWFkLW9ubHkgc2VjdGlv
bnMgKHJvZGF0YSBhbmQgdGV4dCkgc28geW91IG9ubHkgbmVlZCBuZXcgY29waWVzIG9mCj4+IHRo
ZSB3cml0ZWFibGUgc2VnbWVudHMgKGRhdGEgYW5kIGJzcy4gQW5kIHRoZSBoZWFwLiBBbmQgdGhl
IHN0YWNrLikKPiAKPiBPciBBbWlnYSBMb2FkU2VnKCkgcmVsb2NhdGFibGUgYmluYXJpZXMgYW5k
IHNoYXJlZCBsaWJyYXJpZXMgOy0pCj4gQXMgdGhpcyBzdXBwb3J0ZWQgc3BsaXR0aW5nIGNvZGUs
IGRhdGEsIGFuZCBic3MgaW4gbG90cyBvZiBzbWFsbGVyCj4gaHVua3MsIGl0IGNvdWxkIGNvdW50
ZXIgZnJhZ21lbnRlZCBtZW1vcnkgcXVpdGUgd2VsbC4KPiAKPiBCVFcsIGNhbid0IHlvdSBydW4g
YW5kIHRodXMgdGVzdCBub21tdS1iaW5hcmllcyB1bmRlciBub3JtYWwgTGludXgsIHRvbz8KClll
cywgeW91IGNhbi4gVGhlIGZsYXQgZm9ybWF0IGxvYWRlciBjYW4gYmUgYnVpbHQgZm9yIE1NVSBh
cm0gYW5kIG02OGsgTGludXguCkl0IHdpbGwgaGFwcGlseSBsb2FkIGFuZCBydW4gZmxhdCBmb3Jt
YXQgYmluYXJpZXMgb24gbm9ybWFsIFZNIExpbnV4LgpJIHRlc3QgdGhhdCBvZnRlbiBvbiBtNjhr
IChvbiBDb2xkRmlyZSBwbGF0Zm9ybXMpLgoKUmVnYXJkcwpHcmVnCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
