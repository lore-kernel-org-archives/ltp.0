Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFC8C54798
	for <ltp@archiver.kernel.org>; Sat,  9 Mar 2024 08:11:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E95E3CE954
	for <ltp@archiver.kernel.org>; Sat,  9 Mar 2024 09:11:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 646903CB97A
 for <ltp@lists.linux.it>; Sat,  9 Mar 2024 09:11:38 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9289D1000751
 for <ltp@lists.linux.it>; Sat,  9 Mar 2024 09:11:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709971896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2aGI6wiI9kdMafxmiBeD+e+SPUax8yd1nnkHoskcKQ=;
 b=jEwPsBx1nfQBqxrzDbtIQ1wCB7sMVRLAnX+CNaySFCKJ+og38ovR0nPUvINfBTHHLcAhL3
 hfFwvBpAJR/u9XK4iTE01ytIHWWnjujsJifamxAQDvvwdWMKDT0I/CF7PclsYZ7C7E/WBw
 oLkR38WkDvq5JdCmDx5wVr6RUmqX34s=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-LiZksY6yNyuasSyrV-WCuw-1; Sat, 09 Mar 2024 03:11:32 -0500
X-MC-Unique: LiZksY6yNyuasSyrV-WCuw-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5d8dd488e09so2671296a12.2
 for <ltp@lists.linux.it>; Sat, 09 Mar 2024 00:11:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709971891; x=1710576691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2aGI6wiI9kdMafxmiBeD+e+SPUax8yd1nnkHoskcKQ=;
 b=sfOqcCOwZIIvTy0RE1ndnVcNZX8TpeKfgt3zQiUA4C1DRRi+qRXsahDIh+zoxT1N3d
 V0jr1U7T6lMUxzwa7gmd2aaIVjOdAWUFjk2m4E6MSLuIWkx+qjrQi8Lpf5nOdU7weZdv
 ZuwgbshhgzOjso09QG5vXUUPRXu1hu60mFiJFR6hp/xXsPEAy0i5SJxIfamYsbgHuR11
 eZAvh4fDGj0bYzuynAB+Elg4gy1gU6L0bNZctZLmw/MqvdpsuCgzz6bcisswWBU6/GwC
 RIn0S83HrHBNdHzXtewG+navy0mcOUPWt0z1QP8d7PIphCIuv2Y6eMY8Ukawey7zKZBU
 LIVQ==
X-Gm-Message-State: AOJu0YzcREInbNYOAqS+XjdgQdQgWbxOlKrDYc2QsQer0+O5KuWnC4jw
 8HFcWcSCmOCxEWuWWm0LxPJqiMCLdiqQF8fCF5uRhO2jSDxDl30EEiY+WIseidjlhE1T1hOl0MD
 b6eVOL8qK9O9rcWC7BJwanTXleeJg1z2PkciolM/89vTiTXcuu/XjG609nvvZaQznBz8sKcghgi
 rQzrhum029wn6RwIOBt6SSv34GJhWXK3pdbQ==
X-Received: by 2002:a05:6a20:da9d:b0:1a1:4624:bf28 with SMTP id
 iy29-20020a056a20da9d00b001a14624bf28mr1316603pzb.7.1709971891177; 
 Sat, 09 Mar 2024 00:11:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk52Ev7jZqtDmkOG9cwHXm+DpGG06N/zqS1xG0NI3OxpqZgoWncscsbFgvQySBUVPe2GqwWMC54ned6rMmFe4=
X-Received: by 2002:a05:6a20:da9d:b0:1a1:4624:bf28 with SMTP id
 iy29-20020a056a20da9d00b001a14624bf28mr1316586pzb.7.1709971890851; Sat, 09
 Mar 2024 00:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20240308045230.3106549-1-liwang@redhat.com>
 <20240308045230.3106549-2-liwang@redhat.com>
 <20240308084751.GA257921@pevik>
In-Reply-To: <20240308084751.GA257921@pevik>
From: Li Wang <liwang@redhat.com>
Date: Sat, 9 Mar 2024 16:11:19 +0800
Message-ID: <CAEemH2dnw7Hzzh9d+B+s3AcmOZMg+ycCChfeGtS6GqzdN+yoqQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/3] init_module: To handle kernel module
 signature enforcement
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

