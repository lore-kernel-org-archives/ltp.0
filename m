Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B9BC77B7C
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750769173; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=luOzU4C/NGSZ0KN2TncuzPFJTUNU1s0jmvTsPR3ygrw=;
 b=gLL6MnFIuQnV0fnQqeNd6iPx4pcs3kksKJPVK+SYbWs62XfAG+BjUxcXMxfdfsRYWGInb
 vZt5eeDv3sMIVY8GLd8szO/s6MS81BmnTOchaK9hnlklYmDSfp/eaVpXGb8G7VoujxZcrtc
 C6V1edhTFjmSp/bCSUT0dbNGIdN116M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A3FD3CCAB7
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 14:46:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 326863CB294
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 14:45:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7D6316002EA
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 14:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750769150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1Iq/g/67zKh6ET+Wypj7447pe+BztLHY6szXoi/rVA=;
 b=GHWJqEuuCfYAapAwHaTmKRsz7nUnFNiknPYiGVphBq7KZGZ3xJf5kWYcKBZU5TCPfYPvRQ
 N143bkguvKozgrW3c26zlcSAuMwm4Cwo9WH0u8L07RPxTuGdybXZwydbpRQgrKwOzTXeKK
 FKhkqhMLOajTjh8nI41L83ykvXOhgfY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-hUTvrFJ7PRa9JH1OJsWX7g-1; Tue, 24 Jun 2025 08:45:48 -0400
X-MC-Unique: hUTvrFJ7PRa9JH1OJsWX7g-1
X-Mimecast-MFC-AGG-ID: hUTvrFJ7PRa9JH1OJsWX7g_1750769147
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b31cc625817so4099034a12.0
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 05:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750769147; x=1751373947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1Iq/g/67zKh6ET+Wypj7447pe+BztLHY6szXoi/rVA=;
 b=XUiQV1q00VN1KPl5m5msIzUAwjtWBDHwt3yxZrxGuyfWShzhkV5bFZmTMM2zp8Iiz1
 LatgEK2YCDCPMxuVWbKrnGuyFgFDjj289tQ8vm+PuzG90p3BbzL0gIt3Fu/phv4xg/YA
 gDYcZbmfnEuMaypCZu3eFcBb4GouyF7XVhcOu3xSdwFNZPz+dngtXOK5jC9BCvxILHIs
 aI5jWVVJuM1yXkPkV67ha8i7vhex3Ipf62Z9jP8vmSrSegGct/0vhtIazwBOc2fgxeUW
 yMz8CKxRQqx9XiWl8D2Bf84vZNmvC1xSxUaFP1+TVjuR/xi+X//DfLyucTpNGK6kFczz
 Y1qA==
X-Gm-Message-State: AOJu0YySr+V2yqMimB85efTc6x7NGCNpAuZSJ1+2cUcX/2oLNcESm0a4
 Ao41txV1Qzxf5JzXRWWCQsnG1dWMFCxaXUkI+5QP1ZiB74ZTGxHy6aUf7AKBsZXZr6XBiAfuIlC
 YpGCdJcLxbpMT4V0q5g8/P1dZ43OkJgLR/DHShd2A71uIqkWlKZgdXBE2KDfjIoFUKqiNL1WxJk
 OQF4sGj7w41GbDtL+SH8yzNIsM8fk=
X-Gm-Gg: ASbGncspkx12rDvYcQEvNZTkOTYi2MpiRDGGG+u++YYoEIFl2lrFFOcc4ouSmQcApW7
 dj7yxJMoL5aT4YucdrwvRdjuhvbz91sPi3lwyn6rJeKYUUaTOFqPu1BgGioflt1RdlT3P3xp1KO
 IEUHtL
X-Received: by 2002:a17:90b:1343:b0:30a:3e8e:ea30 with SMTP id
 98e67ed59e1d1-315ccd2c4fdmr5342468a91.11.1750769147288; 
 Tue, 24 Jun 2025 05:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn6lDmLN5pbKcAUTbGBIQzBDyhMQR01xkgU2DqyJ2a6zLGo2Zj9QUgRHgaqpebGYUMeEuuQP0p/as661+fPWc=
X-Received: by 2002:a17:90b:1343:b0:30a:3e8e:ea30 with SMTP id
 98e67ed59e1d1-315ccd2c4fdmr5342438a91.11.1750769146864; Tue, 24 Jun 2025
 05:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250623140210.32347-1-liwang@redhat.com>
 <aFrxBElBT0jg6IOy@MiWiFi-CR6608-srv>
 <CAEemH2ctXX_-xs3UPu4wCikok-b7qq747wgTBoer8q6+vELzXw@mail.gmail.com>
 <CAEemH2dRgdg2tH7G3QPn-SmGndf+p2himEQ49VxURrigXwMQHw@mail.gmail.com>
