Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99794CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 12:58:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C2853E6164
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:58:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14EDB3E6158
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:58:40 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F16D600A86
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:58:40 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8b45dff1eebso58227556d6.2
 for <ltp@lists.linux.it>; Wed, 06 May 2026 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778072319; x=1778677119; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HiREfp9dMoyjxeKQ1chQUMqVKaD6oCGqyGBVdvMhoj8=;
 b=DgVbI6cfpV1dQa7rNk+Ra+wbPhEwf9R+7LihHvvmet41tGAovVTexxg6Ct6W7QEXF8
 WnB/661X7iSKfLsm0obWLQZ8TIaMxjcFJUDl/+dgccUS3v8c0ka+ef6dvnshSnGisyKN
 SsE7TBfoUuDbOocy5Qv2SSzkrs8o286BruXwmayWGwAUZJgvw3z+Q/6Q4OKJMdSRYp+M
 PX+ThE2YYJSzRH+nnXkoxIkODZPg+flwlGe8JiZ5UwPbeoytTToZWC/g2xcp1V2EgkXl
 txAuFhwG5rdAWSqZOLJiXIz2YauTlD4GxG4eJW44rD/SJKRJEDTXvNXCYE3RAAO6E/di
 QKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778072319; x=1778677119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HiREfp9dMoyjxeKQ1chQUMqVKaD6oCGqyGBVdvMhoj8=;
 b=n15KToyg/8q+nf9N20Up0ZA/jHC8DGoXbjKPDfw6Vy+bahdsi2oa8gW9hSn+y5HenS
 BTA3CVyOp340MkYVvlVvQjSNHXr3/b4LiADkcBDC1Xt0TjkGXtfsZpGi6dNV6ryJMTSC
 sB4ss45NqN3SeuoU81tBfMhFixqchrS0elhPBoEUZr1VFSLkyNOof7rdIWF1kRy50cBp
 uYTAw/0ATW/+oV1Vl6VNPT5H2qym7c88M9eAtEitBMNnw6aDzFGapOuhFE4uAaxhFFlv
 IIt6PxWVOPJ8CwoPLa4TmzVNujSBSgwNdf08Fh7xbamn1R65/1aV5/oYBxPhHmIHbcn1
 JWFw==
X-Gm-Message-State: AOJu0YwACL17/k5GFkdTLDxbrctXfdcRJoJk2IgTDn4cJts7dImEPrjz
 yft04SOyUiE7KHUlcUtpes4lNem4KOG6kjJ0KsW+sSt2nMmPtiBd4XRO
X-Gm-Gg: AeBDietYOB5zipmUux8CdMgvKWsfi5ilNjFdItQaHyRs1qG56AvlMtSmC4IFAILvLoa
 MxvKQEZY5HQEwZ/+Om42pQBgX7sFyXUwF1ee4g0D2jj0482gEfEpY1oQk5MiZc1Xy2EeQNBqW54
 VmZo+kwQfPSVPl00LINSy+PmwhqnaSKSYM1VBqCxOGj55fWTsKgSaqKGulHaoE1xQ8t1q3zreta
 N8MjsTL1YV6cpJ/EAFWQWI701CVQ2yuJay4sqKViBC1/JJ2wwLEKy3XHyVs4+gjAUn0Z8POCoGv
 7LSDdxPMbbiiJ1KftBhlHBwmclTW6jGSMfhrBw8TTDeS/OCf5daD4UUBPpPWwQpCQQnWHzVZ7hx
 jCLskoHZ1LjtGv5PTG4TwIYnYynFMQEPkz2D2MtyPhS+wCw3U2N4D+P77XRJ0/iX837cVTYNYN4
 CtN6gVRJf4rub5+2b9xobXfB4gbJaYBBjx/m5ggpWHj5OnQDPd165zLzWW6ql3S9kVo5a71Ycyd
 mt+bpblWu9MH6vdYoJD+gskalvVecqGSMz0yC6CuiQfpnw7kag=
X-Received: by 2002:ad4:5aa2:0:b0:8ae:6587:3d60 with SMTP id
 6a1803df08f44-8bc44ba36d0mr45468386d6.33.1778072319208; 
 Wed, 06 May 2026 05:58:39 -0700 (PDT)
Received: from
 runnervmeorf1.snhy0gfitnfuvopcsurrxjmkjb.ex.internal.cloudapp.net
 ([64.236.187.241]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b5391e344fsm199062906d6.12.2026.05.06.05.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 05:58:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed,  6 May 2026 12:58:37 +0000
Message-ID: <20260506125837.4020-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260325-ioctl_getlbmd01-v1-1-00dc526e326f@suse.com>
References: <20260325-ioctl_getlbmd01-v1-1-00dc526e326f@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Add logical_block_metadata_cap struct fallback
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

SGkgQW5kcmVhLAoKLS0tIFtQQVRDSCAxLzJdIC0tLQoKT24gV2VkLCAyNSBNYXIgMjAyNiAxNTox
OToxMCArMDEwMCwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBBZGQgbG9naWNhbF9ibG9ja19t
ZXRhZGF0YV9jYXAgc3RydWN0IGZhbGxiYWNrCj4KPiBBZGQgVUFQSSBmYWxsYmFjayBkZWZpbml0
aW9ucyBmb3Igc3RydWN0IGxvZ2ljYWxfYmxvY2tfbWV0YWRhdGFfY2FwLAo+IEZTX0lPQ19HRVRM
Qk1EX0NBUCBpb2N0bCBhbmQgcmVsYXRlZCBMQk1EXyogY29uc3RhbnRzIGluIGxhcGkvZnMuaAoK
VGhlIGNvbW1pdCBtZXNzYWdlIGNsYWltcyBMQk1EXyogY29uc3RhbnRzIGFyZSBhZGRlZCwgYnV0
IG5vbmUgYXBwZWFyIGluCnRoZSBkaWZmLiBUaGUga2VybmVsJ3MgdWFwaS9saW51eC9mcy5oIGRl
ZmluZXMgTEJNRF9QSV9DQVBfSU5URUdSSVRZLApMQk1EX1BJX0NBUF9SRUZUQUcsIExCTURfUElf
Q1NVTV97Tk9ORSxJUCxDUkMxNl9UMTBESUYsQ1JDNjRfTlZNRX0sIGFuZApMQk1EX1NJWkVfVkVS
MCDigJQgZWl0aGVyIGFkZCB0aGVtIHRvIGxhcGkvZnMuaCBvciBkcm9wIHRoZSBjbGFpbSBmcm9t
IHRoZQpjb21taXQgbWVzc2FnZS4KCi0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUg
cmV2aWV3IG9mIHRoZSBwYXRjaC4gVGhlIGZ1bGwgcmV2aWV3IGNhbiBiZQpmb3VuZCBhdDogPG5v
dCBhdmFpbGFibGU+CgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0
aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5k
IGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdu
b3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
