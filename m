Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1151C87FCE
	for <ltp@archiver.kernel.org>; Sun, 27 Jul 2025 04:51:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23B433C6644
	for <ltp@archiver.kernel.org>; Sun, 27 Jul 2025 06:51:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 830F93C1851
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 06:51:10 +0200 (CEST)
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 74DF71A00492
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 06:51:09 +0200 (CEST)
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196]
 helo=home.neil.brown.name) by neil.brown.name with esmtp (Exim 4.95)
 (envelope-from <mr@neil.brown.name>) id 1uftLU-003aFd-2A;
 Sun, 27 Jul 2025 04:50:49 +0000
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Harshvardhan Jha" <harshvardhan.j.jha@oracle.com>
In-reply-to: <c5d1eb2b-2697-4413-983c-0650eab389e9@oracle.com>
References: <>, <c5d1eb2b-2697-4413-983c-0650eab389e9@oracle.com>
Date: Sun, 27 Jul 2025 14:50:48 +1000
Message-id: <175359184844.2234665.17719114991555307336@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
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
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 Mark Brown <broonie@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Aishwarya.TCV@arm.com, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
 trondmy@kernel.org, Anna Schumaker <anna@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCAyNSBKdWwgMjAyNSwgSGFyc2h2YXJkaGFuIEpoYSB3cm90ZToKPiBPbiAyMy8wNy8y
