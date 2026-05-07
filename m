Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9E0CD3446
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 06:19:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1043D3E2498
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:19:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3F0E3E1F32
 for <ltp@lists.linux.it>; Thu,  7 May 2026 08:18:54 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5BAD2600396
 for <ltp@lists.linux.it>; Thu,  7 May 2026 08:18:54 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso381617eec.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778134733; x=1778739533; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+b2eisQ9kqEvZ0D2EY4CRtcNlgLJ8AvYy5i4ZRaZFA=;
 b=tGsMj92UpIn/SRwgR42imuI2wEPdguHLzbWG6NWSC3sW/rGc8ND1d634f90R9KurKv
 1oRJD6iwDMaq97W6LtrlRQtWtJA9y8LJbAYIYhqdhPasUhVIVG70KcWq7iWiAV2++0Gb
 7GOOvLq8UKMGADSg4rAR4R6Q98iVspBjImJGX7axqEFzYZqYDaIU5EFnAY34kgi9IMUK
 JyfKWzcBxhjopcHOc3NYkLGLHN3oQV6lHu0ncJm0cx2f5D5OI+C690z6adsvRzrc5sqY
 tCBldbFUaVrbzKGKmBb+ZEgOGUcgkvaCZ/39G126yRrx+4thqGbEzgusWQ7SdBaBj9iG
 0DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778134733; x=1778739533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+b2eisQ9kqEvZ0D2EY4CRtcNlgLJ8AvYy5i4ZRaZFA=;
 b=N+qrLLmrVS0f4II7u+cKGOmSBD7hxu13ouXoNzajLKPmtkXZ7LMjsfSHyi71Fpp8Bt
 HqkZ9FB2T5TX1lvqfvj5cONKgRyp4UA/EKt58WZqh7ADnmuzaGdiM1lV9gx6NByvaxBX
 hnN9kz82I3/+N+GjHd7L7rg7ARM1dZsTtaSYAjDkbTs44JhIeYiTRrcBp7oeYYf0s8WP
 aFIifh0EjzGA9zryjdGIqycW4mhrRoS7W9xNZ2jN8aEbhVHKNUBIQZPM4c4QMQlOdq7S
 OJs8kG1qJkonDWakCDISAktMfh8jPRyFRIpVBCxfguEIZWN6NenFt1VsAJchOi93jvRu
 Ov/w==
X-Gm-Message-State: AOJu0YyTLpBTrEbkVKdIjdWz5pSiz96Tl/s9NK2dRhqjGvrDI8vgSkl/
 Ela7oILkPWgUe8vFKP+dRw/h6JhLPHU65ZRk8dMB8B16Nsha2GOPk0kSXmumpgxt7eo=
X-Gm-Gg: AeBDiesByY7y+35iqW8JstRx6q2ZjehMty6RvOEA1dNfwtkRvPwiq3iaI1QVbkXb+GH
 3apN3hSP3DrmL0xyfzLy0QCPsRyTWpPEREBJI322kJHsiiNj7joZN8gkR4DUT/8v2QCU1+orvWF
 ibPlOo1uHm1ZX2VpyuFD3M5Qfe+y4G8MxbCBVK4bwyZufgmmFm2HgUj3cwiG2xdRh4LpwuT0XRr
 cLsZ3vCpLja1tiw+UtYq66sIZdtUzyzKWhmFEt+SQbp5QwQcPIl1HSGARbK2P+mGOhRReobaYtx
 AhtPu6MMMiImIh8Id2ZhdRSqCNRAX80TyAKKXVw/dZY9TcBC19Yhyt6xWAloEB2ObXtz310vVJ9
 G0wp6tQmaGocy9FdLTbjrKa4wmZ29ZAnK3BQAK+YlfgfOIRNEBy30WR+DC7WvJerVkEZ6a5is6Q
 MBdwovnzwk3WK6fmt6De+sKPIHc+deZsR/oQfABTj5DaZOXJz2c8Vgc77QU6hAAwCumTWqPLxNE
 YeSHiBY/deQPXPAVTPwbk338n4iMkii7KLVNDkMWzkuCKAanvEmXzc=
X-Received: by 2002:a05:7300:a599:b0:2ee:7b2e:8a3e with SMTP id
 5a478bee46e88-2f6e1e32133mr648929eec.1.1778134732607; 
 Wed, 06 May 2026 23:18:52 -0700 (PDT)
Received: from
 runnervmeorf1.fsbdu2ptzlfurncko4thihjhgf.phxx.internal.cloudapp.net
 ([172.182.213.152]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56f7967cfsm7043862eec.19.2026.05.06.23.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 23:18:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu,  7 May 2026 06:18:51 +0000
Message-ID: <20260507061851.4073-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507025345.6722-1-wegao@suse.com>
References: <20260507025345.6722-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify22.c: handle multiple asynchronous error events
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgV2VpLAoKT24gVGh1LCAwNyBNYXkgMjAyNiAwMjo1MzozMyArMDAwMCwgV2VpIEdhbyB3cm90
ZToKPiBmYW5vdGlmeTIyLmM6IGhhbmRsZSBtdWx0aXBsZSBhc3luY2hyb25vdXMgZXJyb3IgZXZl
bnRzCgpSZXZpZXdlZC1ieTogTFRQIEFJIFJldmlld2VyIDxsdHAtYWlAbm9yZXBseS5naXRodWIu
Y29tPgoKUHJlLWV4aXN0aW5nIGlzc3VlcyBub3RpY2VkIGluIHRoZSBzdXJyb3VuZGluZyBjb2Rl
IChub3QgaW50cm9kdWNlZApieSB0aGlzIHBhdGNoKToKCi0gZmFub3RpZnkyMi5jOmRvX3Rlc3Qg
4oCUIHBvbGwoKSByZXR1cm5pbmcgLTEgKGUuZy4gRUlOVFIpIGlzIHRyZWF0ZWQKICBpZGVudGlj
YWxseSB0byBhIHRpbWVvdXQsIHByb2R1Y2luZyBhIG1pc2xlYWRpbmcgIlRpbWVvdXQgd2FpdGlu
ZyBmb3IKICBldmVudHMiIFRGQUlMIG1lc3NhZ2UuCgotLS0KTm90ZToKCk91ciBhZ2VudCBjb21w
bGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guCgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBw
cm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdl
bnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50
IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBS
ZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
