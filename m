Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E65EC35FF3
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 06:42:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2E3F3CAECA
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 07:42:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B3CD3CAE66
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 07:41:55 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 863AB1000AEC
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 07:41:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 548D01F452;
 Fri, 21 Mar 2025 06:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742539313;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hc1cN8/Q/fq8LJ6wMklkkN/JfBBtntf953PWuPgMCc=;
 b=LrVdL8vK6x6hP02Yq4ukfu5JVAZIbIonIAjncBdLBcZAGypmVta6gNF0MenLMP4bNxrpN+
 XkzZI+aaDRjD/CLpURWYOoawe95ojBqdQrAwumKqmoKEbEyw57q9ko+PPJ7xEoU+hKWkGo
 RvgUeMGa5mhRwhK6hgQgBd1EptarY6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742539313;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hc1cN8/Q/fq8LJ6wMklkkN/JfBBtntf953PWuPgMCc=;
 b=F2+0qybRYYvFoVFXyBbT9fFFJyDA3IVE4kcwk/ZNnzqVafEL2l+Jhcri2cAJT7BOQO4F6x
 yR3p06DWWlw9XOBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742539313;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hc1cN8/Q/fq8LJ6wMklkkN/JfBBtntf953PWuPgMCc=;
 b=LrVdL8vK6x6hP02Yq4ukfu5JVAZIbIonIAjncBdLBcZAGypmVta6gNF0MenLMP4bNxrpN+
 XkzZI+aaDRjD/CLpURWYOoawe95ojBqdQrAwumKqmoKEbEyw57q9ko+PPJ7xEoU+hKWkGo
 RvgUeMGa5mhRwhK6hgQgBd1EptarY6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742539313;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hc1cN8/Q/fq8LJ6wMklkkN/JfBBtntf953PWuPgMCc=;
 b=F2+0qybRYYvFoVFXyBbT9fFFJyDA3IVE4kcwk/ZNnzqVafEL2l+Jhcri2cAJT7BOQO4F6x
 yR3p06DWWlw9XOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E69713A2C;
 Fri, 21 Mar 2025 06:41:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f7k7ATEK3WcbZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Mar 2025 06:41:53 +0000
