Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAABFC25B10
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 01:25:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 118C43CDB3C
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 03:25:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF40D3C8658
 for <ltp@lists.linux.it>; Tue,  7 May 2024 03:25:23 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0A69B14016EE
 for <ltp@lists.linux.it>; Tue,  7 May 2024 03:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715045121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yCMSgwYyxpgSLrCnrch2k1pTPqSRC4QpnL1v9FjJcg=;
 b=cgTtHIupy+r2q0BprenZCiEgiwMjbfoTW14osTfrD9huKG3kAfEoSwrxa+vF0UF2+i0Mzd
 kzhbZjWjf28zUcVRg/MHXUMJpjWgCRJ3sKPD8KDwyug3X4irhcOpNWfGEzLsugFK7dCOw9
 jjsXVTnUu3aPhY108KiCU52A3UrsoH4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-QuYQbkzGMBOVYPmBbxr91Q-1; Mon, 06 May 2024 21:25:19 -0400
X-MC-Unique: QuYQbkzGMBOVYPmBbxr91Q-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6f452eb2108so2231770b3a.0
 for <ltp@lists.linux.it>; Mon, 06 May 2024 18:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715045116; x=1715649916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6yCMSgwYyxpgSLrCnrch2k1pTPqSRC4QpnL1v9FjJcg=;
 b=iI+sG+A/qkzQ1KphS7v4lK/U/KoEVADUsRtPZGNRRvRQNqQjY3tKj6gwQLHA6W3G0k
 /y3CVdmuFiEKM1T/YEt7rG7sYXAMQSWMaBG9e03dtahF+P+Y/dTMrXXcfa28QwgXQQZJ
 /ID0R4czhRxRzXeQ336qLoOdwL4QgkTfCZioV9wYwTWqQUVv+fgsnFFaHQPsrHCnKnX8
 Ha71Y27Uy+EuyuxAbZvCJ0w8NvHdXxFXofBP+1lIOcm8OFAFeH74P0DpKTV6j56vg9/Q
 0gE2fvC7OdLM7l1vPJGX/apH9Xce74FOB/6VzgkjLleCP9ESGbrBDjhexo39b4KBFtRA
 MsRQ==
X-Gm-Message-State: AOJu0YyuNBHQNAGR4/+qH0cyuiwKlCaZgNOFDWRtarRny2Ep2BV+hPBv
 k1SPwhNEc1ydyMlwMiYjJKgNdnQOFbmeVRTuT0mOczjCMdQyOKyLtHOvBcYsblK5NRCKVEuR3t8
 FMkbSOt+3BwA/sv7Y2zAFBywU40q/C93a36FhnWREB9RNu0BBGQWOeKvcOE0QX4z+XdUaKzrAvF
 6vVBb/dcMNU8W7qWlawQoUtXnPzub9zY2clm2i
X-Received: by 2002:a05:6a00:92a6:b0:6e7:48e3:7895 with SMTP id
 d2e1a72fcca58-6f48e86a97amr2031476b3a.2.1715045116036; 
 Mon, 06 May 2024 18:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaN5zdYu08j++hmS6MaWZraLTZ8ApK9YgorU3P9c6pIyi252s8feMHnNphWZdLSxJf2WL+j8Ui6194ixb4TQA=
X-Received: by 2002:a05:6a00:92a6:b0:6e7:48e3:7895 with SMTP id
 d2e1a72fcca58-6f48e86a97amr2031441b3a.2.1715045115307; Mon, 06 May 2024
 18:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240506200600.47895-1-pvorel@suse.cz>
In-Reply-To: <20240506200600.47895-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 May 2024 09:25:03 +0800
Message-ID: <CAEemH2dAkX7N=m-bgxSgk7s63mzBPfpmW=E-45_92GaoDS_FKw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_test.h: Turn 1 bit tst_test members to
 unsigned
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

