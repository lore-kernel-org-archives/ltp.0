Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38880C71153
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 01:08:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C10A83CEBF2
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 03:08:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 482B73CB899
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 03:08:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E22E82003BC
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 03:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693876109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i5hZp7BtU/w8VFxtWnAuXWJiumDX9SoG0i65MpnfPgI=;
 b=a2DMVIi/IOTAIZp1sIoztYZCRRZjFngT7A+XaB3hOXCbQcSV6E2pyrPN+Tqf5aTGXUqiW7
 BnDFa0VRkEVzEM6YJvmgKEDoir0/JEOTeJOXHh4PvhldWU50Rc4qm1yAt+0ItTKpC45nXm
 ZF1oW/N1XesOYZDa3QW6HhZsHLl+Gv8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-98gV833XMA-298O1rwqcfA-1; Mon, 04 Sep 2023 21:08:27 -0400
X-MC-Unique: 98gV833XMA-298O1rwqcfA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bcc5098038so20824781fa.2
 for <ltp@lists.linux.it>; Mon, 04 Sep 2023 18:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693876105; x=1694480905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i5hZp7BtU/w8VFxtWnAuXWJiumDX9SoG0i65MpnfPgI=;
 b=H6CHXj4Z6cpwd57jrilGSyYsAHwSjAxd/1s0Ff4aJrH5CRajpxXUbPK9Ull+c6bK6t
 S6D/iZH1zBSz2D5pZgjM3BNWdbLCZ768HQU37CAyDaKvnqNrxqfyFhqSVnywGj7juX9C
 viwUW8jdVFzCc1yVnKO3vssYtAht4IkgFbtt2nAT7WGg2GoxlZZoVdSBQBfcDihKF1zv
 +YN2j9uriaXtl+gxOww228Mrc/Eafbet4tiQjIpi8LYuSnx13UIMybOfIsiJoIPA6fpa
 D3teYUjyEPLJfGQwfj8YebrnzVhAEfm5987Gq5ZzI4/aC2mMmPQGuf31jYepXZrFXt3b
 wewg==
X-Gm-Message-State: AOJu0YxrbrmiNL+bDR/JB8Q4sNkmYKzujqdiUnYpM/TTd7tzC65HjvJ7
 NPT1e4Ea08GByA4IHSF9b8XZKKmgOV+Z+5c4MloAjHjAw2AEXJlKLn/YyW1EUQ+VGRrlLahqZka
 WTzDtCurDMDmezU7u9zoH2odpBsEXFrqLWQ58Qw==
X-Received: by 2002:a2e:800b:0:b0:2bd:2056:ceed with SMTP id
 j11-20020a2e800b000000b002bd2056ceedmr7334167ljg.25.1693876105208; 
 Mon, 04 Sep 2023 18:08:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHOhaT1OW5+SISDFNoNyKN+NQBMBN5YV5rEAR670o2maXuT/hMzEg/kl2nUnx5sHv9434V67/LPC4NHgAg6a8=
X-Received: by 2002:a2e:800b:0:b0:2bd:2056:ceed with SMTP id
 j11-20020a2e800b000000b002bd2056ceedmr7334160ljg.25.1693876104733; Mon, 04
 Sep 2023 18:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <927B643AA2DE0DEB+2023083114093400166120@chinasupercloud.com>
In-Reply-To: <927B643AA2DE0DEB+2023083114093400166120@chinasupercloud.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Sep 2023 09:08:13 +0800
Message-ID: <CAEemH2d=nhMThDZH3PsBNE9toXPjr5eQ+q52Sd_1iM48KB3AOw@mail.gmail.com>
To: =?UTF-8?B?5p2O5Y2g5q2m?= <lizw@chinasupercloud.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Seeking help with LTP testing issues.
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgWmhhbnd1LAoKSSBkaWRuJ3QgZmluZCBhbnkgYXR0YWNobWVudHMgaGVyZSwgY2FuIHlvdSBw
bGVhc2UgcmVjaGVjayBpZiB0aGUgZXJyb3IgbG9nCnVwbG9hZCB3YXMgc3VjY2Vzc2Z1bD8KQlRX
LCB3ZSB0eXBpY2FsbHkgcmVjb21tZW5kIHBvc3RpbmcgdGhlIGVycm9ycyBpbiBwbGFpbiB0ZXh0
LgoKCk9uIE1vbiwgU2VwIDQsIDIwMjMgYXQgMTA6NDbigK9QTSDmnY7ljaDmraYgPGxpendAY2hp
bmFzdXBlcmNsb3VkLmNvbT4gd3JvdGU6Cgo+IFdlIGFyZSBhIHNlcnZlciBtYW51ZmFjdHVyZXIg
dXNpbmcgTFRQIHRlc3RpbmcuIFRoZSBhdHRhY2htZW50IGlzIGFuIGVycm9yCj4gbG9nLiBQbGVh
c2UgaGVscCB1cy4KPgo+Cj4gS2VuIC5MaSDmnY7ljaDmraYKPgo+Cj4gLS0KPiBNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgoKCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