Date: Fri, 21 Mar 2025 07:41:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250321064151.GA145712@pevik>
References: <20240612121106.11127-1-chrubis@suse.cz>
 <20240612121106.11127-2-chrubis@suse.cz>
 <20250320173141.GA114876@pevik>
 <CAEemH2d8OzjHVi7ZJD3ah=C+JpDFmGcRTj=4CzDZ950uNqBfmw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d8OzjHVi7ZJD3ah=C+JpDFmGcRTj=4CzDZ950uNqBfmw@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: tst_test: Add per filesystem mkfs and
 mount opts
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgo+IE9uIEZyaSwgTWFyIDIxLCAyMDI1IGF0IDE6MzHigK9BTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgQ3lyaWwsIGFsbCwKCj4gPiA+IFRoaXMgY29t
bWl0IGRvZXM6Cgo+ID4gPiAqIEdyb3VwIHRoZSBmaWxlc3lzdGVtIHR5cGUsIG1rZnMgYW5kIG1v
dW50IG9wdGlvbnMgaW50byBhIHNlcGFyYXRlCj4gPiA+ICAgc3RydWN0dXJlCgo+ID4gPiAqIEFk
ZCBhbiBhcnJheSBvZiB0aGVzZSBzdHJ1Y3R1cmVzIHRvIGJlIGFibGUgdG8gZGVmaW5lIHBlciBm
aWxlc3lzdGVtCj4gPiA+ICAgbWtmcyBhbmQgbW91bnQgb3B0aW9ucwoKPiA+ID4gVGhlIGRldGFp
bHMgb24gdGhlIHVzYWdlIHNob3VsZCBiZSBob3BlZnVsbHkgY2xlYXIgZnJvbSB0aGUKPiA+ID4g
ZG9jdW1lbnRhdGlvbiBjb21tZW50cyBmb3IgdGhlIHN0cnVjdCB0c3RfdGVzdC4KCj4gPiBGWUks
IHRoaXMgbWVyZ2VkIGFzIGNjZTYxODg5MTYgKCJsaWI6IHRzdF90ZXN0OiBBZGQgcGVyIGZpbGVz
eXN0ZW0gbWtmcyBhbmQKPiA+IG1vdW50IG9wdHMiKSBjYXVzZXMgdGhpcyBiZWhhdmlvciBvZiBu
b25lIHRlc3RpbmcgcnVuIHdoZW4gdGhlcmUgaXMgbm8KPiA+IHN1aXRhYmxlCj4gPiBmaWxlc3lz
dGVtLiBJIGZvdW5kIGl0IHdoZW4gdHJ5aW5nIHRvIGJpc2VjdCBzb21ldGhpbmcgd2l0aCByYXBp
ZG8tbGludXgKPiA+IGFuZAo+ID4gY29tcGlsZSBrZXJuZWwgd2l0aG91dCBCdHJmcyBhbmQgWEZT
LiBEb24ndCB3ZSB3YW50IHRvIGFkZCBzb21lIFRDT05GPwoKCj4gSSB0aGluayB3ZSBuZWVkIFRD
T05GIHRoZXJlLiBDYW4geW91IGNvbmZpcm0gYmVsb3cgY2hhbmdlIG1ha2VzIHNlbnNlPwoKVGhh
bmtzISBMR1RNICh1bnRlc3RlZCkuIENhbiB5b3UgcGxlYXNlIHNlbmQgYSBwYXRjaD8gKEknbGwg
dGVzdCBpdCkuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gLS0tIGEvbGliL3RzdF90ZXN0LmMKPiAr
KysgYi9saWIvdHN0X3Rlc3QuYwo+IEBAIC0xODU2LDYgKzE4NTYsNyBAQCBzdGF0aWMgaW50IHJ1
bl90Y2FzZXNfcGVyX2ZzKHZvaWQpCj4gICAgICAgICBpbnQgcmV0ID0gMDsKPiAgICAgICAgIHVu
c2lnbmVkIGludCBpOwo+ICAgICAgICAgY29uc3QgY2hhciAqY29uc3QgKmZpbGVzeXN0ZW1zID0K
PiB0c3RfZ2V0X3N1cHBvcnRlZF9mc190eXBlcyh0c3RfdGVzdC0+c2tpcF9maWxlc3lzdGVtcyk7
Cj4gKyAgICAgICBib29sIGZvdW5kX3ZhbGlkX2ZzID0gZmFsc2U7Cgo+ICAgICAgICAgaWYgKCFm
aWxlc3lzdGVtc1swXSkKPiAgICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgIlRoZXJlIGFy
ZSBubyBzdXBwb3J0ZWQgZmlsZXN5c3RlbXMiKTsKPiBAQCAtMTg2Niw2ICsxODY3LDcgQEAgc3Rh
dGljIGludCBydW5fdGNhc2VzX3Blcl9mcyh2b2lkKQo+ICAgICAgICAgICAgICAgICBpZiAoIWZz
KQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwoKPiArICAgICAgICAgICAgICAg
Zm91bmRfdmFsaWRfZnMgPSB0cnVlOwo+ICAgICAgICAgICAgICAgICByZXQgPSBydW5fdGNhc2Vf
b25fZnMoZnMsIGZpbGVzeXN0ZW1zW2ldKTsKCj4gICAgICAgICAgICAgICAgIGlmIChyZXQgPT0g
VENPTkYpCj4gQEAgLTE4NzcsNiArMTg3OSw5IEBAIHN0YXRpYyBpbnQgcnVuX3RjYXNlc19wZXJf
ZnModm9pZCkKPiAgICAgICAgICAgICAgICAgZG9fZXhpdChyZXQpOwo+ICAgICAgICAgfQoKPiAr
ICAgICAgIGlmICghZm91bmRfdmFsaWRfZnMpCj4gKyAgICAgICAgICAgICAgIHRzdF9icmsoVENP
TkYsICJObyByZXF1aXJlZCBmaWxlc3lzdGVtcyBhcmUgYXZhaWxhYmxlIik7Cj4gKwo+ICAgICAg
ICAgcmV0dXJuIHJldDsKPiAgfQoKCgoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gPiBp
b2N0bF9maWNsb25lMDMuYzoKPiA+ICAgICAgICAgLmZpbGVzeXN0ZW1zID0gKHN0cnVjdCB0c3Rf
ZnMgW10pIHsKPiA+ICAgICAgICAgICAgICAgICB7LnR5cGUgPSAiYnRyZnMifSwKPiA+ICAgICAg
ICAgICAgICAgICB7LnR5cGUgPSAiYmNhY2hlZnMifSwKPiA+ICAgICAgICAgICAgICAgICB7Cj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAudHlwZSA9ICJ4ZnMiLAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgLm1pbl9rdmVyID0gIjQuMTYiLAo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgLm1rZnNfdmVyID0gIm1rZnMueGZzID49IDEuNS4wIiwKPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIC5ta2ZzX29wdHMgPSAoY29uc3QgY2hhciAqY29uc3QgW10pIHsiLW0iLAo+ID4gInJl
Zmxpbms9MSIsIE5VTEx9LAo+ID4gICAgICAgICAgICAgICAgIH0sCj4gPiAgICAgICAgICAgICAg
ICAge30KPiA+ICAgICAgICAgfSwKCj4gPiByYXBpZG8xOi9vcHQvbHRwL3Rlc3RjYXNlcy9iaW4j
IC4vaW9jdGxfZmljbG9uZTAzOyBlY2hvICQ/Cj4gPiB0c3RfYnVmZmVycy5jOjU3OiBUSU5GTzog
VGVzdCBpcyB1c2luZyBndWFyZGVkIGJ1ZmZlcnMKPiA+IHRzdF90bXBkaXIuYzozMTc6IFRJTkZP
OiBVc2luZyAvdG1wL0xUUF9pb2NTS0xTOWwgYXMgdG1wZGlyICh0bXBmcwo+ID4gZmlsZXN5c3Rl
bSkKPiA+IHRzdF9kZXZpY2UuYzo5OTogVElORk86IEZvdW5kIGZyZWUgZGV2aWNlIDAgJy9kZXYv
bG9vcDAnCj4gPiB0c3RfdGVzdC5jOjE5MDA6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTAxMzAt
MTY2LWcxNzk2MGQ5NTIKPiA+IHRzdF90ZXN0LmM6MTkwNDogVElORk86IFRlc3RlZCBrZXJuZWw6
IDQuNS4wLTAwMDAyLWcyMmJkMzMyZjExZDQgIzE2MiBTTVAKPiA+IFRodSBNYXIgMjAgMTg6MDA6
MTAgQ0VUIDIwMjUgeDg2XzY0Cj4gPiB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBr
ZXJuZWwgY29uZmlnICcvLmNvbmZpZycKPiA+IHRzdF90ZXN0LmM6MTcyNDogVElORk86IE92ZXJh
bGwgdGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMXMKPiA+IHRzdF9zdXBwb3J0ZWRfZnNfdHlw
ZXMuYzo5NzogVElORk86IEtlcm5lbCBzdXBwb3J0cyBleHQyCj4gPiB0c3Rfc3VwcG9ydGVkX2Zz
X3R5cGVzLmM6NjI6IFRJTkZPOiBta2ZzLmV4dDIgZG9lcyBleGlzdAo+ID4gdHN0X3N1cHBvcnRl
ZF9mc190eXBlcy5jOjk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIGV4dDMKPiA+IHRzdF9zdXBw
b3J0ZWRfZnNfdHlwZXMuYzo2MjogVElORk86IG1rZnMuZXh0MyBkb2VzIGV4aXN0Cj4gPiB0c3Rf
c3VwcG9ydGVkX2ZzX3R5cGVzLmM6OTc6IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgZXh0NAo+ID4g
dHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjYyOiBUSU5GTzogbWtmcy5leHQ0IGRvZXMgZXhpc3QK
PiA+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzoxMDU6IFRJTkZPOiBTa2lwcGluZyBiY2FjaGVm
cyBiZWNhdXNlIG9mIEZVU0UKPiA+IGJsYWNrbGlzdAo+ID4gdHN0X3N1cHBvcnRlZF9mc190eXBl
cy5jOjk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIHZmYXQKPiA+IHRzdF9zdXBwb3J0ZWRfZnNf
dHlwZXMuYzo2MjogVElORk86IG1rZnMudmZhdCBkb2VzIGV4aXN0Cj4gPiB0c3Rfc3VwcG9ydGVk
X2ZzX3R5cGVzLmM6OTc6IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgdG1wZnMKPiA+IHRzdF9zdXBw
b3J0ZWRfZnNfdHlwZXMuYzo0OTogVElORk86IG1rZnMgaXMgbm90IG5lZWRlZCBmb3IgdG1wZnMK
Cj4gPiBTdW1tYXJ5Ogo+ID4gcGFzc2VkICAgMAo+ID4gZmFpbGVkICAgMAo+ID4gYnJva2VuICAg
MAo+ID4gc2tpcHBlZCAgMAo+ID4gd2FybmluZ3MgMAo+ID4gMAoKPiA+IHJhcGlkbzE6L29wdC9s
dHAvdGVzdGNhc2VzL2JpbiMgZ3JlcCAtZSBDT05GSUdfQlRSRlNfRlMgLWUgQ09ORklHX1hGU19G
Uwo+ID4gLy5jb25maWcKPiA+ICsgZ3JlcCAtZSBDT05GSUdfQlRSRlNfRlMgLWUgQ09ORklHX1hG
U19GUyAvLmNvbmZpZwo+ID4gIyBDT05GSUdfWEZTX0ZTIGlzIG5vdCBzZXQKPiA+ICMgQ09ORklH
X0JUUkZTX0ZTIGlzIG5vdCBzZXQKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
