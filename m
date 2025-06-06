Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCC6C5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749202601; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AUxYAIgyARz95Tt4sGsuCbxH/ar5HSlZeemdLpPuRgU=;
 b=KnKtrQ0tG+LibXXauoPMkwseaCnUdyRirmKpKInB43fpg1IS8anmlvMfwaYwMQbqTwVwy
 baKDP6rDU8ZJj8ATrwbRZrRN5igUV2Pdns7jdbIssw4Tj0S6HgNV0RJ35NPI0XLWTcjL0rr
 ZHEawCI/H1Xaiz0p1JMzN9Fu2C9cPhE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B49E73C9ACB
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 11:36:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1AA53C0885
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 11:36:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0D5AD600915
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 11:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749202577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ijPnZDQzhN7IzmE77hvvwoU2byvUuIu8JXvRldeUvmM=;
 b=P8oXQWlnN0pEgA1HYmLjfSJaxHpg44b7YF0Rkf+W/TRYOUsGgLwH2RoIo0auO8/mQVD3X9
 OWurw5M9nyPnyRpqrxQGZbmVZneuGzlaZHdK9v1+/9A5EiYfEIAQ1zIYYTl4ucfUJ2SEFe
 YeRXuK/OhgGk4Y6CroWZLnghPDzyUQ0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-vuPjI0pQMjey2mszkIfkOA-1; Fri, 06 Jun 2025 05:36:15 -0400
X-MC-Unique: vuPjI0pQMjey2mszkIfkOA-1
X-Mimecast-MFC-AGG-ID: vuPjI0pQMjey2mszkIfkOA_1749202574
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31315427249so2057094a91.1
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 02:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749202573; x=1749807373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ijPnZDQzhN7IzmE77hvvwoU2byvUuIu8JXvRldeUvmM=;
 b=ABGSBUkamdtIQCgGqVd/nup/Q2nMYuny8jJ+p21x6CcABYBEok3isA7FU1GhcZpJ1z
 KdhUBxfRxzA7nF9Zv5DtFtxNL3YrGFVVgn1kQ2H8vLAt+2+0JzVuYxrvbNckEj01vEjo
 rNOp7IobbFnckCyENMY9MxMsSKh/5N8VkHAX4QtNEQzoAJ06pd6y8IjyApnzaUwjkkGF
 YLmURw02nSWjw+hBRHvZxNiB8cSXEK5OajBUPE9PIdG5Zv5250nJ9tTV+UUJu6Q736IK
 GBraMWWWtFOodgzA9t2jkuHUa7NK2R5HYeMzzP+fd0T27l61bVlaTIzSJc+hl+Ezl7dk
 Mc1A==
X-Gm-Message-State: AOJu0YweHTtwzLrgFua9Q2n7oOBPzhc91jChnwrfqkxxh3V047BpbHCW
 VbwrBYOXIynpUAgophwF8JE3HsuCnjsa7zYQjq/sVxc7KkQmrCPM14qWHsdlpwblogu4QX4ZGX3
 lb9krkcF89qBFO7lR227Nhp0QSIP4mzw9kvFOrICIZ1H+buWx6Fp3QzeGdhRnWvaCmbdV3FQoe5
 EovoTOE/ZTeGU0GkCJk3N3S4yKsMG8QaW2gFk=
X-Gm-Gg: ASbGncsWkxeK5IHVywCMxCpiJ2+IIIKxi/QWzcQswJcAXDvq7RvsSOUQqRTBSsGZ9tF
 XdO6mJj27VOk7VCtYQAInhuyO5ypJDQCnTekl/BtVGtxxoZIF8g3dmJ5UzGdWEfYICfmEnTjrrl
 0s8LW8
X-Received: by 2002:a17:90a:f944:b0:311:9c1f:8522 with SMTP id
 98e67ed59e1d1-313472fe61emr4774365a91.10.1749202572994; 
 Fri, 06 Jun 2025 02:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDd3CkqmUYHom/ifa09SXeB8VpLoPJ5AUz+w+BPDZazphB5V32hdudUGsWdLWgY8MaJRoRymTUv86d+76fdGs=
