Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B053CA0FF0
	for <ltp@archiver.kernel.org>; Wed, 27 Aug 2025 01:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756258797; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zuOhszMHvla9hcYbzTPLHQUZF9bNJQb3E7O8Uci2/Bw=;
 b=WKmoZH4tt01MYjcXNEkK9OAXmtju6zxyKRn0xDjC7PYtaeF89JLefEHPIZxOWPhBJo33B
 u3yMMkEFuE5ZJoa5SM+a9TXiHFh6LruGYxL7sJ0wQeyo52Z9UpLrWfSs0k9+wi6RbN5TcuR
 Q4vBHowWMyJSc34HQ8uOZWHffiRKsis=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C6773CCF60
	for <ltp@archiver.kernel.org>; Wed, 27 Aug 2025 03:39:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D30FF3CC00D
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 03:39:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E9250600475
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 03:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756258775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4AKdjXrLOxo9mncoQI2YNKkWEnHyZxy+ck9GOSumq0A=;
 b=d+9IVW4ZDlSPGV5GJNKcDGZSReEIAlWD1I/aMEEO280dsgaeJgGvjCHjqanzdMjiPUVyzt
 Rsbsd3vXZYxDvMisW/wvyuiQeUiX0Zj5GeU+Jf60/iMzuIT0Z/QUl0GSGGN2yAPVMhNJnv
 nfn9Swf4/7Y/keEC58T1BM2cuIU9614=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-y4bKGXKrOdmWYbEEepzMqw-1; Tue, 26 Aug 2025 21:39:32 -0400
X-MC-Unique: y4bKGXKrOdmWYbEEepzMqw-1
X-Mimecast-MFC-AGG-ID: y4bKGXKrOdmWYbEEepzMqw_1756258772
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4716fc56a9so9362247a12.0
 for <ltp@lists.linux.it>; Tue, 26 Aug 2025 18:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756258772; x=1756863572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4AKdjXrLOxo9mncoQI2YNKkWEnHyZxy+ck9GOSumq0A=;
 b=KA8iGHkfYi/1ztKwxq4HOp5IPtGwP1eNw3Nxg8OnN2US0vrIz1hcdFnmmAJIP20lt5
 UOIrwaXHaXB66bHxLtfirxlvqFQDkaZX8L5m29B00z6aeSIWHRLshh6l9oBohVEb24IQ
 AGSY4ve21aOGMSmKxlBdT+VycShiYX80G9U21jL36y353b/Q3wTT+cgoaPkLq7uIBGPb
 xaBNlP4U7TDvGyp5oIfclkcgn1v3dQDNndd07Ef1HOV4/joc/LPasg3Lg/JUFsjdf86G
 M7VVKhL7FOKVfxzUuZSqZIAiLNh3v6wjCotFpl2jwHca1zHJ/dqZHna7EMrB1CmLol82
 VCmA==
X-Gm-Message-State: AOJu0YxUTxRg8mvbTbSpsvbm28Uvvg92P/e4k9/OSPWeDSyWZXj8QabV
 SwbmY+VU2sNrBNxK2oK1zQ3qf3LWw18fU3SmIDdD0f1gAoekmh+hDJu4Hdw9K3eGho2DQNjPGoB
 iOUfKPoz6i4JN0AzOiFmMlF68J1eig9Ot0kbs63MG66c4+jmSWIRHchT6cx0ee/6I0K+8n/LdBn
 IT/1dPSZCUevs8V01DC1BxkDeTB7Y=
X-Gm-Gg: ASbGncvPnnoXwZx689P2Wvy/aLiqkHOsMrwhCc7M9YJI0lTB2y1iIyT30SiPsgt74XW
 jZON1uw8Exs8vKGY5fS8KjkO5a7rjJEvT6c5KGv3scUOPktrUKm3xVdsQNQ0pkHEK75el7sZ9Gw
 m2FnCoDxVA/gTfc24z8Ss3yg==
X-Received: by 2002:a17:90b:48c5:b0:325:8f58:f4d1 with SMTP id
 98e67ed59e1d1-3258f58f6f6mr13218329a91.29.1756258771642; 
 Tue, 26 Aug 2025 18:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsIdKKyWrJRjTyWoXgN4E7nn/Xb7QewIs6mWORmQwMAvRBDykUKlndIzfQWifVPghntG6OEnuLCcSAlnUy51Y=
X-Received: by 2002:a17:90b:48c5:b0:325:8f58:f4d1 with SMTP id
 98e67ed59e1d1-3258f58f6f6mr13218290a91.29.1756258771097; Tue, 26 Aug 2025
 18:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250826-upgrade_tools-v1-0-1e9d8d4c5e2f@suse.com>
 <20250826-upgrade_tools-v1-1-1e9d8d4c5e2f@suse.com>
In-Reply-To: <20250826-upgrade_tools-v1-1-1e9d8d4c5e2f@suse.com>
Date: Wed, 27 Aug 2025 09:39:19 +0800
X-Gm-Features: Ac12FXzxWHm_C4DDMEw4VceqncTcuvJbrjs824DS_1xS0Vu3xVi_hI_MqLAQFjk
Message-ID: <CAEemH2fy_xt2z=qAdWidRszE3b5d_ggz0rBjpgwKukepsEe0zQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yfhW6Dfa1dwHcpxK-YRmlOab1qKlyWkFQiNPH4gPVLw_1756258772
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] kirk: version 2.2.2
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBdWcgMjYsIDIwMjUgYXQgOToyMeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVz
YXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8
bGl3YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgdG9vbHMva2lyayB8IDIgKy0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdG9v
bHMva2lyayBiL3Rvb2xzL2tpcmsKPiBpbmRleAo+IGEyZDQzZTMwMjE3MWZmNjJhNzE3ZWMyNWVl
YmJjMGI2ZjhhM2ZlM2UuLjIwYjE4NzBiOTY0YzliOGI4M2FhMGE5Y2M4NjBhNWJiZDE0NjU1OWMK
PiAxNjAwMDAKPiAtLS0gYS90b29scy9raXJrCj4gKysrIGIvdG9vbHMva2lyawo+IEBAIC0xICsx
IEBACj4gLVN1YnByb2plY3QgY29tbWl0IGEyZDQzZTMwMjE3MWZmNjJhNzE3ZWMyNWVlYmJjMGI2
ZjhhM2ZlM2UKPiArU3VicHJvamVjdCBjb21taXQgMjBiMTg3MGI5NjRjOWI4YjgzYWEwYTljYzg2
MGE1YmJkMTQ2NTU5Ywo+Cj4gLS0KPiAyLjUxLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywK
TGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
