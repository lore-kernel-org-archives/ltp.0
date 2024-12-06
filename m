Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEB1E77173
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 09:27:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B2563E6173
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 10:27:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9473E5DED
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 10:27:23 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5BCCA140BE6B
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 10:27:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733477240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZxQC0V6QjcoB1yg9mge76D2TEM+VfiZL6llIC9pfWU=;
 b=OUlZozn+De2g57Lv0p5sUdf7TCAATOfSKBjUDz/OAOFZKq094YIhBOC10qbWVJ21aq1FPy
 +ASBb8dZANF8M4JSB0Odda+oTPbf1feKercWPOsIz0wnvbz8baJARyY6hz2/qlmddtFMZ6
 44rucpVp+Za7NjPa27TQfrmIEfXdZRU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-S-4QQTZTNeuZNpDeYfQ6UA-1; Fri, 06 Dec 2024 04:27:18 -0500
X-MC-Unique: S-4QQTZTNeuZNpDeYfQ6UA-1
X-Mimecast-MFC-AGG-ID: S-4QQTZTNeuZNpDeYfQ6UA
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ee4866c419so3084709a91.0
 for <ltp@lists.linux.it>; Fri, 06 Dec 2024 01:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733477237; x=1734082037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gZxQC0V6QjcoB1yg9mge76D2TEM+VfiZL6llIC9pfWU=;
 b=fZN4Vg4X/G0aENKK0t9hXVWaDiwVNHBNP9F+ivDwRtJ2cHPGiEAH+2bPFPT+DH17Iq
 bTnCKix83IYkN53gR9oxbmuM7oseJ5gj0ydYMsC/qk2ETlXJ7761Rd6KGkVNEK3qSUZC
 Mo/xREUSC+OKa5WHZL7wD5VvdCPYxsLYPb3haPljb3wbZz1q96us1SJ4v/vJ40gkfWRX
 Z9e0WyptErJ/yHfzLcs+TFvp6ZvAwB9ZGOi+G8QLLSSw5ClZmjUcfvh0Iyv3Aj6nGdSx
 FX4FFOZ1yS5NnzWr9WKxCvS8+XDcgrT6gMllPzjTrDjlJN8HuttJosTDwql05vOlOA2G
 CM6w==
X-Gm-Message-State: AOJu0Yxzb3rB6C6gdn5IrjhdibN6srUMHFF70SbxqaWnJAb5LkcjrruK
 2n2wtbkw+ERuVlBMBJKECEHbjWJvzO6N2UwuSTxvtJ+GPCkysZRzAjjK1VG2/vEW4q75c0fIAJO
 esHCcFByaPu1wStWCh8A1v5WPKjMx16bqaeiL8uMqqkhMPHkCfJeHpOrUWC81qNBczL4vgLADWN
 kn3EmtQ7dj9u00AGEsvrw4ZFg=
X-Gm-Gg: ASbGncsUn9rUeIbczOkgRulbtvKJp/43dvdcwVN8qiXXxQyd0S7k3AhxrzBUplwkK0z
 aCioVLdc2/Q/wu8uvoPOeYvboxkaU1qnJ
X-Received: by 2002:a17:90b:5207:b0:2ee:b26c:1099 with SMTP id
 98e67ed59e1d1-2ef6ab06b5amr3455723a91.34.1733477237012; 
 Fri, 06 Dec 2024 01:27:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSeIPzRytbzEeSaTWmj3nMhSU/riAM3cAUwrc5lLgZXjn7fgU2uTDu5huyPXx3R961g4l0mpgZv1rFdbDeJTc=
X-Received: by 2002:a17:90b:5207:b0:2ee:b26c:1099 with SMTP id
 98e67ed59e1d1-2ef6ab06b5amr3455694a91.34.1733477236608; Fri, 06 Dec 2024
 01:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20241127121233.14638-1-liwang@redhat.com>
 <Z073Lvv3h7cexyQq@yuki.lan>
In-Reply-To: <Z073Lvv3h7cexyQq@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Dec 2024 17:27:04 +0800
Message-ID: <CAEemH2cLrLcrWq1Lf9nPTD_GL1gSuiE9+FrncDyViszxinuTaw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NgOJ_Hue0-hUT6Vee9KSlT__6JCzV1K2A0--n43YVRI_1733477237
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: add extra calibrated runtime to slow
 tests
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

