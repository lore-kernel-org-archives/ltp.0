Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8502DC87FCB
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 02:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754532981; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=sqs+ebbWxQeDZH0tkCR3ynkfCS3eSI8D72A4W+QUgok=;
 b=jnje7U+++3S58YoCPFqgYJ7TZ/tRAmDHiGk3KAYtbCmcpDtdcGzq2rIaD+LBGKh2t3aOc
 +DM5HcOzLKbQ8965pD1K7lhnOVSgggO0a6/lsHIm5yrd7SykttvG7ELV7qjL9j0FrJE9ITt
 QRk2b7Lcj6fa6CADw6Q5cc2oY0VD9kk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C581A3C8C3D
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 04:16:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6E203C4F4A
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 04:16:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFB56100045D
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 04:16:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754532959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jFmH4zXS9deFETfu+1M7f0kDUsUMpIp0XNX2G7pKzQ=;
 b=Vvjk7Vd6bYb8p40l8n6+gZ8B7Boi6JeJEfnb3hC8Mu4Xylzl+KCG/kZVB2WUavEVY7Mvtq
 lgmK1AhUUIBt/cUJIodP1/6HwkYqLXLxVO3w12U6qnK/77h/TL5rNxCKTxuLe7oesKGCRl
 j8R8xZII09fwzxEOAUnfCktNQjqllPU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-6Fqk_sG-OF6iIo3XvC8j1Q-1; Wed, 06 Aug 2025 22:15:56 -0400
X-MC-Unique: 6Fqk_sG-OF6iIo3XvC8j1Q-1
X-Mimecast-MFC-AGG-ID: 6Fqk_sG-OF6iIo3XvC8j1Q_1754532956
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b3beafa8d60so646462a12.3
 for <ltp@lists.linux.it>; Wed, 06 Aug 2025 19:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754532955; x=1755137755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3jFmH4zXS9deFETfu+1M7f0kDUsUMpIp0XNX2G7pKzQ=;
 b=JqNy0MHOUHI/iGALBVcdLPChFSmz4ZUAZSshwzeA7nqf27PpLhCUu4Fo0/4Qc33Q4H
 Kstc5l3mIq9jy4IlBSmsNozgHp6cdjNR5TT+ragNGuffX+glW0wOXBD8haLJAvDJCCbD
 L1qgKV4XVhos61lBbpdPIlYLmebZJ6S09EEdyUqrOP+bxnK8cefqoEMFcwBQE0EE+7mv
 ZKNCI2gLw49HkqvSfSHx28hw88JT9n2dT0/331IiMrsVDZuxoVHg7I2XGWBsLqAdj27M
 n/Mzhn6m1WlDrq9EhJhVzN1XlZNJXz7p34XFZhAVlG8GjxzZApuQjRrhz/BFws9a88YM
 hg5Q==
X-Gm-Message-State: AOJu0YzqsKlh0twvbG1ujVE7dsYbRhuVmzf7vk6JLzoWV2EpDOzLX9Hb
 lDS1CX7lTr21EDMOjDB0Np/pmcjXdVoqX86QZBBso/1BpLKzetyAqn8t9CQSM7mR8XJeV/U6pQt
 IEQgXwEyJTNVyRen+ZYhz0rQvjcqufZNZ/AVt67GHXNfWCK4vi7V1E8T/NuKhy5kZS1rYNG4mW6
 xd/dO9/VIf4+mk9iR0u58MXA5zpSc=
X-Gm-Gg: ASbGnct86Gglz1bwrK5rztegjJ2j+rkCVSIWkFpxByyFLCzyquFeWQ+Kq0XMmiqziUb
 IFsAtmpAWKw4KGiP8Ifcoococc2AjwpV1ovp+NpJkL3hEYwA5WEL5T3O7jbyRra68L4HKjN2avY
 Kv0MkDK9M2eLV8f+hnIdR1wA==
