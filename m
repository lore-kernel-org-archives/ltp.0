Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E087CD3431
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 09:38:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69DD83C1CB2
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 11:38:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C33523C0CCD
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 11:37:54 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B76B61762A
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 11:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725442672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G78Vzrp5JzfcmKAUNk5xKYlACLDoZlhT8yaN3MWaJew=;
 b=cpLVeW+n/9xV9h12+Xj8WKud2Slkp8S9GRwlsRQN5LUq070qEa7kocUlfws27OclxLN+rW
 LUyoulcRIXD2OujwkPp6+lA3zBKOhYaJVHGGr6iMd/wggWBgTKb06exUtXbhlD14YRAhEB
 fMdi+dOTNFmvhvqssKWtt5LzIae8qYM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-ecBxEKNlMv-t7oeY_1SgrA-1; Wed, 04 Sep 2024 05:37:51 -0400
X-MC-Unique: ecBxEKNlMv-t7oeY_1SgrA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7cd98f27becso6618826a12.3
 for <ltp@lists.linux.it>; Wed, 04 Sep 2024 02:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725442669; x=1726047469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G78Vzrp5JzfcmKAUNk5xKYlACLDoZlhT8yaN3MWaJew=;
 b=AQ6Ixl+wId6XT5obCkORsvemrHm+FLLbknSYeyTBAr6/CYt+i0nnxk0ukYBZdwBnyQ
 stM7TCGbGqSbm4x3Rg3XOUWXZk/lrFIDh4mL3i8gd4exKYfVfMpDMtoIuH93HaN8iqIm
 UGwYfGkBjjHCGnhXaQLXpJxMKQFkw/+sU8cHNHS+5Khrc9+xGjIdh47j0Gpr8rAZcYTh
 H1WEoUvWwaV2ObwQ97RM3sYgGtKLWg8Ku0Dr/QP21xKo7fJ7h9MqBSm6jL73bKD8+GNr
 6LYYLoYfKu9YKKFPpOfCQV5n+1dRlQtXUMhD0OgkelzfhOzEqbacQGxCQQmxy33X5mcx
 EBLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/7TsRLKLOVo4HUwjf6NJbLhYYeIabuutK7VES+VtR9IN/+USWTv0ngL5o10osA+aBT4g=@lists.linux.it
X-Gm-Message-State: AOJu0YzL5wHILJklagF6ST2WsXd6uPS+laLeniAJLa53TDjgMsK9GmIR
 OT10tzQfjBuujGuhMrSg9wFnpZWhi660hNSBpV8ey32qbGO2aEr7QnRLHbwq4e9L0kxNwBLEpr3
 dnr7dWodveagrYECLSjD2zEtK6rRBylyHpVrEpB16LFeCpgn7egJSTM2532/3Z/JbQOVinU16IV
 akYCvTEzMIWmtVVhYXKcg9GQcB6CnMR+Pe/MCw
X-Received: by 2002:a05:6a21:4a41:b0:1cc:ec4c:adb4 with SMTP id
 adf61e73a8af0-1cecf4dd8camr13610492637.18.1725442669029; 
 Wed, 04 Sep 2024 02:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1rRAIdWM80/sDS+XISdlgxXOKNWmrQSHooUBwNC8woBte7wcABkJdF6blwEwcwDubOgiqjxJRo6NGX7G5KO4=
X-Received: by 2002:a05:6a21:4a41:b0:1cc:ec4c:adb4 with SMTP id
 adf61e73a8af0-1cecf4dd8camr13610481637.18.1725442668724; Wed, 04 Sep 2024
 02:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240903140326.773060-1-pvorel@suse.cz>
 <ZtcoDmsWrMu8Qaze@yuki.lan>
 <20240904053157.GA836933@pevik> <Ztgfu4bTVyw7hvdP@yuki.lan>
 <CAEemH2edp0xmW=LQzvGPeukqh=NXai6N-3J7fgLcOm5eTkvO+Q@mail.gmail.com>
In-Reply-To: <CAEemH2edp0xmW=LQzvGPeukqh=NXai6N-3J7fgLcOm5eTkvO+Q@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 4 Sep 2024 17:37:37 +0800
Message-ID: <CAEemH2cg=mk7XzwZj+oYOM5BRzjewE9vHVMnDnX+UmQ4YZTT_g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] swapoff01: Define max_runtime 45s
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

T24gV2VkLCBTZXAgNCwgMjAyNCBhdCA1OjI24oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gT24gV2VkLCBTZXAgNCwgMjAyNCBhdCA0OjUz4oCvUE0gQ3lyaWwgSHJ1
YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+ID4KPiA+IEhpIQo+ID4gPiA+IFNvIHllcyBp
dCBsb29rcyBsaWtlIHRoZSBhY3R1YWwgdGVzdCBuZWVkcyBzb21lIHJ1bnRpbWUgZGVmaW5lZCwK
PiA+ID4gPiBhbHRob3VnaCBJJ20gbm90IHN1cmUgaG93IGxvbmcgaXQgc2hvdWxkIGJlLiBXZSBw
cm9iYWJseSBuZWVkIGEKPiA+ID4gPiByZWZlcmVuY2UgbWFjaGluZSB0byBjYWxsaWJyYXRlIHRo
aXMgb24uIEkgd291bGQgYXZvaWQgYW55IGVtdWxhdGVkIENQVQo+ID4gPiA+IGFuZCBjaG9vc2Ug
YSByZWFsIGhhcmR3YXJlLiBJIGd1ZXNzIG9uZSBvZiB0aGUgUlBpcyBlLmcuIFBpIFplcm8gd291
bGQKPiA+ID4gPiBiZSBhIGdvb2QgY2hvaWNlIHNpbmNlIHRoZXkgYXJlIHdpZGVseSBhdmFpbGFi
bGUgYW5kIHNsb3cgYnkgYW55IG1vZGVybgo+ID4gPiA+IHN0YW5kYXJkcy4KPiA+ID4KPiA+ID4g
VGhpcyBtYWtlcyBzZW5zZS4KPiA+Cj4gPiBTbyBJIGR1c3RlZCBvZmYgbXkgUGkgWmVybyBhbmQg
aW5kZWVkIHRoZSB0ZXN0IHRpbWVvdXRzIHRoZXJlIGFzIHdlbGwuCj4gPiBUaGUgbnRmcyBmaWxl
c3lzdGVtIHRha2VzIDc4cywgZXh0MiAyOXMsIGV4ZmF0IDIwcy4gU28gSSB3b3VsZCBzYXkgdGhh
dAo+Cj4gSSdtIHdvbmRlcmluZyB3aGljaCBkaXN0cmlidXRpb24gKGFuZCBrZXJuZWwgdmVyc2lv
bikgZGlkIHlvdSB1c2Ugb24gcmFzcGktMD8KCkkgYXNrIHRoaXMgYmVjYXVzZSB3ZSBtaWdodCBu
ZWVkIHRvIGNvbnNpZGVyIHRoZSBvbGRlc3Qgc3VwcG9ydGVkIHN5c3RlbXM6Ci0gaHR0cHM6Ly9s
aW51eC10ZXN0LXByb2plY3QucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L3VzZXJzL3N1cHBvcnRl
ZF9zeXN0ZW1zLmh0bWwKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
