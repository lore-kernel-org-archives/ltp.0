Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22206C47DAF
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 07:39:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 908F23CE22A
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 08:39:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97D553C98F9
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:39:22 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A00BA64285F
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:39:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705909160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5vY5oeuTQKvmiD1JPE9TkFaJl4kwDHbNPAdkhR0Fts=;
 b=feUrkp+SizrqNz8yAPJaTbZcldrwA0Wuf2JnCOUnGgknHyts5pgQrrh/GptSA7nScQT1rX
 tN52Do6cECYMA2He1QLRgf+jA1CtSvmTsPXBMV53h+L1YN2XvN2rOfFsWB1OTM2mXg3ooQ
 WvIq387Xc9Aqe5g/2qTpHhRZQEGB7Oc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-gA78w7t3MG-MZKu-HWo98g-1; Mon, 22 Jan 2024 02:39:17 -0500
X-MC-Unique: gA78w7t3MG-MZKu-HWo98g-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6dbd35c052eso1968206b3a.0
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 23:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705909156; x=1706513956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y5vY5oeuTQKvmiD1JPE9TkFaJl4kwDHbNPAdkhR0Fts=;
 b=P24sV0QznqfakEPU0j47EzLL7DYYaXYt4FZCFUwsnEVNJA4cJYmU+pgsTyGIgABPIg
 y7SSk2R78A6qIPtbpjIBpyNhu6uGLNDPbouMyzt3rSPy8vBbQQ0UWLGlH/e08WhM8SXz
 vk2PcfvqmLHpSSSBt8LbEd7rYLvXarnY7k/Bb0cuyfhzUQK0sPvtlVsJpNvfnCnJUbTn
 pjpYl5cmlv22cYXt4nvItBCatAcPlZNoLOBK+AAwei457No2gXHngKydv1FMIroARCLU
 sdnNd8QyA8EmyD+NlWWRTo8hRJH3AA9iD7VWE40InmKK8ZR3jl0fjNH6wpsWA0u2tCe+
 squA==
X-Gm-Message-State: AOJu0Yyp1RDH3ibnZ6I1tP25Poz/iSZjBISyA9Bxmmkpn/vE+ODHxazH
 niuKjeOb/JxIsFfhsAY6g4SyggPW8DrYCxM3cALxsvTjbPM8Rz9z6MANIUrod1HuVgJ5AVxb4yn
 ooD83hWzAOZkqyGtj0rezHAGEBw0YHsZDUgJcdUl7GqJCI/6PKn8ojiSDcC3D4T7FhdoOJKQ0QB
 K5Pz+IxhIDisetzezXoT4hRR+jQ2t2OYVeiI9U
X-Received: by 2002:a05:6a20:158c:b0:19a:3da0:103f with SMTP id
 h12-20020a056a20158c00b0019a3da0103fmr5208501pzj.7.1705909156132; 
 Sun, 21 Jan 2024 23:39:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFwOs9U1jshK8iDJLkywZnJawTbOyTzOnoL3XU0ASqzHLdJ+M/ZSRs7xyBWUilZ/KY14CY5yGaz0jR9EyyU4k=
X-Received: by 2002:a05:6a20:158c:b0:19a:3da0:103f with SMTP id
 h12-20020a056a20158c00b0019a3da0103fmr5208496pzj.7.1705909155847; Sun, 21 Jan
 2024 23:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20240119144322.41928-1-pvorel@suse.cz> <ZaqP2_ZeyRM1YY0w@yuki>
 <20240122062239.GA58756@pevik>
In-Reply-To: <20240122062239.GA58756@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jan 2024 15:39:03 +0800
Message-ID: <CAEemH2f2qAnG4ebk=D5Ys5XZdJZT0iY=bwQWZ-WVp4MHevgMOw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] swapon01: Test on all filesystems
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

SGkgUGV0cgoKT24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgMjoyMuKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCgo+Cj4gPiBTbyB0aGUgcmVzdCBvZiB0aGUgZmlsZXN5c3Rl
bXMgd29yayBmaW5lPyBJZiBzbyB0aGlzIGNoYW5nZSBsb29rcyBmaW5lCj4gPiB0byBtZS4KPgo+
IFllcy4KPgo+IEdvaW5nIHRvIHNlbmQgdjIuCj4KCk5vIG5lZWQsIEkgZGFyZWQgdG8gbW9kaWZ5
IGFuZCBjb21iaW5lIGl0IGluIHRoZSAyLzQuCiAgaHR0cHM6Ly9saXN0cy5saW51eC5pdC9waXBl
cm1haWwvbHRwLzIwMjQtSmFudWFyeS8wMzY4MDYuaHRtbAoKU29ycnkgZm9yIG15IGFyYml0cmFy
eSB3b3JrLCBJIGp1c3QgdG8gdGVzdCB0aGUgcGF0Y2hzZXQgb24gbXkgc2lkZSBlYXNpbHkuCgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