T24gVHVlLCBEZWMgMywgMjAyNCBhdCA4OjE44oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+ICsvKgo+ID4gKyAqIExpc3Qgb2YgZGVidWcta2VybmVs
IGNvbmZpZyBvcHRpb25zIHRoYXQgbWF5IGRlZ3JhZGUgcGVyZm9ybWFuY2UKPiB3aGVuIGVuYWJs
ZWQuCj4gPiArICovCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCB0c3Rfa2NvbmZfZGVi
dWdfb3B0aW9uc1tdWzJdID0gewo+ID4gKyAgICAgeyJDT05GSUdfUFJPVkVfTE9DS0lORz15Iiwg
TlVMTH0sCj4gPiArICAgICB7IkNPTkZJR19MT0NLREVQPXkiLCBOVUxMfSwKPiA+ICsgICAgIHsi
Q09ORklHX0RFQlVHX1NQSU5MT0NLPXkiLCBOVUxMfSwKPiA+ICsgICAgIHsiQ09ORklHX0RFQlVH
X1JUX01VVEVYRVM9eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfREVCVUdfTVVURVhFUz15
IiwgTlVMTH0sCj4gPiArICAgICB7IkNPTkZJR19ERUJVR19QQUdFQUxMT0M9eSIsIE5VTEx9LAo+
ID4gKyAgICAgeyJDT05GSUdfS0FTQU49eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfU0xV
Ql9SQ1VfREVCVUc9eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfVFJBQ0VfSVJRRkxBR1M9
eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfTEFURU5DWVRPUD15IiwgTlVMTH0sCj4gPiAr
ICAgICB7IkNPTkZJR19ERUJVR19ORVQ9eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfRVhU
NF9ERUJVRz15IiwgTlVMTH0sCj4gPiArICAgICB7IkNPTkZJR19RVU9UQV9ERUJVRz15IiwgTlVM
TH0sCj4gPiArICAgICB7IkNPTkZJR19GQVVMVF9JTkpFQ1RJT049eSIsIE5VTEx9LAo+ID4gKyAg
ICAgeyJDT05GSUdfREVCVUdfT0JKRUNUUz15IiwgTlVMTH0sCj4gPiArICAgICB7TlVMTCwgTlVM
TH0KPiA+ICt9Owo+ID4gKwo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IHRzdF9rY29uZmlnX2RlYnVn
X21hdGNoZXModm9pZCkKPiA+ICt7Cj4gPiArICAgICBpbnQgaSwgbnVtID0gMTsKPiA+ICsKPiA+
ICsgICAgIGZvciAoaSA9IDA7IHRzdF9rY29uZl9kZWJ1Z19vcHRpb25zW2ldWzBdICE9IE5VTEw7
IGkrKykKPiA+ICsgICAgICAgICAgICAgbnVtICs9ICF0c3Rfa2NvbmZpZ19jaGVjayh0c3Rfa2Nv
bmZfZGVidWdfb3B0aW9uc1tpXSk7Cj4gPiArCj4gPiArICAgICByZXR1cm4gbnVtOwo+ID4gK30K
PiA+ICsKPiA+ICAjZW5kaWYgICAgICAgLyogVFNUX0tDT05GSUdfSF9fICovCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS90c3RfdGltZXIuaCBiL2luY2x1ZGUvdHN0X3RpbWVyLmgKPiA+IGluZGV4
IDZmYjk0MDAyMC4uMjY4ZmM4Mzg5IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS90c3RfdGltZXIu
aAo+ID4gKysrIGIvaW5jbHVkZS90c3RfdGltZXIuaAo+ID4gQEAgLTE3LDYgKzE3LDcgQEAKPiA+
ICAjaW5jbHVkZSA8bXF1ZXVlLmg+Cj4gPiAgI2luY2x1ZGUgPHRpbWUuaD4KPiA+ICAjaW5jbHVk
ZSAidHN0X3Rlc3QuaCIKPiA+ICsjaW5jbHVkZSAidHN0X2Nsb2Nrcy5oIgo+ID4gICNpbmNsdWRl
ICJsYXBpL2NvbW1vbl90aW1lcnMuaCIKPiA+ICAjaW5jbHVkZSAibGFwaS9wb3NpeF90eXBlcy5o
Igo+ID4gICNpbmNsdWRlICJsYXBpL3N5c2NhbGxzLmgiCj4gPiBAQCAtMTA3NCw0ICsxMDc1LDMz
IEBAIHN0YXRpYyBpbmxpbmUgbG9uZyBsb25nIHRzdF90aW1lcl9lbGFwc2VkX3VzKHZvaWQpCj4g
PiAgICAgICByZXR1cm4gdHN0X3RpbWVzcGVjX3RvX3VzKHRzdF90aW1lcl9lbGFwc2VkKCkpOwo+
ID4gIH0KPiA+Cj4gPiArI2RlZmluZSBDQUxMSUJSQVRFX0xPT1BTIDEyMDAwMDAwMAo+ID4gKwo+
ID4gKy8qCj4gPiArICogTWVhc3VyZXMgdGhlIHRpbWUgdGFrZW4gYnkgdGhlIENQVSB0byBwZXJm
b3JtIGEgc3BlY2lmaWVkCj4gPiArICogbnVtYmVyIG9mIGVtcHR5IGxvb3BzIGZvciBjYWxpYnJh
dGlvbi4KPiA+ICsgKi8KPiA+ICtzdGF0aWMgaW5saW5lIGludCB0c3RfY2FsbGlicmF0ZSh2b2lk
KQo+ID4gK3sKPiA+ICsgICAgIGludCBpOwo+ID4gKyAgICAgc3RydWN0IHRpbWVzcGVjIHN0YXJ0
LCBzdG9wOwo+ID4gKyAgICAgbG9uZyBsb25nIGRpZmY7Cj4gPiArCj4gPiArICAgICBmb3IgKGkg
PSAwOyBpIDwgQ0FMTElCUkFURV9MT09QUzsgaSsrKQo+ID4gKyAgICAgICAgICAgICBfX2FzbV9f
IF9fdm9sYXRpbGVfXyAoIiIgOiAiK2ciIChpKSA6IDopOwo+ID4gKwo+ID4gKyAgICAgdHN0X2Ns
b2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDX1JBVywgJnN0YXJ0KTsKPiA+ICsKPiA+ICsgICAg
IGZvciAoaSA9IDA7IGkgPCBDQUxMSUJSQVRFX0xPT1BTOyBpKyspCj4gPiArICAgICAgICAgICAg
IF9fYXNtX18gX192b2xhdGlsZV9fICgiIiA6ICIrZyIgKGkpIDogOik7Cj4gPiArCj4gPiArICAg
ICB0c3RfY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUNfUkFXLCAmc3RvcCk7Cj4gPiArCj4g
PiArICAgICBkaWZmID0gdHN0X3RpbWVzcGVjX2RpZmZfdXMoc3RvcCwgc3RhcnQpOwo+ID4gKwo+
ID4gKyAgICAgdHN0X3JlcyhUSU5GTywgIkNQVSBkaWQgJWkgbG9vcHMgaW4gJWxsaXVzIiwgQ0FM
TElCUkFURV9MT09QUywKPiBkaWZmKTsKPiA+ICsKPiA+ICsgICAgIHJldHVybiBkaWZmOwo+ID4g
K30KPiA+ICsKPiA+ICAjZW5kaWYgLyogVFNUX1RJTUVSICovCj4gPiBkaWZmIC0tZ2l0IGEvbGli
L3RzdF90ZXN0LmMgYi9saWIvdHN0X3Rlc3QuYwo+ID4gaW5kZXggOGRiNTU0ZGVhLi4yOTY2ODNm
ZmIgMTAwNjQ0Cj4gPiAtLS0gYS9saWIvdHN0X3Rlc3QuYwo+ID4gKysrIGIvbGliL3RzdF90ZXN0
LmMKPiA+IEBAIC01NDksMTMgKzU0OSwxNiBAQCBzdGF0aWMgdm9pZCBwYXJzZV9tdWwoZmxvYXQg
Km11bCwgY29uc3QgY2hhcgo+ICplbnZfbmFtZSwgZmxvYXQgbWluLCBmbG9hdCBtYXgpCj4gPiAg
c3RhdGljIGludCBtdWx0aXBseV9ydW50aW1lKGludCBtYXhfcnVudGltZSkKPiA+ICB7Cj4gPiAg
ICAgICBzdGF0aWMgZmxvYXQgcnVudGltZV9tdWwgPSAtMTsKPiA+ICsgICAgIHN0YXRpYyBpbnQg
ZXh0cmFfcnVudGltZSA9IDA7Cj4gPgo+ID4gICAgICAgaWYgKG1heF9ydW50aW1lIDw9IDApCj4g
PiAgICAgICAgICAgICAgIHJldHVybiBtYXhfcnVudGltZTsKPiA+Cj4gPiAgICAgICBwYXJzZV9t
dWwoJnJ1bnRpbWVfbXVsLCAiTFRQX1JVTlRJTUVfTVVMIiwgMC4wMDk5LCAxMDApOwo+ID4KPiA+
IC0gICAgIHJldHVybiBtYXhfcnVudGltZSAqIHJ1bnRpbWVfbXVsOwo+ID4gKyAgICAgZXh0cmFf
cnVudGltZSA9ICh0c3RfY2FsbGlicmF0ZSgpIC8gMTAwMCkgKgo+IHRzdF9rY29uZmlnX2RlYnVn
X21hdGNoZXMoKTsKPiA+ICsKPiA+ICsgICAgIHJldHVybiAobWF4X3J1bnRpbWUgKyBleHRyYV9y
dW50aW1lKSAqIHJ1bnRpbWVfbXVsOwo+Cj4gSSB3YXMgaG9waW5nIGZvciBhIHNpbXBsZXIgY2Fs
Y3VsYXRpb24gc29tZXRoaW5nIGFzOgo+Cj4gICAgICAgICBpZiAoYW55X2tjb25maWdfZGVidWdf
ZW5hYmxlZCgpKQo+ICAgICAgICAgICAgICAgICBtYXhfcnVudGltZSAqPSA0Owo+CgpPaywgaWYg
d2UgZG8gdGhpcywgdGhlIGRlYnVnIGNvbmZpZ3VyYXRpb24gc2V0IHRzdF9rY29uZl9kZWJ1Z19v
cHRpb25zCnNob3VsZCBiZSBjb25maXJtZWQgdG8gd29yayB3aXRoIGRlYnVnIGtlcm5lbHMgb24g
dGhlIG1vc3QgcG9wdWxhcgpkaXN0cmlidXRpb25zIChlLmcuIE9wZW5TdXNlLCBVYnVudHUpLCBh
bmQgSSBjYW4gaGVscCBjaGVjayBpZiB0aGlzIHdvcmtzCm9uIEZlZG9yYSBmYW1pbHkgc3lzdGVt
cy4KCk90aGVyd2lzZSBhbnlfa2NvbmZpZ19kZWJ1Z19lbmFibGVkKCkgd2lsbCBiZSBsaW1pdGVk
IGJ5IHRoZSBMaW51eApkaXN0cmlidXRpb24uCgpbQ2MgU2hpemhhbyB3aG8gaXMgYWxzbyByZXBv
cnRpbmcgdGhlIHN0YXJ2YXRpb24gZmFpbHVyZXMgdG8gbWVdCgoKPiBPciBzb21ldGhpbmcgYWxv
bmcgdGhlc2UgbGluZXMuIEkgZG8gbm90IHRoaW5rIHRoYXQgdGhlIGtlcm5lbCB3aWxsIGdldAo+
IHNsb3dlciB3aXRoIGVhY2ggZGVidWcgb3B0aW9uIGVuYWJsZWQuIEFuZCB3ZSBhcmUgbm90IGxv
b2tpbmcgZm9yIGEKPiB0aWdodCBmaXQgZWl0aGVyLCBzbyB0aGUgY2FsbGJyYXRpb24gbG9vcCBk
b2VzIG5vdCBtYWtlIG11Y2ggc2Vuc2UgaGVyZS4KPgo+IEl0IGFsc28gbWFrZXMgc2Vuc2UgdGhh
dCBhIGRlYnVnIGtlcm5lbCB3aWxsIGJlIE4gdGltZXMgc2xvd2VyLCB3aGVyZQo+IHRoZSBleGFj
dCBOIHdvdWxkIGJlIGhhcmQgdG8gZmluZCBvdXQsIGJ1dCBpbiB0aGlzIGNhc2Ugd2UganVzdCBu
ZWVkIGEKPiByZWFzb25hYmxlIHVwcGVyIGJvdW5kLgo+Cj4gQW5kIHRoaXMgd291bGQgd29yayBu
aWNlbHkgZm9yIHRoZSBzdGFydmF0aW9uIHRlc3QgdG9vLCBzaW5jZSB3ZQo+IGNhbGN1bGF0ZSBh
IHRpZ2h0IGZpdCB0aGVyZSBmaXJzdCwgdGhlbiB3ZSB3b3VsZCBtdWx0aXBseSBpdCBieSB0aGUK
PiAiZGVidWcga2VybmVsIHNsb3duZXNzIiBtdWx0aXBsaWVyLiBUaGVyZSB3b3VsZCBiZSBubyBu
ZWVkIHRvIG1vZGlmeSB0aGUKPiBzdGFydmF0aW9uIHRlc3QgaW4gdGhhdCBjYXNlIGVpdGhlciAo
aXQgbWF5IG1ha2Ugc2Vuc2UgdG8gc2V0IHRoZQo+IHJ1bnRpbWUgb2YgdGhlIHRlc3QgdG8gLTEg
c28gdGhhdCB0aGUgbWV0YWRhdGEgd2lsbCBoYXZlIGFuIGluZm9ybWF0aW9uCj4gdGhhdCB0aGUg
dGVzdCBydW50aW1lIGlzIHVuYm91bmQgdW50aWwgd2UgYWN0dWFsbHkgZXhlY3V0ZSBpdCB0aG91
Z2gpLgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgo+CgotLSAKUmVn
YXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
