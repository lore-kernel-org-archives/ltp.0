Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AA4C71136
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750082929; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=PmJcZsJ5eRZQt/6XhMrfzAmUgCRFsfA85X/QErdzP7k=;
 b=IDuSNDW5vnUfdE+CzNbQ27Vq8P7irzolx8eGAjsbIOyubnN1npyf6Z/qFiZZgs1duBNEJ
 lmdD3mbhupgY0Ye0PM6apXM68/Zq40ntUPzpglkkJo3aC2ryuj63jGA/cjxZYa9duN+Kbpq
 cQhlRRpVlXNTlKcN4MUjwNEcyx/PTi8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E12DD3CC0B3
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 16:08:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B1483CBF43
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:08:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40BFC600713
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:08:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750082906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEBvJuR1fNTqb3D05m2wFRwLbEj93wL0B51cOI2euU0=;
 b=Ym0o5vSJlwsEVJXJnSaUdjQJ9QsfSHezOR0yxCdKUUQvMbnbTLrk785TSO/bkesJHqZcZ1
 SWlK3VKy1v1wYids/LeSh7plIeptptMLYKf4d30bAixC4M7mZBPl1/7gi8rbzSzICZJ1ZA
 QAyqGZwlxQUC4UrFUCH+q7JnWRiawSs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-zbbKFhcwNOmM9qZHOtg1cg-1; Mon, 16 Jun 2025 10:08:24 -0400
X-MC-Unique: zbbKFhcwNOmM9qZHOtg1cg-1
X-Mimecast-MFC-AGG-ID: zbbKFhcwNOmM9qZHOtg1cg_1750082904
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31220ecc586so4522779a91.2
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 07:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082902; x=1750687702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fEBvJuR1fNTqb3D05m2wFRwLbEj93wL0B51cOI2euU0=;
 b=d2lv0/ANoVB/6Q3gDkDcqQeRzuzcz7WeRuBiLY8lhJOpAAb7hrb8f3sqq1gLx4J0t7
 YT3XYtK+319YmfdGPjGEGP6sx5qan5mzWtlP1dgAn31r6gSd2IMDT8YupPjUMD/+ZB+x
 x97oFgN6t3GBn5gN/NTnIXAth09RQKbUP8JJ+Kh9WfuWFhvfTIkRoDyMncusxrz2S0Ns
 GjXFm0UcJJbvgYCUApJClCIrTVBYe42MPmuoCESaaloOOvkWY/4XYY7aU8IbfG2s/FmB
 4oauR04hiAPPCC/j+TLoeOuw5XYkvl1eeyD9payuGqNqPpgEN3TrgeaYVxsW0k2yR6ZP
 kUCA==
X-Gm-Message-State: AOJu0YxgpXO3ZtYryyn74udYdsrzAeZbCMxPWB5AjCz/keNaVYAgAV5z
 nCbZQd60heitHY6q0/P+AP9tg+yIvD+mLJiaqrnCy/q0FcO/7sMP4gDVCzoKiz7PUi9E9PLb5Y3
 2k0fxvOwxzgeAe9WPSAgy+W33X5AlKbvfr6Ok0CGDyJuyrV6k4KABNI2rF2cgu/ocl9xLccqgWf
 JJQgpsFl2KnFK7BFyuBA8xGdxzReGomIyrafQeQw==
X-Gm-Gg: ASbGncuYTgRbes5wQ4+u50TlpLBZgznuN3v47MqSRwTNw0GgrcTt7aO1syZkr3cW6WQ
 pzuagML8Fi1uH9BeJ5vqbTWyFDGiee0y+bsh1EvF9E/uT/lQmI8jesVwMhW5u7Pouof2I3W2fDZ
 stP1Zk
X-Received: by 2002:a17:90b:3d0a:b0:312:1508:fb4d with SMTP id
 98e67ed59e1d1-313f1d0f29bmr18453302a91.33.1750082902039; 
 Mon, 16 Jun 2025 07:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoM/4IP4geCvblpALA6aOdgRTlZp0CNdxbhpIpZEg2UfKBp5HFOsGelmW2pGhASVtoptDnzvsLVHyTiP2TUjg=
X-Received: by 2002:a17:90b:3d0a:b0:312:1508:fb4d with SMTP id
 98e67ed59e1d1-313f1d0f29bmr18453268a91.33.1750082901668; Mon, 16 Jun 2025
 07:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250611-conversions-kill-v1-1-a5d7312df7fe@suse.com>
 <CAEemH2d1JwuFBVVTLTji172qZHss0AgK6n6-uEH1v+Xz_P7P-Q@mail.gmail.com>
 <DANWNAKXH7UY.11MJ8Q7L3MWG@suse.com>
