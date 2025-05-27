Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97870C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748339374; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4PlaIuqQU3LaDXoPChXPHF+GX/5jkFBMR9eJYgIxU7s=;
 b=hJUaU8QJiGWeO5Wf4VZJmkQtQSr7T5Sk/iehIHe/9Xxyz4wPtcnHzqOoBTnnfjDePv3vE
 tcGPwnMbEYY6w9XWixS828y/JCl0+Zi9SVu9d/AxP7/yPJHlrxyZiofWLyq427mWLaMx002
 yRjeoajvTSxyCU4uOQmbrje+2JdTzuc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01B983C5502
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:49:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E64C53C2C13
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:49:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 38558200045
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:49:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748339349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANrHpcPH7e+Dj7pcPyY3NkL77rUEubi8vgitXKwm+RY=;
 b=fXW6BPeAYmoFpgB4vu8lUFOQeDq6qGPZu5l6plEaSzERPwkXNp15yk4BxEmUinRCJSMHy5
 SI+Co9hFN1YLyjE9LZn/+igS/FCsNNj+cpmwk8iIcwNV0rehupfsDBmTX3G7lYmOhFyKDH
 W/NKoTJdSsjPurrelS0twODe9d7fo7Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-7HeMQLFcNCmUBmobOpr_Xw-1; Tue, 27 May 2025 05:49:07 -0400
X-MC-Unique: 7HeMQLFcNCmUBmobOpr_Xw-1
X-Mimecast-MFC-AGG-ID: 7HeMQLFcNCmUBmobOpr_Xw_1748339346
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3108d54d423so3012246a91.1
 for <ltp@lists.linux.it>; Tue, 27 May 2025 02:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748339344; x=1748944144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANrHpcPH7e+Dj7pcPyY3NkL77rUEubi8vgitXKwm+RY=;
 b=sJ0m2k38WNLTYXPxVa04cguAeXSrakLIFjUMJOwUfNGNXFoeRwoQzLBxhqY25IAhHQ
 Lc+/xpKMG2i4YKLCjdDDRGFPNqtSUgvA5EObZ+b5nXmECfEBs0+qRAWrKZyg6FwVXzaC
 +Iv8aek0WW6tudRXCiIHDde2KF6tH4YdG6STT60VBdGmC0JB/pR76FYvffawLzudTN4D
 YoAfKwA8fE5RPnF0bvrhhYGDTjmjw6SNNN0seIMbHKX54ruajQRm80zeMHEYhNXEfxJV
 z7l4Z/x80XbLzVJRZBX2gjwBFAceQYleza4deTRMNACuC6hGG2c9xsprOfvnn2UYipPf
 HF8A==
X-Gm-Message-State: AOJu0YwWcJPwk4EK1grYJix9gpFSlQgCW5D3hGXt4kSOojtOQ7/fPE1g
 YZpjTEuRloY2zcRAI9zmmk8icQDabPuG8IRm4fMG07kQaLAK5hVPq/Prjutn/uDGpjgg0Wu1exr
 c6ykGf7hUqzG+GEhAKUmy/cIPrR43AiSWyL+shgUpe55rppP5JQXi7m8PnSF0XVZsPrr0pkN8Dh
 q5/ltCe26XfnZyNc2yMmz0A8kwHlmmVanhXj9w+Q==
X-Gm-Gg: ASbGncvT9MqH6NWVK4bfv3dIU1d9VVnM26kyJxdvmmfGIqoD97es/egeYymRlUa3skv
 hNXeGbNNNrXlBN7BIGNMpUYiFBJKagw2pabA8KaG4nOoGhABEHoK56gy4Dp9YmNm9nYvOiw==
X-Received: by 2002:a17:90b:17c1:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-311085b18b5mr20075499a91.0.1748339344176; 
 Tue, 27 May 2025 02:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiTvE7HVW9kdQ1/ZwlIj/0sd1c/wCIk043/xfFk48fvmC/UOk53rD3AUuhqVyVe/h2idcH8O8/17pybQK6m0g=
