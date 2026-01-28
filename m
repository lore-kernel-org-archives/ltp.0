Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05619D35661
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 00:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769561509; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Jmjz0UVZoWW84YnMQ0xOnsQAoTfIwn8uxQyowBzVnlo=;
 b=lh7cU4aGjo+5plVL5S6L0MWfkf65a+FdY6Q45+fwxbrUp8niNFSiUmTdeuRCNgodUbnr8
 rSi7RzbWzoAZqeYKE2ApPkUtaG0IsL23lnqVqSDkcr/8ylwlxQh1qmXy96pIZhCI4k0YcXe
 SGHxHQk9dxXUUp13JSxcI5WMgmo6uOE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A71B73CA059
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 01:51:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33D773C4F49
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 01:51:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 707AE10009AB
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 01:51:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769561482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pKnA7vFs/G3ZJEvNMGijkZlOZqsSSoxUEtjHwNh5JLk=;
 b=ZUURNLLcs3LznqBJB2Ppe1wBm1BwQZgqzz6tXehgp/ea0C86G8GovbrkTLSWJeCeVNnMcK
 33yilr6zenOuBz4hac6fwrw58EAdsZ+Fvtdarw2JtzgkgR0XI7jMY5gcYoG6tPGFWRBPGa
 yswiBcn5qKih1wUQnVlwHejdXiPFMWE=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-pmKMBNAjM6exfqcRcSIayQ-1; Tue, 27 Jan 2026 19:51:16 -0500
X-MC-Unique: pmKMBNAjM6exfqcRcSIayQ-1
X-Mimecast-MFC-AGG-ID: pmKMBNAjM6exfqcRcSIayQ_1769561475
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-124a95d580cso2236663c88.1
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 16:51:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769561475; x=1770166275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKnA7vFs/G3ZJEvNMGijkZlOZqsSSoxUEtjHwNh5JLk=;
 b=pEmMSQWUGox1g0Z/19dXCk197cHbsNlkFrbQ1caxfrMMfXGqeibBpa5hXWQlUdySm6
 YZZwZQCwXB7EcMYvcVG+hUFW4w4KQ/rqCeWTPk0d1FfM5rIJaBDfxOYEQr6ObOU+A3as
 M+NBN9scoAyuqzTY08EXKSrHMKmoTurTK+ldliBnSdooebofkeQdvQYY7kcW8/hxguXG
 xBCgSYcBsNRHpHRv1UPLCXkxMFf8f9Du/IGQETDQfBg5FG7FrmXvswB7FSUgO1si31LI
 kvqThooFD47SyV5qjLDtIY/XLEpvlA8/0KjezpjIRdPabFDtcSoU+9F8nMV2pfqRw8LQ
 iyYQ==
X-Gm-Message-State: AOJu0YyNBBsF9GXCaiA2HZ4VuWyc/KwUCfWkeMREy87Ble2H/havj8Te
 D+FuWFiQgcnOscRkBH2i4lGRKyNS0X2+y3rEUSBmyg2MT4baH3CgfXQzBC5qiMKFd2/fpmjtcgS
 jUcRZ+ANm5jDuHuvjM0hupkqrZ2C4Tex2U4frQToSRLv5CIpmEhuDBas0yRe9lCTNdIyVlMxmqL
 XJMfBsbd/h4vv7bcNejzLH1AOwIM3CazXmUhJtIA==
X-Gm-Gg: AZuq6aKqhM5LG/dtrxVtjlTXJem9+xvN8c3EwAE7QlFTOo9Uz2/NqHEQ465ciVZ/adE
 ulemDE+sHvkg1p7MJHtC2ooFbNCwXROnX7XBE9SIXIbzMQ20sa3S/TA6Ez4rRhrNNSj3StLypT8
 csvMsiGH2beJ7B5/5dB5+l+E49AusT6MhmKtHLxJGMNKILmsBR7Yhav5rdSnybTK8HAas=
X-Received: by 2002:a05:7022:252a:b0:11b:9386:a3c9 with SMTP id
 a92af1059eb24-124a00d66e9mr2302728c88.42.1769561474642; 
 Tue, 27 Jan 2026 16:51:14 -0800 (PST)
X-Received: by 2002:a05:7022:252a:b0:11b:9386:a3c9 with SMTP id
 a92af1059eb24-124a00d66e9mr2302717c88.42.1769561474106; Tue, 27 Jan 2026
 16:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20260127131427.146592-1-pvorel@suse.cz>
In-Reply-To: <20260127131427.146592-1-pvorel@suse.cz>
Date: Wed, 28 Jan 2026 08:51:02 +0800
X-Gm-Features: AZwV_QiS2c2NilMUcJL1fUAJjL3pqABDL92hM0tbyJc115UiBqBhenYBgr4ZJfk
Message-ID: <CAEemH2fOwZFDmSyzXKEAq89ukF=8i-YeQUX6ZF7b6sis79-1Ew@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ztWpQb2sYqrqtOIFZ8r-nd8-SbItU6tjptRMDhGuTeg_1769561475
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] tst_net.sh: Print netstress.c logs on
 unexpected error
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

T24gVHVlLCBKYW4gMjcsIDIwMjYgYXQgOToxNeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gV2hlbiB0aGVyZSBpcyBhbiB1bmV4cGVjdGVkIGVycm9yLCBsb2dzIHNo
b3VsZCBiZSBwcmludGVkIGFzIHdlbGwgdG8KPiBrbm93IHRoZSByZWFzb246Cj4KPiAgICAgdGNw
X2Zhc3RvcGVuX3J1biAxIFRJTkZPOiBydW4gc2VydmVyICduZXRzdHJlc3MgLXQgMCAtZCBsdHBf
bnNfdmV0aDEKPiAtUiAzIFwKPiAgICAgICAgIC1CIC90bXAvTFRQX3RjcF9mYXN0b3Blbl9ydW4u
VHB3U2xTb2dCSicKPiAgICAgdGNwX2Zhc3RvcGVuX3J1biAxIFRJTkZPOiBydW4gY2xpZW50ICdu
ZXRzdHJlc3MgLWwgLXQgMCAtSCAxMC4wLjAuMSAtZAo+IGx0cF9uc192ZXRoMiBcCj4gICAgICAg
ICAtYSAyIC1yIDIwMDAgLWMKPiAvdG1wL0xUUF90Y3BfZmFzdG9wZW5fcnVuLlRwd1NsU29nQkov
dHN0X25ldGxvYWQucmVzJyA1IHRpbWVzCj4gICAgIHRjcF9mYXN0b3Blbl9ydW4gMSBUV0FSTjog
bmV0c3RyZXNzIGZhaWxlZCwgcmV0OiA2Cj4gICAgIHRjcF9mYXN0b3Blbl9ydW4gMSBUUEFTUzog
bmV0c3RyZXNzIHBhc3NlZCwgbWVkaWFuIHRpbWUgMTIzIG1zLCBkYXRhOgo+IDExOCAxMjQgMTIy
IDEyNQo+Cj4gV2hpbGUgYXQgaXQsIGZhY3RvciBvdXQgbG9nZ2luZyBjb2RlIGludG8gbmV3IGZ1
bmN0aW9uCj4gdHN0X25ldGxvYWRfcHJpbnRfbG9nKCkuCj4KPiBGaXhlczogZGExNmI2NjRlNyAo
ImxpYi90c3RfbmV0OiBjYWxjIG1lYW4gaW4gdHN0X25ldGxvYWQoKSIpCj4gU2lnbmVkLW9mZi1i
eTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
