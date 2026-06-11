Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B24CD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 07:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781163523; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=v7vKEHqXqO4gM+Z5tkQIMLd0tDMSbyv8JqlPJFgTMGY=;
 b=Sl7Xuil69ZjBOrpOY5K3E/Q6fe0hPvtBHFbnViF7myZWJrzSItQJJCHQcQhJZEM+8xTdi
 G0A5VHPoEN55uWBeMhAujbmmnnOB6XYl68A98iXGifTI0Dkdj2TPvJ0109znN8Oi6Q1eJ+K
 FkBsNFUysrAy21b7zI543c+gQtmupQw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 681923E2AB3
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:38:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34E603C2B4B
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:38:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 58A2B140019F
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:38:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781163500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPUA7LRXCVafnrzLS2FJ0ZvRu1YXGWJrDm/YWWDmrJE=;
 b=TBEwngQaplgLcCSUMFfUM46qKi4ozRchFkcG500jgRaVoKkstx4RCO/hCsy13ChrNJRf8L
 DU/M0bpDNccV1fmKYQdy9dV0Tl7jik92KaX4ZmSQr4CIEMQiDV+vAfuQTG+kl8Xe/t4q2a
 vE/jbL3ExwCzJ/nxEUoxS+HKZaTHXf4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-9uFXsXz2Ncab9IHZDeAjQw-1; Thu, 11 Jun 2026 03:38:19 -0400
X-MC-Unique: 9uFXsXz2Ncab9IHZDeAjQw-1
X-Mimecast-MFC-AGG-ID: 9uFXsXz2Ncab9IHZDeAjQw_1781163498
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46067b07571so205667f8f.1
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 00:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781163498; x=1781768298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PPUA7LRXCVafnrzLS2FJ0ZvRu1YXGWJrDm/YWWDmrJE=;
 b=gadh/FEGjcamxe7xWhbaQGysiViyqrubHLDZdQHe+WVGtS1PfuZIkoR0l6Kx4uRhVu
 8olcUWu1QeMktugvtWYGkxBzrvn/8G96rUsYTo2cUsRH1+aUHXXePIxHpvcZY2Avtt81
 xHK6plluMH4/HowbL/39Mh8Z0Ffvq5LUaTLk2MzKtmISsewDoUuaoMhUodVGgnOt3gns
 tTj2vGv4ZYBY3F50OrhakjWaH14sFl6WRtT+mdVhPk2S70PclNiZYuElCxb1GnxXmMw9
 ns7Bh4z3eEpgZt7L2vBNYnRQMc0XAGGaJzKFEtWasA5EqrInnWEUiBOCdFBsj899xG0z
 fKKw==
X-Gm-Message-State: AOJu0YwDTRmZ2YLEQwwd3wYs+vDvqXsHBNnHR54rbWj/48zs2XEjSlUK
 uYLgT2g8JbalCh75yFTjNhRKbmybzNBpdda5HDKbJE0QgpRzr3xWGMamjXuhPucTCvSAUUR70uj
 EOOlylGueVBA97pXk9KIo96brsIl1IsJxeYrrJnRonpNMuQvS/LCkPSwFWy+gJQMwwtS1gbSc7r
 LIXefBe28igFMsjnyG5LVWMWhp6zR0I+HOwRlP
X-Gm-Gg: Acq92OFfQ5VsUTAtvkC+czB/BVmYO5aD4RQcoL+99PhyCFMQfikTKaio/e2Tqm1p3Hv
 rmGqMDjj6yBY27ezIoqZFHo7EMSox9zbaXraPYIa773ncmI87+4x0FpcJJb2uC6hMLNKdkndbj9
 pdOc4O8LQw6UYcvdsrA9FU/UiwlDHVE4FISidZYro2EqGrW6jaWd5w20anGWnUvPvEkpbhhLWCI
 /tpnCQOERJG+02GV9DBlBZenDXPvLNVWAC50ckM2hf8LPznQCjj6uqLUFCclF0KIZQuFmjwiEHf
 Rila4pat71/8Sg0NViO+Ut9DcOzvW2Pa2L4er8wcvIeMasuQDSjm3nZglKUvkcaiwecJfVx3pMu
 DMwmCMMKuE7LndXApyXME5nlTITPlbRl+JIYqg4yX3kjyDJPthnxnLaNcXKkuBHHIJKDkEcXAPz
 EjLw==
X-Received: by 2002:a05:6000:430b:b0:45a:5392:3a19 with SMTP id
 ffacd0b85a97d-46067c154b7mr1855397f8f.16.1781163497802; 
 Thu, 11 Jun 2026 00:38:17 -0700 (PDT)
X-Received: by 2002:a05:6000:430b:b0:45a:5392:3a19 with SMTP id
 ffacd0b85a97d-46067c154b7mr1855367f8f.16.1781163497441; 
 Thu, 11 Jun 2026 00:38:17 -0700 (PDT)
Received: from fedora.redhat.com (46-116-126-116.bb.netvision.net.il.
 [46.116.126.116]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm61524979f8f.14.2026.06.11.00.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 00:38:16 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 11 Jun 2026 10:38:14 +0300
Message-ID: <20260611073814.16334-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527092618.14824-1-mmenashe@redhat.com>
References: <20260527092618.14824-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KMitZZYxr5rtY_fODVb3qZXnhg1wpobO_EMja54UyRk_1781163498
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v14 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpGb2xsb3dpbmcgdXAgb24gdGhpcyBwYXRjaCBzZXJpZXMgKHYxNCkgc2VudCBvbiBNYXkg
Mjd0aC4gVGhlIExUUApBSSBSZXZpZXdlciBoYXMgYXBwcm92ZWQgYWxsIGZvdXIgcGF0Y2hlcyB3
aXRoIG5vIGlzc3VlcyBmb3VuZCwgYW5kCmFsbCBwcmV2aW91cyByZXZpZXcgY29tbWVudHMgaGF2
ZSBiZWVuIGZ1bGx5IGFkZHJlc3NlZC4KCkkgbm90aWNlZCBtYXN0ZXIgaGFzbid0IGhhZCBtZXJn
ZXMgc2luY2UgTWF5IDEzdGgg4oCUIGlzIHRoZXJlIGEKZnJlZXplIG9yIHF1aWV0IHBlcmlvZCBJ
IHNob3VsZCBiZSBhd2FyZSBvZj8gSGFwcHkgdG8gd2FpdCBpZiBzbywKanVzdCB3YW50IHRvIG1h
a2Ugc3VyZSB0aGUgc2VyaWVzIGlzbid0IGxvc3QgaW4gdGhlIHF1ZXVlLgoKR2l0SHViIFBSOiBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9wdWxsLzEzMDEKClRoYW5r
cywKTWljaGFlbCBNZW5hc2hlcm92CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
