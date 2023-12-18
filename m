Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C5BC46CA2
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 07:38:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B1723CACE7
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 08:38:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 015223C99F7
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 08:38:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E02FB1A010FE
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 08:38:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702885088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B88m917Y5FMLl1drblUU5OmE5Cq109DtVgn1Z9Ya2hk=;
 b=V7rZNbGjqNrZYcL7n8CxYFmOEt2r5tYyZqldm7kSSLjD2HXqDUy1J9XxqxrkWOCq1FDM4V
 X1amkEAYDH/8pKgSxnlN6DgfzAwlD5Xx1JSXM0ORqunyw+ZV7rcsWFDwBf2HmbrSgJZ96k
 +eABQguKVmrgnuvR/yNmPMmzYc8eHYE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-Iy0RfpJ5P_CZ4DBdB3BBNQ-1; Mon, 18 Dec 2023 02:38:06 -0500
X-MC-Unique: Iy0RfpJ5P_CZ4DBdB3BBNQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50be177a378so1844573e87.1
 for <ltp@lists.linux.it>; Sun, 17 Dec 2023 23:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702885084; x=1703489884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B88m917Y5FMLl1drblUU5OmE5Cq109DtVgn1Z9Ya2hk=;
 b=erdDwCm6WP2BDzhKrx3L9+369wneKC1hWGAUdATYSQULxEOug/RBOzxbwTiXO1Dtq+
 f+Zo1AkShAPZCcOpfDqoSHyuDBLlzN2mWJUMdDdtRfQ3Y01IPjoKY28d3PtY2chqa0in
 TRi6a+CJRUFF10QZIdhrMLcdWz12PgfPwbMmkPtecK3sQLtcyrI5eJEQrmtbgfN0rbAs
 xfVXY0zitrtM0kfW7QoC+A/KW4WlUSZmn8zuD3SmqhlE4ifAGoQBcHcd89RGycVQOfC+
 vDI3AIT0PBhfE26vWVCi9tVNTXCKxKbeqEdXG8s3acl9msUThaSQ/X559DxnXBpI+6+M
 RcIg==
X-Gm-Message-State: AOJu0YxNTUQEOekmYTKryBI2JeLB6uryiRGvWoLDIQe/qCvfmIEHBy/P
 5Koc7NL2vEVQ8wHs7nw5VkOrjiDq8xpw0K9zvein4if+Uxv/Lg6Fl74kE5RThY/ObE9cjR+Lpfs
 BqI2jgMxco5KRWbkfGgGn55EItU853MRNQZvDRg==
X-Received: by 2002:a05:6512:48d4:b0:50e:3691:7e69 with SMTP id
 er20-20020a05651248d400b0050e36917e69mr279045lfb.222.1702885083813; 
 Sun, 17 Dec 2023 23:38:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVu9hEfP/wz5LQB6tLGIxj1JY+mkPl5c7YLGm9kFsIyRZwGhIGEaVDDYCIk04YtNANIkbAqN/SB0otVUTTReQ=
X-Received: by 2002:a05:6512:48d4:b0:50e:3691:7e69 with SMTP id
 er20-20020a05651248d400b0050e36917e69mr279042lfb.222.1702885083496; Sun, 17
 Dec 2023 23:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20231214063311.2325-1-wegao@suse.com>
 <20231214071321.9863-1-wegao@suse.com>
 <20231214071321.9863-3-wegao@suse.com>
In-Reply-To: <20231214071321.9863-3-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Dec 2023 15:37:51 +0800
Message-ID: <CAEemH2fGG-2b5N3u5bgFYyqRa2HC+ZjmKJGj_p3NE0XvRKxgOQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/2] swapping01.c: Reporting /proc/meminfo
 during test
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

