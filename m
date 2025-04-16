Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391E7C369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 07:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744788921; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qD7j6aThhaC2x3K9J+kNmHbhDGivg2lgT3INENKuMeQ=;
 b=psYfaTQ3n2iJdfZr+ZOm84xTruwNlC1cYfW1XJMuUuhwQa0SitqJbx5akTFARpiXJvPw6
 yKsdzqzMtjTJwq5TfHrdrYE4NbnFFSACto/ajLvqYQ5oTtidEi9GNnbXCNH3pdArtodqmdQ
 ds8LPq/eHTKzKFm1ZexN5BS5BYFF8HU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 979303CB955
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:35:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 099DE3C5814
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:35:00 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 63ABF1000932
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744788897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqRESIBQRpKoAny9+TfkGGpVDWdYDXAWJnFy0fezJ9I=;
 b=YLmAya/R4s7WobP2A2OykSvSf3Ez5rvJT8m8/X7HFyd1epdRbxwjcpVYLAF0W9nWfTcMlI
 3C+MZwHGGWe7e9ifAOeNb7L1nlmYpJ7QB0TVMkEyKpiFwEgDK2sSQnnennEusHvGWhQhmM
 JY7XwqEQzpSBZRT/zMIcU6wf07RZhP4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-nSapVbJ6OHmj98wVl5Ag2Q-1; Wed, 16 Apr 2025 03:34:55 -0400
X-MC-Unique: nSapVbJ6OHmj98wVl5Ag2Q-1
X-Mimecast-MFC-AGG-ID: nSapVbJ6OHmj98wVl5Ag2Q_1744788894
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3082946f829so6452764a91.0
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 00:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744788894; x=1745393694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mqRESIBQRpKoAny9+TfkGGpVDWdYDXAWJnFy0fezJ9I=;
 b=pHfQtveALdFS7Url9sXsmTIqNT+J1dKlrqDRGcJ7+UBBtQGp9hxR+eEBWb22CHVeBj
 30r+pk47ySFsm96fM9cr/qu7ADTxF159JbX/eiKEbInumTGaQSivnFiuOc7PrEX+l7HK
 DmkAj2i4TE+dpkgLVAIJJ7V8+gs7Izaxrr6d2V89q0vwPkxqgkO4SPyx/k8K906XMa/3
 DBWjFsksU3M/nHNStUGe8S2kIB2DRhmnCrIAeu7gNMJi5qoYodE7wZDj9JWEKs1MBt8s
 uoJzmWFmKIPbdS4x+cc8/AEwS/FeKICbod083OyaqIP7ANRywfpFDv8eXzT4gq57M4I4
 HpKQ==
X-Gm-Message-State: AOJu0Ywyiy2oalW695VeCTWrvbOmK9f7wJs7DWkyBNcK5jEcSYizmxcp
 vfd7C4l7184m8mATxapxaa51kjrXAxrTyj5A3Pi+BX3EnQme5eAc63w1etFL4ISiLdbtB0PPzax
 2ajLB9116C6qxfopOxmxIuZ5yjuiIyG0JUGj9C6HqOnFGJqzyZemyMB0g9ZyzCnH9zk/8tdoTRO
 UepUdSs2pc9XiQuJ4WJwuBNsM=
X-Gm-Gg: ASbGnct+XgD1Ly8xKz3GpwNkb4gNcXzBj7YGISQEIFW4Qgrw0XQlahjzfbEHc/5muje
 +dZ/8sYYX06QY0D6yba49JUH3/dxtUEGp2iAk3TViT8uF1uFUBowOQ6WndX0BJYLC5LKvgQ==
X-Received: by 2002:a17:90a:d008:b0:2fe:b907:562f with SMTP id
 98e67ed59e1d1-30863f1a0c4mr1311886a91.14.1744788893904; 
 Wed, 16 Apr 2025 00:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTSO4QPVhuC0LzmTXVVFl+fFwAP1AI2JgOEN9Eyy1NU45nyHG7OGGT8wDV+Pxwt0fTVEylPgEeh0Wl225X8LQ=
X-Received: by 2002:a17:90a:d008:b0:2fe:b907:562f with SMTP id
 98e67ed59e1d1-30863f1a0c4mr1311869a91.14.1744788893576; Wed, 16 Apr 2025
 00:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250416072113.573818-1-pvorel@suse.cz>
In-Reply-To: <20250416072113.573818-1-pvorel@suse.cz>
Date: Wed, 16 Apr 2025 15:34:40 +0800
X-Gm-Features: ATxdqUH6uvZNompeoywyiQazvpQcqAHDJuRyeAXJvfpoLrY73nexcTOWtv0zWYM
Message-ID: <CAEemH2e3XLZmS0aO4rRZPQ+qV+QOCvbtLWxngMY2so5gSnZpag@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lp7ao3MuXYT8v2i81y2M-PrG-TcLAA8TmfRKIvxCnjw_1744788894
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] cgroup_lib.sh: Improve error messages
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

T24gV2VkLCBBcHIgMTYsIDIwMjUgYXQgMzoyMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gQWRkIGEgaGludCBmb3IgZXJyb3Igb24gYSBuZXcgY29udHJvbGxlci4K
Pgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IC0tLQo+ICB0
ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2Nncm91cF9saWIuc2ggfCA0ICsrLS0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2Nncm91cF9saWIuc2gKPiBiL3Rlc3Rj
YXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY2dyb3VwX2xpYi5zaAo+IGluZGV4IDllNTkyMjFhYmIu
Ljg2YTVjZWI3ZDQgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9j
Z3JvdXBfbGliLnNoCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jZ3JvdXBf
bGliLnNoCj4gQEAgLTExOSwxMiArMTE5LDEyIEBAIGNncm91cF9yZXF1aXJlKCkKPiAgICAgICAg
IHJldD0kPwo+Cj4gICAgICAgICBpZiBbICRyZXQgLWVxIDMyIF07IHRoZW4KPiAtICAgICAgICAg
ICAgICAgdHN0X2JyayBUQ09ORiAiJ3RzdF9jZ2N0bCByZXF1aXJlJyBleGl0ZWQuIENvbnRyb2xs
ZXIgaXMKPiBwcm9iYWJseSBub3QgYXZhaWxhYmxlPyIKPiArICAgICAgICAgICAgICAgdHN0X2Jy
ayBUQ09ORiAiJ3RzdF9jZ2N0bCByZXF1aXJlICRjdHJsJyBleGl0ZWQuICRjdHJsCj4gY29udHJv
bGxlciBub3QgYXZhaWxhYmxlPyIKPgoKcy9leGl0ZWQvZXhpc3RlZAoKCgo+ICAgICAgICAgICAg
ICAgICByZXR1cm4gJHJldAo+ICAgICAgICAgZmkKPgo+ICAgICAgICAgaWYgWyAkcmV0IC1uZSAw
IF07IHRoZW4KPiAtICAgICAgICAgICAgICAgdHN0X2JyayBUQlJPSyAiJ3RzdF9jZ2N0bCByZXF1
aXJlJyBleGl0ZWQiCj4gKyAgICAgICAgICAgICAgIHRzdF9icmsgVEJST0sgIid0c3RfY2djdGwg
cmVxdWlyZSAkY3RybCcgZmFpbGVkLiBMVFAKPiBtaXNzaW5nICRjdHJsIGNvbnRyb2xsZXIgc3Vw
cG9ydD8iCj4gICAgICAgICAgICAgICAgIHJldHVybiAkcmV0Cj4gICAgICAgICBmaQo+Cj4gLS0K
PiAyLjQ5LjAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
