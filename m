Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E80C761A6
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 15:52:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F1A03CD057
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 17:52:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DF7E3CC81F
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 17:52:32 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id BF4651A006EA
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 17:52:31 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ED05FEC;
 Mon,  3 Apr 2023 08:53:13 -0700 (PDT)
Received: from [10.57.56.198] (unknown [10.57.56.198])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04D133F6C4;
 Mon,  3 Apr 2023 08:52:27 -0700 (PDT)
Message-ID: <e1680052-0e83-ed71-1268-c0043273ba32@arm.com>
Date: Mon, 3 Apr 2023 16:52:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230323160442.671164-1-teo.coupriediaz@arm.com>
 <ZCVzVHPnRDcGDrVt@yuki>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <ZCVzVHPnRDcGDrVt@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ipc/msgstress03: Assume all forks will run
 concurently
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgpUaGFua3MgZm9yIHRoZSByZXZpZXcsIHNvcnJ5IGZvciB0aGUgZGVsYXkgaW4g
cmVzcG9uZGluZy4KCk9uIDMwLzAzLzIwMjMgMTI6MzIsIEN5cmlsIEhydWJpcyB3cm90ZToKPiBI
aSEKPj4gSXQgYXBwZWFycyB0aGF0IG1zZ3N0cmVzczAzIGRvZXNuJ3QgYWNjb3VudCBmb3IgYWxs
IFBJRHMgdGhhdCBpdHMgY2hpbGRyZW4KPj4gY2FuIHVzZSwgYXMgaXQgZXhwZWN0cyB0aGUgdGFz
a3Mgd2lsbCB0ZXJtaW5hdGUgcXVpY2tseSBhbmQgbm90IHJlYWNoCj4+IHRoZSBQSUQgbGltaXQu
Cj4+IE9uIHNvbWUgc3lzdGVtcywgdGhpcyBhc3N1bXB0aW9uIGNhbiBiZSBpbnZhbGlkIGFuZCB0
aGUgUElEIGxpbWl0Cj4+IHdpbGwgYmUgaGl0Lgo+PiBDaGFuZ2UgdGhlIGxpbWl0IHRvIGFjY291
bnQgZm9yIGFsbCBwb3NzaWJsZSBjaGlsZHJlbiBhdCBvbmNlLCBrbm93bmluZwo+PiB0aGF0IGVh
Y2ggY2hpbGQgd2lsbCBmb3JrIGFzIHdlbGwuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFRlbyBDb3Vw
cmllIERpYXogPHRlby5jb3VwcmllZGlhekBhcm0uY29tPgo+PiBSZXZpZXdlZC1ieTogUmljaGFy
ZCBQYWxldGhvcnBlIDxycGFsZXRob3JwZUBzdXNlLmNvbT4KPj4gLS0tCj4+IFRoaXMgcGF0Y2gg
d2FzIGFscmVhZHkgcmV2aWV3ZWQgYXMgcGFydCBvZiBhIGxhcmdlciBzZXJpZXNbMF0uIFRoZSBy
ZXN0IG9mCj4+IHRoZSBzZXJpZXMgbmVlZHMgYSBsYXJnZSByZXdvcmsgdG8gYmUgbWVyZ2VkLCBi
dXQgSSBmZWx0IHRoaXMgcGF0Y2ggd2FzIGEKPj4gc2ltcGxlIGFuZCBpbmRlcGVuZG50IGVub3Vn
aCB0byB3YXJyYW50IGEgcmVzZW5kLgo+PiBObyBjaGFuZ2VzIHdlcmUgbWFkZS4KPj4KPj4gQ0kg
QnVpbGQ6IGh0dHBzOi8vZ2l0aHViLmNvbS9UZW8tQ0QvbHRwL2FjdGlvbnMvcnVucy80NTAyMTk3
ODA4Cj4+Cj4+IFswXTogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjMt
RmVicnVhcnkvMDMzMDA3Lmh0bWwKPj4KPj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lw
Yy9tc2dzdHJlc3MvbXNnc3RyZXNzMDMuYyB8IDIgKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvaXBjL21zZ3N0cmVzcy9tc2dzdHJlc3MwMy5jIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9pcGMvbXNnc3RyZXNzL21zZ3N0cmVzczAzLmMKPj4gaW5kZXggM2NiNzBh
YjE4Li4wYzQ2OTI3YjggMTAwNjQ0Cj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aXBjL21zZ3N0cmVzcy9tc2dzdHJlc3MwMy5jCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvaXBjL21zZ3N0cmVzcy9tc2dzdHJlc3MwMy5jCj4+IEBAIC0xMDksNyArMTA5LDcgQEAg
aW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQo+PiAgIAkJfQo+PiAgIAl9Cj4+ICAgCj4+
IC0JZnJlZV9waWRzID0gdHN0X2dldF9mcmVlX3BpZHMoY2xlYW51cCk7Cj4+ICsJZnJlZV9waWRz
ID0gdHN0X2dldF9mcmVlX3BpZHMoY2xlYW51cCkgLyAyOwo+PiAgIAlpZiAobnByb2NzID49IGZy
ZWVfcGlkcykgewo+PiAgIAkJdHN0X3Jlc20oVElORk8sCj4+ICAgCQkJICJSZXF1ZXN0ZWQgbnVt
YmVyIG9mIHByb2Nlc3NlcyBoaWdoZXIgdGhhbiBsaW1pdCAoJWQgPiAlZCksICIKPiBUaGUgbG9n
aWMgYmVoaW5kIHRoZSBjaGFuZ2UgaXMgZ29vZCwgaG93ZXZlciBJIHdvbmRlciBpZiB0aGlzIHdv
dWxkCj4gcHJvZHVjZSBhIGJpdCBjb25mdXNpbmcgbWVzc2FnZSBpbiBjYXNlIHRoYXQgd2UgYXJl
IG92ZXIgbGltaXQgYW5kCj4gc2V0dGluZyB0aGUgdmFsdWUgdG8gdGhlIGN1cnJlbnQgbWF4aW11
bS4gQ2FuIHdlIGF0IGxlYXN0IG11bHRpcGx5IHRoZQo+IHZhbHVlcyBwcmludGVkIGluIHRoZSBU
SU5GTyBtZXNzYWdlIGJ5IDIgc28gdGhhdCB3ZSBnZXQgcmVhbCBsaW1pdHMKPiBpbnN0ZWFkIG9m
IGhhbHZlcz8KWW91J3JlIHJpZ2h0LCBhbmQgd2l0aG91dCB0aGUgcGF0Y2ggaXQgY291bGQgYmUg
d2VpcmQgYXMgd2VsbCBhcyB0aGUgCm1heGltdW0gY291bGQgYmUgaGl0IGFuZCB0aGUgd2Fybmlu
ZyBub3QgYXBwZWFyLgpJIHdpbGwgc2VuZCBhIHYyIHRoYXQgZG9lcyBzb21ldGhpbmcgc2ltaWxh
ciB0byBtc2dzdHJlc3MwNCB3aGVyZSBJIApkb24ndCBjaGFuZ2UgdGhlIGZyZWVfcGlkcyBpdHNl
bGYuCj4KPiBHZW5lcmFsbHkgdGhlIG5wcm9jcyBpcyBhY3R1YWxseSB0aGUgbnVtYmVyIG9mIG1l
c3NhZ2UgcXVldWVzLCB3aGljaCBpcwo+IGNvbmZ1c2luZyBpdHNlbGYsIGJ1dCB0aGF0IGlzIHBy
b2JhYmx5IGxlZnQgZm9yIGEgYmlnZ2VyIGNsZWFudXAgb2YgdGhlCj4gdGVzdGNhc2UuLi4KSXQg
c2VlbXMgdGhhdCBtc2dzdHJlc3MwNCBpcyBhIGJpdCBjbGVhcmVyIG9uIHRoaXMgcG9pbnQsIGFz
IGl0IGhhcyAKbnJfbXNncXMgb24gdG9wIG9mIG5wcm9jcy4KQnV0IEkgYWdyZWUsIGlmIEkgaGFk
IHRoZSB0aW1lIEkgd291bGQgaGF2ZSBiZWVuIGhhcHB5IGNsZWFuaW5nIHVwIHRoZSAKdGVzdCBt
b3JlLgpJbiB0aGUgbWVhbnRpbWUgSSBob3BlIHRoaXMgZml4IGNhbiBiZSB1c2VmdWwgZm9yIHNv
bWUuCgpUaGFua3MgYWdhaW4gZm9yIHRoZSByZXZpZXcsCkJlc3QgcmVnYXJkcwpUw6lvLUNECgo+
IC0tIAo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+CgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
