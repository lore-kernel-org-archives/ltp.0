Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A99FC3DA64
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 07:37:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 147CA3D1D29
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 09:37:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF2E63CF94B
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 09:37:28 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 05E1F600444
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 09:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722929845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=21LRsS0WzputE+BksW7xxcCp+pfAkT+8AmBxDyt9h4Y=;
 b=IM1WuClTKNcxQU4pahrNEuBtprplmfA7Xm5M05gjIjPwZuYjTxT5KtVDAiqZMLZEeO5VWK
 g3fHMDRxntFUlAKVA9QTYzajtuby9M5uBtkpwmMMJshEtA6OiTU3GMolxSGq4PDZqOVCwx
 GUPcDgzuHIafOCoB+qVWdX4XnHPY/ao=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-PciNImOFNKimBUwR_m5f1Q-1; Tue, 06 Aug 2024 03:37:24 -0400
X-MC-Unique: PciNImOFNKimBUwR_m5f1Q-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-70d1df50db2so645617b3a.0
 for <ltp@lists.linux.it>; Tue, 06 Aug 2024 00:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722929842; x=1723534642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=21LRsS0WzputE+BksW7xxcCp+pfAkT+8AmBxDyt9h4Y=;
 b=rVbeSz375XQvvBkrJXoL1BsAecKsvtykd4h58HUSm9C/fJw0gHRtFxm4FmHGFf9MrK
 4wIk1zqMeSUj2aL5AvXZ0xDGwMiwQvGY7U2O6wKHF76G1+bUoD7PQj8XNMMBNn7n25mv
 HpN0fR5yqe9xMcviATr6dupQUOR00JehRbSaRT5+l1KyJiDcpsEiMmNQYkax00FXU0KE
 cxiS+lPjuDU0qj47eyLR3LZB7RnMVA8Y1p2IKrLlkSNCFiKh+2xd2u6ruzaSc183Zxh4
 k9sfOQvISBoj4rPeYIkl5OGukKacoC2xJpt488iL1okDwyXxGSTLaBBzKrGg3mBLGMv0
 nNXQ==
X-Gm-Message-State: AOJu0Ywd0hbdG5dFo8SxZHz5vuTW2c7E2W5Zt8vc+72orP1kH00gt7JF
 7EEwIzjkONFpaMlgZvYvNl7ch5D9F5lv3Avws6KRoymh5NN32Dq8rSIaCrQWOcCGfUhWCV/E5oE
 akzILbTbTj4/rlbx5o7maDL2Q7OLrAWJh1lWdK3ZZtktTfrNlMILxLRlQ+ODFHXoHPLpBR5549b
 olVpLuE9PeopRVOokdJVQz8uvVpAbmEZR+5g==
X-Received: by 2002:a05:6a00:2406:b0:70d:14d1:1bad with SMTP id
 d2e1a72fcca58-7106d9d9330mr25056581b3a.3.1722929841734; 
 Tue, 06 Aug 2024 00:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuBI3I4nT64HF+8c6i3Gs61YYXwJZG44rq1xHt5Zgw8m1+t9/f5lKiXBJ3Jb0Y8ACNSTaTl0WjqgjTmL6Qbcw=
X-Received: by 2002:a05:6a00:2406:b0:70d:14d1:1bad with SMTP id
 d2e1a72fcca58-7106d9d9330mr25056564b3a.3.1722929841348; Tue, 06 Aug 2024
 00:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2eF3B41E2nv1+-oMrCUTw7zfVrgCULRBaBe=Pk9roBUiQ@mail.gmail.com>
 <20240806023105.20509-1-liwang@redhat.com> <20240806061947.GB73369@pevik>
In-Reply-To: <20240806061947.GB73369@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 6 Aug 2024 15:37:09 +0800
Message-ID: <CAEemH2dR-sQGkwHG5eP9mzKp=oBoLjoFSOe_+7jwnYaJ8NgFzQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] pkey: remove the ltp_ prefix from pkey functions
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

SGkgUGV0cgoKT24gVHVlLCBBdWcgNiwgMjAyNCBhdCAyOjE54oCvUE0gUGV0ciBWb3JlbCA8cHZv
cmVsQHN1c2UuY3o+IHdyb3RlOgoKPiBIaSBMaSwKPgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4KPiBUaGFua3MhCj4KPiBPdGhlciB0aGluZyB3aGljaCBzaG91bGQg
Zm9sbG93IGlzIHRvIHVzZSAudGVzdF92YXJpYW50cy4KPgoKQXMgSSBwb2ludGVkIG91dCBpbiB0
aGUgbGFzdCBlbWFpbCwgbXNlYWwoKSBpcyB0b28gbmV3IHRvIGxpYmMsIHRoZXJlIGlzIG5vCndy
YXBwZXIgaW4gR2xpYmMgc28gZmFyLgpTaG91bGQgd2UgYWRkIC50ZXN0X3ZhcmlhbnRzIG5vdz8K
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
