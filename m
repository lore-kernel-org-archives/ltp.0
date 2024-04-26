Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976C4C4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 02:32:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D6363CFED2
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 04:32:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F4E33CFFD5
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 04:32:29 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7839510009F4
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 04:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714098746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdxWoPH55GSbeTOKnXgsCmeATBMz/QtYOWNQOBUfvVw=;
 b=LUoW9OXPmz2ltY0qL/eIi1Cz+u996vSc/Na08+Kv7EeNnQmZJdJBxamsxHhloT+fHbwDrM
 2wb6pBpeJp7T0AZpqjA6++kODzaNSmWgcaj+H6z7X4YnIIosABuUkq15tJZgZU8wgNJQl3
 Hz8tkQ7VUFAHCbBhSiY3DmNKhxtZzTA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-rDfqSAaRM6CJDhvddiApsQ-1; Thu, 25 Apr 2024 22:32:24 -0400
X-MC-Unique: rDfqSAaRM6CJDhvddiApsQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a537ab9d7eso1807903a91.1
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 19:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714098743; x=1714703543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdxWoPH55GSbeTOKnXgsCmeATBMz/QtYOWNQOBUfvVw=;
 b=DURcOsJzWnAm1Uo/PAtCyUwrOXoOwhkVkoWMA+6aYCtS4lXQa6lDi3CFM42FmsDFc0
 gcTf+lsH7LIigWENHnzTZaivVMo/OX3owni2tkjy8eFr6ahUW52Cfb8Tnx6l2dIkAkv6
 v/R4zHNzi3sR2Af9vguvZxxDMu9qA8r49TYrqGY1C3jbfBFEU2+LEXUgAvMN1N4wQEke
 c+pWYGRK2jFSKexuhe90NMMy8jPXPuUowpzU3Y5atA7RcfVUzBCU4WahqOGvlhCUJU3p
 gPqimU/wEVxQaYrKYIsiMC9AWPy8sBZzqGFncwH8vM51ghEkR+wYyFom+DhCM+vMt0m7
 xeDw==
X-Gm-Message-State: AOJu0YxqUNCo3uSoj6I1lw3tfF0DQ3oMDkIJCpUT9ynENid76dejzK5g
 F7LNce1TFliIJRdBO5KaobSqFMQh4vGZoeq+cbdKO8ma77MUNI2ZYQu98UlJpeU6xHcckgoMTGl
 efWnc9u5DAC1jknEEnzZUL7Wa8LL48OTVhoXUFEmLxsHzHh/18qrGcWOpkEVpzsrckhOVJEwwGA
 QHYgY5DxM124oPNfw6MRyUfEQ=
X-Received: by 2002:a17:90b:3a91:b0:2ad:de9f:f4b2 with SMTP id
 om17-20020a17090b3a9100b002adde9ff4b2mr1325423pjb.32.1714098743049; 
 Thu, 25 Apr 2024 19:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH48zcfcPP/VPa3bHkyy3cI+EdpxFH05lfwCtQAc+Qdq2T+lPwgu1pKdAx/LOFrunOM/yr+bdFDnzPgN2DH5lU=
X-Received: by 2002:a17:90b:3a91:b0:2ad:de9f:f4b2 with SMTP id
 om17-20020a17090b3a9100b002adde9ff4b2mr1325413pjb.32.1714098742756; Thu, 25
 Apr 2024 19:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240425211042.299714-1-pvorel@suse.cz>
 <20240425211042.299714-3-pvorel@suse.cz>
In-Reply-To: <20240425211042.299714-3-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Apr 2024 10:32:10 +0800
Message-ID: <CAEemH2fnaMv-NTvS6dEp5COuLoSwuRw6uR_AjjnELZTDmNkKtw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/2] libswap: Use {SAFE_,
 }MAKE_MINIMAL_SWAPFILE()
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