NSAxOjM3IFBNLCBOZWlsQnJvd24gd3JvdGU6Cj4gPiBPbiBXZWQsIDIzIEp1bCAyMDI1LCBIYXJz
aHZhcmRoYW4gSmhhIHdyb3RlOgo+ID4+IE9uIDA4LzA0LzI1IDQ6MDEgUE0sIE1hcmsgQnJvd24g
d3JvdGU6Cj4gPj4+IE9uIEZyaSwgTWFyIDI4LCAyMDI1IGF0IDAxOjQwOjQ0UE0gLTA0MDAsIHRy
b25kbXlAa2VybmVsLm9yZyB3cm90ZToKPiA+Pj4+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4KPiA+Pj4+Cj4gPj4+PiBPbmNlIGEgdGFzayBj
YWxscyBleGl0X3NpZ25hbHMoKSBpdCBjYW4gbm8gbG9uZ2VyIGJlIHNpZ25hbGxlZC4gU28gZG8K
PiA+Pj4+IG5vdCBhbGxvdyBpdCB0byBkbyBraWxsYWJsZSB3YWl0cy4KPiA+Pj4gV2UncmUgc2Vl
aW5nIHRoZSBMVFAgYWNjdDAyIHRlc3QgZmFpbGluZyBpbiBrZXJuZWxzIHdpdGggdGhpcyBwYXRj
aAo+ID4+PiBhcHBsaWVkLCB0ZXN0aW5nIG9uIHN5c3RlbXMgd2l0aCBORlMgcm9vdCBmaWxlc3lz
dGVtczoKPiA+Pj4KPiA+Pj4gMTAyNzEgMDU6MDM6MDkuMDY0OTkzICB0c3RfdGVzdC5jOjE5MDA6
IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTAxMzAtMS1nNjBmZTg0YWFmCj4gPj4+IDEwMjcyIDA1
OjAzOjA5LjA3NjQyNSAgdHN0X3Rlc3QuYzoxOTA0OiBUSU5GTzogVGVzdGVkIGtlcm5lbDogNi4x
NS4wLXJjMSAjMSBTTVAgUFJFRU1QVCBTdW4gQXByICA2IDIxOjE4OjE0IFVUQyAyMDI1IGFhcmNo
NjQKPiA+Pj4gMTAyNzMgMDU6MDM6MDkuMDc2NzMzICB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzog
UGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4gPj4+IDEwMjc0IDA1OjAz
OjA5LjA4NzgwMyAgdHN0X3Rlc3QuYzoxNzIyOiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBy
dW4gaXMgMGggMDFtIDMwcwo+ID4+PiAxMDI3NSAwNTowMzowOS4wODgxMDcgIHRzdF9rY29uZmln
LmM6ODg6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25maWcgJy9wcm9jL2NvbmZpZy5neicKPiA+
Pj4gMTAyNzYgMDU6MDM6MDkuMDkzMDk3ICBhY2N0MDIuYzo2MzogVElORk86IENPTkZJR19CU0Rf
UFJPQ0VTU19BQ0NUX1YzPXkKPiA+Pj4gMTAyNzcgMDU6MDM6MDkuMDkzNDAwICBhY2N0MDIuYzoy
NDA6IFRJTkZPOiBWZXJpZnlpbmcgdXNpbmcgJ3N0cnVjdCBhY2N0X3YzJwo+ID4+PiAxMDI3OCAw
NTowMzoxMC4wNTM1MDQgIDw2PlsgICA5OC4wNDMxNDNdIFByb2Nlc3MgYWNjb3VudGluZyByZXN1
bWVkCj4gPj4+IDEwMjc5IDA1OjAzOjEwLjA1MzkzNSAgPDY+WyAgIDk4LjA0MzE0M10gUHJvY2Vz
cyBhY2NvdW50aW5nIHJlc3VtZWQKPiA+Pj4gMTAyODAgMDU6MDM6MTAuMDY0NjUzICBhY2N0MDIu
YzoxOTM6IFRJTkZPOiA9PSBlbnRyeSAxID09Cj4gPj4+IDEwMjgxIDA1OjAzOjEwLjA2NDk1MyAg
YWNjdDAyLmM6ODQ6IFRJTkZPOiBhY19jb21tICE9ICdhY2N0MDJfaGVscGVyJyAoJ2FjY3QwMicp
Cj4gPj4+IDEwMjgyIDA1OjAzOjEwLjA3NjAyOSAgYWNjdDAyLmM6MTMzOiBUSU5GTzogYWNfZXhp
dGNvZGUgIT0gMzI3NjggKDApCj4gPj4+IDEwMjgzIDA1OjAzOjEwLjA3NjMzMSAgYWNjdDAyLmM6
MTQxOiBUSU5GTzogYWNfcHBpZCAhPSAyNDY2ICgyNDYxKQo+ID4gSXQgc2VlbXMgdGhhdCB0aGUg
YWNjdDAyIHByb2Nlc3MgZ290IGxvZ2dlZC4uCj4gPiBNYXliZSB0aGUgdmZvcmsgYXR0ZW1wdCAo
dHJ5aW5nIHRvIHJ1biBhY2N0MDJfaGVscGVyKSBnb3QgaGFsZiB3YXkgYW4KPiA+IGFib3J0ZWQu
Cj4gPiBJdCBnb3QgZmFyIGVub3VnaCB0aGF0IGFjY291bnRpbmcgZ290IGludGVyZXN0ZWQuCj4g
PiBJdCBkaWRuJ3QgZ2V0IGZhciBlbm91Z2ggdG8gdXBkYXRlIHRoZSBwcGlkLgo+ID4gSSdkIGJl
IHN1cnByaXNlZCBpZiB0aGF0IHdlcmUgZXZlbiBwb3NzaWJsZS4uLi4KPiA+Cj4gPiBJZiB5b3Ug
d291bGQgbGlrZSB0byBoZWxwIGRlYnVnIHRoaXMsIGNoYW5naW5nIHRoZQo+ID4KPiA+ICsgICAg
ICAgaWYgKHVubGlrZWx5KGN1cnJlbnQtPmZsYWdzICYgUEZfRVhJVElORykpCj4gPgo+ID4gdG8K
PiA+Cj4gPiArICAgICAgIGlmICh1bmxpa2VseShXQVJOX09OKGN1cnJlbnQtPmZsYWdzICYgUEZf
RVhJVElORykpKQo+ID4KPiA+IHdvdWxkIHByb3ZpZGUgc3RhY2sgdHJhY2VzIHNvIHdlIGNhbiB3
ZWUgd2hlcmUgLUVJTlRSIGlzIGFjdHVhbGx5IGJlaW5nCj4gPiByZXR1cm5lZC4gIFRoYXQgc2hv
dWxkIHByb3ZpZGUgc29tZSBoaW50cy4KPiA+Cj4gPiBOZWlsQnJvd24KPiAKPiBIaSBOZWlsLAo+
IAo+IFVwb24gdGhpcyBhZGRpdGlvbiBJIGdvdCB0aGlzIGluIHRoZSBsb2dzCgpUaGFua3MgZm9y
IHRlc3RpbmcuICBXYXMgdGhlcmUgYW55dGhpbmcgbmV3IGluIHRoZSBrZXJuZWwgbG9ncz8gIEkg
d2FzCmV4cGVjdGluZyBhIFdBUk5JTkcgbWVzc2FnZSBmb2xsb3dlZCBieSBhICJDYWxsIFRyYWNl
Ii4KCklmIHRoZXJlIHdhc24ndCwgdGhlbiB0aGlzIHBhdGNoIGNhbm5vdCBoYXZlIGNhdXNlZCB0
aGUgcHJvYmxlbS4KSWYgdGhlcmUgd2FzLCB0aGVuIEkgbmVlZCB0byBzZWUgaXQuCgpUaGFua3Ms
Ck5laWxCcm93bgoKCj4gCj4gPDw8dGVzdF9zdGFydD4+Pgo+IHRhZz1hY2N0MDIgc3RpbWU9MTc1
MzQ0NDE3Mgo+IGNtZGxpbmU9ImFjY3QwMiIKPiBjb250YWN0cz0iIgo+IGFuYWx5c2lzPWV4aXQK
PiA8PDx0ZXN0X291dHB1dD4+Pgo+IHRzdF9rY29uZmlnLmM6ODg6IFRJTkZPOiBQYXJzaW5nIGtl
cm5lbCBjb25maWcKPiAnL2xpYi9tb2R1bGVzLzYuMTUuOC0xLmJ1ZzM4MjI3OTcwLmVsOS5yYzIu
eDg2XzY0L2NvbmZpZycKPiB0c3RfdG1wZGlyLmM6MzE2OiBUSU5GTzogVXNpbmcgL3RtcGRpci9s
dHAtdzFvektLbEo2bi9MVFBfYWNjNFJSZkxoIGFzCj4gdG1wZGlyIChuZnMgZmlsZXN5c3RlbSkK
PiB0c3RfdGVzdC5jOjIwMDQ6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTA1MzAtMTA1LWdkYTcz
ZTE1MjcKPiB0c3RfdGVzdC5jOjIwMDc6IFRJTkZPOiBUZXN0ZWQga2VybmVsOgo+IDYuMTUuOC0x
LmJ1ZzM4MjI3OTcwLmVsOS5yYzIueDg2XzY0ICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgRnJpIEp1
bCAyNQo+IDAyOjAzOjA0IFBEVCAyMDI1IHg4Nl82NAo+IHRzdF9rY29uZmlnLmM6ODg6IFRJTkZP
OiBQYXJzaW5nIGtlcm5lbCBjb25maWcKPiAnL2xpYi9tb2R1bGVzLzYuMTUuOC0xLmJ1ZzM4MjI3
OTcwLmVsOS5yYzIueDg2XzY0L2NvbmZpZycKPiB0c3RfdGVzdC5jOjE4MjU6IFRJTkZPOiBPdmVy
YWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMG0gMzBzCj4gdHN0X2tjb25maWcuYzo4ODogVElO
Rk86IFBhcnNpbmcga2VybmVsIGNvbmZpZwo+ICcvbGliL21vZHVsZXMvNi4xNS44LTEuYnVnMzgy
Mjc5NzAuZWw5LnJjMi54ODZfNjQvY29uZmlnJwo+IGFjY3QwMi5jOjYxOiBUSU5GTzogQ09ORklH
X0JTRF9QUk9DRVNTX0FDQ1RfVjM9eQo+IGFjY3QwMi5jOjIzODogVElORk86IFZlcmlmeWluZyB1
c2luZyAnc3RydWN0IGFjY3RfdjMnCj4gYWNjdDAyLmM6MTkxOiBUSU5GTzogPT0gZW50cnkgMSA9
PQo+IGFjY3QwMi5jOjgyOiBUSU5GTzogYWNfY29tbSAhPSAnYWNjdDAyX2hlbHBlcicgKCdhY2N0
MDInKQo+IGFjY3QwMi5jOjEzMTogVElORk86IGFjX2V4aXRjb2RlICE9IDMyNzY4ICgwKQo+IGFj
Y3QwMi5jOjEzOTogVElORk86IGFjX3BwaWQgIT0gODg5MjkgKDg4OTI4KQo+IGFjY3QwMi5jOjE4
MTogVEZBSUw6IGVuZCBvZiBmaWxlIHJlYWNoZWQKPiAKPiBISU5UOiBZb3UgX01BWV8gYmUgbWlz
c2luZyBrZXJuZWwgZml4ZXM6Cj4gCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9NGQ5NTcwMTU4YjYy
Ngo+IAo+IFN1bW1hcnk6Cj4gcGFzc2VkwqAgwqAwCj4gZmFpbGVkwqAgwqAxCj4gYnJva2VuwqAg
wqAwCj4gc2tpcHBlZMKgIDAKPiB3YXJuaW5ncyAwCj4gaW5jcmVtZW50aW5nIHN0b3AKPiA8PDxl
eGVjdXRpb25fc3RhdHVzPj4+Cj4gaW5pdGlhdGlvbl9zdGF0dXM9Im9rIgo+IGR1cmF0aW9uPTEg
dGVybWluYXRpb25fdHlwZT1leGl0ZWQgdGVybWluYXRpb25faWQ9MSBjb3JlZmlsZT1ubwo+IGN1
dGltZT0wIGNzdGltZT0yMAo+IAo+IDw8PHRlc3RfZW5kPj4+Cj4gCj4gCj4gVGhhbmtzICYgUmVn
YXJkcywKPiAKPiBIYXJzaHZhcmRoYW4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