T24gVHVlLCBNYXkgNywgMjAyNCBhdCA0OjA24oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBUaGlzIGZpeGVzIGNsYW5nIHdhcm5pbmc6Cj4KPiAgICAgdGVzdDIyLmM6
MzM6MTc6IHdhcm5pbmc6IGltcGxpY2l0IHRydW5jYXRpb24gZnJvbSAnaW50JyB0byBhIG9uZS1i
aXQKPiAgICAgd2lkZSBiaXQtZmllbGQgY2hhbmdlcyB2YWx1ZSBmcm9tIDEgdG8gLTEKPiAgICAg
Wy1Xc2luZ2xlLWJpdC1iaXRmaWVsZC1jb25zdGFudC1jb252ZXJzaW9uXQo+Cj4gU2lnbmVkLW9m
Zi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5n
IDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0tLQo+ICBpbmNsdWRlL3RzdF90ZXN0LmggfCA0MCArKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3RzdF90ZXN0LmggYi9pbmNsdWRlL3RzdF90ZXN0LmgKPiBpbmRleCBiZTA5YmNlMjcuLjY5NTg3
OTE3ZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3RzdF90ZXN0LmgKPiArKysgYi9pbmNsdWRlL3Rz
dF90ZXN0LmgKPiBAQCAtNDc2LDI2ICs0NzYsMjYgQEAgc3RydWN0IHRzdF91bGltaXRfdmFsIHsK
Pgo+ICAgICAgICAgY29uc3QgY2hhciAqdGNvbmZfbXNnOwo+Cj4gLSAgICAgICBpbnQgbmVlZHNf
dG1wZGlyOjE7Cj4gLSAgICAgICBpbnQgbmVlZHNfcm9vdDoxOwo+IC0gICAgICAgaW50IGZvcmtz
X2NoaWxkOjE7Cj4gLSAgICAgICBpbnQgbmVlZHNfZGV2aWNlOjE7Cj4gLSAgICAgICBpbnQgbmVl
ZHNfY2hlY2twb2ludHM6MTsKPiAtICAgICAgIGludCBuZWVkc19vdmVybGF5OjE7Cj4gLSAgICAg
ICBpbnQgZm9ybWF0X2RldmljZToxOwo+IC0gICAgICAgaW50IG1vdW50X2RldmljZToxOwo+IC0g
ICAgICAgaW50IG5lZWRzX3JvZnM6MTsKPiAtICAgICAgIGludCBjaGlsZF9uZWVkc19yZWluaXQ6
MTsKPiAtICAgICAgIGludCBuZWVkc19kZXZmczoxOwo+IC0gICAgICAgaW50IHJlc3RvcmVfd2Fs
bGNsb2NrOjE7Cj4gLQo+IC0gICAgICAgaW50IGFsbF9maWxlc3lzdGVtczoxOwo+IC0KPiAtICAg
ICAgIGludCBza2lwX2luX2xvY2tkb3duOjE7Cj4gLSAgICAgICBpbnQgc2tpcF9pbl9zZWN1cmVi
b290OjE7Cj4gLSAgICAgICBpbnQgc2tpcF9pbl9jb21wYXQ6MTsKPiAtCj4gLSAgICAgICBpbnQg
bmVlZHNfaHVnZXRsYmZzOjE7Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgbmVlZHNfdG1wZGlyOjE7
Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgbmVlZHNfcm9vdDoxOwo+ICsgICAgICAgdW5zaWduZWQg
aW50IGZvcmtzX2NoaWxkOjE7Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgbmVlZHNfZGV2aWNlOjE7
Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgbmVlZHNfY2hlY2twb2ludHM6MTsKPiArICAgICAgIHVu
c2lnbmVkIGludCBuZWVkc19vdmVybGF5OjE7Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgZm9ybWF0
X2RldmljZToxOwo+ICsgICAgICAgdW5zaWduZWQgaW50IG1vdW50X2RldmljZToxOwo+ICsgICAg
ICAgdW5zaWduZWQgaW50IG5lZWRzX3JvZnM6MTsKPiArICAgICAgIHVuc2lnbmVkIGludCBjaGls
ZF9uZWVkc19yZWluaXQ6MTsKPiArICAgICAgIHVuc2lnbmVkIGludCBuZWVkc19kZXZmczoxOwo+
ICsgICAgICAgdW5zaWduZWQgaW50IHJlc3RvcmVfd2FsbGNsb2NrOjE7Cj4gKwo+ICsgICAgICAg
dW5zaWduZWQgaW50IGFsbF9maWxlc3lzdGVtczoxOwo+ICsKPiArICAgICAgIHVuc2lnbmVkIGlu
dCBza2lwX2luX2xvY2tkb3duOjE7Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgc2tpcF9pbl9zZWN1
cmVib290OjE7Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgc2tpcF9pbl9jb21wYXQ6MTsKPiArCj4g
KyAgICAgICB1bnNpZ25lZCBpbnQgbmVlZHNfaHVnZXRsYmZzOjE7Cj4KPiAgICAgICAgIGNvbnN0
IGNoYXIgKmNvbnN0ICpza2lwX2ZpbGVzeXN0ZW1zOwo+Cj4gLS0KPiAyLjQzLjAKPgo+Cj4gLS0K
PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
Pgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
