Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245EFC3ABDA
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 08:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747210774; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=iQVzaOM4kl1SEkrM0+bHj8HxItCzTYxi5vwnsPqtDtg=;
 b=G0DVHRaUoR4ij88VCRN/pl6Ym2MPgEHsrqpKosnQs+Ujs7IrhazJ4FM9VzTFDQoPKynET
 TYFpc0WJfkWRJC60DLBULqDt67JB82tEU47d8mhTvIzYO0xDn/h2aBWvzfkrvzEa8sdrBn9
 U/C3oZwsK22vUle3ruj9N6gjkFwFavo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 680E53CC381
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 10:19:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C98F3C1D15
 for <ltp@lists.linux.it>; Wed, 14 May 2025 10:19:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 169451A002DB
 for <ltp@lists.linux.it>; Wed, 14 May 2025 10:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747210748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7i/MpLwDJNa8tPU/kB+AHdupYeSLiqFp7gICRJSblw=;
 b=OLi9tQYJ+/z1fGKM2AiZtY8x2pFHcoVaYRq1FhOAJ+aoIMIOUtCPIlPe37ZrPUYZJLIqYQ
 l15JIS0WS9IrtkvSdZWrq2YkFu2FW4MxR9/eUjJbqMPaSH5AxxehueOebExWvUVPMtGu9D
 Ws70sMTBLUE8dohpZveA0ThMCDG7cFA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-r0mQZrAiPU-SwVDmdEfq7A-1; Wed, 14 May 2025 04:19:07 -0400
X-MC-Unique: r0mQZrAiPU-SwVDmdEfq7A-1
X-Mimecast-MFC-AGG-ID: r0mQZrAiPU-SwVDmdEfq7A_1747210746
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22e3abea7e8so69030955ad.2
 for <ltp@lists.linux.it>; Wed, 14 May 2025 01:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747210746; x=1747815546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7i/MpLwDJNa8tPU/kB+AHdupYeSLiqFp7gICRJSblw=;
 b=CDCZF7kDG3pqILTIyopIegpoDGqbR/o0wwj9mJUd+Uf9Qq/g1LqVe+dLoIpJuaFNAz
 bGQrmqW6vvrsSUTssrjUtSlwRZBZhYFv2Q/2FUYSqMfosvmJd+VpvUpnKesVzfu5SCuR
 McO/oS23LDU2PY4uHpDq8QILINnzuP1Y9cv3p+tZQrt+yS3yHwPH62mYfwibQgoJdYd9
 BqIbxSy5tubhQFvdr3tEhJIZOEgzisGwC//Xnje1GvqSA99fcOcGSX1kFUFwWojR9na0
 WAyu57lm06q4L7HSuIAEtT7KQv6jYwEbU+gckpTTELJo3C4oztA/43x54reI5cAu8Uri
 rgkA==
X-Gm-Message-State: AOJu0YzZdWjkod1OMb5hrJNYNki4gYhgQhARbfxPT3XqnZHk4NoYEM4k
 g2koh+XfON4/vChf7+3Pqv3B9HAvdpLp5ffyIKNrvMNSeRis8lCc5gH52bXTO4PFZkc+5JGPAPY
 1H3C1r+bd7MZGkg0z1e0Ua0Vmw01fsgQPs/cz+mZuimZXXSgLqfR+567YR89lfdrqSA5kkedlzq
 D2gx7UINFvEpOgQ4uHGqOEUY4=
X-Gm-Gg: ASbGncuIn/kKx+cc/7PmHcsdgscBEyyagrjfBi99fyeAZKb86Q2OhUI1joVS355Hpfr
 T1zXMPSfrt7xHpPMEygKYPpIECKv03/YwukwLx5jm5RJvztGSyj/xvgzRjcs/oLSVZ3j5BA==
X-Received: by 2002:a17:902:d4c2:b0:220:e362:9b1a with SMTP id
 d9443c01a7336-23198161b33mr37888095ad.25.1747210746150; 
 Wed, 14 May 2025 01:19:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqKMMHjvvd/h1O1g9SG+vXZGQbK/TKIa1UpqudYXze0ZghTbYGRQJ6kn2Nvj+U30FFitQWXxXlFdELVVG5WlQ=
X-Received: by 2002:a17:902:d4c2:b0:220:e362:9b1a with SMTP id
 d9443c01a7336-23198161b33mr37887875ad.25.1747210745832; Wed, 14 May 2025
 01:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250513050530.47541-1-liwang@redhat.com>
 <aCM2PrCrCdPqNIGc@yuki.lan>
 <CAEemH2cP78yxJEWi-Z_v=EuXWP+6XDQBNnGMVHKq3pYLiGQRdw@mail.gmail.com>
 <aCRNqIAGRnZQJzua@yuki.lan>
In-Reply-To: <aCRNqIAGRnZQJzua@yuki.lan>
Date: Wed, 14 May 2025 16:18:53 +0800
X-Gm-Features: AX0GCFvnte_iMXWI9TH22UgN9rqucHHEblqMEx0L4rP5kUBBQpioATZ4SpHvTBo
Message-ID: <CAEemH2f8TVDozK+UJDrtekwNqk7AM2MZZu8Mq8VDrkvyyu50LA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xvy1RXizSj20FJ80ZQKw-fNfZwQTWDgfDNP2zGgyIfk_1747210746
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: initialize lib|main_pid to zero in the
 setup_ipc
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

