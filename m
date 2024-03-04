Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2CFC54E41
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 08:50:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BA3B3CE0C7
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 09:50:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EFE53CAB09
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 09:49:53 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 028B21400124
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 09:49:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709542191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Em80ULKeTK2WXPNGvpEWhfWj5DvWmVcwmEUSgAex9IM=;
 b=EDz5dK5v7U9/WgtVLvrKLmeN2RVJ3YC5k5nGXn98g3nkdjoc4NkKykIaAOc4xv8N8aA6Be
 qV7CrbSyfGfRbLVpsLg40MffWMxOLqnKgn9KKgDY1Zi6qyi8pc1cBx6mTlv9ub93P5H8mM
 61CtZG2GBwbKOodj2N8HO5YN9g/QIqk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-1TnXVPyeODeteBrNKaOjOg-1; Mon, 04 Mar 2024 03:49:48 -0500
X-MC-Unique: 1TnXVPyeODeteBrNKaOjOg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29b2c29b9e5so2452025a91.2
 for <ltp@lists.linux.it>; Mon, 04 Mar 2024 00:49:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709542188; x=1710146988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Em80ULKeTK2WXPNGvpEWhfWj5DvWmVcwmEUSgAex9IM=;
 b=DIwNGdiqpaiOHF6W0LYsMGw6iEa6vVxoWcsIfudQgLzhYD0pedANiHOUoEkAPlcJyk
 eLgo0lwRmkHPnK6SYnEVGb6+pZ3Yk0UpMFipuetzoimaWKzhfPkXA9cUV9boZDxPiauf
 9sqJBIbj/22HZRuzdbPV+6Q6DYhpOE5quNKfy9DusbWy/NPCJBz9Hb674Ae/UQOQ0AkU
 lOpaEWKzYWWgdrwF4NYVdkXcC0Z90SHJwfJepFVEkLnXe5xJFWRIgE6IECIcYpw47TQG
 WTi24p6bqsaHJONRaZgAovTq/x9P0HEFykBV0pwO5lwey7aTrgEC9NktmZr1oRk++2Rr
 s9Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgYFK/Irc06S7dNAvXBp3lq4bquPzl4ttkbtBX1kVwRQz4XrvDcACbPB++6UDAieDt9T/gBv/B3Vvw5TPqQz2XEU0=
X-Gm-Message-State: AOJu0Yx6nbi3cTKxvp0mqbdvIs5tkSV8FBs8LBTRE9CDen24chiv9hsW
 cngTyBrs1MZQHwLnZoBzCxS/OvhF6Cjiqkp2dtc9NcS2nLaS/W3PI6osXjZdsrzDKj3rKkgeoVK
 6ep8AqSZYcZRGkzWlj6G7/3wEqqLTELABKktPjKzH2VvA+etXtukv0vN9OF9rDqeZSwRPuxesia
 nMXESLdOIEsLlIEfKFWjnhies=
X-Received: by 2002:a17:90b:892:b0:299:5401:89d2 with SMTP id
 bj18-20020a17090b089200b00299540189d2mr5609167pjb.45.1709542187882; 
 Mon, 04 Mar 2024 00:49:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwvO3O0X1Fai9agzfYiV49JFFtJGCeHI87dGmW/W43DhId1BOAiJ/DqXbO+xCAj349WSTpcHF4OOLD8z+mjKo=
X-Received: by 2002:a17:90b:892:b0:299:5401:89d2 with SMTP id
 bj18-20020a17090b089200b00299540189d2mr5609159pjb.45.1709542187629; Mon, 04
 Mar 2024 00:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20240301062716.3023-1-wegao@suse.com>
 <5681819a-2a3a-4c47-a1f1-3f9f49c994d9@fujitsu.com>
 <20240303131402.GC1856074@pevik>
In-Reply-To: <20240303131402.GC1856074@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Mar 2024 16:49:35 +0800
Message-ID: <CAEemH2eKts8X+tj1keU4Vqp5LwKRa8V1w7QdzGOPmC95F9JK7Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
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

T24gU3VuLCBNYXIgMywgMjAyNCBhdCA5OjE04oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBXZWksIFh1LAo+Cj4gPiBIaSAgV2VpCj4KPiA+ID4gSSBlbmNvdW50
ZXIgYSBkZWFkIGxvb3Agb24gZm9sbG93aW5nIGNvZGUgaW4gb3VyIHRlc3Qgb24gcHBjNjQgbWFj
aGluZToKPiA+ID4gd2hpbGUgKChjID0gZmdldGMoZnApKSAhPSBFT0YpCj4KPiA+ID4gSSB0aGlu
ayAiL3Byb2Mvc3dhcHMiIGlzIG5vdCBub3JtYWwgZmlsZSBhbmQgY2FuIG5vdCBnZXQgRU9GIGlu
IHNvbWUKPiBzaXR1YXRpb24sCj4gPiA+IHNvIGkgdXNlIGZnZXRzIGEgbGluZSBhbmQgY2FjdWxh
dGUgc3dhcCBkZXYgbnVtYmVyLgo+Cj4gSSBndWVzcyB0aGUgcHJvYmxlbSBoYXMgYmVlbiBmaXhl
ZCBieSBhbm90aGVyIHBhdGNoIFsxXSwgdGh1cyBjbG9zaW5nIGl0IGluCj4gcGF0Y2h3b3JrLiBQ
bGVhc2UgbGV0IG1lIGtub3cgaWYgbm90Lgo+CgpTZWVtcyBub3QsIHRoZSBwYXRjaCBbMV0gYmVs
b3cgaXMgbWFpbmx5IHRvIGNvdW50IHRoZSBmcmVlIGRpc2sgc2l6ZS4KCkJ1dCBXZWkncyB3b3Jr
IGhlcmUgaXMgdG8gY2FsY3VsYXRlIHN3YXAtZGV2IG51bWJlcnMgY29ycmVjdGx5Cihlc3BlY2lh
bGx5IGdldCByaWQgb2YgRU9GIGFmZmVjdGlvbiB0byBzb21lIGRlZ3JlZSkuCgpYdSBZYW5nLCB3
aGF0IGRvIHlvdSB0aGluaz8gb3IgZGlkIEkgbWlzcyBhbnl0aGluZyBoZXJlPwoKCgotLSAKUmVn
YXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
