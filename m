Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321B2C47DDB
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 08:05:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4E483CF8D1
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 09:05:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2823D3C9968
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 09:05:22 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 009F0100018C
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 09:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706774720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYkFCeR2Yr7yOeI8oxcfyeLkpf6qtRsHz+4pHZCr4OY=;
 b=Iy28hxuIsiVDnC7JneI96uBurJupX8QA3HYRKWSnJQGlD3TMYefKMdy7Qk6N77Bi+rAWX7
 kyvD5viDLPIvC2As4qYEo7aH3hcK9bDD63cbcDvWgKEihjpFtCiJKX8JbzBsWKZd0e90Ns
 LwHTWYUYURR0skJcuaz0mEVROgbhAb0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-DC_UWNMFPsS1XUI6uxId8Q-1; Thu, 01 Feb 2024 03:05:18 -0500
X-MC-Unique: DC_UWNMFPsS1XUI6uxId8Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-290f607c1dfso560053a91.3
 for <ltp@lists.linux.it>; Thu, 01 Feb 2024 00:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706774717; x=1707379517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YYkFCeR2Yr7yOeI8oxcfyeLkpf6qtRsHz+4pHZCr4OY=;
 b=nTNTF/WZipEJf2Zov5Ul9uTf8boJ8o+OIDu0T85i8e84HIR0QKp7n429ziFRUbpdgS
 EQykyEQWcmIsCgiyAjYxBYdnT2FrlPeOPnIqKBQyA+6y5vW0yW6HOx0A3RlazwfpG2Wg
 /kk4GlLArV+L8mgLHL/W3qN/bXPPRm36Ccyx3KG6Uen9bzvEL/qm478rcrxXkSrCDJD/
 7/wwKT5Nc/8Gcdm+F2F/6+SBhEw8ETi9l+xEQgVS60EdT3REVE2dgi9xDjwub/ft1Ny4
 1fwxoBwvxE8kRTRslD5nXT8seir5IRjvjo2zLfzPnyJ8kjBbRHrrWmxuUjyHPCacN6kE
 GKjg==
X-Gm-Message-State: AOJu0Yz4UXpYKehHgM+AVz0ZcJCeCoCe3ONggSS5m0Kn07nGBjw5xjdV
 ZGRJgpPTpq5qdmYRw7k5iyoPVL7Tov+GARyxAvCNQkvp/Npj9dIgqdxdZ3RaVpkdtRm9quguWV7
 Til97Eip+mcv++6RI3qtXInoMMPkD/y6yDpnmyJIxydyRq+YHHs65Gl2j1dYyDuJcW0s/1uSJDy
 4tQ5b2M6N0pp9d7m/BENWhv0TFudKZ568=
X-Received: by 2002:a17:90a:cf16:b0:295:cfad:38cd with SMTP id
 h22-20020a17090acf1600b00295cfad38cdmr3877427pju.35.1706774717026; 
 Thu, 01 Feb 2024 00:05:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUec8jfx/SS1Z9AhhxlS/ztO6hJLdkpNMoygEQ2FaCAR/13CIJPMLrarutiB0fm0/ZXG2cIzXnymIISn0+ENk=
X-Received: by 2002:a17:90a:cf16:b0:295:cfad:38cd with SMTP id
 h22-20020a17090acf1600b00295cfad38cdmr3877410pju.35.1706774716759; Thu, 01
 Feb 2024 00:05:16 -0800 (PST)
MIME-Version: 1.0
References: <20240131102514.2739270-1-liwang@redhat.com>
 <20240131102514.2739270-8-liwang@redhat.com>
 <20240131173840.GA18869@pevik> <20240131185310.GA30901@pevik>
 <20240131190122.GB30901@pevik>
 <CAEemH2fVdZdTnRUZSWCrZrqKYyuVWvu8nNQ4A=d3h7389KO3+g@mail.gmail.com>
 <20240201074633.GA58275@pevik>
In-Reply-To: <20240201074633.GA58275@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 1 Feb 2024 16:05:03 +0800
Message-ID: <CAEemH2edphvbo4mRv+0Ukn9dMuzMaqvWYPrq56xGqc4UV3W18Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [Patch v6 7/8] swapon/off: enable all_filesystem in swap
 test
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

T24gVGh1LCBGZWIgMSwgMjAyNCBhdCAzOjQ24oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKCj4gPiBFcnIsIEkgcmVwcm9kdWNlIGl0IHdpdGggYW4gUkhFTDkgcHBjNjRs
ZSB0b28uCj4gPiBJIGd1ZXNzIGl0IGRvZXMgbm90IGFsbG93IHRvIGNyZWF0ZSBhIGZpbGUgdGhh
dCBzaXplIGxlc3MgdGhhbiBwYWdlX3NpemUuCj4KPiA+IE9uY2UgSSByZXBsYWNlIHRoZSBibGtf
c2l6ZSB3aXRoIHBhZ2Vfc2l6ZSwgYWxsIHRlc3RzIGdldCBwYXNzZWQuCj4KPiArMSwgZ3JlYXQu
IEZlZWwgZnJlZSB0byBtZXJnZSB0aGUgcmVzdCB3aXRoIG15IGFjay4KPgoKVGhhbmtzLCBwdXNo
ZWQgd2l0aCB5b3VyIHN1Z2dlc3Rpb24gKGFuZCB0aW55IGZpeGVzKS4KCgotLSAKUmVnYXJkcywK
TGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