X-Received: by 2002:a17:90b:17c1:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-311085b18b5mr20075465a91.0.1748339343747; Tue, 27 May 2025
 02:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250527094415.4760-1-andrea.cervesato@suse.de>
In-Reply-To: <20250527094415.4760-1-andrea.cervesato@suse.de>
Date: Tue, 27 May 2025 17:48:51 +0800
X-Gm-Features: AX0GCFuI73S3J80h7cx6vJsiwUFAdk4Zl5Ukwyk1bAlOampPwxH489K8XG18dq8
Message-ID: <CAEemH2f5v_=gDjFr=LMOKBatj8hMf-=ZOhS8k=T8mr7GvsNt9A@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q3fmA5TWLP1G8W30m0sX7NsMTSy1XcwS-X-ug2Eu-KE_1748339346
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kirk: version 2.1
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

SGkgQW5kcmVhLAoKU3BlYWtpbmcgb2YgS2lyayByZW1pbmRzIG1lIHRoYXQgd2UgZG8gaGF2ZSBh
biBpbnRlcm5hbCBzY3JpcHQKanNvbjJsb2dzLCB3aGljaCBpcyB0YXJnZXRlZCB0byBjb252ZXJ0
IHRoZSBKU09OIGZpbGUgdG8gc29tZSB0cmFkaXRpb25hbApsb2cgKGxpa2UgTFRQIGJlZm9yZSB1
c2VkOiBSVU5URVNULmxvZywgUlVOVEVTVC5ydW4ubG9nLCBldGMpLApkbyB5b3UgdGhpbmsgS2ly
ayBuZWVkcyB0aGF0IG9uZT8KCk5vdGU6IHdlIGNyZWF0ZSB0aGUganNvbjJsb2dzIGJlY2F1c2Ug
d2UgaGF2ZSBzb21lIGZyYW1ld29yawp0byByZWNvZ25pemUgdGVzdCBmYWlsdXJlcyBvciBpbmZv
cm1hdGlvbiBhdXRvbWF0aWNhbGx5IGluIG91ciBiZWFrZXIKc3lzdGVtLgoKVGhlIHVzYWdlIGlz
IHZlcnkgc2ltaWxhciB0byBqc29uMmh0bWw6CgpweXRob24zIGpzb24ybG9ncyAtLXJlc2ZpbGUg
JFJVTlRFU1QuanNvbiAtLXN1bWZpbGUgJFJVTlRFU1QubG9nCi0tcnVuZmlsZSAkUlVOVEVTVC5y
dW4ubG9nIC0tZmFpbGZpbGUgJFJVTlRFU1QuZmFpbC5sb2cKCnB5dGhvbjMganNvbjJodG1sIC1y
ICRSVU5URVNULmpzb24gPiAkUlVOVEVTVC5odG1sCgpPbiBUdWUsIE1heSAyNywgMjAyNSBhdCA1
OjQ04oCvUE0gQW5kcmVhIENlcnZlc2F0bwo8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmRlPiB3cm90
ZToKPgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1
c2UuY29tPgo+IC0tLQo+ICB0b29scy9raXJrIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS90b29scy9raXJrIGIv
dG9vbHMva2lyawo+IGluZGV4IDZkNDE5ZDQxOS4uYTJkNDNlMzAyIDE2MDAwMAo+IC0tLSBhL3Rv
b2xzL2tpcmsKPiArKysgYi90b29scy9raXJrCj4gQEAgLTEgKzEgQEAKPiAtU3VicHJvamVjdCBj
b21taXQgNmQ0MTlkNDE5YTQxNjIzOGM3ODVmNjI2MjEyZDM1ZDE5NDBhMGRmMAo+ICtTdWJwcm9q
ZWN0IGNvbW1pdCBhMmQ0M2UzMDIxNzFmZjYyYTcxN2VjMjVlZWJiYzBiNmY4YTNmZTNlCj4gLS0K
PiAyLjQzLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAKPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
