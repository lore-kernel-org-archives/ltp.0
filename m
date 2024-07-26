Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D507C3DA63
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 07:53:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C941E3D1A55
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 09:53:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7202E3CF2B3
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 09:52:59 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 84EE51000D5E
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 09:52:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721980376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxf2qC0+KFT4kE/qaX40SXyUSaX7+XMvojzTuWy+1XY=;
 b=MvCM2s1pIDFRr68eaMuVEF/9tk5Wv9O/8jMLsLjkHLtW4NCLegON9f6uap+US6/lCj/GSR
 Apo6ikvXd+LWD+OM8rnQvVEG9D1zMzqvaVGA67yAJopefTp62H+QYaG09oqYpR4FwNHA8x
 iUXYgeDnmCiloqGPYl13IDAajmDheIs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-6zwtDqWkMaq9zR32ARM0Nw-1; Fri, 26 Jul 2024 03:52:54 -0400
X-MC-Unique: 6zwtDqWkMaq9zR32ARM0Nw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb576921b6so797692a91.1
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 00:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721980372; x=1722585172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zxf2qC0+KFT4kE/qaX40SXyUSaX7+XMvojzTuWy+1XY=;
 b=B2lskoM2tlUd3TmT2gBeQ6PefE+tkYEK8wbo+mD/nhDdWcSM1EIL/SwqqH0D5bg0/p
 TBcOmms59r1gyRfwNU3YCzhG10Nyvki9LRVpr5yVpWwSFJHVvcEW3uFhNYJd20UwNvsd
 QXA3cmKgthnoYIzqOM8ptRZBam3xWz84f9KCbjHumg/GHS9C1XiZc0NT8e8EVye7ICTn
 Clt6pCeA46Qlt4wEcLWNNS0AT03hiID2MP1+f3T3nqEqnytNEAXp8ADUgviq8j68yHcO
 wCii46+gaL8CmNYkrDEoQenjo0TxJ5SOj2g6ju5jG4P+xgdhUIOOHHAkp1dsYLAWPfz+
 frNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKzR5UgkxNLHzpErNqD8RSl7vW53kSnGfZvvfKlQhg+2ploWYHqFuW1E129mFyLnX1ezOCIRcash5iVbmUkiYEzOA=
X-Gm-Message-State: AOJu0YxD0GWww65Uad/a9vZr0L1+o1hGEgVlLCXoDBXYlqfJGg4qGrss
 PMVIfvnnya5OZy7sYSn42xKkLJmhkH1tMUWWQU1R7g2z+hLHRBZRuqhLZvozELbv5J8NTdLWtnR
 tjB0jDOzlyBJnlqvEDEWHs/3rbIiYSQcZM+hijj9YXJBYvZ8HvriLSyF2OXLHsef0g6YRkNTHXS
 SrApjrbgIpLDF/t1VKQWqlDpInymmDhUklyQ==
X-Received: by 2002:a17:90b:4b4e:b0:2c9:96fc:ac54 with SMTP id
 98e67ed59e1d1-2cf23771ddemr5845168a91.2.1721980372066; 
 Fri, 26 Jul 2024 00:52:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF01AoF5OhC8PcamiMX6BJY5Yi3lYijutiyYD6+uK7HiRTxym5jqM68/BWbZVVxGqgVZyzXDYKsHelY2RLUVRg=
X-Received: by 2002:a17:90b:4b4e:b0:2c9:96fc:ac54 with SMTP id
 98e67ed59e1d1-2cf23771ddemr5845153a91.2.1721980371784; Fri, 26 Jul 2024
 00:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240726024447.134802-1-liwang@redhat.com>
 <b8c4a02f-d108-42d0-8da1-aa4000f789bd@suse.com>
 <20240726065205.GA1017966@pevik>
In-Reply-To: <20240726065205.GA1017966@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Jul 2024 15:52:40 +0800
Message-ID: <CAEemH2cD7JLu1DjQBNhqxMBA3GXk3eOv9=eJG-nDi4Fu53UW8w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] cachestat: remove .min_kver from cachestat tests
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
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdWwgMjYsIDIwMjQgYXQgMjo1MuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEFuZHJlYSwKPgo+ID4gSGkhCj4KPiA+IE9uIDcvMjYvMjQg
MDQ6NDQsIExpIFdhbmcgd3JvdGU6Cj4gPiA+IFJlbW92aW5nIHRoZSBrZXJuZWwgdmVyc2lvbiBj
aGVjayAoLm1pbl9rdmVyKSBmcm9tIHRoZSBjYWNoZXN0YXQKPiA+ID4gdGVzdHMgdG8gYWxsb3cg
dGhlIHRlc3QgdG8gcnVuIG9uIGRpc3RyaWJ1dGlvbnMgdGhhdCBiYWNrcG9ydCB0aGUKPiA+ID4g
Y2FjaGVzdGF0IHN5c2NhbGwuCj4KPiA+ID4gV2l0aCBubyBzdXBwb3J0IGp1c3Qgc2tpcCBhcyBU
Q09ORjoKPiA+ID4gICAgLi4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL21tYW4uaDo0MDogVENPTkY6
IHN5c2NhbGwoNDUxKQo+IF9fTlJfY2FjaGVzdGF0IG5vdCBzdXBwb3J0ZWQgb24geW91ciBhcmNo
Cj4KPiArMS4gSnVzdCBmb3Igc3VyZSwgdGVzdGVkIG9uIDYuNCBiYXNlZCBTTEVTIDE1LVNQNiBh
bmQgaXQgd29ya3MgYXMKPiBleHBlY3RlZCAoVENPTkYpCj4KPiBSZXZpZXdlZC1ieTogUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KClB1c2hlZCwgdGhhbmtzIQoKCj4gTWF5YmUgd2Ugc2hv
dWxkIGRvY3VtZW50LCB0aGF0IGlkZWFsbHkgd2Ugc2hvdWxkIHRyeSB0byBhdm9pZCAubWluX2t2
ZXIKPiB1bmxlc3MKPiByZWFsbHkgbmVlZGVkLiBJdCdzIGFsc28ga2luZCBvZiBhIGRvY3VtZW50
YXRpb24sIGJ1dCBrZXJuZWwgdmVyc2lvbiBjYW4gYmUKPiBzcGVjaWZpZWQgaW4gbWV0YWRhdGEg
ZG9jdW1lbnRhdGlvbi4KPgoKWWVhaCwgZXNwZWNpYWxseSBuZXcgZmVhdHVyZSB0ZXN0cyBzaG91
bGQgYmUgYXZvaWRlZCAubWluX2t2ZXIsCihjYW4gY29tcGxldGVseSByZXBsYWNlIGJ5IHN1cHBv
cnRfc3lzY2FsbG5hbWUoKSBmdW5jdGlvbiBpbiBzZXR1cCkKYXMgbWFueSBvZmZpY2lhbCBkaXN0
cm9zIGFsd2F5cyBiYWNrcG9ydCBuZXcgdGhpbmdzIHRvIGN1c3RvbWVycy4KCkJ1dCBmb3Igb3Ro
ZXIgcHVycG9zZXMsIHdlIHN0aWxsIG5lZWQgdGhhdC4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
