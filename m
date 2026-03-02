Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B0DD58E7A
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772441430; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RSPRKSeluRfkhiysjEPtBm9OnbCxcZ4/b6hEVSoM2gQ=;
 b=W51AyNtDa8g1+fOe18b3byxp2v5wc5iZ5thDYig/JEGp0zU4qwOPjwM28F+a/z8Ukr5DO
 SYMd3FDXv5cj2b9xXwyPspmo7taC85wftB3OgO7A0Yk6AUiJQei8o8KCQON4SKD/EoNCFPh
 M5AlKihIq617U9jpYxbnBsM3+9ON6fA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 250B93D74E3
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 09:50:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F2BD3CD9A1
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 09:50:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D04841A004C9
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 09:50:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9X27wQrz1nK34XujXN/8X9kr0F9l5gatp/+naLmguY=;
 b=fbvM/1zZEc+jMiyVkH19BB/kUflC3Zpp1HcwpakTqw3CUabYkbJq17H1e+F7q97FUWTn4W
 FwLADlsq4NRUivpwCLoSlHSNqAnGyJJa0Pykr7xEDbngjfb+BPLo/h4div9s1fgyeRY4+N
 CH3zlX5iCOAZzoRR6i/tg5Z3LqymqIQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681--gxvKGLiMcGLtcySj8Ukwg-1; Mon, 02 Mar 2026 03:49:49 -0500
X-MC-Unique: -gxvKGLiMcGLtcySj8Ukwg-1
X-Mimecast-MFC-AGG-ID: -gxvKGLiMcGLtcySj8Ukwg_1772441388
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48378df3469so28283605e9.1
 for <ltp@lists.linux.it>; Mon, 02 Mar 2026 00:49:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441387; x=1773046187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e9X27wQrz1nK34XujXN/8X9kr0F9l5gatp/+naLmguY=;
 b=bG4K22/IciJzUn2yFrec816DGDs39M9pB7PZ0ltN3ltoDQ2lTPf+dvGqoQ3d5u8yt8
 5RBYT4YGub94OjiYk6KbmYNGpycjKhZK2EIYxcIqp7RKVRNNAkHciG3Bz6o2hGKsB7up
 baCpK/cvGdUXpkfH7fan22OFHKDVVAhpGja2Y0KcvzpP/6hZq6V6WoeWR7C13bhV7w+j
 mLne0B/X8kLIdH2OMpt6pY57E5s4Eea27vo8qugQa7NWW3mhUQJ0nL3uccsgudastUjF
 ZuoQ+Be+QpFfSKT8YIzBE1cuZ1AaQpJO6N8ycKqdCj1ytjCN1TpvuQ97uF4SJD0bmsqm
 212g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBZaMPpHH4E7xbH8V2Xil4HyaGA6SVXVgB7hRPy1vDUYMMKebpmaNlL1lF2bANLL3tHVI=@lists.linux.it
X-Gm-Message-State: AOJu0Yy6qkJZI25vp4F/17OLB/408tGZFN/nwDjNgEYWZiJJMerZwpnr
 Gs+XN5s+uwq3z6zNJajvVaICboYgp9wkqNj7EQ3zocwRrk9Yn/tOGWb+dPInSIPSOXsSObKnIJr
 zBd3VhsUDoZU6X2zpu1DKQAfCmFiNkDDGANZE4GPM0ETKYT2lTdYk/C8ds5NTHepBsj7oedhg6f
 htudi2j9Oj3Wub9IV6O/yt2VUvRuM=
X-Gm-Gg: ATEYQzxAOxYZtMLj5wAfiMgwpI4UMq8BOuqxAo6JLJ2Gp7XeewKGh6dxwuXDhvr9O6i
 QvZQ6y8kGxbZU+9Hrby3XvaolL8obC7hTYCPaZL+c3qsXNW95GUwXrPiTqsfwWwR4zRFrrXE6kD
 cMZYKZPiJ0Yp0spBNnPP2g3UIl+6XQ+aQwRpokFNNHwFtnqwnzMDhC5Jz43t7AQti2f7dXT/Mng
 BDJ
X-Received: by 2002:a05:600c:4f08:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-483c992e3c0mr169612775e9.12.1772441387587; 
 Mon, 02 Mar 2026 00:49:47 -0800 (PST)
X-Received: by 2002:a05:600c:4f08:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-483c992e3c0mr169612335e9.12.1772441386954; Mon, 02 Mar 2026
 00:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20260220173928.57467-1-japo@linux.ibm.com>
In-Reply-To: <20260220173928.57467-1-japo@linux.ibm.com>
Date: Mon, 2 Mar 2026 09:49:30 +0100
X-Gm-Features: AaiRm53AX2CNc8kAqDsMvApj6Hd-UsSXCbW3ZFvzoKcyVyjY2D0do98DNc2gmDQ
Message-ID: <CAASaF6zb5c+VmzKEC6Y5_-yx55TpHQA1T+81POFJ9rR77qN8Kg@mail.gmail.com>
To: Jan Polensky <japo@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NSbWpWy7XaCEGKptgvR_5cfYRqRJm7_wU11Md4Eqcik_1772441388
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] [STAGING] ioctl_pidfd06: Select expected
 errno for PIDFD_GET_INFO across pidns
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBGZWIgMjAsIDIwMjYgYXQgNjozOeKAr1BNIEphbiBQb2xlbnNreSA8amFwb0BsaW51
eC5pYm0uY29tPiB3cm90ZToKPgo+IFBJREZEX0dFVF9JTkZPIHNlbWFudGljcyBjaGFuZ2VkIGZv
ciBwaWRmZHMgcmVmZXJyaW5nIHRvIHRhc2tzIHdpdGhvdXQgYSBQSUQKPiBpbiB0aGUgY2FsbGVy
J3MgY3VycmVudCBwaWQgbmFtZXNwYWNlIChjb21taXQgYWI4OTA2MGZiYzkyZSAoInBpZGZzOiBy
ZXR1cm4KPiAtRVJFTU9URSB3aGVuIFBJREZEX0dFVF9JTkZPIGlzIGNhbGxlZCBvbiBhbm90aGVy
IG5zIikpLgo+Cj4gU2VsZWN0IHRoZSBleHBlY3RlZCBlcnJubyBiYXNlZCBvbiB0aGUgcnVubmlu
ZyBrZXJuZWwgdmVyc2lvbiB0byBrZWVwIHRoZQo+IHRlc3Qgd29ya2luZyBvbiBrZXJuZWxzIGJl
Zm9yZSBhbmQgYWZ0ZXIgdGhlIGNoYW5nZSwgd2hpbGUgYmVpbmcgc3RyaWN0IG9uCj4gbmV3ZXIg
a2VybmVscyB0byBhdm9pZCBhY2NlcHRpbmcgdGhlIGxlZ2FjeSBlcnJubyBieSBhY2NpZGVudC4K
Pgo+IFN1Z2dlc3RlZC1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4gU2lnbmVk
LW9mZi1ieTogSmFuIFBvbGVuc2t5IDxqYXBvQGxpbnV4LmlibS5jb20+CgpBY2tlZC1ieTogSmFu
IFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
