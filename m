Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D87FC433EF
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 09:42:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 856AF3C902B
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 10:42:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F267F3C0513
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 10:42:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6C60E653A40
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 10:42:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642066943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1350e0BhU8CIgvnuEjTWUyBxhdJ28nsg53ULfXanTYc=;
 b=SfvQjt4oqTmeXtvJNxxwpv/eM8Ruxblum6Ath9cCEZY4pTsxamK4JPBBzqMSIs/fCTgY9a
 1RswJjdbL11bOohoZcOs9b3qpwolRkbUwLzi6+b8inSbg7hbiUv1dcZMgGcuV89tf0rHy+
 CTeDfTtc4EHKnZPZPGVz1ENw4Iqierc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-YKrFvnhdMvCZG78V26Se9w-1; Thu, 13 Jan 2022 04:42:22 -0500
X-MC-Unique: YKrFvnhdMvCZG78V26Se9w-1
Received: by mail-yb1-f198.google.com with SMTP id
 127-20020a250f85000000b00611ab6484abso6956193ybp.23
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 01:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1350e0BhU8CIgvnuEjTWUyBxhdJ28nsg53ULfXanTYc=;
 b=1d3nZfsdeS82MDIWptThRnkd9RPK4gyi5MRFdHaoiJd271bGw7r2MDDpk9NbylRT4B
 2WmDJgR1a5ygfmL/KB5jfmDhg/sDVOXF16gndzgib+npR3DFbch187V0i97W7i11cwYm
 WRzuIYkWLqLo7JO7Fph5vjDyd70myow1ywMXCBp6NqY7sKZln7/TKFACdSM7+1iNM8ef
 p8ULMsWyxilg3GlWrlgnH6VmxHnXBMSlOZJZAtK7ZyIrMlxYGILNffVkvH+wMC2mxoeI
 p4ZEEfGKYYcJfSONpIzV4UBr2K+ZNEsJlMtZBeHY/o0We4nNqboAkOc9w2kf8lL7vqIe
 FLlw==
X-Gm-Message-State: AOAM530ttCPTBw4rCmgMWuDTe14OngYXhiIX4eHDxKesSkl2ZFxSQ+lP
 yi2/4hgPSkH0SnBiHyNc0RYg66JyNIeBuK2U9CEnN0QY3rmGzxnWJvNeZEgSWiq67Igvh1KyRse
 KzQD4ov2/lxveR85L2KCSbPGZmHw=
X-Received: by 2002:a25:b00b:: with SMTP id q11mr5107151ybf.421.1642066941772; 
 Thu, 13 Jan 2022 01:42:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhmDPverTVwK4ok9bcxhUGOSuwQCGWWuZ7ANEo8ntTknh3UNL7Z2jwcjEbTgT2y+47s021DC4GFxS6OJbnoco=
X-Received: by 2002:a25:b00b:: with SMTP id q11mr5107134ybf.421.1642066941497; 
 Thu, 13 Jan 2022 01:42:21 -0800 (PST)
MIME-Version: 1.0
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641881435-2351-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2eZJ7U1+Bdsb5xCB6-KYa1mQQ=GriaDtyFSJ_6zprT7yw@mail.gmail.com>
 <61DD4215.2050104@fujitsu.com> <61DFEE02.5020204@fujitsu.com>
In-Reply-To: <61DFEE02.5020204@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Jan 2022 17:42:08 +0800
Message-ID: <CAEemH2c8V6AJ6XfaxT-RJKCZ9TLVb8qZ+xJ-M+rZDdFvh-y3Wg@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/5] shell: add kconfig parse api
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiA+IFRoZSBsYXN0ZXN0IGNvZGUgc2hvdWxkIGJlIGFzIGJlbG93Ogo+ID4KPiA+IGludCBtYWlu
KGludCBhcmdjLCBjaGFyICphcmd2W10pCj4gPiB7Cj4gPiAgICAgICAgICAgY2hhciAqc3RyID0g
YXJndlsxXTsKPiA+ICAgICAgICAgICBjaGFyICpkZWxpbSA9IGFyZ3ZbMl07Cj4gPiAgICAgICAg
ICAgdW5zaWduZWQgaW50IGksIGNudCA9IDE7Cj4gPiAgICAgICAgICAgaW50IHJldCA9IDA7CgpU
aGUgc3RhdGVtZW50IG9mIOKAmHJldOKAmCBjYW4gbW92ZSB1cCB0byB1bnNpZ25lZCBpbnQgYXMg
d2VsbC4KT3RoZXJ3aXNlLCB0aGlzIHZlcnNpb24gTEdUTS4KCj4gPgo+ID4gICAgICAgICAgIGlm
IChhcmdjID09IDIpIHsKPiA+ICAgICAgICAgICAgICAgICAgIGRlbGltID0gIiwiOwo+ID4gICAg
ICAgICAgIH0gZWxzZSBpZiAoYXJnYyA9PSAzKSB7Cj4gPiAgICAgICAgICAgICAgICAgICBpZiAo
c3RybGVuKGRlbGltKT4gIDEpIHsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZnByaW50
ZihzdGRlcnIsICJUaGUgZGVsaW0gbXVzdCBiZSBhIHNpbmdsZQo+ID4gY2hhcmFjdGVyXG4iKTsK
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDE7Cj4gPiAgICAgICAgICAgICAg
ICAgICB9Cj4gPiAgICAgICAgICAgfSBlbHNlIHsKPiA+ICAgICAgICAgICAgICAgICAgIGZwcmlu
dGYoc3RkZXJyLCAiUGxlYXNlIHByb3ZpZGUga2VybmVsIGtjb25maWcgbGlzdCBhbmQKPiA+IGRl
bGltICIKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiKG9wdGluYWwsIGRl
ZmF1bHQgdmFsdWUgaXMgJywnKVxuIik7Cj4gPiAgICAgICAgICAgICAgICAgICByZXR1cm4gMTsK
PiA+ICAgICAgICAgICB9Cj4gPgo+ID4gICAgICAgICAgIGZvciAoaSA9IDA7IHN0cltpXTsgaSsr
KSB7Cj4gPiAgICAgICAgICAgICAgICAgICBpZiAoc3RyW2ldID09IGRlbGltWzBdKQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICBjbnQrKzsKPiA+ICAgICAgICAgICB9Cj4gPgo+ID4gICAg
ICAgICAgIGNoYXIgKiprY29uZmlncyA9IG1hbGxvYygrK2NudCAqIHNpemVvZihjaGFyICopKTsK
PiA+Cj4gPiAgICAgICAgICAgZm9yIChpID0gMDsgaTwgIGNudDsgaSsrKQo+ID4gICAgICAgICAg
ICAgICAgICAga2NvbmZpZ3NbaV0gPSBzdHJ0b2tfcihzdHIsIGRlbGltLCZzdHIpOwo+ID4KPiA+
ICAgICAgICAgICBpZiAodHN0X2tjb25maWdfY2hlY2soKGNvbnN0IGNoYXIgKiBjb25zdCopa2Nv
bmZpZ3MpKQo+ID4gICAgICAgICAgICAgICAgICAgcmV0ID0gMTsKPiA+Cj4gPiAgICAgICAgICAg
ZnJlZShrY29uZmlncyk7Cj4gPiAgICAgICAgICAgcmV0dXJuIHJldDsKPiA+IH0KCgotLSAKUmVn
YXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
