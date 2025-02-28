Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE43C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 12:26:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DCF83C9E39
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 13:26:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82B3A3C180F
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 13:25:44 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CEDAF63D42F
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 13:25:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740745542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fXLHS21nDZq6N2uublwIlgmpGQEuV2ElRLOSdKGJG+E=;
 b=cn0oiwHjdOFIJktcKKi5Cf2bNj6fEbz6rYzELAEx/ktiIfyM7E2zAIGv6cqZ0NbC0DHbPF
 7nCldfGTec6gSmj7L290GqY6yftgW6weBYuEUdyJSLgairHi8gt8007OzKHiMwmeK4uSyr
 4+3R5e5Y8bcngNXHQpVDMNDJCGBh9lI=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-dr6zYhXSPcq0MAfz_nRdHA-1; Fri, 28 Feb 2025 07:25:40 -0500
X-MC-Unique: dr6zYhXSPcq0MAfz_nRdHA-1
X-Mimecast-MFC-AGG-ID: dr6zYhXSPcq0MAfz_nRdHA_1740745540
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-8617b6c6d03so599863241.3
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 04:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740745540; x=1741350340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXLHS21nDZq6N2uublwIlgmpGQEuV2ElRLOSdKGJG+E=;
 b=sqPe8iS4YSz93VYVan1+G3gSWps+iQ1+dTLCK9aTpWiYDqqDce92g25Pve1siVqIEZ
 ueJm8IDeLqttTg2OsJ30Tq8wP1LpG6/2keG/0Rel4P/3s3xmQLfbvuZHFJnrOuqbGIbI
 EAAJ1gztQaJEWw5JYuvM2bwhDRUpY8A9TrybJnq2ysaQb/an3se5mAia5RR1iNzCUwIc
 861VXlo9PVWkQ2VvfMStsl/Cpl1sNQnoLuzkAB2PlItzbk/V0tIBTLO6eJBIjrkWx7+i
 MxYfrt/3c8fVkhG9/2uPKTdDh4lCg9St+4xVpz7TpLLbQtG9Rik4xQ+G1ZSzlBpkaXNz
 wPog==
X-Gm-Message-State: AOJu0YzSm2UoqQ/icYCS9DoVoHJ4s2Sta8i0GKy+StuvWSYKAOjFYyBj
 oO4rYlhl5VljT/BouiYsweOGjaC4veel7Llbi5px+U8DqRY+JQumxKMTw9URh9vaUI1kAMGNVa4
 kqQQh+wteLLx/Oc1oo0AkAyCQvSkm91U/Wei/2/w042RjGhW0VtjYdnZtKF2v87TZyku911zTfH
 JajY7sfulGwRP2Qo9rZ7bWxuU=
X-Gm-Gg: ASbGncv5wcqMiwmbhXe1yI/xTVWz75Om45ZAoc8T7uzwICFrCYvyKFNmAlRIpyF/72E
 B16pOquGuEgTCeJS/kyXNI8tNAmir+TsHaxISzdJRC6SEa29VdmWl2jUDE4YXRCc6BJc1yd/L
X-Received: by 2002:a05:6102:390a:b0:4ba:9a20:dd03 with SMTP id
 ada2fe7eead31-4c04495a10amr2270559137.12.1740745540157; 
 Fri, 28 Feb 2025 04:25:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGWUObm0Yy4QxvkMUPWgFfU4BAOIwuTyTEla5JTo3UTiuC0KGoyECXDNyKNCN1RFCgUKHB5CzUaF4etZq7Yrc=
X-Received: by 2002:a05:6102:390a:b0:4ba:9a20:dd03 with SMTP id
 ada2fe7eead31-4c04495a10amr2270555137.12.1740745539938; Fri, 28 Feb 2025
 04:25:39 -0800 (PST)
MIME-Version: 1.0
References: <18cb6752b375941581aa66617e52edad0913344e.1740650948.git.jstancek@redhat.com>
 <20250227133851.GA3067784@pevik>
In-Reply-To: <20250227133851.GA3067784@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 28 Feb 2025 13:25:24 +0100
X-Gm-Features: AQ5f1JqwJkpHJEK9syNrFD00NPoYZsdreTT5kRuigkc-T-Ky-md-xvDyT9R3eo4
Message-ID: <CAASaF6wp1fMv+kY8twURVzhoFU=VPsVN6+xr_FJhNR7KfCbP_Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wM4D3eSOfFDaupFZeaUKVh3IiGUHzSbbJ-eL__Acbxk_1740745540
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: sem_timedwait: replace sleep with
 tst_process_state_wait3
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

T24gVGh1LCBGZWIgMjcsIDIwMjUgYXQgMjozOeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEphbiwKPgo+ID4gVGhpcyBtYWtlcyB0aGUgdGVzdCBmYXN0ZXIg
YW5kIGFsc28gYXZvaWRzIGEgc21hbGwgcmFjZSAtIHdoZW4gdGhlCj4gPiB0aW1lIGlzIHZlcnkg
Y2xvc2UgdG8gc3RhcnRpbmcgbmV3IHNlY29uZCwgdGhpcyBtYWtlcyB0aGUgdGVzdCB1c2UKPiA+
IHRpbWVvdXQgdGhhdCdzIGVmZmVjdGl2ZWx5IGp1c3Qgc2xpZ2h0bHkgb3ZlciBvbmUgc2Vjb25k
LCBiZWNhdXNlCj4gPiBuYW5vc2Vjb25kIHBvcnRpb24gaXMgYWx3YXlzIHNldCB0byAwLiBBbmQg
cHJldmlvdXNseSBjaGlsZCB3b3VsZAo+ID4gc2xlZXAgcm91Z2hseSBvbmUgc2Vjb25kLgo+Cj4g
TEdUTS4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpUaGFua3Ms
IHB1c2hlZC4KCj4KPiBJIGFsc28gd29uZGVyIGlmIG90aGVyIHRlc3RzIHdpdGggc2xlZXAoMSkg
YXJlIHJlbGV2YW50LiBlLmcuCj4KPiBjb25mb3JtYW5jZS9pbnRlcmZhY2VzL3B0aHJlYWRfcnds
b2NrX3RpbWVkcmRsb2NrLzYtMi5jCj4gY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9wdGhyZWFkX3J3
bG9ja190aW1lZHdybG9jay82LTIuYwo+Cj4gKFRoZXJlIGFyZSBtb3JlIHNsZWVwKCkgdXNlcywg
YnV0IEkgc3VwcG9zZSBvdGhlcnMgYXJlbid0IHJlbGV2YW50LikKCkkgc3VzcGVjdCB0aGVyZSBh
cmUgc3RpbGwgbWFueSB0ZXN0Y2FzZXMgd2hlcmUgc2xlZXAoKSBjb3VsZCBiZSByZXBsYWNlZC4K
Cj4KPiBBbHNvLCBzb21lIHRlc3RzIChlLmcgY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9jbG9ja19u
YW5vc2xlZXAvMS0zLmMgdXBkYXRlZCBmZXcKPiB5ZWFycyBhZ28pIGRpZCBub3QgdXBkYXRlZCBz
bGVlcCgpIGluIGRvY3MgY29tbWVudC4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
