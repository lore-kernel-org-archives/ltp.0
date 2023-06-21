Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E4BEB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 02:53:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CC7C3CE0F9
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 04:53:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAB3C3C9BB9
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 04:53:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F2C6C60046E
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 04:53:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687315993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xpoPZYEMpcuooapkr/8N0hpDw6Hl2cXP5UlC197IYE=;
 b=YrW/s++gIgTJFJThD/xNeDk4OjxCUC6HIVCLwob5Dg+plEiHYR6fkeJxNhc+FQIHHttYlR
 N0/hWxb3hBBx0e0JskaNQFn0WvOYyB3RMMjzlLP3ExVRRqHyIgdjj6+SuzYQqZcqOB7S3p
 ZUZRI0AyWU5OoGeJpBQKGpFZpyidQPE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-eIpgEYv0MZCbduWifMW9xQ-1; Tue, 20 Jun 2023 22:53:11 -0400
X-MC-Unique: eIpgEYv0MZCbduWifMW9xQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b46dc4f6faso28040391fa.3
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 19:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687315989; x=1689907989;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2xpoPZYEMpcuooapkr/8N0hpDw6Hl2cXP5UlC197IYE=;
 b=THcxSffrNW6QwlCfe8R1LRwN+j5SEofu/Tib0UjF2ng5pCUTCdu4ABea1bYVBdGyyG
 HczRIL9+z4u33whaMdup2+rZWklzRqncsYgu5wjj3RRLCs/L/Gf2vjjIH8awC90tbQHr
 bxCjBlCj65lt6FzoMOWJi/RkQ+R0JwwGxmZ0bfUn/UdjI/dKVrGxOvRCUG60sHGX2gsL
 P2/Gbs4w03ytTZsW8dygIivBDDqhEKUZjC/TPAPtDlW72bPiut/2D5iv6h+Hgiw2awXz
 fYOykMJAlOtVlqsx1NuglVINS0qnln+h6HOxhVt/u2bZT+4lMKVN4qcz7cNE6VRu35O9
 l2FQ==
X-Gm-Message-State: AC+VfDwnGPdlD9Ql2XFG4OrX7A+CVlkFDZgJsu8vjaibR1jSaTMqw0Je
 YvawJA4Ljo96Zd32mKBW4Am15alPp5U+UySg6WLxPWruODWYLglLp2CBZdc6cIBLWseVY6E0GOb
 V1VkltRTbbImTiwM47bUF0V/ihAFyFjrPgE4l2g==
X-Received: by 2002:a05:651c:1048:b0:2b5:828c:bfc7 with SMTP id
 x8-20020a05651c104800b002b5828cbfc7mr647617ljm.19.1687315989007; 
 Tue, 20 Jun 2023 19:53:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TvjkF+hgW3enMry8UTyOERpeeKi47FhzlrVY36JBWV8iBb2eDM3dlKw/o5/wSCUknwOG1TJPta3uzprREeRo=
X-Received: by 2002:a05:651c:1048:b0:2b5:828c:bfc7 with SMTP id
 x8-20020a05651c104800b002b5828cbfc7mr647612ljm.19.1687315988705; Tue, 20 Jun
 2023 19:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230529061135.24261-1-liwang@redhat.com>
In-Reply-To: <20230529061135.24261-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Jun 2023 10:52:56 +0800
Message-ID: <CAEemH2dwz_TTzc4vucOcHyR1nMe2rcF0z9DN0P3Ct5PXS_2WFw@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] hugemmap32: release mem caches and prepare
 for hugepage
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

cGluZ34KCklmIG5vYm9keSBvYmplY3RzIHRvIHRoZXNlIHR3byBzaW1wbGUgaW1wcm92ZW1lbnRz
LApJIHdvdWxkIHB1c2ggYm90aCB0aGUgbmV4dCBkYXkuCgpPbiBNb24sIE1heSAyOSwgMjAyMyBh
dCAyOjEx4oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgoKPiBBcyBNYXJ0
aW4gcG9pbnRlZCB0aGF0IG1lbSBjYWNoZXMgY291bnQgYXMgYXZhaWxhYmxlLCB3ZSdkIGJldHRl
cgo+IHJlbGVhc2UgdGhlbSBmb3IgaHVnZSBwYWdlIHVzZS4KPgo+IFNpZ25lZC1vZmYtYnk6IExp
IFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL21lbS9o
dWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzIuYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxi
L2h1Z2VtbWFwL2h1Z2VtbWFwMzIuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9o
dWdlbW1hcC9odWdlbW1hcDMyLmMKPiBpbmRleCAzNmE0MjZhMDkuLjc2Yjc5MGE5NSAxMDA2NDQK
PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzIu
Ywo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAz
Mi5jCj4gQEAgLTY0LDYgKzY0LDcgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPgo+ICAgICAg
ICAgU0FGRV9DTE9TRURJUihkaXIpOwo+Cj4gKyAgICAgICBTQUZFX0ZJTEVfUFJJTlRGKCIvcHJv
Yy9zeXMvdm0vZHJvcF9jYWNoZXMiLCAiMyIpOwo+ICAgICAgICAgaWYgKHRzdF9hdmFpbGFibGVf
bWVtKCkgPCAobG9uZyBsb25nKWhwYWdlX3NpemUpIHsKPiAgICAgICAgICAgICAgICAgZ19ocGFn
ZV9wYXRoWzBdID0gJ1wwJzsKPiAgICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgIk5vIGVu
b3VnaCBtZW1vcnkgZm9yIGdpZ2FudGljIGh1Z2VwYWdlCj4gcmVzZXJ2YXRpb24iKTsKPiAtLQo+
IDIuNDAuMQo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
