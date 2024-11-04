Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C5FD132A2
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 09:39:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1E123D04E6
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 10:39:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FBB93D0442
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 10:38:51 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D9B6C21EF04
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 10:38:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730713128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipvrW/7CVPYmq1G16BNQ/idq2OvZsx8rmNNzjhPauUk=;
 b=UOIWp9vfDYOTWCyhzkxMZzA44rjxcitZLb0bgcQlWysaCAZZhKbVDJZbSvT59LXaV+0Llu
 hSoCdll5ilUto+UcFxAk88syEseTVMucEbkP0txSbJ6r98fvNQRY1LThcmZbgY2cLhElU+
 vSi8RApnF3gZ+7XG0nDjmHc47R0xLs0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-ZYrJ_-c4MNCVfbsOBtLJWw-1; Mon, 04 Nov 2024 04:38:46 -0500
X-MC-Unique: ZYrJ_-c4MNCVfbsOBtLJWw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-71e467c39a4so5374806b3a.3
 for <ltp@lists.linux.it>; Mon, 04 Nov 2024 01:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730713124; x=1731317924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ipvrW/7CVPYmq1G16BNQ/idq2OvZsx8rmNNzjhPauUk=;
 b=po82+IV3AeXeYeBTzrvcZQ0iMhtOOw7Amh2Ug0Z6SJPPkK2HpWJhz4H8k26P4ycHMw
 38EjlWHh6fot3Tv4JXV1O07u1c7aznB4hIimFFUVWcuKDI21GQArYYlv9liAuBCOaXmN
 KjGCCUSnDWqMiwCP/r8hBVM1Howin3yQjEwKlZ4tGMBWWW0a410PWZ5bszyefPA+uOi6
 UDn6pKnXC6J6bxXFVX0DqJSllP3x7BBU8xe807xhcePsqGTSmZtBb3ZaDJJuibvHxizD
 BxVLRyI3yd7C26iwhNlAg7QXdrXN19RyZLVCNm5J5eyzsq9wtda+2pJH9+7hZRj+fIZy
 Gcng==
X-Gm-Message-State: AOJu0Yxgg4KbBWz/JGi5mPA1mG23K72UZb3IwbqWvzbm/9iEgPmq98uZ
 Lvixxn7CebNX5Ct1sGtlkZekn9/vrQECCPO/Ry22jjGKTe54derU6WSx69UM0mEjnIl2p14G41G
 J8SKbkqr2sdK/848cXxUiIm/cFZXmzPUiwvAqrpuE/jlniB4/0xcT45X5djyGHDPILcVtTvmuJY
 C87HYUgTV0tU9ARh2UCRYEI6vuR2wtODRHUgeP
X-Received: by 2002:a05:6a21:38f:b0:1d9:282f:3d17 with SMTP id
 adf61e73a8af0-1db91e53617mr23763102637.35.1730713124306; 
 Mon, 04 Nov 2024 01:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS0Nw+AecJH11baFlTjH0EeCF5IkDVzn8vy2xYA8A06CXfQkqUQAW3cLgFPiP2tl7SqbELaOxAvnf7eqgqBqA=
X-Received: by 2002:a05:6a21:38f:b0:1d9:282f:3d17 with SMTP id
 adf61e73a8af0-1db91e53617mr23763087637.35.1730713123976; Mon, 04 Nov 2024
 01:38:43 -0800 (PST)
MIME-Version: 1.0
References: <10cd93cb-4514-4d79-9ab6-e33e2a08435c@suse.com>
In-Reply-To: <10cd93cb-4514-4d79-9ab6-e33e2a08435c@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Nov 2024 17:38:31 +0800
Message-ID: <CAEemH2eQSwr7KaUsO_bdieernxhz7joG7dcD-yrneeKQ8GKjxQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Open LTP meeting in November
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

T24gTW9uLCBOb3YgNCwgMjAyNCBhdCA0OjU34oCvUE0gQW5kcmVhIENlcnZlc2F0byB2aWEgbHRw
IDxsdHBAbGlzdHMubGludXguaXQ+Cndyb3RlOgoKPiBIaSwKPgo+IEkgd2FzIHRoaW5raW5nIHdl
IGNvdWxkIGhhdmUgYSBMVFAgbWVldGluZyB0aGUgMTF0aCBvciAxM3RoIG9mIE5vdmVtYmVyLgo+
IFdoYXQgZG8geW91IHRoaW5rPwo+CgpOb3YgMTN0aCBzb3VuZHMgZ29vZCB0byBtZS4KCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