In-Reply-To: <DANWNAKXH7UY.11MJ8Q7L3MWG@suse.com>
Date: Mon, 16 Jun 2025 22:08:09 +0800
X-Gm-Features: AX0GCFvED5zSC1P_7oUPHWkE9I0lncXAo_1FgBMJIMCE9og3A35C658Wvo-3JNU
Message-ID: <CAEemH2fM82gZitSh5wjcp34N6GoTd=EtSh-AVtxSm_+qAh1suA@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B6JwHRWf110gjTKJ9YgXmTddIjJsxZe3Bcg6bRbUKaA_1750082904
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls: kill: Remove kill07
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMTYsIDIwMjUgYXQgNzowMuKAr1BNIFJpY2FyZG8gQi4gTWFybGnDqHJlIDxy
Ym1Ac3VzZS5jb20+IHdyb3RlOgoKPiBPbiBXZWQgSnVuIDExLCAyMDI1IGF0IDEwOjUyIFBNIC0w
MywgTGkgV2FuZyB3cm90ZToKPiA+IFJpY2FyZG8gQi4gTWFybGnDqHJlIHZpYSBsdHAgPGx0cEBs
aXN0cy5saW51eC5pdD4gd3JvdGU6Cj4gPgo+ID4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUg
PHJibUBzdXNlLmNvbT4KPiA+Pgo+ID4+IFRoZSB0ZXN0IGNhc2UgZGVzY3JpcHRpb24gcmVhZHM6
Cj4gPj4KPiA+PiAiVGVzdCBjYXNlIHRvIGNoZWNrIHRoYXQgU0lHS0lMTCBjYW4gbm90IGJlIGNh
dWdodC4iCj4gPj4KPiA+PiBJdCBtYWtlcyB1c2Ugb2Ygc2lnYWN0aW9uKCkgdG8gc2V0IHVwIGEg
aGFuZGxlciBmb3IgU0lHS0lMTCwgYnV0Cj4gPj4gYWNjb3JkaW5nIHRvIGl0cyBtYW51YWwgcGFn
ZToKPiA+Pgo+ID4+ICJFSU5WQUwgQW4gaW52YWxpZCBzaWduYWwgd2FzIHNwZWNpZmllZC4gIFRo
aXMgd2lsbCBhbHNvIGJlIGdlbmVyYXRlZAo+IGlmIGFuCj4gPj4gYXR0ZW1wdCBpcyBtYWRlIHRv
IGNoYW5nZSB0aGUgYWN0aW9uIGZvciBTSUdLSUxMIG9yIFNJR1NUT1AsIHdoaWNoCj4gY2Fubm90
Cj4gPj4gYmUgY2F1Z2h0IG9yIGlnbm9yZWQuIgo+ID4+Cj4gPgo+ID4gT3IgY291bGQgd2UgcmVm
YWN0b3Iga2lsbDA3IHRvIHZhbGlkYXRlIHRoZSBFSU5WQUwgd2hlbiBjaGFuZ2luZyBhY3Rpb24K
PiBvbgo+ID4gU0lHS0lMTC9TSUdTVE9QPwo+Cj4gQnV0IHRoZW4gd2Ugd291bGQgYmUgdGVzdGlu
ZyBzaWdhY3Rpb24oKS4gQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGU/Cj4KCllvdSdyZSByaWdo
dCwgaWYgd2UgdGVzdCBzaWdhY3Rpb24oKSwgdGhlbiB0aGUgY29kZSBzaG91bGQgYmUgcHV0IGlu
dG8Ka2VybmVsL3N5c2NhbGxzL3NpZ2FjdGlvbi9zaWdhY3Rpb24wMy5jLgoKTWF5YmUgd2UgY2Fu
IHRyeToKCnN0YXRpYyB2b2lkIHJ1bih2b2lkKQp7CiAgICBzdHJ1Y3Qgc2lnYWN0aW9uIGFjdCA9
IHsKICAgICAgICAuc2FfaGFuZGxlciA9IFNJR19JR04sCiAgICB9OwoKICAgIGludCByZXQ7Cgog
ICAgcmV0ID0gc2lnYWN0aW9uKFNJR0tJTEwsICZhY3QsIE5VTEwpOwogICAgaWYgKHJldCA9PSAt
MSAmJiBlcnJubyA9PSBFSU5WQUwpIHsKICAgICAgICB0c3RfcmVzKFRQQVNTLCAic2lnYWN0aW9u
KFNJR0tJTEwpIGZhaWxlZCBhcyBleHBlY3RlZCB3aXRoIEVJTlZBTCIpOwogICAgfSBlbHNlIHsK
ICAgICAgICB0c3RfcmVzKFRGQUlMLCAuLi4pOwogICAgfQoKICAgIHJldCA9IHNpZ2FjdGlvbihT
SUdTVE9QLCAmYWN0LCBOVUxMKTsKICAgIElmIChyZXQgPT0gLTEgJiYgZXJybm8gPT0gRUlOVkFM
KSB7CiAgICAgICAgdHN0X3JlcyhUUEFTUywgInNpZ2FjdGlvbihTSUdTVE9QKSBmYWlsZWQgYXMg
ZXhwZWN0ZWQgd2l0aCBFSU5WQUwiKTsKICAgIH0gZWxzZSB7CiAgICAgICAgdHN0X3JlcyhURkFJ
TCwgLi4uKTsKICAgIH0KfQoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
