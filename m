Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A196FC2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 10:01:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 243213D131A
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 12:01:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 747EF3D0FB1
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 12:00:49 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 65EC01A0C27E
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 12:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719482446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Xia0YONTL0gMhdHL/h97ohF45+4Q6H37NuI59T9nDU=;
 b=A/NsloXqGCZHRbF+59xZp4l4U2FjptIlUKC1x+zHHg5YdjciIzLI7C0v42UFEtn2vKFXMj
 DovVKmK8tWeQvI0A7wCt4EGCUjN9olXOq4tWnB/CpQSFofYq5CJn8kEuTlbDQRanHdOBlB
 uuLfTA0xN0DVrHO4DwXsNvsG52FRfZ4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-RcIDWnauPR2rCgm4kgS-IA-1; Thu, 27 Jun 2024 06:00:44 -0400
X-MC-Unique: RcIDWnauPR2rCgm4kgS-IA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7065ba27265so9079341b3a.0
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 03:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482444; x=1720087244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Xia0YONTL0gMhdHL/h97ohF45+4Q6H37NuI59T9nDU=;
 b=uz4Gc3X6TrqHqouQMROnc/P3RkICa0AZyThms1AQ0U/ieWk22Qg26kkj+g6iR2aUVw
 rIGrY+56OFPEAG91lujJSXF9RvdLB5pWd5grmJeEzzzrT+1AS2VdYkixvnZwXX3wehvv
 rgGHPmo04fcGtfGFEVDCTKu0WIZvZDqWm89njnRfwWuibg7jJb09338cbOhmBj7x83ur
 svFwnl1ZB9IL7Udh1i/LMSw6Fatsm8XJXGxmqt1yHPvQEaUkCPThThgrQkhTp0mO7DNS
 kyrzltlFVS01WUzkClKIXXHpz6ag+//8IDUMpwBhovQw9NyKufrizTJ9Eg+m8LlJwOJu
 GNzA==
X-Gm-Message-State: AOJu0YwMYywYpfHvWcHyaqY7RpGQSOdOIFXOdevi1K2x2xINAB1t4JIH
 A5RBALQWV6270S7fcJKFF/t/mlxXPtkAABdbCChqOlh0W5vCmYNyKdTWpyBnu9w1Cj7nC4+JV4H
 GJrnHlBkW0VhVYISpcIGLs+G3sVJ5PXzyn/xziviPMPtSxO+3CrG2+9tKojtg8GKOplx7WTQ+gw
 WSP4SNXJR3hVBBLklgYpQ1CUw=
X-Received: by 2002:a05:6a20:4908:b0:1be:c5d9:5a19 with SMTP id
 adf61e73a8af0-1bec5d95c47mr3191167637.24.1719482443621; 
 Thu, 27 Jun 2024 03:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ8rTbyTJAbEd1rCNSWgOinwLcxyBAgXxoax3Gg6fPltTXwFMFhPDIbPRFA/7cUtOLgfFYzAGo7LDqLuHTKMQ=
X-Received: by 2002:a05:6a20:4908:b0:1be:c5d9:5a19 with SMTP id
 adf61e73a8af0-1bec5d95c47mr3191136637.24.1719482443203; Thu, 27 Jun 2024
 03:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240627021947.13718-1-kuan-ying.lee@canonical.com>
 <20240627094216.2204110-1-po-hsu.lin@canonical.com>
In-Reply-To: <20240627094216.2204110-1-po-hsu.lin@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 27 Jun 2024 18:00:30 +0800
Message-ID: <CAEemH2emVepTL56Tcu9bYnvq9fXU9bA3WJnzuh1KBxKmo_ji0g@mail.gmail.com>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] kallsyms: check if CONFIG_KALLSYMS=y
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
Cc: kuan-ying.lee@canonical.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UGF0Y2ggYXBwbGllZCwgdGhhbmsgeW91IGJvdGghCgpPbiBUaHUsIEp1biAyNywgMjAyNCBhdCA1
OjQz4oCvUE0gUG8tSHN1IExpbiA8cG8taHN1LmxpbkBjYW5vbmljYWwuY29tPiB3cm90ZToKCj4g
VGVzdGVkIHdpdGggVWJ1bnR1IEphbW15IEtWTSBrZXJuZWwsIHRoaXMgdGVzdCB3aWxsIGJlIHNr
aXBwZWQgYXMKPiBleHBlY3RlZC4KPgo+IDw8PHRlc3Rfc3RhcnQ+Pj4KPiB0YWc9a2FsbHN5bXMg
c3RpbWU9MTcxOTM5NjI3Ngo+IGNtZGxpbmU9ImthbGxzeW1zIgo+IGNvbnRhY3RzPSIiCj4gYW5h
bHlzaXM9ZXhpdAo+IDw8PHRlc3Rfb3V0cHV0Pj4+Cj4gaW5jcmVtZW50aW5nIHN0b3AKPiB0c3Rf
a2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnCj4gJy9saWIvbW9kdWxl
cy81LjE1LjAtMTA2MS1rdm0vYnVpbGQvLmNvbmZpZycKPiB0c3Rfa2NvbmZpZy5jOjUzMTogVElO
Rk86IENvbnN0cmFpbnQgJ0NPTkZJR19LQUxMU1lNUz15JyBub3Qgc2F0aXNmaWVkIQo+IHRzdF9r
Y29uZmlnLmM6NDc3OiBUSU5GTzogVmFyaWFibGVzOgo+IHRzdF9rY29uZmlnLmM6NDk1OiBUSU5G
TzogIENPTkZJR19LQUxMU1lNUz1uCj4gdHN0X3Rlc3QuYzoxMTkyOiBUQ09ORjogQWJvcnRpbmcg
ZHVlIHRvIHVuc3VpdGFibGUga2VybmVsIGNvbmZpZywgc2VlCj4gYWJvdmUhCj4gPDw8ZXhlY3V0
aW9uX3N0YXR1cz4+Pgo+IGluaXRpYXRpb25fc3RhdHVzPSJvayIKPiBkdXJhdGlvbj0wIHRlcm1p
bmF0aW9uX3R5cGU9ZXhpdGVkIHRlcm1pbmF0aW9uX2lkPTMyIGNvcmVmaWxlPW5vCj4gY3V0aW1l
PTAgY3N0aW1lPTAKPiA8PDx0ZXN0X2VuZD4+Pgo+IElORk86IGx0cC1wYW4gcmVwb3J0ZWQgYWxs
IHRlc3RzIFBBU1MKPgo+IFRlc3RlZC1ieTogUG8tSHN1IExpbiA8cG8taHN1LmxpbkBjYW5vbmlj
YWwuY29tPgo+IFJldmlld2VkLWJ5OiBQby1Ic3UgTGluIDxwby1oc3UubGluQGNhbm9uaWNhbC5j
b20+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
