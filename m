Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56443C3ABCC
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 13:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747141366; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/+tf0+4arWtd6I4vrbZaZ1YzGqiZyB4VNEhb1CQLc3U=;
 b=K7WTGUdNyABzrwkbr1kFIaXpF207wypj8McVlDtot5nc9vqKglMVxDdijPenjC/2YB1vr
 QHlYmXF5LaUlon1YOrSUPKVPIIDUH9dbxTMZxz9fxYsaQlHIg7D6j09wFdnzLeRirdJG8HM
 5W5JAvs96zpDJ84PB8pcNoBb+zBZpXw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D18363CC32D
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 15:02:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FE473CB54D
 for <ltp@lists.linux.it>; Tue, 13 May 2025 15:02:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B38FD1400764
 for <ltp@lists.linux.it>; Tue, 13 May 2025 15:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747141341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBPYwQAUXbHZ7v6b/eH9rZ1XmtrkWARuciLy1fqhqx8=;
 b=RS4pJXJdl3IUCiUeg75s7ruiuelsGvSdjWN/UcBvhpRYNqqsH1vPOAU7xl9Nne1Lv+cLZ6
 HSSd44t1vZxoo+2Qi3GzfRRTMduumqAo9rWtpJkELrZndja+INzMfbQjG32VlnMQ7L4Twz
 YJWGjPdPrMWVzXomZ4YxJWrg6/KAJYc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-sFMRuJ_jOISDzRaQtHUW4Q-1; Tue, 13 May 2025 09:02:20 -0400
X-MC-Unique: sFMRuJ_jOISDzRaQtHUW4Q-1
X-Mimecast-MFC-AGG-ID: sFMRuJ_jOISDzRaQtHUW4Q_1747141339
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22e50d4f49bso84805395ad.1
 for <ltp@lists.linux.it>; Tue, 13 May 2025 06:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747141339; x=1747746139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBPYwQAUXbHZ7v6b/eH9rZ1XmtrkWARuciLy1fqhqx8=;
 b=wOfsdB7Vr54EN/8aBhOh10RGo56t380tDQmhP3EECCFt0T6qgNb+wdAhew2RqeiSPl
 9F2Yzuw3THqAC5Re53KuAR5tYV4tJINNPXO40AUN0FqxBIuI7P8gYohsI67Nghw0UPSv
 1QV/yH16O63foyx2StpN2YzR8vMet3SGJlNi5TOn3pLgILrms/Yb+sA1gN7cYGkP4iYH
 EeppVUGBJG7h9YMcNcFq/9lKN6nQrVSCjv/UXOsNnF7+e1ALjJCcPSWvzxGoLxkk+NSe
 5et7FGud+FdL7PIasEqMM2sD3pXNRomfZjTM/r217RPKv8xgT8NMo+kLPYmaG3dRQ2cp
 ls0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdBzFkzAcuJ9AAj4tjWgomjw1c5JxU4Yw1mjNYzWf5Lur46/kAvJdiRp9CFjPdY3j3+Uw=@lists.linux.it
X-Gm-Message-State: AOJu0YxPKbktAzFoKWIk5h+IH5F4CrSNC06xRpuY1xua4Br5/+Wqalsc
 zGFspcO6oaaFHdEvJD1QSUaZSEJojcUZic1h+o1a/8jLZVsb/eb7H8BxOSj/FmwJgjqCS3UMETK
 Hj7qKx9vkKVJpT1WhA7InCtxdYnr30E3LWUFWNMZmpNxmgQo4+keLONRF3lCdXWZJcRRKP+nxA0
 UEQUMp5yz0I9Qpb475w7aXaBk=
X-Gm-Gg: ASbGnctqNuZuig6UVgVQM98h4d/kVgtbhBLjg56TKvXX4F4HbYiVOOxg7NXfxpDtDkP
 OAVlrSptZFc6dEELyhLLbZzGyrumtzF3yVekIfNbarLh+cQN0DAA1WbYEmAHIJtk47eoOYw==
