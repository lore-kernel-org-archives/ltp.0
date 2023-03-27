Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ED9C76195
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 10:26:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D4663CCBDB
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 12:26:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16B1B3CA2FE
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 12:26:05 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 2D8FE140076D
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 12:26:03 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 731384B3;
 Mon, 27 Mar 2023 03:26:45 -0700 (PDT)
Received: from [10.57.54.115] (unknown [10.57.54.115])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B18AE3F73F;
 Mon, 27 Mar 2023 03:26:00 -0700 (PDT)
Message-ID: <d9d23632-b21a-5c43-c3dc-8a9b0873e0ba@arm.com>
Date: Mon, 27 Mar 2023 11:25:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Li Wang <liwang@redhat.com>
References: <20230323160508.672397-2-teo.coupriediaz@arm.com>
 <ZB2PB6adFr+3sYI8@yuki> <76663541-e9bd-a17a-0ebd-ddd4d1eb68dd@arm.com>
 <CAEemH2e9gbNOfm3Opc46Qh8FYmiYNtzrmyJy1hdbsVFVjyLk3w@mail.gmail.com>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <CAEemH2e9gbNOfm3Opc46Qh8FYmiYNtzrmyJy1hdbsVFVjyLk3w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sockioctl: Align buffer to struct ifreq
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

