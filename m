Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F2DC67861
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 08:07:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FA253CF563
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 10:07:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9800B3CF454
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 10:07:00 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B1F201001583
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 10:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712563618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jd10luwafmTZvyVVVjoGGF/up/L3Kz9B6k3D5dH3jUw=;
 b=IBH+Kl8HslpH8JPQmus23vnvCgz1/MgIxyNa4t1f8emP0N26bqqyg4UbyVIXflXA4OZ8Aq
 O2J13cDU3ml5MxgknUnlyl8li8Mr37cz8TkNMLrkN8iIHf2oMw7DrosMlzKuqeRY6xkApv
 KtzEutJQuTon9L+acyqHgpZDSXb8rI4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-mlH-3XNhOn6bcHtHF_gZ4w-1; Mon, 08 Apr 2024 04:06:56 -0400
X-MC-Unique: mlH-3XNhOn6bcHtHF_gZ4w-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5d8dc8f906aso2415602a12.2
 for <ltp@lists.linux.it>; Mon, 08 Apr 2024 01:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712563615; x=1713168415;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jd10luwafmTZvyVVVjoGGF/up/L3Kz9B6k3D5dH3jUw=;
 b=Y9nLVubJeM1W7NFf4VMuE5x7qTvdw64FwLqtS3aUx+k5wNdcADiFwNESdw60YbTHO9
 OthtLYZ8AfTjd4+u53eZmBd4rf7nEjaeaJBcPlWRCxsUc2Nx6+BMJhXW5b94bo/ECwYN
 XsN9WnJVp+a7fTDo0MOKshtRKJ079akjSn73iTSBcmUI/xzYjC0S+ZCYJt3Nd920KHH6
 1Jb5AiC88ynKezBF3ygQ3LiUIzdmYo0QgJ7wRS8Nlsp9egwIKb8xoxYzv0KjGuox1qa3
 dpR5zed/QFeZxbCaPia/Swv8IthSi0BDuLeLYV8ioY3U+hKlBeI+vJSv/HL7lz6RfS8Z
 0+Pw==
X-Gm-Message-State: AOJu0YyLxTHIOgftH7kw2f3ujeu/Wh7HAx72znn58QuBVC3dWO7tvV8J
 tJRQJgn+YaXAcx5g+t9le6Cob9Rd5pgo7Y29RiQrY31KrN4rL7E1/ZbRKbA7El/7jvme7wBTI4A
 GdyiqNZC5nnN4ok96F+HiUdpSHE7yzSWOZTekUMRvZnpe00Z3I6x53HZu4+wDskolM77yf5V6rm
 rP48Qf1PLPM/z0HHOrMz/TVcM=
X-Received: by 2002:a05:6a20:3946:b0:1a3:dfd2:949c with SMTP id
 r6-20020a056a20394600b001a3dfd2949cmr8163546pzg.54.1712563615368; 
 Mon, 08 Apr 2024 01:06:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEckamxk1hJOvcrjvMeJBuUUQ1S0a/A4v51jCMV60bsPtf+CkvI6ooBUMciIwRSfQ+3LzqQSBULhoeoWmFd3Uk=
X-Received: by 2002:a05:6a20:3946:b0:1a3:dfd2:949c with SMTP id
 r6-20020a056a20394600b001a3dfd2949cmr8163530pzg.54.1712563614982; Mon, 08 Apr
 2024 01:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240408071848.80862-1-minachou@andestech.com>
