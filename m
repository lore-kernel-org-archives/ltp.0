Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684ADC3DA49
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 02:11:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 547ED3CDE69
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 04:11:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFEBF3CDE69
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 04:11:28 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E331601FFB
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 04:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720750285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AAO6vpa1qrh9swRECS46dVDzLxGYml9Oxgye9Sh7uTc=;
 b=Afhmkr30d1iFihx8K/Sb5HCsIGVgeoyqkTfKkc2wVYvGID8afHtliXARCpZ2gaamqopZ5z
 aiZx6Tq8+sNyU0XMZXIUKQ1+CtxRB2ootTy5FeDZW4qnldU1JHq1nWWr/J+/LjU6XpXGRx
 y2kltjiF5E3Bx7uzQtjtbuFjsGT5cjM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-Bx4XMESkNfKgQt0DTjgIWQ-1; Thu, 11 Jul 2024 22:11:22 -0400
X-MC-Unique: Bx4XMESkNfKgQt0DTjgIWQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c998cf5679so1258231a91.3
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 19:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720750280; x=1721355080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AAO6vpa1qrh9swRECS46dVDzLxGYml9Oxgye9Sh7uTc=;
 b=Gg5njFPhasZfQFTlA5T1e1XFDG3sGRKOQFneSfbQAwJIPUu6DKk6HYWMj3bWFDkTrV
 +iS0Yh3akPNnTO3qzzu2ZQFviJ/LoyG12HNVRB1P/QPXw1iSBdIxhmkHhFu9vgGbSTGp
 ynZYUnVrrtHsqoyHOBNdmp7wocI6NtbjZXj+fedHEqQuPpcp6s1tUCBHTJcEPwtWUiPH
 rKAj3XvcRaRJ7qxl2lYsRRImFERBDHV5tiuyaGYGGNcsMFP91ssIQPvIje9fJMr7JbOO
 jq3iXsYvkS9OkzxH2g9RHF60LnfKinlZK5K9m44feQY2mqwBicz1DtfriyAkM4udDnf/
 f2YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVH9EWaFtI34071hn8bwjctPL24rvZ5Z7B+CNBIYW9U/IH4yHv9OCReLE2MkgltHTEDCsurLut8HZmMQlQ9vbwhyw=
X-Gm-Message-State: AOJu0YytkhqTUdiFcnu/jJQA/nqyCxklHLvTXbNSodUfEW64Dm1L/2KN
 LXQNKixdh7TYzTuwACX59uEZeUm1Qqwf79K/gqkZ4A/uzZTH7wToIW+GnHsofuGhOKtGR4qCtr2
 JgPIHNIrrjRPz2izccLbRPWAPl2LDp+VX4pWgXlENXXvGu0buR4ofev8JroAfknR9ihbSumqT55
 yZTgOZwdIxSewVx+8MYpre+gkFLuqM6BlpwtQ8
X-Received: by 2002:a17:90b:384e:b0:2c7:1370:f12f with SMTP id
 98e67ed59e1d1-2ca35d6b78amr8304415a91.40.1720750280394; 
 Thu, 11 Jul 2024 19:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPa1olhV9LyswmC0F1fCCX3X1S0Lzq+URGC8lgySLdHkMvVNlGLQ+uQFX08WFAiNjS06TZVZxNezPw+OABYWI=
X-Received: by 2002:a17:90b:384e:b0:2c7:1370:f12f with SMTP id
 98e67ed59e1d1-2ca35d6b78amr8304398a91.40.1720750279949; Thu, 11 Jul 2024
 19:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-5-c7b0e9edf9b0@suse.com>
 <20240711204007.GC85696@pevik>
In-Reply-To: <20240711204007.GC85696@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 12 Jul 2024 10:11:07 +0800
Message-ID: <CAEemH2fdFsQqN3a8sZ7+oeU7w3j+X7HdnGa=zC4H4+iXO9YUAw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 05/11] Add landlock01 test
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

SGkgUGV0ciwKCk9uIEZyaSwgSnVsIDEyLCAyMDI0IGF0IDQ6NDDigK9BTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIEFuZHJlYSwKPgo+IGFnYWluLCBMR1RNLCAyIHRo
aW5nczoKPgo+IEZpcnN0LCB0aGlzIGZhaWxzIGF0IGxlYXN0IG9uIHZhcmlvdXMga2VybmVsIHZl
cnNpb25zICh0ZXN0ZWQ6IFR1bWJsZXdlZWQKPiA2LjEwLjAtcmM3LTMuZzkyYWJjMTAtZGVmYXVs
dCwgYW5kIFNMRTE1LVNQNCA1LjE0LjIxIHdpdGggbHNtPWxhbmRsb2NrIGFuZAo+IERlYmlhbiA2
LjYuMTUtYW1kNjQpOgo+Cj4gbGFuZGxvY2swMS5jOjQ5OiBURkFJTDogU2l6ZSBpcyB0b28gc21h
bGwgZXhwZWN0ZWQgRUlOVkFMOiBFTk9NU0cgKDQyKQo+Cj4gSXMgaXQgYSBrZXJuZWwgYnVnIG9y
IGEgdGVzdCBidWc/Cj4KCllvdSBwcm9iYWJseSBuZWVkIHRvIGNoZWNrIHRoZSBgL3Vzci9pbmNs
dWRlL2xpbnV4L2xhbmRsb2NrLmhgIGhlYWRlciBmaWxlCmV4aXN0LAphbmQgdG8gc2VlIGlmICdz
dHJ1Y3QgbGFuZGxvY2tfcnVsZXNldF9hdHRyJyBjb250YWlucyB0aGUgbmV3IGZpZWxkCidoYW5k
bGVkX2FjY2Vzc19uZXQnLgoKSWYgbm90IGV4aXN0IG9yIGRvZXMgbm90IGNvbnRhaW4gdGhhdCwg
dGhlIHRlc3QgZGVmaW5lcyAnc3RydWN0CmxhbmRsb2NrX3J1bGVzZXRfYXR0cicKaW4gbGFwaS9s
YW5kbG9jay5oIHdoaWNoIGNvbnRhaW5zIGhhbmRsZWRfYWNjZXNzX25ldCBkaXJlY3RseSwgdGhp
cyBpcwpsaWtlbHkgdGhlCnJvb3QgY2F1c2UgbGVhZCB0ZXN0IGZhaWxlZCBvbiB5b3VyIGJveC4K
CgoKPgo+IEknbSBub3Qgc3VyZSBpZiBMaSdzIGNvbmNlcm4gWzFdIHdhcyBmdWxseSBhZGRyZXNz
ZWQ6Cj4KPiAgICAgICAgIFdlIHN0aWxsIGhhdmUgdG8gYWRqdXN0IHRoZSBjYXNlIGlmIHNvbWVv
bmUgaW50cm9kdWNlcyBvbmUgbW9yZQo+IG5ldyBmaWVsZAo+ICAgICAgICAgc2ltaWxhciB0byAn
aGFuZGxlZF9hY2Nlc3NfbmV0JyB0byB0aGUgc3RydWN0dXJlIGluIHRoZSBmdXR1cmUuCj4KPiBL
aW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gWzFdCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRw
L0NBRWVtSDJka0t2dGhieCt6YS1yd2ZzbWFucmFadXVkLXNxMU80RlpLMnp0YTVNQk1TZ0BtYWls
LmdtYWlsLmNvbS8KPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
