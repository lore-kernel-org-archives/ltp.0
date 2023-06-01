Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB30C7EE23
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 06:44:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DCB73CCF04
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 08:44:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FEB13CCE20
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 08:44:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3AADF600E3E
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 08:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685601879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3p9J4kCBzd6/1yj6G7AQzYfdLrksQbGWYMDKD8ge1tE=;
 b=NM+7YL2Peh4Aj/Wv2BKOCoJUyeeBMfS3DlzmPQ0cEj6n9C8VZhxj62AsAqaXMlq8br1WEk
 AkEY4CP6DVQXmpP+amobIKzh2ztTRfxLHgicbwQI0hzOqvqIZO5u788S0rpLWwdPT/Q9AY
 wySEmD//NoDDjaRTZ7emcKWKVAqMNb4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-E7NiYTYyN1a5yjLk5R4aeQ-1; Thu, 01 Jun 2023 02:44:37 -0400
X-MC-Unique: E7NiYTYyN1a5yjLk5R4aeQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af25b667d5so4116931fa.1
 for <ltp@lists.linux.it>; Wed, 31 May 2023 23:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685601876; x=1688193876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3p9J4kCBzd6/1yj6G7AQzYfdLrksQbGWYMDKD8ge1tE=;
 b=WIiEbqMYLZ0Zv+Y9FIDRDSykUN95WPd8Pq+BVKTFSiGe8j7wdHGONwvAUptTQuHNk5
 B/Q4PlMP2jhF9+5GQIOKaLwfhFvUiLPsrG0OJ0vFS0czHny8ZWPbobW6MgJpyO4ntGWi
 k/RrgKAOQFCVOEg16VpmwMS7AaJHlsggVL7u/SEs0pJ/azwzWFjY2lhNjuaNoY0/E3Zr
 hxaiMREUHv5UmYKRM1+3oRrJyRaxxVTPLwnJdDnADVEvbO1gwXSsiMlT+PjiPrkYLT0v
 TzO27WFqSSiCD1YahVlhb1VHl2hjEDFzlerK4L+D50FOxzhAq8F+BwxvlL9j6l+1D5dF
 bMGw==
X-Gm-Message-State: AC+VfDyAZTY8zJiVxqWWlCyaU4dEAQKfMQTljXsmFJiHvkpPlgeQlgD1
 R/7TRTw5nWPEVL//XskbbaE4HMFgA+CmjFdKG40XjrnOQd24aqSLf3KzuF21Xygh8O2OSbG3VY8
 ObMlANtX+EyRd5SXWoMvZq+jbGLU=
X-Received: by 2002:a2e:9182:0:b0:2a8:a5b8:184a with SMTP id
 f2-20020a2e9182000000b002a8a5b8184amr3680734ljg.40.1685601876214; 
 Wed, 31 May 2023 23:44:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HzQ6y6I5NwTKl3c3omm8VsZ3x+0T5iTuAyk4JAga6eWz3iQdBEh7mWbCt2uIj9onpOd88flEykDkMIG/2MsA=
X-Received: by 2002:a2e:9182:0:b0:2a8:a5b8:184a with SMTP id
 f2-20020a2e9182000000b002a8a5b8184amr3680727ljg.40.1685601875876; Wed, 31 May
 2023 23:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230525080934.54793-1-liwang@redhat.com>
 <20230525080934.54793-2-liwang@redhat.com>
 <20230526142547.GA812267@pevik>
In-Reply-To: <20230526142547.GA812267@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 1 Jun 2023 14:44:24 +0800
Message-ID: <CAEemH2fE2c=wdrTWKMUNMqo6yscOpMSMxkaruDQNBFPMyHcBjQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] cleanup: changing FILE_PRINTF to
 SAFE_FILE_PRINTF
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

SGkgUGV0ciwKCk9uIEZyaSwgTWF5IDI2LCAyMDIzIGF0IDEwOjI14oCvUE0gUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKCj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2Rldmlj
ZS1kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9ib29zdC5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL2RldmljZS1kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9ib29zdC5jCj4gPiBAQCAtNzgsMTAg
Kzc4LDEwIEBAIHN0YXRpYyB2b2lkIGNoZWNrX3NldF90dXJibyhjaGFyICpmaWxlLCBjaGFyICpv
ZmYpCj4KPiA+ICBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gPiAgewo+ID4gLSAgICAgRklM
RV9QUklOVEYoY2RydltpZF0uZmlsZSwgIiVkIiwgYm9vc3RfdmFsdWUpOwo+ID4gKyAgICAgU0FG
RV9GSUxFX1BSSU5URihjbGVhbnVwLCBjZHJ2W2lkXS5maWxlLCAiJWQiLCBib29zdF92YWx1ZSk7
Cj4KPiB0ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9ib29z
dC5jIHVzZXMgb2xkIEFQSSwKPiBJTUhPIG5vdCBhZmZlY3RlZCBieSA2NDQwYzVkMGQxNS4gVGhl
cmVmb3JlIHdlIHNob3VsZCBwb3N0cG9uZSB0aGlzIHRpbGwKPiBpdCdzCj4gY29udmVydGVkIHRv
IHRoZSBuZXcgQVBJLgo+CgpUaGF0J3MgcmlnaHQuIEkgcmV2ZXJ0IHRoZSBjaGFuZ2UgYW5kIHB1
c2hlZCBpdCwgdGhhbmtzISEKCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