T24gRnJpLCBBcHIgMjYsIDIwMjQgYXQgNToxMeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gVGhpcyBlZmZlY3RpdmVseSBpbmNyZWFzZXMgdGhlIG1pbmltYWwgdXNl
ZCBudW1iZXIgb2YgYmxvY2tzIHRvIDI1Ni4KPgo+IEFsbCB7U0FGRV8sfU1BS0VfU1dBUEZJTEVf
U0laRSgpIGNhbGxzIHdoaWNoIHdlcmUgY3JlYXRpbmcgc3dhcCB1c2VkIDEwCj4gYmxvY2tzLiBX
aGlsZSB0aGlzIGlzIG9rIG9uIDRrYiBwYWdlIHNpemUsIGl0J3MgdG9vIGxvdyBvbiBzeXN0ZW1z
IHdpdGgKPiA2NGtiIHBhZ2Ugc2l6ZSAoZS5nLiBvbiBhYXJjaDY0IHdpdGggQ09ORklHX0FSTTY0
XzY0S19QQUdFUz15IG9yIG9uCj4gcHBjNjRsZSB3aXRoIENPTkZJR19QQUdFX1NJWkVfNjRLQj15
KToKPgo+ICAgICBUV0FSTjogU3dhcGZpbGUgc2l6ZSBpcyBsZXNzIHRoYW4gdGhlIHN5c3RlbSBw
YWdlIHNpemUuIFVzaW5nIHBhZ2Ugc2l6ZQo+ICAgICAoNjU1MzYgYnl0ZXMpIGluc3RlYWQgb2Yg
YmxvY2sgc2l6ZSAoNDA5NiBieXRlcykuCj4KPiBPYnZpb3VzbHkgaXQgd291bGQgZmFpbCBhbHNv
IG9uIGtlcm5lbHMgd2l0aCBDT05GSUdfUEFHRV9TSVpFXzI1NktCLgo+Cj4gUmV2aWV3ZWQtYnk6
IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6Pgo+CgogUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRo
YXQuY29tPgoKCj4gLS0tCj4gIGxpYnMvbGlibHRwc3dhcC9saWJzd2FwLmMgICAgICAgICAgICAg
ICAgICAgICB8IDIgKy0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb2ZmL3N3YXBv
ZmYwMi5jIHwgMiArLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24w
Mi5jICAgfCA0ICsrLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9u
MDMuYyAgIHwgNCArKy0tCj4gIDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2xpYnMvbGlibHRwc3dhcC9saWJzd2FwLmMgYi9s
aWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jCj4gaW5kZXggYWVkNzZkZmUyLi5lYjA2NmRmNzEgMTAw
NjQ0Cj4gLS0tIGEvbGlicy9saWJsdHBzd2FwL2xpYnN3YXAuYwo+ICsrKyBiL2xpYnMvbGlibHRw
c3dhcC9saWJzd2FwLmMKPiBAQCAtMTkyLDcgKzE5Miw3IEBAIGludCBtYWtlX3N3YXBmaWxlKGNv
bnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4gIGJvb2wgaXNfc3dhcF9zdXBwb3J0
ZWQoY29uc3QgY2hhciAqZmlsZW5hbWUpCj4gIHsKPiAgICAgICAgIGludCBpLCBzd19zdXBwb3J0
ID0gMDsKPiAtICAgICAgIGludCByZXQgPSBTQUZFX01BS0VfU1dBUEZJTEVfQkxLUyhmaWxlbmFt
ZSwgMTApOwo+ICsgICAgICAgaW50IHJldCA9IFNBRkVfTUFLRV9TTUFMTF9TV0FQRklMRShmaWxl
bmFtZSk7Cj4gICAgICAgICBpbnQgZmlfY29udGlndW91cyA9IGZpbGVfaXNfY29udGlndW91cyhm
aWxlbmFtZSk7Cj4gICAgICAgICBsb25nIGZzX3R5cGUgPSB0c3RfZnNfdHlwZShmaWxlbmFtZSk7
Cj4gICAgICAgICBjb25zdCBjaGFyICpmc3R5cGUgPSB0c3RfZnNfdHlwZV9uYW1lKGZzX3R5cGUp
Owo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvZmYvc3dhcG9m
ZjAyLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDIuYwo+
IGluZGV4IDVhMTU4MjZlNC4uMGFiODMzOGM1IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDIuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDIuYwo+IEBAIC04Nyw3ICs4Nyw3IEBAIHN0YXRpYyB2
b2lkIHNldHVwKHZvaWQpCj4gICAgICAgICBub2JvZHlfdWlkID0gbm9ib2R5LT5wd191aWQ7Cj4K
PiAgICAgICAgIGlzX3N3YXBfc3VwcG9ydGVkKFRFU1RfRklMRSk7Cj4gLSAgICAgICBTQUZFX01B
S0VfU1dBUEZJTEVfQkxLUyhTV0FQX0ZJTEUsIDEwKTsKPiArICAgICAgIFNBRkVfTUFLRV9TTUFM
TF9TV0FQRklMRShTV0FQX0ZJTEUpOwo+ICB9Cj4KPiAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0
ZXN0ID0gewo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9z
d2Fwb24wMi5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMi5j
Cj4gaW5kZXggZTVlMjliOGU3Li41NDc5NmJkY2MgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDIuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAyLmMKPiBAQCAtNTAsOCArNTAsOCBAQCBzdGF0aWMgdm9p
ZCBzZXR1cCh2b2lkKQo+ICAgICAgICAgaXNfc3dhcF9zdXBwb3J0ZWQoVEVTVF9GSUxFKTsKPgo+
ICAgICAgICAgU0FGRV9UT1VDSChOT1RTV0FQX0ZJTEUsIDA3NzcsIE5VTEwpOwo+IC0gICAgICAg
TUFLRV9TV0FQRklMRV9CTEtTKFNXQVBfRklMRSwgMTApOwo+IC0gICAgICAgTUFLRV9TV0FQRklM
RV9CTEtTKFVTRURfRklMRSwgMTApOwo+ICsgICAgICAgTUFLRV9TTUFMTF9TV0FQRklMRShTV0FQ
X0ZJTEUpOwo+ICsgICAgICAgTUFLRV9TTUFMTF9TV0FQRklMRShVU0VEX0ZJTEUpOwo+Cj4gICAg
ICAgICBpZiAodHN0X3N5c2NhbGwoX19OUl9zd2Fwb24sIFVTRURfRklMRSwgMCkpCj4gICAgICAg
ICAgICAgICAgIHRzdF9yZXMoVFdBUk4gfCBURVJSTk8sICJzd2Fwb24oYWxyZWFkeXVzZWQpIGZh
aWxlZCIpOwo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9z
d2Fwb24wMy5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMy5j
Cj4gaW5kZXggNTI5NWE2YTczLi5lY2NlMjhiZGMgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDMuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAzLmMKPiBAQCAtNDksNyArNDksNyBAQCBzdGF0aWMgaW50
IHNldHVwX3N3YXAodm9pZCkKPgo+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIENyZWF0ZSB0
aGUgc3dhcGZpbGUgKi8KPiAgICAgICAgICAgICAgICAgICAgICAgICBzbnByaW50ZihmaWxlbmFt
ZSwgc2l6ZW9mKGZpbGVuYW1lKSwgIiVzJTAyZCIsCj4gVEVTVF9GSUxFLCBqICsgMik7Cj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgTUFLRV9TV0FQRklMRV9CTEtTKGZpbGVuYW1lLCAxMCk7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgTUFLRV9TTUFMTF9TV0FQRklMRShmaWxlbmFtZSk7Cj4K
PiAgICAgICAgICAgICAgICAgICAgICAgICAvKiB0dXJuIG9uIHRoZSBzd2FwIGZpbGUgKi8KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBUU1RfRVhQX1BBU1NfU0lMRU5UKHN3YXBvbihmaWxlbmFt
ZSwgMCkpOwo+IEBAIC02Miw3ICs2Miw3IEBAIHN0YXRpYyBpbnQgc2V0dXBfc3dhcCh2b2lkKQo+
ICAgICAgICAgICAgICAgICB0c3RfYnJrKFRGQUlMLCAiRmFpbGVkIHRvIHNldHVwIHN3YXAgZmls
ZXMiKTsKPgo+ICAgICAgICAgdHN0X3JlcyhUSU5GTywgIlN1Y2Nlc3NmdWxseSBjcmVhdGVkICVk
IHN3YXAgZmlsZXMiLCBzd2FwZmlsZXMpOwo+IC0gICAgICAgTUFLRV9TV0FQRklMRV9CTEtTKFRF
U1RfRklMRSwgMTApOwo+ICsgICAgICAgTUFLRV9TTUFMTF9TV0FQRklMRShURVNUX0ZJTEUpOwo+
Cj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+IC0tCj4gMi40My4wCj4KPgoKLS0gClJlZ2FyZHMs
CkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
