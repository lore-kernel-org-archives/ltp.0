Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CE9D35660
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769561559; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GIBP8NPNYh0nVSsu3fGiyrP7b/lex6Jxsb+GQIj+Tmc=;
 b=NDEMN7TvCVFN/fOUl0yklW8aob25GAYtB6nOS+UBo88KincXSMMIlcX2tKaTxvP+pth2D
 8s4lHg0OdljU2hMmmQopuRUyblGfmE0gjpQ5qgm1nXgyeAtweLoHWPFhY35TPcrRh/GPw/Z
 Tx/7AyYW67DSaK7BHu2gbk5fD/LaDI4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEE3C3CA48E
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 01:52:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF9213C4F49
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 01:52:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 155912002AF
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 01:52:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769561529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0il/XBQ+NpITrNmbN0W6ESd87R6D7qUrfGouuX9+QZE=;
 b=Qp0cCgf1lTXNossG1zS3zMq7CcrwhDE9+yPWM6mAk5UnDhykHZHNtZBBxf2YtHOa+my6o9
 86tpoWPlpm4jmHFLnx0DCr8G77WD46fFJDOCnN6G+1YD9nywMQBtZgEiPA+oZtAIBC82qO
 uVPeeIGyMtEtDI8oxnw0jvPHpQ1LR+8=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-GDezVlFMNs2gN_wRkVWJ-g-1; Tue, 27 Jan 2026 19:52:07 -0500
X-MC-Unique: GDezVlFMNs2gN_wRkVWJ-g-1
X-Mimecast-MFC-AGG-ID: GDezVlFMNs2gN_wRkVWJ-g_1769561526
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b724ff60e6so6589844eec.0
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 16:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769561525; x=1770166325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0il/XBQ+NpITrNmbN0W6ESd87R6D7qUrfGouuX9+QZE=;
 b=J64Ip7q1irR1U/l1outZKiibiLS73N3n/43AUYBkcP+A2RI0E1YkUJObBNsp/kssZ6
 PDU7+32fesP8daQ924APUcp89NQDVwLampceqUh53JcJEZvPPLyFyM3obDaDinAGnJek
 x5JNeFQ4GlWGxFIusOp+alvboEiwylwhtucJn8mdmAoZJJ99b5PiBiPO8z9XiJabPZ2M
 6x+h9YGo5x64BTSHkkTvJZ0Nt4/Ml/lipA0Rx7aKWBviTazqP3+mA2acakqmWqZB+N+U
 eEpF63PAKKFFjoY4Z+xhxAB4iFU4jUEeEoSr4nWZUYNnaNVTrXk0eEmJC/UEgh+4MZY3
 k65A==
X-Gm-Message-State: AOJu0YxMAYYq/nf/R+qj6Mv/25f+B1X4VM1rG/t594v5j/vYcqqjIBJR
 QdBRWypxbjMH6ILBbeEk66XAJVpyZJdB7/7/ZMftz2bTPBcyJhQJrNk5QEH3AfX0kbRdcHpZVze
 K5+sFwX+IgOyy14yBCSs+Ukfb3xgs2IR3ihZLtZyqCBSYpY2LwmHzfPaFuCTWwJcztAV3B1y8Od
 gUVq54gfPbMvqjByYRqyRAvGf02tPixU/xVS6LhQ==
X-Gm-Gg: AZuq6aKaNM/1vQJvognsbzQnnNWfmBTieM3uR7+KlPC+IT7fWjM75UXwikcjRKkb7oA
 QFxUvwg6tstTY5RjmrAnJ9mQa7IMKOWnjYcxpXnuckmGhf6MQaPc93vvey8M/+O0WOMSq9myEEo
 caZTwyTJ2Xg2V2C70TpTj+7WQ8eRElX8fbZPZfYAnf0srdU56waPHTmXTbp8wvi84RRu0=
X-Received: by 2002:a05:7301:1698:b0:2b6:fa0c:6c44 with SMTP id
 5a478bee46e88-2b78d8a205bmr2102267eec.12.1769561525598; 
 Tue, 27 Jan 2026 16:52:05 -0800 (PST)
X-Received: by 2002:a05:7301:1698:b0:2b6:fa0c:6c44 with SMTP id
 5a478bee46e88-2b78d8a205bmr2102258eec.12.1769561525179; Tue, 27 Jan 2026
 16:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20260127131427.146592-1-pvorel@suse.cz>
 <20260127131427.146592-2-pvorel@suse.cz>
In-Reply-To: <20260127131427.146592-2-pvorel@suse.cz>
Date: Wed, 28 Jan 2026 08:51:53 +0800
X-Gm-Features: AZwV_Qh7lPC2sHVwLS1H1bnaRwMe5isG-5F7l3IuPmsdG63dAtTlDpS9ZDoc6sI
Message-ID: <CAEemH2c5hL+DeJvCe+UjN-5YtTjTRUQDsWWomYU43gpGLNOCOg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F6v6_QmdHXuW6V8IBlKBS-F1Y6S8zfgh2CxoVvSv44g_1769561526
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] tst_net.sh: Fix tst_brk() use in
 tst_netload_brk()
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

T24gVHVlLCBKYW4gMjcsIDIwMjYgYXQgOToxNOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gU2luY2UgMTg3ODUwMmY2MyAoInRzdF90ZXN0LnNoL3RzdF9icmsoKTog
QWxsb3cgb25seSBUQlJPSyBhbmQgVENPTkYiKQo+IGl0J3Mgbm90IHBvc3NpYmxlIHRvIHVzZSB0
c3RfYnJrKCkgd2l0aCBURkFJTC4gQ2FsbCB0c3RfcmVzKCkgZm9sbG93ZWQKPiBieSB0c3RfYnJr
KCkgZm9yIFRGQUlML1RXQVJOLgo+Cj4gQWxzbyBjb252ZXJ0IGZhaWx1cmUgb24gbWlzc2luZyBm
aWxlIHRvIFRCUk9LLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+CgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
