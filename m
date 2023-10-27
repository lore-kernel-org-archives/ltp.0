Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CA1C25B67
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 09:58:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82EFB3CCDF3
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 11:58:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BC373CCAD0
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 11:58:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 72A0D600EA7
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 11:58:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698400683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8v2ZOCMdHP9SWg9tHMbcVUVy7mOR6hcfvuniyeLl7s=;
 b=hFMPGQ7csmTfzFHooUqYYVy64TRYQOx1gzYhTanlkJklPIMTIdghmAPdd5tiZn8WNYYPyO
 2YqChSwaG9jS/U7qsBmK5eG63WnUiyESSy3gI8s7ec45lcfn8uIJzyCFljX3Y69LQqjeru
 VT+jV1lPVHjhw5Cfba7SoUc1rRAs7iY=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-lMexxIS0NtavpD6qiC742A-1; Fri, 27 Oct 2023 05:58:02 -0400
X-MC-Unique: lMexxIS0NtavpD6qiC742A-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-457ba261d60so837474137.2
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 02:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698400681; x=1699005481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8v2ZOCMdHP9SWg9tHMbcVUVy7mOR6hcfvuniyeLl7s=;
 b=rphSS+oy69qI8aH2/14RumZ5YQgJKYCZZTnCi+UPQyHP4cQQRvunpnlT8htKOf5Srp
 tPU2KF0YUZAkT/XjZpW8QWtcLwEP43f6oBFyvQgRc7rlNCOr7RrNJKU8AitFTZ9xY4YH
 ul9KuIiSb2djlLWNISlNYDmr0MIzOwhF5oNXXHIji5MFFRBsPeKPsO0GmZ8I8xSh/1lG
 3axsKj+Gfd1xtVLvpXn08GxWHmfsTjv0rXyAU908LEcEaUAKslzEQEUU6JanyrpR+Pef
 w7xqsbcIorXFKyAPHDPzpmZfXygSXhbO5Fjm2lgt4mrIi52+dlD7Q+pVNifBSVCQe4Ed
 2yyQ==
X-Gm-Message-State: AOJu0YwD7Nkf4FSeCbNUZiGEAXgEjqeUTOuEy01jEiimQ6rCbom8FDNj
 kJHlZDs+JiNvMz7w7aav1PndDAVJK6jnMqab4VbX3n/guB1D69fq1auQlavYdga3ncuXjPL0OU0
 tff5bonX4N9pJgjYRVuMsy0HYL38xs/sbRqc=
X-Received: by 2002:a67:cb9c:0:b0:458:3bc1:9777 with SMTP id
 h28-20020a67cb9c000000b004583bc19777mr2025258vsl.15.1698400681533; 
 Fri, 27 Oct 2023 02:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSkzEKJiJRjc0autizAbgLWuaYbNPX7OuJHao9mVcvGDMq4caQWyY+jqd2d+bnNZ0HKzYUuT59aUODUNsHqbI=
X-Received: by 2002:a67:cb9c:0:b0:458:3bc1:9777 with SMTP id
 h28-20020a67cb9c000000b004583bc19777mr2025244vsl.15.1698400681259; Fri, 27
 Oct 2023 02:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <345e84821f2319d24ce8b9b84f5e038d53a2c9d5.1697715265.git.jstancek@redhat.com>
 <CAEemH2fkj49Z-NQVSewZAgm6z8agC-Z_PoBrqRhFvGbu8uRAZg@mail.gmail.com>
In-Reply-To: <CAEemH2fkj49Z-NQVSewZAgm6z8agC-Z_PoBrqRhFvGbu8uRAZg@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 27 Oct 2023 11:58:33 +0200
Message-ID: <CAASaF6y1y2t=g2-Rpc8SGxv3JTtW-f9KTuVk4vmH6Favm3W-DA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/gettid02: fix s390x and couple races
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

