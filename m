Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B4AC433F5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:23:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A62561AD1
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A62561AD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F188D3C8153
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 10:23:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D070E3C1C46
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 10:23:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0178A1A00A44
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 10:23:07 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 19718218A9;
 Mon, 15 Nov 2021 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636968187;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJcC3z3vnQUCGKsKotgvZROzmeKNahkQsTBt31qJJkM=;
 b=aKsos1Nc2wvTk8X+faz0doAw79Pw9fkpTfcYl/h1DjIXKvwxUEzArveUpwq94x/cHbI6vT
 Yj1PSyYZIV1dOWg2cIlmn/AWzrTMMxfe8GuttIQwho1ZOj89j3a0mGTy1rd5ImU/z5B9na
 llMvwcn9sg/QFRCajT8C1NNKldk3k6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636968187;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJcC3z3vnQUCGKsKotgvZROzmeKNahkQsTBt31qJJkM=;
 b=ROjz3Sehdkk6xBo8TMM5C052BsgnzksLVenLNH5As33RFsloO+hmIAjFCLZuz7homxfrX2
 YHbvlJSq0tZroJDw==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CF183A3B81;
 Mon, 15 Nov 2021 09:23:06 +0000 (UTC)
References: <20210623071543.171021-1-lkml@jv-coder.de> <87mtrg4yz6.fsf@suse.de>
 <3a6d7a45-2205-34f9-aaab-2d039d132456@jv-coder.de>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 15 Nov 2021 09:19:52 +0000