T24gV2VkLCBNYXkgMTQsIDIwMjUgYXQgNDowMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gPiA+IEBAIC0xMzkzLDggKzEzOTYsNiBAQCBzdGF0
aWMgdm9pZCBkb19zZXR1cChpbnQgYXJnYywgY2hhciAqYXJndltdKQo+ID4gPiA+ICAgICAgIGlm
ICh0c3RfdGVzdC0+aHVnZXBhZ2VzLm51bWJlcikKPiA+ID4gPiAgICAgICAgICAgICAgIHRzdF9y
ZXNlcnZlX2h1Z2VwYWdlcygmdHN0X3Rlc3QtPmh1Z2VwYWdlcyk7Cj4gPiA+ID4KPiA+ID4gPiAt
ICAgICBzZXR1cF9pcGMoKTsKPiA+ID4gPiAtCj4gPiA+Cj4gPiA+IEkgc3VwcG9zZSB0aGF0IHRo
aXMgaGFzIHRvIGdvIGJlZm9yZSB0aGUgdHN0X3Jlc2VydmVfaHVnZXBhZ2VzKCkgc28gdGhhdAo+
ID4gPiB3ZSBoYXZlIHJlc3VsdHMtPmxpYl9waWQgZGVmaW5lZCBhbmQgcHJvcGVybHkgY2xlYW4g
dXAgYWZ0ZXIgdGhlCj4gPiA+IGh1Z2VwYWdlcy4gSG93ZXZlciBmb3IgdGhhdCB0byB3b3JrIHdl
IGhhdmUgdG8gc2V0IHRoZQo+ID4gPiByZXN1bHRzLT5saWJfcGlkIGRpcmVjdGx5IGluIHRoZSBz
ZXR1cF9pcGMoKS4KPiA+Cj4gPiBJbiB0aGlzIHBhdGNoLCBzZXR1cF9pcGMoKSBpcyBhbHJlYWR5
IG1vdmVkIHVwIGJlZm9yZSB0aGUKPiA+IHRzdF9yZXNlcnZlX2h1Z3BhZ2VzKCkuIEkgcGFydGlj
dWxhcmx5IHB1dCBpdCBhZnRlciB0c3RfdGVzdC0+cnVuc19zY3JpcHRzLAo+ID4gd2hpY2ggaXMg
bWFuZGF0b3J5IHRvIGhhdmUgLmNoaWxkX25lZWRzX3JlaW5pdCBpbml0aWFsaXplZCBmaXJzdC4K
PiA+Cj4gPiBBbmQgdGhlIGh1Z3BhZ2VzIGNsZWFudXAgd29yayBpcyBjb21wbGV0ZWQgaW4gdHN0
X3N5c19jb25mX3Jlc3RvcmUoMCkKPiA+IGluIHRoZSBkb19jbGVhbnVwLCBzbyB0aGF0IG1pZ2h0
IG5vdCBiZSBhIHByb2JsZW0uCj4gPiBJIGhhdmUgdmFsaWRhdGVkIHRoYXQgYWxsIGh1Z2V0bGIg
dGVzdHMgd29yayB3ZWxsLgo+ID4KPiA+IEFsc28sCj4gPgo+ID4gT3IsIGRpZCBJIG1pc3MgYW55
dGhpbmc/Cj4KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IG5vIGxpYnJhcnkgY2xlYW51cCB3aWxsIGhh
cHBlbiB1bmxlc3MgbGliX3BpZCBpcwo+IHNldCwgdGhhdCBtZWFucyB0aGF0IHRzdF9icmsoKSB3
aWxsIGJlIHRyaWdnZXJlZCBhbnl3aGVyZSBpbiBkb19zZXR1cCgpCj4gdGhlIGNsYW51cCB3aWxs
IG5vdCBiZSBydW4gYmVjYXVzZSB3ZSBzZXQgdGhlIGxpYl9waWQgYWZ0ZXIgdGhlCj4gZG9fc2V0
dXAoKSBpbiB0aGUgcGF0Y2guCgpJIHNlZSwgYW5kIHlvdSdyZSByaWdodCB3ZSBoYXZlIHRvIHNl
dCBsaWJfcGlkIGJlZm9yZSBhbnkgcmVhbCBzZXR1cC4KCkRvZXMgdGhpcyBjaGFuZ2UgYmVsb3cg
bWFrZSBzZW5zZSAoYmFzZWQgb24gdGhlIHYyIEkganVzdCBzZW50KT8KCi0tLSBhL2xpYi90c3Rf
dGVzdC5jCisrKyBiL2xpYi90c3RfdGVzdC5jCkBAIC0xNDQsNiArMTQ0LDggQEAgc3RhdGljIHZv
aWQgc2V0dXBfaXBjKHZvaWQpCiAgICAgICAgfQoKICAgICAgICBtZW1zZXQocmVzdWx0cywgMCAs
IHNpemUpOworCisgICAgICAgcmVzdWx0cy0+bGliX3BpZCA9IGdldHBpZCgpOwogfQoKIHN0YXRp
YyB2b2lkIGNsZWFudXBfaXBjKHZvaWQpCkBAIC0xOTMzLDcgKzE5MzUsNiBAQCB2b2lkIHRzdF9y
dW5fdGNhc2VzKGludCBhcmdjLCBjaGFyICphcmd2W10sCnN0cnVjdCB0c3RfdGVzdCAqc2VsZikK
CiAgICAgICAgZG9fc2V0dXAoYXJnYywgYXJndik7CgotICAgICAgIHJlc3VsdHMtPmxpYl9waWQg
PSBnZXRwaWQoKTsKICAgICAgICB0c3RfZW5hYmxlX29vbV9wcm90ZWN0aW9uKHJlc3VsdHMtPmxp
Yl9waWQpOwoKICAgICAgICBTQUZFX1NJR05BTChTSUdBTFJNLCBhbGFybV9oYW5kbGVyKTsKCgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