In-Reply-To: <20240408071848.80862-1-minachou@andestech.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Apr 2024 16:06:42 +0800
Message-ID: <CAEemH2f9OqTPMkEvQosPRp5+kYgGqFhZahfGqMOrzH+UoqOG3w@mail.gmail.com>
To: Hui Min Mina Chou <minachou@andestech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] waitid10: Add .needs_tmpdir=1 to run test in
 temporary directory
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
Cc: tim609@andestech.com, cynthia@andestech.com, az70021@gmail.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBcHIgOCwgMjAyNCBhdCAzOjQ44oCvUE0gSHVpIE1pbiBNaW5hIENob3UgdmlhIGx0
cCA8bHRwQGxpc3RzLmxpbnV4Lml0Pgp3cm90ZToKCj4gV2hlbiB0ZXN0aW5nIHZpYSBORlMgbW91
bnQgTFRQIGZvbGRlciBvbiB0aGUgYm9hcmQsIHdpdGggdGhlIE5GUyBzZXJ2ZXIKPiBjb25maWd1
cmVkIHVzaW5nICdhbm9udWlkJyBhbmQgJ2Fub25naWQnIG9wdGlvbnMgdG8gc2V0IHNwZWNpZmlj
Cj4gdWlkL2dpZCwgd2FpdGlkMTAgZmFpbHMuIFRoaXMgaXMgZHVlIHRvIGEgdWlkIG1pc21hdGNo
IGR1cmluZyBjb3JlIGR1bXAKPiBmaWxlIGNyZWF0aW9uLCBsZWFkaW5nIHRvIGFuIGFib3J0ZWQg
ZHVtcCwgcmVzdWx0aW5nIGluIHRoZSBjaGlsZAo+IHByb2Nlc3MgcmVjZWl2aW5nIHRoZSBzaWdu
YWwgQ0xEX0tJTExFRCBpbnN0ZWFkIG9mIENMRF9EVU1QRUQuCj4KPiAgICMgLi93YWl0aWQxMAo+
ICAgdHN0X2J1ZmZlcnMuYzo1NjogVElORk86IFRlc3QgaXMgdXNpbmcgZ3VhcmRlZCBidWZmZXJz
Cj4gICB0c3RfdGVzdC5jOjE3MzI6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNDAxMjkKPiAgIHRz
dF90ZXN0LmM6MTYxNjogVElORk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwNW0gMDBzCj4gICB3
YWl0aWQxMC5jOjY0OiBUSU5GTzogUmFpc2luZyBSTElNSVRfQ09SRSBybGltX2N1cj0wIC0+IDAK
PiAgIFsgIDI5Ni40ODI2NjVdIG1udF91aWQ9IDEwMzYsIGN1cnJfdWlkPSAwCj4gICBbICAyOTYu
NDgzMDQxXSBDb3JlIGR1bXAgdG8gY29yZSBhYm9ydGVkOiBjYW5ub3QgcHJlc2VydmUgZmlsZSBv
d25lcgo+ICAgd2FpdGlkMTAuYzozNjogVFBBU1M6IHdhaXRpZChQX0FMTCwgMCwgaW5mb3AsIFdF
WElURUQpIHBhc3NlZAo+ICAgd2FpdGlkMTAuYzozNzogVFBBU1M6IGluZm9wLT5zaV9waWQgPT0g
cGlkY2hpbGQgKDE0OSkKPiAgIHdhaXRpZDEwLmM6Mzg6IFRQQVNTOiBpbmZvcC0+c2lfc3RhdHVz
ID09IFNJR0ZQRSAoOCkKPiAgIHdhaXRpZDEwLmM6Mzk6IFRQQVNTOiBpbmZvcC0+c2lfc2lnbm8g
PT0gU0lHQ0hMRCAoMTcpCj4gICB3YWl0aWQxMC5jOjQyOiBURkFJTDogaW5mb3AtPnNpX2NvZGUg
KDIpICE9IENMRF9EVU1QRUQgKDMpCj4KPiBUaGVyZWZvcmUsIGFkZCAubmVlZHNfdG1wZGlyID0g
MSByZWxvY2F0ZXMgdGhlIHdvcmtpbmcgZGlyZWN0b3J5IHRvCj4gdGVtcG9yYXJ5IGRpcmVjdG9y
eSwgcHJldmVudGluZyBjb3JlIGZpbGUgY3JlYXRpb24gZmFpbHVyZXMgZHVlIHRvCj4gTkZTIHNl
cnZlciBzZXR0aW5ncy4KPgo+IFNpZ25lZC1vZmYtYnk6IEh1aSBNaW4gTWluYSBDaG91IDxtaW5h
Y2hvdUBhbmRlc3RlY2guY29tPgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+CgotLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy93YWl0aWQvd2FpdGlkMTAu
YyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3dhaXRpZC93YWl0aWQxMC5jCj4gYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3dhaXRpZC93YWl0aWQxMC5jCj4gaW5kZXggZTU1ZTg4YzIzMjVl
Li45MTAwY2MyZDdhNTQgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy93
YWl0aWQvd2FpdGlkMTAuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvd2FpdGlk
L3dhaXRpZDEwLmMKPiBAQCAtNzYsNCArNzYsNSBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRl
c3QgPSB7Cj4gICAgICAgICAgICAgICAgIHsmaW5mb3AsIC5zaXplID0gc2l6ZW9mKCppbmZvcCl9
LAo+ICAgICAgICAgICAgICAgICB7fSwKPiAgICAgICAgIH0sCj4gKyAgICAgICAubmVlZHNfdG1w
ZGlyID0gMSwKPiAgfTsKPiAtLQo+IDIuMzQuMQo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApM
aSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