T24gRnJpLCBPY3QgMjAsIDIwMjMgYXQgMTA6NTXigK9BTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gVGh1LCBPY3QgMTksIDIwMjMgYXQgNzo0MOKAr1BNIEph
biBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPiB3cm90ZToKPj4KPj4gczM5MHggaXMgYmln
IGVuZGlhbiB3aGVyZSBzaXplb2YoaW50KSA9PSA0IGFuZCBzaXplb2Yodm9pZCAqKSA9PSA4Lgo+
PiBUaGlzIHRlc3QgY3VycmVudGx5IGZhaWxzIG9uIHMzOTB4IGJlY2F1c2UgaW4gcHRocmVhZF9q
b2luLCAiJnRpZHNbaV0iCj4+IGlzIHRyZWF0ZWQgYXMgInZvaWQqKiIgYW5kIGR1ZSB0byBkaWZm
ZXJlbnQgdHlwZSBzaXplIGl0IHdyaXRlcyBvdmVyCj4+IDIgZW50cmllcyBvZiB0aWRzW10gYXJy
YXkuIFNvIGZvciBzbWFsbCB0aWQgdmFsdWVzIHRlc3QgcmVwb3J0czoKPj4gICAgICAgICBnZXR0
aWQwMi5jOjI5OiBUUEFTUzogRXhwZWN0OiBwYXJlbnQgSUQgKDE0MDQ4KSBkaWZmZXJzIGZyb20g
dGhyZWFkWzBdIElEICgxNDA0OSkKPj4gICAgICAgICBnZXR0aWQwMi5jOjI5OiBUUEFTUzogRXhw
ZWN0OiBwYXJlbnQgSUQgKDE0MDQ4KSBkaWZmZXJzIGZyb20gdGhyZWFkWzFdIElEICgxNDA1MCkK
Pj4gICAgICAgICBnZXR0aWQwMi5jOjI5OiBUUEFTUzogRXhwZWN0OiBwYXJlbnQgSUQgKDE0MDQ4
KSBkaWZmZXJzIGZyb20gdGhyZWFkWzJdIElEICgxNDA1MSkKPj4gICAgICAgICBnZXR0aWQwMi5j
OjI5OiBUUEFTUzogRXhwZWN0OiBwYXJlbnQgSUQgKDE0MDQ4KSBkaWZmZXJzIGZyb20gdGhyZWFk
WzNdIElEICgxNDA1MikKPj4gICAgICAgICBnZXR0aWQwMi5jOjI5OiBUUEFTUzogRXhwZWN0OiBw
YXJlbnQgSUQgKDE0MDQ4KSBkaWZmZXJzIGZyb20gdGhyZWFkWzRdIElEICgxNDA1MykKPj4gICAg
ICAgICBnZXR0aWQwMi5jOjI5OiBUUEFTUzogRXhwZWN0OiBwYXJlbnQgSUQgKDE0MDQ4KSBkaWZm
ZXJzIGZyb20gdGhyZWFkWzVdIElEICgxNDA1NCkKPj4gICAgICAgICBnZXR0aWQwMi5jOjI5OiBU
UEFTUzogRXhwZWN0OiBwYXJlbnQgSUQgKDE0MDQ4KSBkaWZmZXJzIGZyb20gdGhyZWFkWzZdIElE
ICgxNDA1NSkKPj4gICAgICAgICBnZXR0aWQwMi5jOjI5OiBUUEFTUzogRXhwZWN0OiBwYXJlbnQg
SUQgKDE0MDQ4KSBkaWZmZXJzIGZyb20gdGhyZWFkWzddIElEICgxNDA1NikKPj4gICAgICAgICBn
ZXR0aWQwMi5jOjI5OiBUUEFTUzogRXhwZWN0OiBwYXJlbnQgSUQgKDE0MDQ4KSBkaWZmZXJzIGZy
b20gdGhyZWFkWzhdIElEICgxNDA1NykKPj4gICAgICAgICBnZXR0aWQwMi5jOjI5OiBUUEFTUzog
RXhwZWN0OiBwYXJlbnQgSUQgKDE0MDQ4KSBkaWZmZXJzIGZyb20gdGhyZWFkWzldIElEICgxNDA1
OCkKPj4gICAgICAgICBnZXR0aWQwMi5jOjQ5OiBUSU5GTzogdGhyZWFkWzBdIGFuZCB0aHJlYWRb
MV0gaGF2ZSB0aGUgc2FtZSBJRAo+PiAgICAgICAgIGdldHRpZDAyLmM6NDk6IFRJTkZPOiB0aHJl
YWRbMF0gYW5kIHRocmVhZFsyXSBoYXZlIHRoZSBzYW1lIElECj4+ICAgICAgICAgZ2V0dGlkMDIu
Yzo0OTogVElORk86IHRocmVhZFswXSBhbmQgdGhyZWFkWzNdIGhhdmUgdGhlIHNhbWUgSUQKPj4g
ICAgICAgICAuLi4KPj4gd2hpY2ggaXMgY2xlYXJseSB3cm9uZywgc2luY2UgZWFjaCB0aHJlYWQg
YWJvdmUgcHJpbnRlZCBkaWZmZXJlbnQgSUQuCj4+Cj4+IFRoaXMgY29uc3RydWN0IGlzIHJhY2Ut
eSBvbiBzbG93ZXIgczM5MHggc3lzdGVtczoKPj4gICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8
IFRIUkVBRFNfTlVNOyBpKyspCj4+ICAgICAgICAgICAgICAgICBTQUZFX1BUSFJFQURfQ1JFQVRF
KCZ0aHJlYWQsIE5VTEwsIHRocmVhZGVkLCAmaSk7Cj4+IGJlY2F1c2UgYnkgdGhlIHRpbWUgdGhy
ZWFkIHN0YXJ0cyBhbmQgbG9va3MgYXQgIiZpIiwgdGhlIGxvb3AgY2FuCj4+IGFscmVhZHkgbW92
ZSBvbiBhbmQgaW5jcmVtZW50ICJpIi4KPj4KPj4gQWxzbywgcG90ZW50aWFsbHkgc3RhcnRpbmcg
YW5kIHdhaXRpbmcgZm9yIGVhY2ggdGhyZWFkIGNvdWxkIGJlIGFuIGlzc3VlLCBzaW5jZSBrZXJu
ZWwgaXMKPj4gZnJlZSB0byByZS11c2UgdGlkIGZvciBhbHJlYWR5IGZpbmlzaGVkIHRocmVhZHMu
Cj4KPgo+IE1ha2Ugc2Vuc2UhCj4KPiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+CgpQdXNoZWQgd2l0aCBtb2RpZmllZCBjb21taXQgbWVzc2FnZS4KCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