In-Reply-To: <CAEemH2dRgdg2tH7G3QPn-SmGndf+p2himEQ49VxURrigXwMQHw@mail.gmail.com>
Date: Tue, 24 Jun 2025 20:45:35 +0800
X-Gm-Features: Ac12FXz5YqpNK8za0Sl9zg-YFft7i5d-XGvPZyuDsK6TcMHm3foAycnVJCqjDP4
Message-ID: <CAEemH2ehiCC3vBvMzTF8awvqd_MHd2oOc25jt=B+bMCrc6D4Rg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X7dbaSitTOCZa-DHiw8KkEErvadAwj8sD3kK4XSthKc_1750769147
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] tst_test: Add min_runtime to control lower
 bound of scaled runtime
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

T24gVHVlLCBKdW4gMjQsIDIwMjUgYXQgODozNuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gSGkgQWxsLAo+Cj4gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Cj4KPj4gQnV0IHRoZSBkZWZhdWx0IDEwMjQgbWluX3NhbXBsZXMgSSBzdGlsbCBoYXZl
IG5vIGlkZWEgaG93IGxvbmcKPj4gdGhlIC5taW5fcnVudGltZSBuZWVkcy4gTWF5YmUgd2UgY2Fu
IGVzdGltYXRlIGFuZCBzZXQgLm1pbl9ydW50aW1lCj4+IG9uIGEgc2xvdyBzeXN0ZW0gbWFudWFs
bHkuCj4+Cj4KPiBJIGNob29zZSB0byBydW4gdGhlIGZ1enp5X3N5bmMgdGVzdHMgb24gYSBDb3J0
ZXgtQTU1IENQVSB3aXRoCj4gb25seSBvbmUgY29yZSBhc3NpZ25lZCwgdXNpbmcgdGhlIHRhc2tz
ZXQgY29tbWFuZCB0byBzaW11bGF0ZQo+IGFuIGV4dHJlbWUgc2luZ2xlLWNvcmUgZXhlY3V0aW9u
IHNjZW5hcmlvLgo+Cj4gVGVzdGVkIG9uOgo+ICAgICBDb3J0ZXgtQTU1LCAxLjJHSHoKPiAgICAg
TGludXggNS4xNCwgYWFyY2g2NAo+Cj4gRm9yIGV4YW1wbGU6Cj4gICAgIHRpbWUgdGFza3NldCAt
YyAwIC4vY3ZlLTIwMTYtNzExNyAoaGFja2VkIHRoZSB0ZXN0IG9ubHkgZG8gc2FtcGxpbmcpCj4K
PiBUaGlzIHNldHVwIGFsbG93cyBtZSB0byBldmFsdWF0ZSBob3cgbG9uZyB0aGUgc2FtcGxpbmcg
cGhhc2UKPiB0YWtlcyB1bmRlciBjb25zdHJhaW5lZCBjb25kaXRpb25zLgo+Cj4gQmFzZWQgb24g
dGhlIG9ic2VydmVkIHNhbXBsaW5nIGR1cmF0aW9uLCBJIGFwcGx5IHRoZSBmb2xsb3dpbmcgcG9s
aWN5Cj4gZm9yIHNldHRpbmcgLm1pbl9ydW50aW1lOgo+Cj4gICAxLiBJZiB0aGUgc2FtcGxpbmcg
dGltZSBpcyB2ZXJ5IHNob3J0IChsZXNzIHRoYW4gMSBzZWNvbmQpLAo+ICAgICAgIEkgc2ltcGx5
IHNldCAubWluX3J1bnRpbWUgPSAyLgo+Cj4gICAyLiBJZiB0aGUgc2FtcGxpbmcgdGltZSBpcyBs
b25nZXIgdGhhbiAyIHNlY29uZHMgYnV0IHN0aWxsIGxlc3MgdGhhbgo+ICAgICAgLnJ1bnRpbWUs
IEkgc2V0IC5taW5fcnVudGltZSB0byB0d2ljZSB0aGUgc2FtcGxpbmcgdGltZSwgd2hpbGUKPiAg
ICAgIGtlZXBpbmcgLnJ1bnRpbWUgdW5jaGFuZ2VkLgo+Cj4gICAzLiBJZiB0aGUgc2FtcGxpbmcg
dGltZSBleGNlZWRzIC5ydW50aW1lLCBJIGFsc28gZG91YmxlIHRoZSBzYW1wbGluZwo+ICAgICAg
IHRpbWUgZm9yIC5taW5fcnVudGltZSwgYnV0IGxlYXZlIC5ydW50aW1lIGFzIGlzLgo+CgozLiBJ
ZiB0aGUgc2FtcGxpbmcgdGltZSBleGNlZWRzIC5ydW50aW1lLCBJIHNpbXBseSBzZXQgLm1pbl9y
dW50aW1lCiAgICB0byB0aGUgLnJ1bnRpbWUgdmFsdWUgYW5kIHJlbW92ZSAucnVudGltZS4KCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
