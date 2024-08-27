Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A1AC5320E
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 07:36:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26EA93D273A
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 09:36:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 033F53C8D92
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 09:35:51 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4459B1401652
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 09:35:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724744149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02dk6NMMcpkIDMHf2jaQRB/DcSut0WzixTzX5tb12v0=;
 b=Z6WFgnsEC/EJhAg4m549N6R3vZlfCZ5ymNa8QhbiF2lilbhi1T28VQyROLGggkgrEddsDS
 5Cm0LWl5aV7yCz5B1jt/n+HKkLFlAG3I1T/rShepqOjDNaf/K6YqY/jU0mtAttxLa8jgMC
 LWEaui5ZeTDFgktCINDPhy6+UX7qVrk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-gu3R2C_TM7qLUlBTw2j8jg-1; Tue, 27 Aug 2024 03:35:47 -0400
X-MC-Unique: gu3R2C_TM7qLUlBTw2j8jg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2d3baf38457so5514239a91.0
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 00:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724744145; x=1725348945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02dk6NMMcpkIDMHf2jaQRB/DcSut0WzixTzX5tb12v0=;
 b=RgfysPecXqPoEwb70/snDF3lhHNlhpYZ3b3sDGPTNG+ywqjiHEbjYYW4bD/iTFEClt
 ec3USPHRReR8Wy9h2cuaYjTiKsZ548a627lLfwfl48lFJyoRaMFcqaHG7EohJAcawWP7
 xeacQ/YgGyPe5PdHa4NXyOhS/2HqgP/v09DDGxfCtA8RD0XRqmGfQCwrtIi8QuyuQjOJ
 u9Eagk6ZgoDKoTcWHaOMYvKyS/fuF6UAAvpuNPy800P5R/oJrKJhCu5saDpA440ii//5
 4cFxC9ulAqW9MY4LBwxTVs14gWQk/CMPnljc/Sg2MBWHbPg8Kr00xSVP//63HlNIl3/S
 HP8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+mA4JECAdhkvtMr7Qzvv/EE8p1obIoT0zEG7twapHFMA3pKLacns4a21aK8+mmynMtu8=@lists.linux.it
X-Gm-Message-State: AOJu0Yx8qcYq2oM3IIlu52rsob4GD5mI5MeMWnxedDYB4MGhjEuHAHta
 HaNCO2BoHTj+7SRCl7nfmNGFbpIM8vws9xAhv0UJMEsE3+KQVScYRwmAyYbHabvs5docxIXtsPE
 QnFHVGeOQbMf1Nzly2cGJ+RxW534XcP4eAjrjfkX25iMvL0pxJgKIpsIFat9GVRdrE4uYmk5SiU
 0FOfJkxGGlHVC7kUuNAmzvpqqzsPwmLjaR7Wq+
X-Received: by 2002:a17:90a:d347:b0:2d4:902e:ca3f with SMTP id
 98e67ed59e1d1-2d824d0288dmr3096351a91.19.1724744145342; 
 Tue, 27 Aug 2024 00:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0OSblcWUdxuv087XjvF/81nCSFwqkvcum8/J4kLvynjY/Hbxh1qtdxhnJbYOqU0yqhBuXNtqzORD896PQFj8=
X-Received: by 2002:a17:90a:d347:b0:2d4:902e:ca3f with SMTP id
 98e67ed59e1d1-2d824d0288dmr3096327a91.19.1724744144979; Tue, 27 Aug 2024
 00:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240827032218.34744-1-liwang@redhat.com>
 <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
In-Reply-To: <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Aug 2024 15:35:32 +0800
Message-ID: <CAEemH2djkWMtuTN2=Y5MXZVOACeCm32_Hh0zAJxH7X4Ss1MSuQ@mail.gmail.com>
To: John Garry <john.g.garry@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] loop: Increase bsize variable from unsigned short
 to unsigned int
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
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBdWcgMjcsIDIwMjQgYXQgMzoyMOKAr1BNIEpvaG4gR2FycnkgPGpvaG4uZy5nYXJy
eUBvcmFjbGUuY29tPiB3cm90ZToKPgo+IE9uIDI3LzA4LzIwMjQgMDQ6MjIsIExpIFdhbmcgd3Jv
dGU6Cj4KPiArbGludXgtYmxvY2ssIEplbnMKPgo+ID4gVGhpcyBjaGFuZ2UgYWxsb3dzIHRoZSBs
b29wYmFjayBkcml2ZXIgdG8gaGFuZGxlIGxhcmdlciBibG9jayBzaXplcwo+Cj4gbGFyZ2VyIHRo
YW4gd2hhdD8gUEFHRV9TSVpFPwoKWWVzLCBzeXN0ZW0gc2hvdWxkIHJldHVybiBFSU5WQUwgd2hl
biB0aGUgdGVzdGVkIGJzaXplIGlzIGxhcmdlciB0aGFuIFBBR0VfU0laRS4KQnV0IGR1ZSB0byB0
aGUgbG9vcF9yZWNvbmZpZ3VyZV9saW1pdHMoKSBjYXN0IGl0IHRvICd1bnNpbmVkIHNob3J0JyB0
aGF0Cm5ldmVyIGdldHMgYW4gZXhwZWN0ZWQgZXJyb3Igd2hlbiB0ZXN0aW5nIGludmFsaWQgbG9n
aWNhbCBibG9jayBzaXplLgoKVGhhdCdzIHdoeSBMVFAvaW9jdGxfbG9vcDA2IGZhaWxlZCBvbiBh
IHN5c3RlbSB3aXRoIDY0ayAocHBjNjRsZSkgcGFnZXNpemUKKHNpbmNlIGtlcm5lbC12Ni4xMS1y
YzEgd2l0aCBwYXRjaGVzKToKCiAgOTQyM2M2NTNmZTYxMTAgKCJsb29wOiBEb24ndCBib3RoZXIg
dmFsaWRhdGluZyBibG9ja3NpemUiKQogIGZlM2Q1MDhiYTk1YmM2ICgiYmxvY2s6IFZhbGlkYXRl
IGxvZ2ljYWwgYmxvY2sgc2l6ZSBpbiBibGtfdmFsaWRhdGVfbGltaXRzKCkiKQoKCgotLQpSZWdh
cmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