X-Received: by 2002:a17:902:da2d:b0:215:a179:14ca with SMTP id
 d9443c01a7336-22fc8b0023cmr203483615ad.2.1747141338562; 
 Tue, 13 May 2025 06:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSL3+IsOAIWkzaUmWRdsAqrOJC5hABQq02Qap3VMZtCHz7I9ed9hTeVeGMvyE7C4eKplGywLaww3Eqrnf9D9A=
X-Received: by 2002:a17:902:da2d:b0:215:a179:14ca with SMTP id
 d9443c01a7336-22fc8b0023cmr203482895ad.2.1747141337907; Tue, 13 May 2025
 06:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250513050530.47541-1-liwang@redhat.com>
 <aCM2PrCrCdPqNIGc@yuki.lan> <20250513125148.GA244619@pevik>
In-Reply-To: <20250513125148.GA244619@pevik>
Date: Tue, 13 May 2025 21:02:05 +0800
X-Gm-Features: AX0GCFs3KRirOBVF9oP7bQbAkHfBJ550tkUPN1n3w2WsR1CwXxP-JcEoQG3JF78
Message-ID: <CAEemH2dng7ZaxVgYUFLcqy0aamgFstoCogdOKkA2+DPJWctpig@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ktdhci_SlTi2tOaWtNaN-rdxLT1J-MUhphClgZUDGJw_1747141339
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: initialize lib|main_pid to zero in the
 setup_ipc
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMTMsIDIwMjUgYXQgODo1MuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIGFsbCwKPgo+IC4uLgo+ID4gPiArKysgYi9saWIvdHN0X3Rlc3Qu
Ywo+ID4gPiBAQCAtNTksNyArNTksNiBAQCBzdGF0aWMgY29uc3QgY2hhciAqdGlkOwo+ID4gPiAg
c3RhdGljIGludCBpdGVyYXRpb25zID0gMTsKPiA+ID4gIHN0YXRpYyBmbG9hdCBkdXJhdGlvbiA9
IC0xOwo+ID4gPiAgc3RhdGljIGZsb2F0IHRpbWVvdXRfbXVsID0gLTE7Cj4gPiA+IC1zdGF0aWMg
cGlkX3QgbGliX3BpZDsKPiA+ID4gIHN0YXRpYyBpbnQgbW50cG9pbnRfbW91bnRlZDsKPiA+ID4g
IHN0YXRpYyBpbnQgb3ZsX21vdW50ZWQ7Cj4gPiA+ICBzdGF0aWMgc3RydWN0IHRpbWVzcGVjIHRz
dF9zdGFydF90aW1lOyAvKiB2YWxpZCBvbmx5IGZvciB0ZXN0IHBpZCAqLwo+ID4gPiBAQCAtMTQz
LDcgKzE0Miw5IEBAIHN0YXRpYyB2b2lkIHNldHVwX2lwYyh2b2lkKQo+ID4gPiAgICAgICAgICAg
ICB0c3RfZnV0ZXhlcyA9IChjaGFyICopcmVzdWx0cyArIHNpemVvZihzdHJ1Y3QgcmVzdWx0cyk7
Cj4gPiA+ICAgICAgICAgICAgIHRzdF9tYXhfZnV0ZXhlcyA9IChzaXplIC0gc2l6ZW9mKHN0cnVj
dCByZXN1bHRzKSkvc2l6ZW9mKGZ1dGV4X3QpOwo+ID4gPiAgICAgfQo+ID4gPiAtICAgcmVzdWx0
cy0+bGliX3BpZCA9IGxpYl9waWQ7Cj4gPiA+ICsKPiA+ID4gKyAgIHJlc3VsdHMtPmxpYl9waWQg
PSAwOwo+ID4gPiArICAgcmVzdWx0cy0+bWFpbl9waWQgPSAwOwo+Cj4gbml0OiBJcyBpdCByZWFs
bHkgbmVlZGVkIHRvIGludCB0aGVtIHRvIDA/IEJlY2F1c2UgdGhleSBzaG91bGQgYmUgMCBkdWUg
dGhlCj4gZGVmYXVsdCBzdHJ1Y3QgdmFsdWUsIHJpZ2h0PwoKUmlnaHQhCgpJIHRoaW5rIHdlIG5l
ZWQgdG8gaW5pdGlhbGl6ZSB0aGVtLCBiZWNhdXNlIHRoZSB0ZXN0IG1heSBmYWlsL2JyZWFrCmp1
c3QgYmVmb3JlIGNyZWF0aW5nIG1haW5fcGlkLCB0aGVuIHRlc3QgY2xlYW51cCB3b3JrIG5lZWRz
IHRvCmludm9rZSB0c3RfdmJya18gYW5kIHRzdF9yZXNfIHNvbWV3aGVyZSB0aGF0IGNvbXBhcmVz
IHBpZCB0bwppbnZva2UgdGhlIGNvcnJlc3BvbmRpbmcgY2xlYW51cCB3b3JrLgoKPgo+ID4gPiAg
fQo+Cj4gPiA+ICBzdGF0aWMgdm9pZCBjbGVhbnVwX2lwYyh2b2lkKQo+ID4gPiBAQCAtMzk0LDcg
KzM5NSw3IEBAIHZvaWQgdHN0X3ZicmtfKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5l
bm8sIGludCB0dHlwZSwgY29uc3QgY2hhciAqZm10LAo+ID4gPiAgICAgICogSWYgdHN0X2Jyaygp
IGlzIGNhbGxlZCBmcm9tIHNvbWUgb2YgdGhlIEMgaGVscGVycyBldmVuIGJlZm9yZSB0aGUKPiA+
ID4gICAgICAqIGxpYnJhcnkgd2FzIGluaXRpYWxpemVkLCBqdXN0IGV4aXQuCj4gPiA+ICAgICAg
Ki8KPiA+ID4gLSAgIGlmICghcmVzdWx0cy0+bGliX3BpZCkKPiA+ID4gKyAgIGlmICghcmVzdWx0
cyB8fCAhcmVzdWx0cy0+bGliX3BpZCkKPiA+ID4gICAgICAgICAgICAgZXhpdChUVFlQRV9SRVNV
TFQodHR5cGUpKTsKPgo+ID4gPiAgICAgdXBkYXRlX3Jlc3VsdHMoVFRZUEVfUkVTVUxUKHR0eXBl
KSk7Cj4gPiA+IEBAIC0xMzM0LDYgKzEzMzUsOCBAQCBzdGF0aWMgdm9pZCBkb19zZXR1cChpbnQg
YXJnYywgY2hhciAqYXJndltdKQo+ID4gPiAgICAgICAgICAgICB0c3RfdGVzdC0+Zm9ya3NfY2hp
bGQgPSAxOwo+ID4gPiAgICAgfQo+Cj4gPiA+ICsgICBzZXR1cF9pcGMoKTsKPiA+ID4gKwo+ID4g
PiAgICAgaWYgKHRzdF90ZXN0LT5uZWVkc19rY29uZmlncyAmJiB0c3Rfa2NvbmZpZ19jaGVjayh0
c3RfdGVzdC0+bmVlZHNfa2NvbmZpZ3MpKQo+ID4gPiAgICAgICAgICAgICB0c3RfYnJrKFRDT05G
LCAiQWJvcnRpbmcgZHVlIHRvIHVuc3VpdGFibGUga2VybmVsIGNvbmZpZywgc2VlIGFib3ZlISIp
Owo+Cj4gPiA+IEBAIC0xMzkzLDggKzEzOTYsNiBAQCBzdGF0aWMgdm9pZCBkb19zZXR1cChpbnQg
YXJnYywgY2hhciAqYXJndltdKQo+ID4gPiAgICAgaWYgKHRzdF90ZXN0LT5odWdlcGFnZXMubnVt
YmVyKQo+ID4gPiAgICAgICAgICAgICB0c3RfcmVzZXJ2ZV9odWdlcGFnZXMoJnRzdF90ZXN0LT5o
dWdlcGFnZXMpOwo+Cj4gPiA+IC0gICBzZXR1cF9pcGMoKTsKPiA+ID4gLQo+Cj4gPiBJIHN1cHBv
c2UgdGhhdCB0aGlzIGhhcyB0byBnbyBiZWZvcmUgdGhlIHRzdF9yZXNlcnZlX2h1Z2VwYWdlcygp
IHNvIHRoYXQKPiA+IHdlIGhhdmUgcmVzdWx0cy0+bGliX3BpZCBkZWZpbmVkIGFuZCBwcm9wZXJs
eSBjbGVhbiB1cCBhZnRlciB0aGUKPiA+IGh1Z2VwYWdlcy4KPgo+IFdoeT8gSXMgdGhhdCBkdWUg
cG9zc2libGUgdHN0X2JyaygpIGNhbGxzIGluIHRzdF9yZXNlcnZlX2h1Z2VwYWdlcygpPwo+IChX
aGljaCB1c2VzIFNBRkVfKiBtYWNyb3MuKSBUaGF0IHdvdWxkIHRyaWdnZXIgQmVjYXVzZSB0aGVy
ZSBhcmUgdHN0X2JyaygpIGNhbGxzIGJlZm9yZS4KPgo+IEFsc28gd2h5IG5vdCBhc3NpZ24gcmVz
dWx0cy0+bGliX3BpZCA9IGdldHBpZCgpIGF0IHRoZSBiZWdpbm5pbmcgb2YKPiB0c3RfcnVuX3Rj
YXNlcygpID8KCk5vLCB3ZSBjYW4ndC4KCkJlY2F1c2Ugd2UgbW92ZWQgdGhlIGxpYl9waWQgaW4g
dGhlIElQQyByZWdpb24sIHdoaWNoIGFsbG9jYXRlZCBtZW1vcnkKaW4gdGhlIHNldHVwX2lwYygp
IGZ1bmN0aW9uLgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiA+IEhvd2V2ZXIgZm9yIHRo
YXQgdG8gd29yayB3ZSBoYXZlIHRvIHNldCB0aGUKPiA+IHJlc3VsdHMtPmxpYl9waWQgZGlyZWN0
bHkgaW4gdGhlIHNldHVwX2lwYygpLgo+Cj4gPiA+ICAgICBpZiAodHN0X3Rlc3QtPmJ1ZnMpCj4g
PiA+ICAgICAgICAgICAgIHRzdF9idWZmZXJzX2FsbG9jKHRzdF90ZXN0LT5idWZzKTsKPgo+ID4g
PiBAQCAtMTkyOSwxMCArMTkzMCwxMSBAQCB2b2lkIHRzdF9ydW5fdGNhc2VzKGludCBhcmdjLCBj
aGFyICphcmd2W10sIHN0cnVjdCB0c3RfdGVzdCAqc2VsZikKPiA+ID4gICAgIHVuc2lnbmVkIGlu
dCB0ZXN0X3ZhcmlhbnRzID0gMTsKPiA+ID4gICAgIHN0cnVjdCB1dHNuYW1lIHV2YWw7Cj4KPiA+
ID4gLSAgIGxpYl9waWQgPSBnZXRwaWQoKTsKPiA+ID4gICAgIHRzdF90ZXN0ID0gc2VsZjsKPgo+
ID4gPiAgICAgZG9fc2V0dXAoYXJnYywgYXJndik7Cj4gPiA+ICsKPiA+ID4gKyAgIHJlc3VsdHMt
PmxpYl9waWQgPSBnZXRwaWQoKTsKPgo+ID4gU2V0dGluZyBpdCBoZXJlIGlzIHRvbyBsYXRlLgo+
Cj4gPiBPdGhlciB0aGFuIHRoYXQgdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuCj4KCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
