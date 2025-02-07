Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F496C0219B
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 09:53:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1CAE3C9364
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 10:53:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3386E3C92F4
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 10:52:47 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4AD30101A590
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 10:52:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738921965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yY5SdndMe1PIaVczBWQC6HBQi0Q44KnZcokpJXPG0/k=;
 b=Sbq71RRx+2tQukUJX/Io61nIbD5P29TwdtYBddh15Make2px6yz2jo2xIp0sqM+FB5XO4j
 7kTAK//6BwWxqD1v8HdOR9aL5FaK4OBt/Nct+ml47GuXersNpQGbHpnP9OKt40DwFwXZcW
 Ui824xYNrUAtdvOqytP69fRSIrKHowU=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-x9p2hMKAN2mufjvl1BOg-A-1; Fri, 07 Feb 2025 04:52:43 -0500
X-MC-Unique: x9p2hMKAN2mufjvl1BOg-A-1
X-Mimecast-MFC-AGG-ID: x9p2hMKAN2mufjvl1BOg-A
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5fc0058d68eso566284eaf.0
 for <ltp@lists.linux.it>; Fri, 07 Feb 2025 01:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738921963; x=1739526763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yY5SdndMe1PIaVczBWQC6HBQi0Q44KnZcokpJXPG0/k=;
 b=dRVgO6JUBmmxdjD21XAr2v+Cb+lBLuPlFYcBTHte+PGK6nfanW4GrW0E3qLHHYMYp2
 4FBz6m5adThlx1v4O8zbZH8bAUs1QHLxZg4Ir1t8iHviizmZtN0jjzSu6Bu9geIkVcax
 wQcqF8xUUe2SW3dzSXB9ZxLHQxGnP+9XIGW+i67AeeNCxw+8lYVjX4d9oj6c8vJTfxS8
 QxfUiT9J4sH5T8pNvsCIsXCGOVEQhUNVtf1gkKVCv+ZlNM3Ur329yAYLV2BFhJ6SAyNs
 IFa86rD2W8E3nV4PwxIxAtN7VHye/thgHID6lsXQiIcIEOMcoU/tDyo7O0r1quo3b+ZO
 z5Pw==
X-Gm-Message-State: AOJu0YzwFBeG+gefNYqluF4AkhmNJvw2Ux1oJYtUR5rp0vwjuDTay2Cp
 EVlbiuwC1LmOk+IbbddpPJQ/YvQNm+i/CZ3ElXVKKg+2DpbaYYSaAudPTb3Ww4eqeDkZRAeSjun
 7fySK29miwV2ZgSj4Va3jrCF7B4GB75qaIYKYlkvRaDYm6jCVWxnT8oEq83lfaGFhU+io7CbG0S
 DZCfKjZSyclpFzovNRDgrdXJk=
X-Gm-Gg: ASbGncshxwDnFnvyvpq2XaLoPtj43FDyC23bzAWz3N+fNOYghWcy6ILTmiaNTg8pGiI
 Mkwb+Ra0P0qCQB9cbBzdVPggJZu6lhWJIuQ/qhT68tC7acyaOA6gFoRMdfwxC+A==
X-Received: by 2002:a05:6820:1845:b0:5fa:9407:a41b with SMTP id
 006d021491bc7-5fc5e45c32cmr1574444eaf.0.1738921962971; 
 Fri, 07 Feb 2025 01:52:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUwULnlIj24w1MABKFJOdmc5Wk29iYRYnsBatbegC8f0Msdp0pqMA6mKItC2x0fO/jC2/22OTrYWbXb2omqoY=
X-Received: by 2002:a05:6820:1845:b0:5fa:9407:a41b with SMTP id
 006d021491bc7-5fc5e45c32cmr1574438eaf.0.1738921962620; Fri, 07 Feb 2025
 01:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20250206022327.11821-1-wegao@suse.com>
In-Reply-To: <20250206022327.11821-1-wegao@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 7 Feb 2025 10:52:26 +0100
X-Gm-Features: AWEUYZnDKFkt1mmRdDIElMEKMKdSbAG0CH0wgEx-t3hELdRI3qxM3Gk9DIulJEM
Message-ID: <CAASaF6ww-4cnZqaytGEMhYCkUWLDpH8eNfXNQy=xmt9W7dNMDA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PWgWA_2Weuc-l2-IgzEcM9u-7_yQ6B3hIzJGr9ALyfw_1738921963
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] hugemmap34: Disable -fstack-clash-protection
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

T24gVGh1LCBGZWIgNiwgMjAyNSBhdCAzOjIz4oCvQU0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+
IHdyb3RlOgo+Cj4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gU3Vn
Z2VzdGVkLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KPgo+IENvbXBpbGlu
ZyBodWdlbW1hcDM0IHdpdGggQ0ZMQUdTPSctZnN0YWNrLWNsYXNoLXByb3RlY3Rpb24nIGNhdXNl
cwo+IGdjYyB0byBpbnNlcnQgYWRkaXRpb25hbCBzdGFjayBhZGRyZXNzIHZhbGlkYXRpb24gY2hl
Y2tzIGR1cmluZwo+IGFsbG9jYSBjYWxscy4gIFRoaXMgcmVzdWx0cyBpbiBrZXJuZWwgc3RhcnQg
YWxsb2NhdGUgbWVtb3J5IHJlYWxseSwKPiBldmVudHVhbGx5IHRyaWdnZXJpbmcgYW4gT09NLgo+
Cj4gQmFzZSBKYW4ncyBzdWdnZXN0aW9uLCBkaXNhYmxlIC1mc3RhY2stY2xhc2gtcHJvdGVjdGlv
biB0byBhbGxvd3MKPiB0ZXN0IHRvIHJ1biBvbiBsYXJnZXIgcG9vbCBvZiBzeXN0ZW1zCj4KPiBT
aWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KClB1c2hlZCB3aXRoIHNtYWxs
IHR3ZWFrcyB0byBjb21taXQgbWVzc2FnZS4KClRoYW5rcywKSmFuCgo+IC0tLQo+ICB0ZXN0Y2Fz
ZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL01ha2VmaWxlIHwgMyArKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvTWFrZWZpbGUgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9o
dWdldGxiL2h1Z2VtbWFwL01ha2VmaWxlCj4gaW5kZXggMmQ2NTFiNGFhLi42ZTcyZTcwMDkgMTAw
NjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9NYWtlZmls
ZQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvTWFrZWZpbGUK
PiBAQCAtOCw0ICs4LDcgQEAgaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvdGVzdGNh
c2VzLm1rCj4gIGluY2x1ZGUgJChhYnNfc3JjZGlyKS8uLi9NYWtlZmlsZS5pbmMKPiAgaW5jbHVk
ZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3RhcmdldC5tawo+Cj4gK0NG
TEFHU19ub19zdGFja19wcm90IDo9ICQoZmlsdGVyLW91dCAtZnN0YWNrLWNsYXNoLXByb3RlY3Rp
b24sICQoQ0ZMQUdTKSkKPiArCj4gIGh1Z2VtbWFwMDY6IENGTEFHUys9LXB0aHJlYWQKPiAraHVn
ZW1tYXAzNDogQ0ZMQUdTPSQoQ0ZMQUdTX25vX3N0YWNrX3Byb3QpCj4gLS0KPiAyLjM1LjMKPgoK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