X-Received: by 2002:a17:902:ebd1:b0:234:d679:72e9 with SMTP id
 d9443c01a7336-2429f1dbd61mr71714275ad.12.1754532955596; 
 Wed, 06 Aug 2025 19:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhea2OcNwxvgrgK0qmKSFjTp12sh0O7iwDRy63PjRcJzgNOiMMkBR3EEvx/Ok3b1yMJecSUP5LCV1X7Y06T7A=
X-Received: by 2002:a17:902:ebd1:b0:234:d679:72e9 with SMTP id
 d9443c01a7336-2429f1dbd61mr71714055ad.12.1754532955261; Wed, 06 Aug 2025
 19:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250806211420.445452-1-pvorel@suse.cz>
 <CAEemH2cgv6vwZvK4J5cquG4=sXt2076CdNtB-fuMzx0+OOFcDw@mail.gmail.com>
In-Reply-To: <CAEemH2cgv6vwZvK4J5cquG4=sXt2076CdNtB-fuMzx0+OOFcDw@mail.gmail.com>
Date: Thu, 7 Aug 2025 10:15:43 +0800
X-Gm-Features: Ac12FXz1SliZw1H3SqGvygEpb_09o20K7rw9IE7sDBmE8TLSIG0DXQXfElrcyoQ
Message-ID: <CAEemH2ddKZwocZbpf9vUVjNssbonifJG5o7hu-PoBggZocXVSA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DYnoEEzOUrv-deV6diFSVoc9zoAhrvZ8RIDQgsVYbSQ_1754532956
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] Makefile: Add kernel modules related make
 targets
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
Cc: =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBdWcgNywgMjAyNSBhdCA3OjIy4oCvQU0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPiBIaSBQZXRyLAo+Cj4gT24gVGh1LCBBdWcgNywgMjAyNSBhdCA1OjE04oCv
QU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4+IExUUCBjb250YWlucyBm
ZXcga2VybmVsIG1vZHVsZXMgYW5kIHRlc3RzIHdoaWNoIGFyZSB1c2luZyB0aGVtLiAgVGhlc2UK
Pj4gcmVxdWlyZSB0byBiZSBidWlsdCB3aXRoIHRoZSBzYW1lIGtlcm5lbCBoZWFkZXJzIGFzIHRo
ZSBydW5uaW5nIGtlcm5lbAo+PiAoU1VUKS4gU29tZXRpbWVzIHRoZSBiZXN0IHdheSB0byBhY2hp
ZXZlIHRoaXMgaXMgdG8gY29tcGlsZSB0aGVtIG9uIHRoZQo+PiBTVVQuCj4+Cj4+IEFkZCAnbW9k
dWxlcycsICdtb2R1bGVzLWNsZWFuJyBhbmQgJ21vZHVsZXMtaW5zdGFsbCcgbWFrZSB0YXJnZXRz
IHRvCj4+IG1ha2UgaXQgZWFzaWVyIHRvIGJ1aWxkIHRoZW0uCj4+Cj4KPiBNYXliZSBiZXR0ZXIg
dG8ga2VlcCB0aGUgbWFrZSB0YXJnZXQgY29uc2lzdGVudCB3aXRoIHRoZSBrZXJuZWwgYnVpbGQK
PiBjb21tYW5kOgo+ICAgbWFrZSBtb2R1bGVzX2luc3RhbGwKPiAgIG1ha2UgbW9kdWxlc19jbGVh
bgo+CgpBbHNvLCBpdCBsb29rcyBsaWtlIExUUCBtaXhlcyB1c2luZyAiLSIgYW5kICJfIiBpbiBp
dHMgbWFrZSB0YXJnZXRzOgoKICBsaWItYWxsLCBtZXRhZGF0YS1hbGwsIGNsZWFuX2luc3RhbGxf
ZGlyLCB2ZXJfbGludXgKClNvIHdlIG1heSBuZWVkIHRvIHVzZSBqdXN0IG9uZSBzZWxlY3Rpb24s
IHdoaWNoIGNhbiBiZSBkb25lIGluIGEgc2VwYXJhdGUKcGF0Y2ggYW55d2F5LgoKCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
