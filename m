Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F98DC3ABA2
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 11:16:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0DDE3C2BBA
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 13:16:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D73C3C1BE2
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 13:16:18 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5ED02201101
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 13:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726485375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7iGSO3wL1KJJ9bW5iQ2hK+1H8B8UwYENNWiFFoIZZM=;
 b=TnJzKaQKP+04RAY5OLAQPVGpoLxlFk05gvAg75d1bnvF9wfcDMwuQm/htkzSTzOPBZ16dg
 TWhciPmunuv5L0z3Yeom1r8Z/ZE6OhioZZIT/8D2vaWsNcQNJ7niR2fyFxZwSmCNXXbgBt
 Oa3SZkSi9p9NeG7PIwXwdcL4Zw/gYmo=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-xu7KhadIMuS7LJRQ3LMs0w-1; Mon, 16 Sep 2024 07:16:14 -0400
X-MC-Unique: xu7KhadIMuS7LJRQ3LMs0w-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5e1bb4ce5acso538877eaf.3
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 04:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726485373; x=1727090173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7iGSO3wL1KJJ9bW5iQ2hK+1H8B8UwYENNWiFFoIZZM=;
 b=iYmB9X+DgiHueXW6z5pm7TegivIS04TS6GAUq2VjUT+y/cezBU5DhjECHc+uRnuNmp
 B6GYTiyRLTjJ5KPHdOqi/wbEozNH3wVfAWEy3Urnxuqet+xgyi7sUatqLbck9JSn8VzG
 nVOLbPczcRoX7LeXltApYlEKE48AD6Oov+fnlNCra80e5vSWSjWCKtBb26sfo/MnFDfu
 c+0AXRWv7Hf30wX2P1uQl+XWHfZFixcRNT9pjuslF/664ZRolpZh0VOhOjdgRlbzL0rq
 kJsquZkHUF8x4VBf8/ePmnzciwYK6kfonmLKuOFLC7s8hFjH3eyJLsBubcXd2nYkI7wK
 jarA==
X-Gm-Message-State: AOJu0YxOnWi5fzIOM3qgNA01pcAfdmISqdH8sGgT6GDNCPaQZfICUeR6
 mFS0XQ+dpVvAUMZCMpV9h4/hLRfWE288aLp689ACsJ31yRzTU/v/52HtMIU6x62EQX00aRW5cCx
 XSyKA019RcLS6qW9l9LtbiWrfuF1FC8KyUV802WB15leUUy/5qfqfTFX2A5Bugo/7zKmS+6mnhv
 dBs9wOj1jbntvWy38Lpq73Qr9uBJmRSY7eTQ==
X-Received: by 2002:a05:6871:60b:b0:270:2abd:4772 with SMTP id
 586e51a60fabf-27c68c1ea59mr5252962fac.45.1726485373433; 
 Mon, 16 Sep 2024 04:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC1idW21lJDZ9hL8Im/Lc2Qby577onBQIjn/SqBQ8HPmI6V5N+iuVQ7v03PT6mTI2C/19ZuzKaAwDDAjB6r2Y=
X-Received: by 2002:a05:6871:60b:b0:270:2abd:4772 with SMTP id
 586e51a60fabf-27c68c1ea59mr5252954fac.45.1726485373131; Mon, 16 Sep 2024
 04:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <mvmplp327ob.fsf@suse.de>
In-Reply-To: <mvmplp327ob.fsf@suse.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Sep 2024 13:15:54 +0200
Message-ID: <CAASaF6yhuojMH7mD0xuQYXhFtMM=5e8Zj=oQtkDUfp_BpwJNHA@mail.gmail.com>
To: Andreas Schwab <schwab@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getdents: account for d_name size in tst_dirp_size
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

T24gTW9uLCBTZXAgMTYsIDIwMjQgYXQgMTI6NTHigK9QTSBBbmRyZWFzIFNjaHdhYiA8c2Nod2Fi
QHN1c2UuZGU+IHdyb3RlOgo+Cj4gVGhlIGxpbnV4X2RpcmVudCBhbmQgbGludXhfZGlyZW50NjQg
c3RydWN0cyBkbyBub3QgY29udGFpbiBzcGFjZSBmb3IgdGhlCj4gZF9uYW1lIG1lbWJlci4gIEFk
ZCBOQU1FX01BWCB0byB0aGUgc2l6ZSBpbiB0c3RfZGlycF9zaXplIHNvIHRoYXQgdGhlCj4gZ2V0
ZGVudHMgc3lzY2FsbHMgZG8gbm90IHNwdXJpb3VzbHkgZmFpbCB3aXRoIEVJTlZBTCBpbnN0ZWFk
IG9mIEVGQVVMVC4KPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgU2Nod2FiIDxzY2h3YWJAc3Vz
ZS5kZT4KCkFja2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KCj4gLS0t
Cj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMuaCB8IDQgKyst
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMu
aCBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMuaAo+IGluZGV4
IDU2MGRmNDEyNi4uMDJjM2JjNTA5IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMuaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZ2V0ZGVudHMvZ2V0ZGVudHMuaAo+IEBAIC02NCw5ICs2NCw5IEBAIHRzdF9kaXJwX3NpemUo
dm9pZCkKPiAgewo+ICAgICAgICAgc3dpdGNoICh0c3RfdmFyaWFudCkgewo+ICAgICAgICAgY2Fz
ZSAwOgo+IC0gICAgICAgICAgICAgICByZXR1cm4gc2l6ZW9mKHN0cnVjdCBsaW51eF9kaXJlbnQp
Owo+ICsgICAgICAgICAgICAgICByZXR1cm4gc2l6ZW9mKHN0cnVjdCBsaW51eF9kaXJlbnQpICsg
TkFNRV9NQVg7Cj4gICAgICAgICBjYXNlIDE6Cj4gLSAgICAgICAgICAgICAgIHJldHVybiBzaXpl
b2Yoc3RydWN0IGxpbnV4X2RpcmVudDY0KTsKPiArICAgICAgICAgICAgICAgcmV0dXJuIHNpemVv
ZihzdHJ1Y3QgbGludXhfZGlyZW50NjQpICsgTkFNRV9NQVg7Cj4gICNpZiBIQVZFX0dFVERFTlRT
Cj4gICAgICAgICBjYXNlIDI6Cj4gICAgICAgICAgICAgICAgIHJldHVybiBzaXplb2Yoc3RydWN0
IGRpcmVudCk7Cj4gLS0KPiAyLjQ2LjEKPgo+Cj4gLS0KPiBBbmRyZWFzIFNjaHdhYiwgU1VTRSBM
YWJzLCBzY2h3YWJAc3VzZS5kZQo+IEdQRyBLZXkgZmluZ2VycHJpbnQgPSAwMTk2IEJBRDggMUNF
OSAxOTcwIEY0QkUgIDE3NDggRTRENCA4OEUzIDBFRUEgQjlENwo+ICJBbmQgbm93IGZvciBzb21l
dGhpbmcgY29tcGxldGVseSBkaWZmZXJlbnQuIgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