In-reply-to: <3a6d7a45-2205-34f9-aaab-2d039d132456@jv-coder.de>
Message-ID: <871r3heps5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] cpuset_regression_test: convert and improve
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gSm9lcmcsCgpKb2VyZyBWZWhsb3cgPGxrbWxAanYtY29kZXIuZGU+IHdyaXRlczoKCj4g
SGkgUmljaGFyZCwKPgo+IE9uIDYvMjMvMjAyMSAxOjExIFBNLCBSaWNoYXJkIFBhbGV0aG9ycGUg
d3JvdGU6Cj4+IEhlbGxvIEpvZXJnLAo+Pgo+PiBKb2VyZyBWZWhsb3cgPGxrbWxAanYtY29kZXIu
ZGU+IHdyaXRlczoKPj4KPj4+IEhpLAo+Pj4KPj4+IHRoaXMgaXMgbW9yZSBvciBsZXNzIGEgdjIg
b2YgYSBwYXRjaCBJIHNlbmQgcHJldmlvdXNseSAocGF0Y2ggMykuCj4+PiBJIGtub3cgdGhhdCBy
aWNoYXJkIGlzIG5vdCBlbnRpcmVseSBoYXBweSB3aXRoIHRoaXMgcGF0Y2gsIEkgd2lsbAo+Pj4g
Z2l2ZSBpdCBhbm90aGVyIHRyeSBhbnl3YXkuLi4KPj4+IEl0IGlzIGVpdGhlciB0aGlzIHBhdGNo
IG9yIGFub3RoZXIgcGF0Y2gsIHRoYXQgaGFzIHRvIGxvb2sgdGhyb3VnaAo+Pj4gdGhlIGNncm91
cCBoaWVyYXJjaHksIHRvIGNoZWNrIGlmIHRoZXJlIGlzIGFueSBncm91cCx0aGF0IGV4cGxpY2l0
ZWx5Cj4+PiB1c2VzIGNwdSAwLgo+PiBJZiBpdCBpcyBhbHJlYWR5IGJlaW5nIHVzZWQgdGhlbiBj
YW4geW91IHNldCBpdD8KPiBUaGUgdGVzdCBjYW4gdXNlIGFueSBjcHUsIHRoYXQgaXMgbm90IGV4
cGxpY2l0bHkgYXNzaWduZWQgdG8gYSBncm91cAo+IGFscmVhZHkuCj4gV2hhdCBJIG1lYW4gYnkg
ImVpdGhlciB0aGlzIG9yIGFub3RoZXIgcGF0Y2giIChhbmQgZm9yZ290IHRvIHR5cGUpLAo+IHRo
ZSBhbHRlcm5hdGl2ZQo+IHBhdGNoIGhhcyB0byBjaGVjayBpZiBhbnl0aGluZyBpcyB1c2luZyBj
cHUgMCBleHBsaWNpdGx5IGFuZCB0aGVuIGZhaWwKPiB3aXRoIFRDT05GLgo+IE9yIGl0IGhhcyB0
byBsb29rIGZvciBhbiB1c2VkIGNwdSBjb3JlLiBUaGF0IHdvdWxkIGJlIGFub3RoZXIgcG9zc2li
aWxpdHkuLi4KPgo+Pgo+Pj4gVG8gbWUsIGl0IGlzIGEgYmV0dGVyIHNvbHV0aW9uIHRvIGp1c3Qg
Y2hhbmdlIGdyb3VwcyBmb3IgYSBzaG9ydCB0aW1lLAo+Pj4gYW5kIGNoZWNrIGlmIHRoZSBidWcg
ZXhpc3RzLiBJZiBsdHAgdGVzdHMgYXJlIHJ1bm5pbmcsIHRoZSBjaGFuY2UsIHRoYXQKPj4+IHRo
ZXJlIGlzIGFueXRoaW5nIHJ1bm5pbmcsIHRoYXQgcmVhbGx5IG5lZWRzIGEgY29ycmVjdCBjcHVz
ZXQgaXMgdmVyeSBsb3cuCj4+PiBJIGFtIGNvbW1pbmcgZnJvbSBhIHN5c3RlbSwgd2hlcmUgY2dy
b3VwcyBhcmUgc2V0dXAgYnkgYSBjb250YWluZXIgbGF1bmNoZXIsCj4+PiB0aGF0IGp1c3QgaGFw
cGVucyB0byBhc3NpZ24gY3B1cyB0byB0aGUgY29udGFpbmVycyAtIG5vdCBldmVuIGV4Y2x1c2l2
ZWx5Lgo+Pj4gTFRQIHRlc3RzIGFyZSB1c2VkIGFzIHNvbWUgcGFydCBvZiB0aGUgdGVzdHN1aXRl
LCB0byB0ZXN0IGFzIGNsb3NlIHRvIGEKPj4+IHByb2R1Y3Rpb24gc3lzdGVtIGFzIHBvc3NpYmxl
Lgo+PiBJIHdhcyB0aGlua2luZyB0aGF0IGlmIHlvdSBhcmUgYWxyZWFkeSB1c2luZyBDUFUgc2V0
cyB0aGVuIHlvdSBlaXRoZXIKPj4gZG9uJ3QgaGF2ZSB0aGUgYnVnIG9yIHlvdSB3b24ndCBoaXQg
aXQgb24geW91ciBzZXR1cChzKT8gSWYgc28gdGhlbiB0aGUKPj4gdGVzdCBpcyByZWR1bmRhbnQu
Cj4gVHJ1ZSBhYm91dCB0aGUgImRvbid0IGhpdCBpdCBwYXJ0IiwgYXQgbGVhc3Qgd2l0aCB0aGUg
c2V0dXAsIGJ1dCBJCj4gZ3Vlc3MgdGhlIHJlYXNvbiBmb3IgYSByZWdyZXNzaW9uIHRlc3QsCj4g
aXMgdG8gcHJldmVudCByZWdyZXNzaW9ucy4gVGhpcyB3YXMgY2xlYXJseSBhIGJ1ZyBpbiB0aGUg
a2VybmVsIGFuZAo+IG5vdCBvbmx5IGFuIGluY29udmVuaWVuY2UuIEFuZCBzaW5jZQo+IHRoZXJl
wqAgaXMgbm90ICJ0aGUgb25lIGtlcm5lbCBzb3VyY2UiLCBJIHRoaW5rIGl0IGlzIGltcG9ydGFu
dCB0byBydW4KPiB0ZXN0cyBsaWtlIHRoaXMgZm9yIGFzIG1hbnkgZGlmZmVyZW50Cj4ga2VybmVs
cyBhcyBwb3NzaWJsZS4gQXBhcnQgZnJvbSB0aGUgYWxyZWFkeSBzZXR1cCBjZ3JvdXBzLCB0aGVy
ZSBtYXkKPiBiZSBvdGhlciB1c2VzIG9mIGNncm91cHMgYXMgd2VsbCwKPiB0aGF0IHRyeSB0byBz
ZXQgdGhlbSB1cCB0aGUgb3RoZXIgd2F5IGFyb3VuZCAoZmlyc3QgZXhjbHVzaXZlLCB0aGVuIGNw
dXMpLgo+Pgo+Pj4gVGhlIG9ubHkgd2F5IEkgY291bGQgdGhpbmsgb2YgYSBwcm9jZXNzIG1pc2Jl
aGF2aW5nIGJ5IGRpc2FiZWxpbmcgY3B1IHBpbm5pbmcsCj4+PiB3b3VsZCBiZSBhIGJhZGx5IHdy
aXR0ZW4gbXVsdGl0aHJlYWQgYXBwbGljYXRpb24sIHRoYXQgY2Fubm90IGNvcnJlY3RseSBydW4s
Cj4+PiBpZiB0aHJlYWRzIGFyZSByZWFsbHkgcnVubmluZyBpbiBwYXJhbGxlbCwgYnV0IHRoaXMg
d291bGQgYWxzbyByZXF1aXJlIGEgc2NoZWR1bGluZwo+Pj4gcG9saWN5LCB0aGF0IG1ha2VzIHNj
aGVkdWxpbmcgcG9pbnRzIHByZWRpY2F0YWJsZS4gV2hpbGUgSSBrbm93IHRoYXQgc29mdHdhcmUg
bGlrZQo+Pj4gdGhhdCBleGlzdHMgKGluIGZhY3QgSSB3YXMgd29ya2luZyBvbiBzb21ldGhpbmcg
bGlrZSB0aGF0IGluIHRoZSBwYXN0KSwgSSB0aGluayBpdAo+Pj4gaXMgaGlnaGx5IHVubGlrZWx5
LCB0aGF0IGl0IGlzIHJ1bm5pbmcgcGFyYWxsZWwgdG8gbHRwLgo+Pj4gQW5kIGV2ZW4gdGhlbiwg
dGhpcyBjb3VsZCBiZSBtaXRpZ2F0ZWQgYnkgbm90IGp1c3Qgc2V0dGluZyBjcHUgYmluZGluZyB0
byB1bmRlZmluZWQsCj4+PiBidXQgdG8gb25lIGZpeGVkIGNvcmUuIEJ1dCB3aXRoIHRoZSBjaGFu
Z2VzIGluIHBhdGNoIDIsIHRoaXMgaXMgbm90Cj4+PiBwb3NzaWJsZS4KPj4+Cj4+PiBCdXQgYW55
aG93IGx0cCBmaWRkbGVzIHdpdGggbG90cyBvZiBjcml0aWNhbCBzeXN0ZW0gcGFyYW1ldGVycyBk
dXJpbmcgaXQncyBydW50aW1lLAo+Pj4gdGhlcmUgaXMgbm8gZ3VhcmFudGVlLCB0aGF0IGFuIGFw
cGxpY2F0aW9uIHRoYXQgcmVxdWlyZXMgc29tZSB2ZXJ5IHNwZWNpZmljIGtlcm5lbAo+Pj4gcnVu
dGltZSBzZXR0aW5ncyBzdXJ2aXZlcyB0aGlzLiBUaGF0J3Mgd2h5IEkgd291bGQgc3RpbGwgdm90
ZSBmb3IgdGhpcyBwYXRjaC4KPj4+Cj4+PiBKw7ZyZwo+PiBJIHN0aWxsIHRoaW5rIGl0IGhhcyBh
IHNtYWxsIGNoYW5jZSBvZiBjYXVzaW5nIHByb2JsZW1zIGZvciB1cy4gVGhlcmUKPj4gYXJlIHNv
bWUgaGV0ZXJvZ2VuZW91cyBDUFUgc3lzdGVtcyB3aGVyZSBjb250cm9sIHNvZnR3YXJlIHNob3Vs
ZCBydW4gb24KPj4gYSBnaXZlbiBDUFUuIEkgZG9uJ3Qga25vdyB3aGV0aGVyIENHcm91cHMgYXJl
IHVzZWQgdG8gY29udHJvbCB0aGF0IG9yIGlmCj4+IGl0IHdvdWxkIG1hdHRlciBpZiB0aGUgcHJv
Y2VzcyBpcyBtb3ZlZCB0ZW1wb3JhcmlseS4gSXQncyBqdXN0IGEgc21hbGwKPj4gcmlzayBJIHdv
dWxkIGF2b2lkIGlmIHRoZSB0ZXN0IGlzIG5vdCByZWFsbHkgd29ydGggaXQuCj4gSSBnZXQgdGhh
dCwgYnV0IHRoZXNlIHN5c3RlbXMgbWF5IGhhdmUgdG8gb3B0LW91dCBvZiBzb21lIHRlc3RzIGFu
eXdheS4KPj4KPj4gT1RPSCB0aGUgcGF0Y2ggbG9va3MgZ29vZCBvdGhlcndpc2UsIHNvIGl0IHNo
b3VsZCBiZSBtZXJnZWQgaWYgbm8gb25lCj4+IGVsc2UgYWdyZWVzIHdpdGggbWUuCj4gT2ssIGxl
dHMgc2VlIHdoYXQgdGhlIG90aGVycyBoYXZlIHRvIHNheSA6KQo+Cj4gSsO2cmcKClNvIGEgZmV3
IG1vbnRocyBsYXRlciB0aGVyZSBhcmUgbm8gY29tbWVudHMuIFRoZSBwYXRjaC1zZXQgYXMgYSB3
aG9sZQpsb29rcyBhIGxpa2UgYW4gaW1wcm92ZW1lbnQuIFNvIGxldCdzIG1lcmdlIGl0LgoKCi0t
IApUaGFuayB5b3UsClJpY2hhcmQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
