Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42253EE57DF
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 12:06:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C11F3CE850
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 14:06:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9515D3CB427
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 14:06:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB70A1A01081
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 14:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694433995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jIJnG1t1+08Z4sXXNy+98n4Y7qrhzGFcPsGLUlSUSag=;
 b=Ds/AwAoSo0zi0qVIs1/gsDWejmmArsbZPlzY6MlD3Y4mHbwUbUX1P5eqMLpWd8tneS3wLD
 5ZcGOdl/VbWXpKbU+RdYhIusVQILAXjqiAzkIUqN/58NG+5AUYaMzyW1XpM2HkH7mKfqIy
 VmQsxN7p0jnNK/tHJH+lCxaUBBcgjtY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-4-bS0vgqPxCxxtVOq104zA-1; Mon, 11 Sep 2023 08:06:33 -0400
X-MC-Unique: 4-bS0vgqPxCxxtVOq104zA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-500a6ae8392so4688688e87.0
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 05:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694433990; x=1695038790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jIJnG1t1+08Z4sXXNy+98n4Y7qrhzGFcPsGLUlSUSag=;
 b=oEgvWuY9Nr27uXW9zXGs+LI+X61BSaLqCh8HNVMMWiJJ6/0FzDmuq4GgWMBJVIbXgQ
 eEwhKTjba/+8zPmnRxzISUzAG4DZw199ZzbR1itS/5Xw9GLU2NgOE1ztYQZJS3eWnT86
 /ZlCOjP1+cRo1GtLiXZyFsWz1AyaYXtEtUEmUCW/AV4QbphfyP8D0pM3TdO3gHhlnILd
 9WGDdADfPj/pothohbG61Gq0S2rmmJx6JWPV/8YFWLD7Jiy1iz73GdB0yryZuM21Eah8
 M52JkVsfCBPS93j/0XICAti5gabw84o2JqzcSCv1vI0N+k3dpCkySIzqM3BGOnC3osbF
 5OWg==
X-Gm-Message-State: AOJu0YyMcWeqWJRpwkR4P5A4q1nzj3PgJdzNrAdFs5Gif2+XeK7CYoMc
 s1r0EXD4OESngXvXKyzBgLRMgEC7fsojRNqgskzQd+x28vz6IrwbBiNuqFXVrgnvkUoKEBzc1x6
 hxdbRUSwmgGlOaj6Xxk/BL5EYm3kVp7wRSvDu9UfFnUk=
X-Received: by 2002:ac2:5ddb:0:b0:4fb:a0f1:f8b8 with SMTP id
 x27-20020ac25ddb000000b004fba0f1f8b8mr6754281lfq.63.1694433989987; 
 Mon, 11 Sep 2023 05:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpfyPF192r4DWP+bdA0jQ9JR4vfWb7V27es0WqB6acTIWXN2dfUWIzN6AKxf+DPiAXBllKpGoSd6dhm9q4G/s=
X-Received: by 2002:ac2:5ddb:0:b0:4fb:a0f1:f8b8 with SMTP id
 x27-20020ac25ddb000000b004fba0f1f8b8mr6754256lfq.63.1694433989625; Mon, 11
 Sep 2023 05:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230909113004.21766-1-pastalian46@gmail.com>
 <CAEemH2f3-LqJ0M5yLoBPQErfkrWgELgiRZjzxGLJ0QrKMoof9Q@mail.gmail.com>
 <CAAaAyq_1w2UqVSTkxy+x8CohiK2DEOHEjgVV5t7+gbL0s44VXQ@mail.gmail.com>
In-Reply-To: <CAAaAyq_1w2UqVSTkxy+x8CohiK2DEOHEjgVV5t7+gbL0s44VXQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Sep 2023 20:06:17 +0800
Message-ID: <CAEemH2fH+dm127iCFOf_hm94jTUvWLt7OQh8K67eCZSVRaqByQ@mail.gmail.com>
To: Takuya Wakazono <pastalian46@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] recvmsg01: Skip unsupported test
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

T24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgNjo1MOKAr1BNIFRha3V5YSBXYWthem9ubyA8cGFzdGFs
aWFuNDZAZ21haWwuY29tPgp3cm90ZToKCj4gSGkgTGksCj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3
Lgo+Cj4gPiA+ICAgICAgICAgaWYgKCh0c3Rfa3ZlcmNtcCgzLCAxNywgMCkgPCAwKQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAmJiAodGMtPmZsYWdzICYgTVNHX0VSUlFVRVVFKQo+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAmJiAodGMtPnR5cGUgJiBTT0NLX1NUUkVBTSkpIHsK
PiA+ID4gICAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJNU0dfRVJSUVVFVUUgcmVxdWly
ZXMga2VybmVsID49IDMuMTciKTsKPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiA+ID4K
PiA+Cj4gPiBJdCdkIGJlIGJldHRlciB0byB1c2UgdHN0X2JyayBUQ09ORiByYXRoZXIgdGhhbiB0
c3RfcmVzICsgcmV0dXJuLgo+Cj4gV291bGRuJ3QgdGhhdCBhYm9ydCBhbGwgc3Vic2VxdWVudCB0
ZXN0IGNhc2VzPyBXZSBvbmx5IHdhbnQgdG8gc2tpcCB0aGUKPiBNU0dfRVJSUVVFVUUgdGVzdCBj
YXNlcy4KPgoKQWgsIHllcywgSSBvdmVybG9va2VkIHRoYXQgdGNhc2VzIHRyYXZlcnNlLiBTb3Jy
eX4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