SGkgV2VpLAoKVGhlIHByaW50IG9mIG1lbWluZm8gd2lsbCBoZWxwIHRvIGRlYnVnIGJ1dCB0aGUg
bmVnYXRpdmUKaXMgdG8gbWVzcyB1cCB0aGUgdGVzdCBsb2cgaW4gTFRQLgoKU28sIGNhbiB3ZSBh
Y2hpZXZlIGFuIGltcGxpY2l0IHdheSBmb3IgZGVidWcgcHJpbnRpbmcgYW5kIG9ubHkKZW5hYmxl
IGl0IGJ5IHVzaW5nIGFkZGl0aW9uYWwgcGFyYW1ldGVycz8KCmUuZy4gLi9zd2FwcGluZzAxIC1E
ICgtLWRlYnVnKQoKCk9uIFRodSwgRGVjIDE0LCAyMDIzIGF0IDM6MTTigK9QTSBXZWkgR2FvIHZp
YSBsdHAgPGx0cEBsaXN0cy5saW51eC5pdD4gd3JvdGU6Cgo+IEdldCBjbGVhciBvdmVydmlldyBt
ZW1vcnkgc3RhdHVzIGR1cmluZyB0ZXN0IGlzIGdvb2QgZm9yIGRlYnVnLCBzdWNoIGFzCj4gZ2V0
IHJlcG9ydCBiZWZvcmUgdGhlIHRlc3QgYW5kIGFsc28gYXQgdGhlIG1vbWVudCBvZiB0aGUgZmFp
bHVyZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+IC0tLQo+
ICB0ZXN0Y2FzZXMva2VybmVsL21lbS9zd2FwcGluZy9zd2FwcGluZzAxLmMgfCAzICsrKwo+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vc3dhcHBpbmcvc3dhcHBpbmcwMS5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL21l
bS9zd2FwcGluZy9zd2FwcGluZzAxLmMKPiBpbmRleCBmYzIyNWU0YTYuLmY3NzI0ZTdlMSAxMDA2
NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9zd2FwcGluZy9zd2FwcGluZzAxLmMKPiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9zd2FwcGluZy9zd2FwcGluZzAxLmMKPiBAQCAtODMs
NyArODMsOSBAQCBzdGF0aWMgdm9pZCB0ZXN0X3N3YXBwaW5nKHZvaWQpCj4KPiAgICAgICAgIHN3
aXRjaCAocGlkID0gU0FGRV9GT1JLKCkpIHsKPiAgICAgICAgIGNhc2UgMDoKPiArICAgICAgICAg
ICAgICAgdHN0X3ByaW50X21lbWluZm8oKTsKPiAgICAgICAgICAgICAgICAgZG9fYWxsb2MoMCk7
Cj4gKyAgICAgICAgICAgICAgIHRzdF9wcmludF9tZW1pbmZvKCk7Cj4gICAgICAgICAgICAgICAg
IGRvX2FsbG9jKDEpOwo+ICAgICAgICAgICAgICAgICBleGl0KDApOwo+ICAgICAgICAgZGVmYXVs
dDoKPiBAQCAtMTQ2LDYgKzE0OCw3IEBAIHN0YXRpYyB2b2lkIGNoZWNrX3N3YXBwaW5nKHZvaWQp
Cj4KPiAgICAgICAgIHN3YXBwZWQgPSBTQUZFX1JFQURfUFJPQ19TVEFUVVMocGlkLCAiVm1Td2Fw
OiIpOwo+ICAgICAgICAgaWYgKHN3YXBwZWQgPiBtZW1fb3Zlcl9tYXgpIHsKPiArICAgICAgICAg
ICAgICAgdHN0X3ByaW50X21lbWluZm8oKTsKPiAgICAgICAgICAgICAgICAga2lsbChwaWQsIFNJ
R0NPTlQpOwo+ICAgICAgICAgICAgICAgICB0c3RfYnJrKFRGQUlMLCAiaGVhdnkgc3dhcHBpbmcg
ZGV0ZWN0ZWQ6ICIKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIlbGQgTUIgc3dh
cHBlZC4iLCBzd2FwcGVkIC8gMTAyNCk7Cj4gLS0KPiAyLjM1LjMKPgo+Cj4gLS0KPiBNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