SGkgTGksCgpPbiAyNy8wMy8yMDIzIDA5OjM1LCBMaSBXYW5nIHdyb3RlOgo+IEhpIFRlbywKPgo+
IE9uIEZyaSwgTWFyIDI0LCAyMDIzIGF0IDEwOjM14oCvUE0gVGVvIENvdXByaWUgRGlhego+IDx0
ZW8uY291cHJpZWRpYXpAYXJtLmNvbT4gd3JvdGU6Cj4+IEhpIEN5cmlsLAo+Pgo+PiBPbiAyNC8w
My8yMDIzIDExOjUyLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4+PiBIaSEKPj4+PiBJbiBzZXR1cDMs
IHRoZSBmb2xsb3dpbmcgbGluZSBjYW4gbGVhZCB0byBhbiB1bmRlZmluZWQgYmVoYXZpb3I6Cj4+
Pj4gICAgIGlmciA9ICooc3RydWN0IGlmcmVxICopaWZjLmlmY19idWY7Cj4+Pj4KPj4+PiBJbmRl
ZWQsIGF0IHRoaXMgcG9pbnQgaXQgY2FuIGJlIGFzc3VtZWQgdGhhdCBpZmMuaWZjX2J1ZiBpcyBz
dWl0YWJseQo+Pj4+IGFsaWduZWQgZm9yIHN0cnVjdCBpZnJlcS4KPj4+PiBIb3dldmVyLCBpZmMu
aWZjX2J1ZiBpcyBhc3NpZ25lZCB0byBidWYgd2hpY2ggaGFzIG5vIGFsaWdubWVudAo+Pj4+IGNv
bnN0cmFpbnRzLiBUaGlzIG1lYW5zIHRoZXJlIGV4aXN0cyBjYXNlcyB3aGVyZSBidWYgaXMgbm90
IHN1aXRhYmx5Cj4+Pj4gYWxpZ25lZCB0byBsb2FkIGEgc3RydWN0IGlmcmVxLCB3aGljaCBjYW4g
Z2VuZXJhdGUgYSBTSUdCVVMuCj4+Pj4KPj4+PiBGb3JjZSB0aGUgYWxpZ25tZW50IG9mIGJ1ZiB0
byB0aGF0IG9mIHN0cnVjdCBpZnJlcS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFRlbyBDb3Vw
cmllIERpYXogPHRlby5jb3VwcmllZGlhekBhcm0uY29tPgo+Pj4+IC0tLQo+Pj4+IENJIEJ1aWxk
OiBodHRwczovL2dpdGh1Yi5jb20vVGVvLUNEL2x0cC9hY3Rpb25zL3J1bnMvNDUwMjIwNDEzMgo+
Pj4+Cj4+Pj4gICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zb2NraW9jdGwvc29ja2lvY3Rs
MDEuYyB8IDggKysrKysrKy0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9zb2NraW9jdGwvc29ja2lvY3RsMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvc29ja2lvY3RsL3NvY2tpb2N0bDAxLmMKPj4+PiBpbmRleCA0ODYyMzZhZjlkNmIuLmU2M2Fh
MTkyMTg3NyAxMDA2NDQKPj4+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NvY2tp
b2N0bC9zb2NraW9jdGwwMS5jCj4+Pj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9z
b2NraW9jdGwvc29ja2lvY3RsMDEuYwo+Pj4+IEBAIC01Miw3ICs1MiwxMyBAQCBzdGF0aWMgc3Ry
dWN0IGlmcmVxIGlmcjsKPj4+PiAgICBzdGF0aWMgaW50IHNpbmxlbjsKPj4+PiAgICBzdGF0aWMg
aW50IG9wdHZhbDsKPj4+Pgo+Pj4+IC1zdGF0aWMgY2hhciBidWZbODE5Ml07Cj4+Pj4gKy8qCj4+
Pj4gKyAqIGJ1ZiBoYXMgbm8gYWxpZ25tZW50IGNvbnN0cmFpbnRzIGJ5IGRlZmF1bHQuIEhvd2V2
ZXIsIGl0IGlzIHVzZWQgdG8gbG9hZAo+Pj4+ICsgKiBhIHN0cnVjdCBpZnJlcSBpbiBzZXR1cDMs
IHdoaWNoIHJlcXVpcmVzIGl0IHRvIGhhdmUgYW4gYXBwcm9wcmlhdGUgYWxpZ25tZW50Cj4+Pj4g
KyAqIHRvIHByZXZlbnQgYSBwb3NzaWJsZSB1bmRlZmluZWQgYmVoYXZpb3IuCj4+Pj4gKyAqLwo+
Pj4+ICtzdGF0aWMgY2hhciBidWZbODE5Ml0KPj4+PiArICAgIF9fYXR0cmlidXRlX18oKGFsaWdu
ZWQoX19hbGlnbm9mX18oc3RydWN0IGlmcmVxKSkpKTsKPj4+Pgo+Pj4+ICAgIHN0YXRpYyB2b2lk
IHNldHVwKHZvaWQpOwo+Pj4+ICAgIHN0YXRpYyB2b2lkIHNldHVwMCh2b2lkKTsKPj4+IExvb2tp
bmcgYXQgdGhlIGNvZGUsIHNob3VsZG4ndCB3ZSByYXRoZXIgdGhhbiB0aGF0IGRlY2xhcmUgdGhl
IGJ1ZmZlciBhcwo+Pj4gYW4gc3RydWN0IGlmcmVxIGFycmF5LCB0aGF0IHdvdWxkIG5hdHVyYWxs
eSBhbGlnbiB0aGUgYnVmZmVyIHdpdGhvdXQgYW55Cj4+PiBuZWVkIGZvciB0cmlja3kgX19hdHRy
aWJ1dGVfXy4KPj4gX19hdHRyaWJ1dGVfXytfX2FsaWdub2ZfXyBpcyBxdWl0ZSB1bndpZWxkeSBp
bmRlZWQuIEkga2VwdCB0aGUgY2hhciogdG8KPj4gbWF0Y2ggdGhlIHN0cnVjdCBkZWZpbml0aW9u
LAo+PiBidXQgaXQncyByZWFsbHkganVzdCB0byByZXByZXNlbnQgYSBwb2ludGVyIHRvIHNvbWV0
aGluZy4gSXQncyBub3QgdXNlZAo+PiBhcyBhbnl0aGluZyBlbHNlIGluIHRoZSB0ZXN0IGFueXdh
eS4KPj4KPj4gSWYgeW91IGZlZWwgdGhlcmUncyBubyBnb29kIHJlYXNvbiB0byBrZWVwIHRoZSBj
aGFyKiBidWZmIGFuZCBjYXN0IHRvCj4+IHZvaWQqIGZvciB0aGUgc3lzY2FsbCwKPj4gSSBhZ3Jl
ZSB0aGF0IGl0IHdvdWxkIGJlIGJldHRlci4gSSB0ZXN0ZWQgb24gb3VyIHN5c3RlbSB3aGljaCBn
ZW5lcmF0ZWQKPj4gdGhlIGZhdWx0IGluaXRpYWxseQo+PiBhbmQgaXQgd29ya3MgZmluZSBhcyBl
eHBlY3RlZC4KPj4KPj4gV2hhdCB3b3VsZCBiZSB0aGUgcHJvY2VkdXJlIGluIHRoaXMgY2FzZSA/
IFNoYWxsIEkgcmVzZW5kIHRoZSBwYXRjaCB3aXRoCj4+IHlvdXIgY2hhbmdlcyA/Cj4gWWVzLCB5
b3UgbmVlZCB0byBzZW5kIGEgcGF0Y2ggdjIgd2l0aCBDeXJpbCdzIHN1Z2dlc3Rpb24uClRoYW5r
cyBmb3IgY2xhcmlmeWluZyBMaSwgdGhlbiBJIHdpbGwgc2ltcGx5IHNlbmQgb3V0IHRoZSB2MiB3
aXRoIApDeXJpbCdzIGNoYW5nZXMKYW5kIHVwZGF0ZWQgY29tbWl0IG1lc3NhZ2UuCgpCZXN0IHJl
Z2FyZHMsClTDqW8KCj4KPj4gV291bGQgeW91IGp1c3QgYXBwbHkgaXQgb3Igc2VuZCBpdCB5b3Vy
c2VsZiA/IEhhcHB5IHRvIGZvbGxvdyB1cCBob3dldmVyCj4+IGlzIGJlc3QuCj4+Cj4+IFRoYW5r
cyBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIGxvb2sgaW50byBpdCwKPj4gQmVzdCByZWdhcmRzCj4+
IFTDqW8KPj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NvY2tpb2N0
bC9zb2NraW9jdGwwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zb2NraW9jdGwvc29j
a2lvY3RsMDEuYwo+Pj4gaW5kZXggNTFkYWM5YzE2Li4yMDZhNDk5OWUgMTAwNjQ0Cj4+PiAtLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NvY2tpb2N0bC9zb2NraW9jdGwwMS5jCj4+PiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NvY2tpb2N0bC9zb2NraW9jdGwwMS5jCj4+
PiBAQCAtNTIsNyArNTIsNyBAQCBzdGF0aWMgc3RydWN0IGlmcmVxIGlmcjsKPj4+ICAgIHN0YXRp
YyBpbnQgc2lubGVuOwo+Pj4gICAgc3RhdGljIGludCBvcHR2YWw7Cj4+Pgo+Pj4gLXN0YXRpYyBj
aGFyIGJ1Zls4MTkyXTsKPj4+ICtzdGF0aWMgc3RydWN0IGlmcmVxIGJ1ZlsyMDBdOwo+Pj4KPj4+
ICAgIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpOwo+Pj4gICAgc3RhdGljIHZvaWQgc2V0dXAwKHZv
aWQpOwo+Pj4gQEAgLTIxOCw3ICsyMTgsNyBAQCBzdGF0aWMgdm9pZCBzZXR1cDIodm9pZCkKPj4+
ICAgICAgICAgICBzID0gU0FGRV9TT0NLRVQoY2xlYW51cCwgdGRhdFt0ZXN0bm9dLmRvbWFpbiwg
dGRhdFt0ZXN0bm9dLnR5cGUsCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHRkYXRbdGVz
dG5vXS5wcm90byk7Cj4+PiAgICAgICAgICAgaWZjLmlmY19sZW4gPSBzaXplb2YoYnVmKTsKPj4+
IC0gICAgICAgaWZjLmlmY19idWYgPSBidWY7Cj4+PiArICAgICAgIGlmYy5pZmNfYnVmID0gKHZv
aWQqKWJ1ZjsKPj4+ICAgIH0KPj4+Cj4+Pgo+PiAtLQo+PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