T24gRnJpLCBNYXIgOCwgMjAyNCBhdCA0OjQ34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwKPgo+ID4gVGhlIHBhdGNoIG1vZGlmaWVzIGluaXRfbW9kdWxl
IHN5c2NhbGwgdGVzdCBjYXNlcyB0byBhY2NvdW50Cj4gPiBmb3Iga2VybmVsIG1vZHVsZSBzaWdu
YXR1cmUgZW5mb3JjZW1lbnQuIEl0IGFkZHMgcGFyc2luZyBmb3IKPiA+IHRoZSAnbW9kdWxlLnNp
Z19lbmZvcmNlJyBwYXJhbWV0ZXIgYW5kIGFkanVzdHMgdGVzdCBleHBlY3RhdGlvbnMKPiA+IGJh
c2VkIG9uIHdoZXRoZXIgc2lnbmF0dXJlIGVuZm9yY2VtZW50IGlzIGVuYWJsZWQsIHVzaW5nCj4g
PiBuZXcgY29uZGl0aW9uYWwgbG9naWMuCj4KPiA+IElmIGVuZm9yY2VtZW50IGlzIGFjdGl2ZSwg
dGVzdHMgZXhwZWN0IGFuIEVLRVlSRUpFQ1RFRCBlcnJvcjsKPiA+IG90aGVyd2lzZSwgdGhleSBw
cm9jZWVkIGFzIG5vcm1hbC4KPgo+IC4uLgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZGVsZXRlX21vZHVsZS9kZWxldGVfbW9kdWxlMDEuYwo+IGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9kZWxldGVfbW9kdWxlL2RlbGV0ZV9tb2R1bGUwMS5jCj4gPiBpbmRl
eCA5MGQ4YjUyODkuLjRjMzFmODFiMCAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZGVsZXRlX21vZHVsZS9kZWxldGVfbW9kdWxlMDEuYwo+ID4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9kZWxldGVfbW9kdWxlL2RlbGV0ZV9tb2R1bGUwMS5jCj4gPiBA
QCAtMTQsOCArMTQsMTAgQEAKPiA+ICAgKiBJbnN0YWxsIGR1bW15X2RlbF9tb2Qua28gYW5kIGRl
bGV0ZSBpdCB3aXRoIGRlbGV0ZV9tb2R1bGUoMikuCj4gPiAgICovCj4KPiA+ICsjaW5jbHVkZSA8
c3RkbGliLmg+Cj4gPiAgI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gPiAgI2luY2x1ZGUgInRzdF9t
b2R1bGUuaCIKPiA+ICsjaW5jbHVkZSAidHN0X2tjb25maWcuaCIKPiA+ICAjaW5jbHVkZSAibGFw
aS9zeXNjYWxscy5oIgo+Cj4gPiAgI2RlZmluZSBNT0RVTEVfTkFNRSAgImR1bW15X2RlbF9tb2Qi
Cj4gPiBAQCAtMjUsNiArMjcsMTIgQEAgc3RhdGljIGludCBtb2R1bGVfbG9hZGVkOwo+Cj4gPiAg
c3RhdGljIHZvaWQgZG9fZGVsZXRlX21vZHVsZSh2b2lkKQo+ID4gIHsKPiA+ICsgICAgIHN0cnVj
dCB0c3Rfa2NtZGxpbmVfcGFyYW0gcGFyYW1zID0KPiBUU1RfS0NNRExJTkVfSU5JVCgibW9kdWxl
LnNpZ19lbmZvcmNlIik7Cj4gPiArCj4gPiArICAgICB0c3Rfa2NtZGxpbmVfcGFyc2UoJnBhcmFt
cywgMSk7Cj4gPiArICAgICBpZiAoYXRvaShwYXJhbXMudmFsdWUpID09IDEpCj4gPiArICAgICAg
ICAgICAgIHRzdF9icmsoVENPTkYsICJtb2R1bGUgc2lnbmF0dXJlIGlzIGVuZm9yY2VkLCBza2lw
IHRlc3QiKTsKPiBPbmx5IDIgdGVzdHMgZG8gdHN0X2JyayhUQ09ORikuIEkgd2FzIHRoaW5raW5n
IGFib3V0IGFkZGluZyBsaWJyYXJ5IGZsYWcKPiAuc2tpcF9pbl9tb2R1bGVfc2lnX2VuZm9yY2Us
IGJ1dCBwcm9iYWJseSBub3Qgd29ydGggb2YgaXQuCj4KCkhtbSwgaXQgaXMgbm90IHZlcnkgbmVj
ZXNzYXJ5IGF0IHRoaXMgbW9tZW50LgpNYXliZSBpbiB0aGUgZnV0dXJlLCBpdCBjb3VsZCBiZSBh
biBleHRlbmRlZCBkaXJlY3Rpb24uCgoKCj4KPiBUaGUgcmVzdCBMR1RNLgo+Cj4gUmV2aWV3ZWQt
Ynk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IFRlc3RlZC1ieTogUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+Cj4KClRoYW5rcyBhIGxvdCBmb3IgdGVzdGluZy9yZXZpZXdpbmcsIHRo
ZSByZXNldCBjb21tZW50cyBsb29rIGdvb2QgdG8gbWUuCgpWMiBpcyBjb21pbmcuCgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
