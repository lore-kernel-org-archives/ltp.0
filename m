Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40570C54E67
	for <ltp@archiver.kernel.org>; Sun, 24 Mar 2024 02:27:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 486FE3CFF16
	for <ltp@archiver.kernel.org>; Sun, 24 Mar 2024 03:27:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E3B03C81C7
 for <ltp@lists.linux.it>; Sun, 24 Mar 2024 03:27:36 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 72E38140E7C8
 for <ltp@lists.linux.it>; Sun, 24 Mar 2024 03:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711247254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ujfn1ysBPkhKXRtmbt/SO1ajOdIaWphbekUL2uMOBok=;
 b=Jf0PNxI+CEhmnNJPWrDbsENuk3BlqFnpTtGNhiN7NwLEnnDLOqxnhNKFvGHIKwcpx2zHgT
 N2gcCnD/scylnz+dpEZeZSpVSzfi+E2b/7TMitS9qBCUHt21qsbZBbiRS4SsNj5wdOGDCK
 p975kJOSg7Gby4Hb70gFu5mJjQNBaJQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Lj-yOueGPhShagv21icgOw-1; Sat, 23 Mar 2024 22:27:30 -0400
X-MC-Unique: Lj-yOueGPhShagv21icgOw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29de02b98caso2656653a91.0
 for <ltp@lists.linux.it>; Sat, 23 Mar 2024 19:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711247250; x=1711852050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ujfn1ysBPkhKXRtmbt/SO1ajOdIaWphbekUL2uMOBok=;
 b=r22EvDV9eCIh3GHTjxD/QTLwOIxMZ0eV2kMQs9SAzaJgwZcrm2JcyRjc6rTo3+XEl+
 hgGaGui8+RkBMWPg+FRhlcKW8hWNexbQ2j6WphFARfFOjp+qkBYqYJhqF1HUfV+AxUiI
 jD6MITM9ibQ8H4yhtzWobPsmEGLv8/jTB1UVBSlCJe7StSvhTdhpPSVKUPgpCu3ReWYt
 TyBVToiHWkCvPzafZAyxgAOF5MUTymXcwTuu0Zu8mX7OrBlzDs7vPMKuE+0nemXeHAyN
 VagYXpcm7RdXAkI85rk3ur5czWsB3qXHeDqVYA7n7QU8OH9tJkujCbH90GAGy/0upmYU
 qS0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCULrt+cPXv6FnJJxB4sXI7+HNchqevHT/JfVgVCC9XBoFKnwW9vZW41N3FImNXeWdtSix7/YTcSIgxvtNyCAkzBox0=
X-Gm-Message-State: AOJu0YwC30JvMBLFAt3obuX0wPoTw4o31OegIIK+MbldiO56fKY7iNFl
 vy1NZofmKbhvxp792Ml8FHOFmD+dvRm9rJd0y76lXNINEGy/KHm/e+ALJoUQteFbY/Cu3urKVJ3
 zVULUkoshTCyrK+5J4ydLSuyDFfvek7gfZwCSkBdkv+WWN0nUOPAIhzzjcaLtkgu2MjSJwrZkv6
 DeFVWof0u3qj7HGVjCTM8uEZM=
X-Received: by 2002:a17:90a:bd08:b0:29f:ed40:4a8a with SMTP id
 y8-20020a17090abd0800b0029fed404a8amr3127713pjr.29.1711247249782; 
 Sat, 23 Mar 2024 19:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHfiyHenWZxJyJLgoHf5VKa4PB2e2hmtqx8e+ByOYDGa50Ymsh9HZAIwyOoJrBaptJTVdYH7jqNYiwy5RE9oA=
X-Received: by 2002:a17:90a:bd08:b0:29f:ed40:4a8a with SMTP id
 y8-20020a17090abd0800b0029fed404a8amr3127708pjr.29.1711247249485; Sat, 23 Mar
 2024 19:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <75b59f47-5e94-4293-8f9d-746aab4ef7d5@suse.com>
 <Zf18fSP0uQoFOpl6@yuki> <00c5cb3e-6b58-4192-9159-1825a05ac657@suse.com>
In-Reply-To: <00c5cb3e-6b58-4192-9159-1825a05ac657@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Sun, 24 Mar 2024 10:27:17 +0800
Message-ID: <CAEemH2cft19JByyEOc24_TVQZwTGkzaSPQ70T60Q=LmHKLuGDg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Next open monthly meeting request
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMjIsIDIwMjQgYXQgOTo0M+KAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gdmlhIGx0
cCA8bHRwQGxpc3RzLmxpbnV4Lml0Pgp3cm90ZToKCj4gSGkgQ3lyaWwsCj4KPiBJJ20gYWxzbyBh
d2F5IHRoYXQgd2VlayA6LSgKPgoKQWhoLCBzb3JyeSBJIG1pc3NlZCB0aGlzIG1lc3NhZ2UuCgoK
PiBNYXliZSBmcmlkYXk/Cj4KClN1cmUsIEkgY2FuIGF0dGVuZCBpdCBvbiB0aGUgaGlnaC1zcGVl
ZCB0cmFpbiwgYnV0IHByb2JhYmx5IGp1c3QgbGlzdGVuLgoocG9vciBuZXR3b3JrIG9uIHRoZSB0
cmFpbikKCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
