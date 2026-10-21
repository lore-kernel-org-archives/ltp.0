Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD660A263B
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=PSldDyOp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BGruqeXF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792597402; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/02WlbUIVqyoiiuHL06fyJ+xD4Y80LPnihpWHTVLXJc=;
 b=PSldDyOp+m7iB5QzdsN5hrP2OHeU/LVgH/X9CYb+Xd/sw6kfSiJJV2ChRZ2IuNNqdXsJR
 5VDE78AIR5ApvP2NzoxCfWVMJ5Z/lrcu+RKHHJb0C5YBD7j99DZ0Bu48DHpndwZWctWtw6O
 5EaTSb5wHmH/7aWlZ0RV6v3ecADNjWI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D71F3CFD14
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 17:43:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD9DB3CFD00
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 17:42:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2396D200975
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 17:42:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792597365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czWOqYssCvV95S0y9bqpSx/gO6YZ0gEFZnqlMCyI0PE=;
 b=BGruqeXFEi9+2J0mXgLezz2rMKkiQ2wDT9eHOKG91mUC3ndzhqv3bdahsPbxgtkqGQHlGt
 Au0EZp8aKi/yTesXsejA8o8S8xTfMKvsLmj4S210Q1XoCXHof6e/lXKPY4wlvr2+ZNMGWV
 sD+3yRjOx7xv8uq6Tet+TL8xuo8T00Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-MPClLuKgNjyXyeySrSpGrQ-1; Wed, 21 Oct 2026 11:42:44 -0400
X-MC-Unique: MPClLuKgNjyXyeySrSpGrQ-1
X-Mimecast-MFC-AGG-ID: MPClLuKgNjyXyeySrSpGrQ_1792597363
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso130645e9.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 08:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792597363; x=1793202163;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=czWOqYssCvV95S0y9bqpSx/gO6YZ0gEFZnqlMCyI0PE=;
 b=jTHFtLJ7I2ghKHf725KwIuTBVpYR4D2V8skl4ZNZhfhwF0ErKseeCInjy9RFOOJD8+
 gxLLk9ecftIvIue9Sy+ti/OSv9FLadB8n4v7NF+6ucC0lftlmNTdxLiPiahbWaVW6RSf
 Z7Un5/n8sB1eku5/0piWAMvvHUEhH7JA0xJM9fR2cr9BgO92ildz8mxgh4fEMS7+idYO
 P17vlr1FOhivUF9EDqg8bKtXcYueJvDuMu83HgS0ItAHvtkz+b6XaPU9uQ9AIwh8BvxP
 s69ro+6FRxfW4lvUMZlEyr4daaOvfxQnGzdradjG8nQ5Gf0445FroAArnvoN+SwpZeLQ
 C5xg==
X-Gm-Message-State: AFq9FYJSM7xY2i69yES89x83gqJSEOUIhig6kF+E70lohCaVX/eiNm0F
 3ah9iRFaDw08+U4ZUTrrgTp4yjbv2Z/uaufOm7Xy6t0sfhXr7Hot170f6vjvP+JivZ9pHoK/lA3
 Q71bv0c3fr6g7wEht40dn5Dh3/BK1qr2X+PJelUO//zqZEE1FxxUInv9uCD1N/seHihXEQXNuCH
 wuh1pd1Z2vHhaN7YYN6wBVdGGgLUkrkVimxhU=
X-Gm-Gg: AYBFou3qOltUrYAW9xMHMgJSUUdJUD1vNXQpbk/95NROdO3QGdUpzmFAhOHKL9vJLMd
 4lcMSds69YcVK7gQAvJoHz6z/E13qxbnTTqiL6dJ8CotV9P+C5Dsour6zQYoQSDYg9p5tHhBa4N
 +hy614uVUT4B5xmYsvLvRfucYSbiEmdZP0LHWJPMBhcVtzFnAvutyVGwg=
X-Received: by 2002:a05:600c:1c09:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4a1fdd3bb0fmr53300015e9.17.1792597363102; 
 Wed, 21 Oct 2026 08:42:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1c09:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4a1fdd3bb0fmr53299575e9.17.1792597362681; Wed, 21 Oct 2026
 08:42:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <dc45087f4a5dd1700aae6df3a8181ae349f2bdfe.1792413269.git.jstancek@redhat.com>
 <yvghh4rRtY35Af2DMzcAVGa6TqwKgHWf4amF@localhost.localdomain>
In-Reply-To: <yvghh4rRtY35Af2DMzcAVGa6TqwKgHWf4amF@localhost.localdomain>
Date: Wed, 21 Oct 2026 17:42:25 +0200
X-Gm-Features: AclHuK_z_fQjbuqhf0Xb6chRKOYVUGV7G_uiWQilNHfm-vvwfyC0K2LDuDe57vk
Message-ID: <CAASaF6zi+COFGNv6ojZ9Zmk2jhYZMsTbLsLfPQtLnPt46w0zGQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OnbkMWIe0ms_bERdgyro1DAij9oAYaeRDLjNTMYm4Rk_1792597363
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] float_trigo: Fix acos/asin/atan input generation
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UHVzaGVkLgoKT24gV2VkLCBPY3QgMjEsIDIwMjYgYXQgMTE6MzPigK9BTSBBbmRyZWEgQ2VydmVz
YXRvCjxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPiB3cm90ZToKPgo+IFJldmlld2VkLWJ5OiBB
bmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+Cj4gLS0KPiBBbmRy
ZWEgQ2VydmVzYXRvCj4gU1VTRSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVyIExpbnV4Cj4gYW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmNvbQo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