X-Received: by 2002:a17:90a:f944:b0:311:9c1f:8522 with SMTP id
 98e67ed59e1d1-313472fe61emr4774344a91.10.1749202572624; Fri, 06 Jun 2025
 02:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250605120702.213048-1-liwang@redhat.com>
 <aEKyXpEg3NoPKLfq@yuki.lan>
In-Reply-To: <aEKyXpEg3NoPKLfq@yuki.lan>
Date: Fri, 6 Jun 2025 17:36:00 +0800
X-Gm-Features: AX0GCFvpzn72_xGyzzGzm6y9ezGjTvJRCVheEyz6rBVQmF0OOxQgNVTPMBWDM2g
Message-ID: <CAEemH2fKJY+_bSEtugZVMzjYwGOPG3DSnffZp7gBBuSQ8N3nkA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HQKNuTygWm4fcvc8PUnKh5sOegVKU0gvv-8YOW8QobE_1749202574
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] tst_atomic: drop legacy inline assembly
 and use __atomic or __sync builtins
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

T24gRnJpLCBKdW4gNiwgMjAyNSBhdCA1OjE44oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IFJlZmFjdG9yIHRzdF9hdG9taWMuaCB0byByZW1vdmUg
YWxsIGxlZ2FjeSBhcmNoaXRlY3R1cmUtc3BlY2lmaWMgaW5saW5lCj4gPiBhc3NlbWJseSBhbmQg
ZmFsbGJhY2sgY29kZSBwYXRocy4gVGhlIG5ldyBpbXBsZW1lbnRhdGlvbiBzdXBwb3J0cyBvbmx5
Cj4gPiB0d28gd2VsbC1kZWZpbmVkIGludGVyZmFjZXM6IF9fYXRvbWljXyogYnVpbHQtaW5zIChH
Q0Mg4omlIDQuNykgYW5kCj4gX19zeW5jXyoKPiA+IGJ1aWx0LWlucyAoR0NDIOKJpSA0LjEpLgo+
ID4KPiA+IFRoaXMgc2ltcGxpZmljYXRpb24gaW1wcm92ZXMgbWFpbnRhaW5hYmlsaXR5LCBjbGFy
aXR5LCBhbmQgcG9ydGFiaWxpdHkKPiA+IGFjcm9zcyBwbGF0Zm9ybXMuIEl0IGFsc28gdXBkYXRl
cyBhbGwgZnVuY3Rpb24gc2lnbmF0dXJlcyB0byB1c2UgaW50MzJfdAo+ID4gZm9yIHR5cGUgY29u
c2lzdGVuY3kgd2hlbiBvcGVyYXRpbmcgb24gYXRvbWljIGNvdW50ZXJzLCBzdWNoIGFzIHRob3Nl
IGluCj4gPiBzdHJ1Y3QgdHN0X3Jlc3VsdHMuCj4KPiBDYW4gd2UgcGxlYXNlIHNwbGl0IHRoZSBw
YXRjaCBpbnRvIHRoZSByZW1vdmFsIG9mIHRoZSBhc3NlbWJseSBhbmQKPiBzZXBhcmF0ZSBwYXRj
aCB0aGF0IGNoYW5nZXMgdGhlIHR5cGVzPwo+CgpPZiBjb3Vyc2Ugc3VyZS4gSXQgd291bGQgYmUg
Y2xlYXJlciBhbmQgdGlkaWVyLgoKCgo+Cj4gQWxzbyBkbyB3ZSBuZWVkIHRvIHVwZGF0ZSBmdXp6
eSBzeW5jIGxpYnJhcnkgaW4gdGhlIHNlY29uZCBwYXRjaCBpbgo+IG9yZGVyIG5vdCB0byBwcm9k
dWNlIHdhcm5pbmdzPwoKCkdvb2QgcG9pbnQsIGFsc28gd2UgcHJvYmFibHkgbmVlZCB0byBjaGVj
ayBhbGwgcmVsYXRlZCBhdG9taWMgb3BlcmF0aW9ucyB0bwplbnN1cmUgbm8gbmV3IHdhcm5pbmdz
IGJ5IHRoZSB0eXBlIGNvbnZlcnNpb24uCgpJIHdpbGwgcmV3b3JrIHRoYXQgaW50byB0d28gc2Vw
YXJhdGUgcGF0Y2hlcyBhbmQgc2VuZCB2My4gVGhhbmtzIQoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
