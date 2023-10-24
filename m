Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0F3C00A8F
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 09:07:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E0323CECB3
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 11:07:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56ABE3CCC3D
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:07:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 4B9911001153
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:07:45 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B92002F4;
 Tue, 24 Oct 2023 02:08:24 -0700 (PDT)
Received: from [10.57.5.81] (unknown [10.57.5.81])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59C543F64C;
 Tue, 24 Oct 2023 02:07:43 -0700 (PDT)
Message-ID: <e6cc15ff-cb44-4805-cba5-9f5340410746@arm.com>
Date: Tue, 24 Oct 2023 11:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: Cyril Hrubis <chrubis@suse.cz>
References: <20231023135647.2157030-1-kevin.brodsky@arm.com>
 <20231023135647.2157030-4-kevin.brodsky@arm.com> <ZTaF2kM1R1i3_JpR@yuki>
 <87291cdf-0245-c825-d3a3-235e4a4d1f9d@arm.com> <ZTaL6rLETxHwvFDr@yuki>
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ZTaL6rLETxHwvFDr@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Provide a PATH_MAX-long buffer when expecting
 ENAMETOOLONG
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjMvMTAvMjAyMyAxNzowNiwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+IEhpIQo+Pj4+IEEgbnVt
YmVyIG9mIHRlc3RzIGNoZWNrIHRoYXQgc3lzY2FsbHMgbWFuaXB1bGF0aW5nIHBhdGhzIHJldHVy
bgo+Pj4+IC1FTkFNRVRPT0xPTkcgd2hlbiB0aGUgc3BlY2lmaWVkIHBhdGggaXMgbG9uZ2VyIHRo
YW4gYWxsb3dlZC4gVGhlcmUKPj4+PiBhcmUgYWN0dWFsbHkgdHdvIHdheXMgdGhpcyBlcnJvciBj
YW4gYmUgdHJpZ2dlcmVkOgo+Pj4+Cj4+Pj4gMS4gSWYgdGhlIGdpdmVuIHN0cmluZyBpcyBsb25n
ZXIgdGhhbiBQQVRIX01BWCwgaS5lLiA0MDk2IGFzIGZhciBhcwo+Pj4+ICAgIHRoZSBrZXJuZWwg
aXMgY29uY2VybmVkLCB0aGVuIHRoZSBnZXRuYW1lKCkgaGVscGVyIHdpbGwgZmFpbCBhbmQKPj4+
PiAgICB0aGUga2VybmVsIHdpbGwgcmV0dXJuIC1FTkFNRVRPT0xPTkcgcmlnaHQgYXdheS4KPj4+
Pgo+Pj4+IDIuIElmIHRoZSBzdHJpbmcgZml0cyBpbiBQQVRIX01BWCwgYnV0IHRoZSBmaWxlc3lz
dGVtIHJlamVjdHMgdGhlCj4+Pj4gICAgcGF0aCBuYW1lLCBmb3IgaW5zdGFuY2UgYmVjYXVzZSBv
bmUgb2YgaXRzIGNvbXBvbmVudHMgaXMgbG9uZ2VyCj4+Pj4gICAgdGhhbiB0aGUgc3VwcG9ydCBm
aWxlIG5hbWUgbGVuZ3RoIChlLmcuIDI1NSBmb3IgZXh0NCkuCj4+PiBJZGVhbGx5IHdlIHNob3Vs
ZCBoYXZlIGF0IGxlYXN0IG9uZSB0ZXN0IHRoYXQgd291bGQgaGl0IHRoZSAxLiBhcyB3ZWxsLi4u
Cj4+IFRoaXMgaXMgd2hhdCBwYXRjaCAzIGlzIG1lYW50IHRvIGFjaGlldmU6IGluc3RlYWQgb2Yg
aGl0dGluZyAyLiB3ZSBub3cKPj4gc3lzdGVtYXRpY2FsbHkgaGl0IDEuCj4gU2lnaCwgSSBtZWFu
dCAyLiBJIGd1ZXNzIHRoYXQgd2Ugd291bGQgaGF2ZSB0byBsb29wIG92ZXIgZmlsZXN5c3RlbXMK
PiAoZWFzaWx5IGRvbmUgd2l0aCAuYWxsX2ZpbGVzeXN0ZW1zID0gMSkgYW5kIHBhc3MgdmVyeSBs
b25nIGZpbGVuYW1lLiBPcgo+IGRvIHdlIGhhdmUgc3VjaCB0ZXN0IGFscmVhZHk/Cj4KPiBMb29r
aW5nIGF0IG91ciB0ZXN0cywgdGhlIHJlbmFtZTEwLmMgaXMgYWN0dWFsbHkgb25lIG9mIHR3byB0
ZXN0cyB0aGF0Cj4gc2V0cyAuYWxsX2ZpbGV5c3RlbXMgYW5kIGNoZWNrcyBmb3IgRU5BTUVUT09M
T05HLiBMb29raW5nIGF0IHRoZQo+IGZpbGVzeXN0ZW0gbGltaXRzLCBhbGwgc2VlbXMgdG8gaGF2
ZSBsaW1pdHMgdGhhdCBhcmUgPD0gMjU1IGNoYXJhY3RlcnMsCj4gdGhlIG9ubHkgcHJvYmxlbSBp
cyBhIGRlZmluaXRpb24gb2YgY2hhcmFjdGVyLiBGb3IgdXRmOCBjaGFyYWN0ZXIgMjU1Cj4gY2hh
cmFjdGVycyBhcmUgYXJvdW5kIDEwMjEgKGluY2x1ZGluZyBudWwgdGVybWluYXRvcikuIFNvIEkg
c3VwcG9zZSB0aGF0Cj4gaWYgd2UgcGFzcyBhbm90aGVyIGJ1ZmZlciB0aGF0IGlzIFBBVEhfTUFY
IGluIGxlbmd0aCBhbmQgaGFzIFBBVEhfTUFYLTEKPiBjaGFyYWN0ZXJzIHdlIHNob3VsZCBjb25z
aXN0ZW5seSBoaXQgMi4gT3IgZG8gSSBtaXNzIHNvbWV0aGluZz8KClRoaXMgaXMgYSBnb29kIHBv
aW50LCBJIGRpZG4ndCB0aGluayBhYm91dCBpdCB0aGlzIHdheS4gWW91ciBpZGVhIHNlZW1zCnNl
bnNpYmxlLiBXaXRoIHRoaXMgcGF0Y2ggd2UgYWx3YXlzIGhpdCAxLiBhcyB3ZSBzcGVjaWZ5IGEg
c3RyaW5nIHRoYXQKaXMgbG9uZ2VyIHRoYW4gUEFUSF9NQVguIFdlIGNvdWxkIGluc3RlYWQgaGl0
IDIuIHdpdGhvdXQgb3V0LW9mLWJvdW5kCmFjY2VzcyBieSBzcGVjaWZ5aW5nIGEgc3RyaW5nIHRo
YXQgaXMgYXQgbW9zdCBQQVRIX01BWCBpbiBsZW5ndGgKKGluY2x1ZGluZyB0aGUgbnVsbCB0ZXJt
aW5hdG9yKSwgYW5kIGF0IGxlYXN0IHRoZSBmaWxlc3lzdGVtIGNoYXJhY3RlcgpsaW1pdC4gTWF5
YmUgc29tZXRoaW5nIGxpa2UgdGhlIGRpZmYgYmVsb3cgKGp1c3QgdGVzdGVkIGl0LCB0aGF0IHdv
cmtzCmZpbmUpLgoKS2V2aW4KCi0tLS0tODwtLS0tLQoKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9yZW5hbWUvcmVuYW1lMTAuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3JlbmFtZS9yZW5hbWUxMC5jCkBAIC0xOCw3ICsxOCw3IEBACsKgI2RlZmluZSBNTlRfUE9JTlQg
Im1udHBvaW50IgrCoCNkZWZpbmUgVEVNUF9GSUxFICJ0bXBmaWxlIgrCoAotc3RhdGljIGNoYXIg
bG9uZ19wYXRoW1BBVEhfTUFYICsgMV0gPSB7WzAgLi4uIFBBVEhfTUFYXSA9ICdhJ307CitzdGF0
aWMgY2hhciBsb25nX3BhdGhbUEFUSF9NQVhdID0ge1swIC4uLiBQQVRIX01BWCAtIDJdID0gJ2En
LApbUEFUSF9NQVggLSAxXSA9ICdcMCd9OwrCoArCoHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCsKg
ewoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
