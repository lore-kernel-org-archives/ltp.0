Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45E2CCF9F0
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 02:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761877671; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ay4wRmeIMs/HiOPi2Sj/apKN/IiNZtlWdDuq82GQJ7U=;
 b=AVcn9QdmV60ThRRRCAawlqcdrEA6s8PC18CLaapJU0lDm74Sw1JBLgGoOxQ7wmi4IZHpK
 7ZxhBT0VdIMSttVcdoDIRffCMSMBLoXscSvRSsJCVOMrd6rsLwSxgtewDDqiXA/fpd9/MUm
 GkitD6Avmz8dOXk2pj2kAfrgjHXWKpM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 867BE3CC20B
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 03:27:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C73793C0372
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 03:27:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1069420091A
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 03:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761877648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avn9tEjyJeb2xkM43RE4UYPaJaz5ADBnFOQvyrvvTHI=;
 b=VOhdK6fDe+1G/BQERW0nsr19hK8sMVKH7okhOSrQB1TAgiESpoe6mwfNJDyNm+FwFO7Ygh
 PqOxMxDA0KBHRStUVLQCai3F31OvrZFwtTCesf8vn3f+uUf/IMA75cx/Gtyn+o8ky5Huxt
 3Q0OiauZEEZRCssFALqts22jhxC+w1A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-6ibIlAGDMeKWojLZk5mEeA-1; Thu, 30 Oct 2025 22:27:26 -0400
X-MC-Unique: 6ibIlAGDMeKWojLZk5mEeA-1
X-Mimecast-MFC-AGG-ID: 6ibIlAGDMeKWojLZk5mEeA_1761877645
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-290c9724deeso17065625ad.2
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 19:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761877645; x=1762482445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avn9tEjyJeb2xkM43RE4UYPaJaz5ADBnFOQvyrvvTHI=;
 b=wo8z5EiHgvQsmi5tg3Sz0fpqxQzrQezdhEbDbtO0XDxMK/68R2+3vb2B+P2Ek2lD7m
 MXdG0f7JYbnEPux4tLqiVyjh/V7VbqJ2RuByDiwJLch5ASDNqgF6wRFG4J81UG3gqYsA
 dWRaVpNc9fKd1lPBhTehiZQQ1mtqrGgxvg0qgjDgXOB0x7n5B0IIv5vzsPyBV0bW3cN3
 EOHlqrtICdNbsGnwq7km6VU49CDTK+ftUOIc/4bFqtRrXiNlHE616QN1vuTiv8EOynOf
 eTj8ZiOSpILzEusMqU5GCLxdvV3IBtVEp+HtJ/36LaITN0Ak4UCLBXIVsL1iIC0f30Bu
 NTPQ==
X-Gm-Message-State: AOJu0YwoNGmR14anTjLEQPZMj8DLsgzQdyjIubPMSBiv9Yx9FIwGKP5M
 TEYeeeoVGlPR0zpVUI6tzDewDUhjqrKaeeHs2H3yH691iss170PUC2x3Fut5/x9QpoQfPEj9aCi
 sKQsvUWVtc2lf90ImJWkHNRBCmYMFHAkz6Tyk33UE6mLwr7+28xKyTfy7EZX0xkEG+HrYcu5+Gr
 TBziv+YKsGSkI8BNdavXsYiooTEj8=
X-Gm-Gg: ASbGncuJmYRv8Qjm0r/R2v1jz2VDTn6furhM2a+SEBnbjgOsOLSL1avrm0j/5qlbZ20
 N9kh8TKw9vECVpaGRHNf9h7u3JoPAZE+89k0vTVqdChHVXfgxTqGPgwOb0SS5CHHE8ErV7pP68E
 ajiI4OgSMIpjVnKO1QuRX96+HtRYsUwP7QEF59TpC0zpirKV+1TumahGx+
X-Received: by 2002:a17:902:778a:b0:264:a34c:c6d with SMTP id
 d9443c01a7336-2951a459ba5mr17693475ad.37.1761877645039; 
 Thu, 30 Oct 2025 19:27:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3mrQVOdMbrie8MFxTAX0UtwcAc/GBHdD9kKranGUrv1yjlKlA3VBF/KpsOdEKKEp82paD5yjl1j5WlbqpFCc=
X-Received: by 2002:a17:902:778a:b0:264:a34c:c6d with SMTP id
 d9443c01a7336-2951a459ba5mr17693285ad.37.1761877644529; Thu, 30 Oct 2025
 19:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251030113534.67798-1-liwang@redhat.com>
 <20251030202935.GE753947@pevik>
In-Reply-To: <20251030202935.GE753947@pevik>
Date: Fri, 31 Oct 2025 10:27:08 +0800
X-Gm-Features: AWmQ_bkp5nk0uMRUfWgxyts1-pFv9gg3amQUuTAAjncZ-111xkI9CSZYUjS8fVY
Message-ID: <CAEemH2eVKTbukjE9kUZOJSrQcfC+9+tj7eOjQqvPbwAS=gWkpQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yVEPlBlz5Jjj_xepdpvjckdQh4wLC7wRKewMjg5jdkQ_1761877645
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] hugeshmctl02: set 2 huge pages as an enforced
 requirement
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
Cc: ltp@lists.linux.it, Luiz Capitulino <luizcap@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBPY3QgMzEsIDIwMjUgYXQgNDoyOeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IFNldCBodWdlc2htY3RsMDIgdG8gcmVxdWlyZSBl
eGFjdGx5IDIgSHVnZVRMQiBwYWdlcyBhbmQgYmFpbCBvdXQKPiA+IGNsZWFubHkgaWYgdW5hdmFp
bGFibGUuIFRvIHByZXZlbnQgc2htZ2V0IEVJTlZBTCBmYWlsdXJlcyBzZWVuIHdoZW4KPiA+IHRo
ZSBlbnZpcm9ubWVudCBjYW5ub3QgcHJvdmlkZSBlbm91Z2ggaHVnZXBhZ2VzLgo+Cj4gSSBzZWUg
IlRDT05GOiBObyBlbm91Z2ggaHVnZXBhZ2VzIGZvciB0ZXN0aW5nLiIgb24gcHBjNjRsZSBvbiBU
dW1ibGV3ZWVkLAo+IGhvcGVmdWxseSBpdCB3aWxsIGhhdmUgMiA6KS4KPgo+IFJldmlld2VkLWJ5
OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKUGF0Y2ggbWVyZ2VkLCB0aGFua3MhCgot
LSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
