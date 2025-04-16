Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C0BC369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 07:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744788855; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Gn447bUj8/Ny/F4PHGx3m/x5lUcOw8VnCIgYtDtIAQ0=;
 b=VDStfQoZ7M/rXceJ//7hrxGwQm0ywW/85D+FmhWl7yQl7Pf7NBapXYB4vQN+UvbIxfaVi
 NL0noqX0TIrD3z7iyaOhj/USxoTTcSrd32dFkMG0tMDsnK/0SMLiV9bU3/+3Q96QO5VIDGa
 SILEPCk8pggkBDQGOMLWp8Unsfi05jI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D96CE3CB946
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:34:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A71C53C5814
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:33:54 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E547E1400762
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744788831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lmtRLYkLuGneDaplaL/1RvcdLS9TGEKfscaA1pFSVvI=;
 b=Oo2z2qAlVxJoa5443gK0toz9yM7u2D57ZCPwWYu6eJ1qJQ9yhOVx2Q4EZO+lZiWYhP2A+M
 /oUV8zJgG8T475zwUa1z43+2i1o+oqLMd9KDwjbORKhvOGF2almWmGO/DAmINgyqJ2eKaH
 khUxJ9jkByAtECXQtncxGOa9xRCmpfU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-IymtDwVwMQ2cNP6aWcBqzg-1; Wed, 16 Apr 2025 03:33:50 -0400
X-MC-Unique: IymtDwVwMQ2cNP6aWcBqzg-1
X-Mimecast-MFC-AGG-ID: IymtDwVwMQ2cNP6aWcBqzg_1744788829
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff8119b436so5389625a91.0
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 00:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744788827; x=1745393627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lmtRLYkLuGneDaplaL/1RvcdLS9TGEKfscaA1pFSVvI=;
 b=aa0K7o3WNvBWbIFuxqBwuLPmJByQVs03TjqPHo2SaxdKRiC1nnCWxjBZ5Cz7EuMJzd
 iPaVQjWrn/A0l2NMqVxSqIfGMVjQsuPHLJYFUBZUcyqzIzwagDbusPSICMZwkPOOKQag
 +D0ZXVRBC6ArIAzkGSBHCIiCdieprU0T4nLHAQh1FPM9qcBolwHo1AF9Wd3+AuREpbJY
 IEYqjE8Hj/rMuap/2veLCDB1vOqbbypR7Kk6Ft7ve6b6GuUy0GYVpStWER4VrEu1iofb
 a3LSgEf1BgKH06s4H9w6F/AJQA47suFTTVN9/+O7rJ0gP3RVUKcEidyCQXmIKmpiwJlf
 DB0Q==
X-Gm-Message-State: AOJu0YzS33KVeGSPcsk+KxEetFPjAJylUZKCbptUQuVQkSKtyloor/Rq
 TlWWyXQRry34LKq6g9E4NEHFScraIlM4QvIF2Iv+NvSFk+kyABp5l6Pj6x3lWkTS7/Xl9dlcq38
 eKESOFrZcxFCiSbhfvpeq2NlgxTDb2/HjTMJvoYfn2EyXTieMaEvfOthxXMUqUZrJ9p45gIGptq
 IQ/UW8YaH5SCHwKpj4lSciMwtgLQa2vFBU0ijw
X-Gm-Gg: ASbGncsWUBxpdNPxJxRQXU6SJ0kmzLowohn72fm2kHCHkVDcQNrf/gaNeyh3XAvhRBw
 +PBtOr3GZyWqxnzFtrLokm+QbAd5BIEevS6v7vURT9tdz96EqK2/TPL6yU90f1kUZNWNdsw==
X-Received: by 2002:a17:90b:1f8b:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-30863d1fdbamr1094236a91.5.1744788827542; 
 Wed, 16 Apr 2025 00:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFpKA5SkieR22GHJPciifdORpPb1WZdotQi9O0T0znbmqTIAWfAC45QzEdZ1y8AX5XICrytvUJx49edv/FvZI=
X-Received: by 2002:a17:90b:1f8b:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-30863d1fdbamr1094206a91.5.1744788827096; Wed, 16 Apr 2025
 00:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250416072113.573818-1-pvorel@suse.cz>
In-Reply-To: <20250416072113.573818-1-pvorel@suse.cz>
Date: Wed, 16 Apr 2025 15:33:34 +0800
X-Gm-Features: ATxdqUEOy7Po2Y-OfyMRKuBJXWmm6fUOen9Wh1nwRqf3ubzI6mcjZ64_LsPMMjU
Message-ID: <CAEemH2cFLKwLMCcAPORR5QWeF09=MOWHMgm=FMDF-2n37fbzqw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ukW7AmlN8BVGMq3YrDzxx4SGV0G-iOfwXlJBDT7TM7g_1744788829
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] cgroup_lib.sh: Improve error messages
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

T24gV2VkLCBBcHIgMTYsIDIwMjUgYXQgMzoyMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gQWRkIGEgaGludCBmb3IgZXJyb3Igb24gYSBuZXcgY29udHJvbGxlci4K
Pgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+CgpSZXZpZXdl
ZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgdGVzdGNhc2VzL2tlcm5l
bC9jb250cm9sbGVycy9jZ3JvdXBfbGliLnNoIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9jb250cm9sbGVycy9jZ3JvdXBfbGliLnNoCj4gYi90ZXN0Y2FzZXMva2VybmVsL2Nv
bnRyb2xsZXJzL2Nncm91cF9saWIuc2gKPiBpbmRleCA5ZTU5MjIxYWJiLi44NmE1Y2ViN2Q0IDEw
MDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY2dyb3VwX2xpYi5zaAo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY2dyb3VwX2xpYi5zaAo+IEBAIC0x
MTksMTIgKzExOSwxMiBAQCBjZ3JvdXBfcmVxdWlyZSgpCj4gICAgICAgICByZXQ9JD8KPgo+ICAg
ICAgICAgaWYgWyAkcmV0IC1lcSAzMiBdOyB0aGVuCj4gLSAgICAgICAgICAgICAgIHRzdF9icmsg
VENPTkYgIid0c3RfY2djdGwgcmVxdWlyZScgZXhpdGVkLiBDb250cm9sbGVyIGlzCj4gcHJvYmFi
bHkgbm90IGF2YWlsYWJsZT8iCj4gKyAgICAgICAgICAgICAgIHRzdF9icmsgVENPTkYgIid0c3Rf
Y2djdGwgcmVxdWlyZSAkY3RybCcgZXhpdGVkLiAkY3RybAo+IGNvbnRyb2xsZXIgbm90IGF2YWls
YWJsZT8iCj4gICAgICAgICAgICAgICAgIHJldHVybiAkcmV0Cj4gICAgICAgICBmaQo+Cj4gICAg
ICAgICBpZiBbICRyZXQgLW5lIDAgXTsgdGhlbgo+IC0gICAgICAgICAgICAgICB0c3RfYnJrIFRC
Uk9LICIndHN0X2NnY3RsIHJlcXVpcmUnIGV4aXRlZCIKPiArICAgICAgICAgICAgICAgdHN0X2Jy
ayBUQlJPSyAiJ3RzdF9jZ2N0bCByZXF1aXJlICRjdHJsJyBmYWlsZWQuIExUUAo+IG1pc3Npbmcg
JGN0cmwgY29udHJvbGxlciBzdXBwb3J0PyIKPiAgICAgICAgICAgICAgICAgcmV0dXJuICRyZXQK
PiAgICAgICAgIGZpCj4KPiAtLQo+IDIuNDkuMAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
