Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC678D358D1
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 07:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769671485; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kQI0GER9Qf9qQwYEHynjVOtG18B0RbKU4ybf33OPp5A=;
 b=kaQpLk58srPx7fg0pBy7Mfc//YxhwRAecNWsv+CoV8TDEn3vXWoJnAIwXSH1x7SLz0pZd
 /IhMxnYcaHRbMJ1Bs2GPj6+Wr+glfC3QFUfphB+QNmsBnsTxcuRXpzVRj2M8+3hl/w1Jk6P
 ADBAHhDFwyLECEpPPDQJ4IC5dcROTYo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3A6B3CAFD3
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 08:24:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4452A3CAF61
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 08:24:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 87EA61400772
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 08:24:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769671460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQTQvyMxKj0+cTfKycFyQBZ4xRQ7i7fjGV+9gmoRWfQ=;
 b=BvVwdBVM274bTpPhEtIq6U5cGaZgH2e7/H8qIbNKbdX9thnKOxw+oZc7CMv0rd3whP4SwC
 rJT4Ulu4cNwWdLzBmdhqjliJ2sBa09YRmCZb9wFm2K9ey2C2s+iUybdvM5rCjxyF09EEA8
 yH71pvKHE/I3guApRrr+1DevRvAU5H0=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561--QpyfogVN92q1QixVdUdzA-1; Thu, 29 Jan 2026 02:24:18 -0500
X-MC-Unique: -QpyfogVN92q1QixVdUdzA-1
X-Mimecast-MFC-AGG-ID: -QpyfogVN92q1QixVdUdzA_1769671457
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b6b9c1249fso1069160eec.1
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 23:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769671457; x=1770276257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nQTQvyMxKj0+cTfKycFyQBZ4xRQ7i7fjGV+9gmoRWfQ=;
 b=hjfOoE4PUD7olTBfFZsRoxdSrqEzrr8Wz2bcC4DYPCm8FuYey6wF7qKzuOBCF5Oybp
 jZZQ1uqva0jOZwCr6ydzbP5zi+VguDohwQhhCkq3E62HG2JL4ifsJ2tc/7hsSVDdFI4E
 NK49Z+zBeuE0JKLZAEVZRLrWEUB4SnOiocJ5grUEtNL3q0WSoOGAPvw4TuHq77QEIAV7
 ioXJVBzlmeWHjtQvtOGb9QFcDO5QyOM+T0U5eNm6xYP1piJPKjUVkcgqu+72AzVugysQ
 jmP2T5XTa5QQByQRc4qpSPW97TcjkVT5ek8sQLh9vH5yVZFvbnbGab3EOawHpDWw0Csr
 w53Q==
X-Gm-Message-State: AOJu0YxVYGpKwNeGuQc+CHOsClGjPjCbIx79N6AbcoHudLMWpKcSs8tF
 GyWXYsfK+ywcEP+RTdheoH3JmmPCLgcXQogpeNIgg3J6G1hKyrJPN7PEEqLsq4/fL9UuxOWp2zi
 zKqvQBXQMAfO8ygylNtEOQT3R+O0zNzw88ZWdxQHOidYJzeFlkuOn3BeayGY+Ne/DDQq+1kT44U
 N94pa0VKKnIaBtfl4RC3x2ChL7cNE=
X-Gm-Gg: AZuq6aLaBp4ulFLVIZoVlHQFtzAaZPDlwLteDHK9YTwOLmylHsD/7jOBr8pJwZCSRCp
 rOAFX0ScjPp8HZ6z1tZxmwSyEMsTfgP0orTfd43CnDnGMtl0EztaWhS7s7fcYr9WP6djPhZFWs5
 K5BmV83hDDQKhOLcwamaXy/jZZrOlTdByIAYExWFMb+0lE27uEan6lwIuOFu0uC64ap88=
X-Received: by 2002:a05:693c:40db:b0:2b7:97b0:82b3 with SMTP id
 5a478bee46e88-2b797b09390mr2462815eec.5.1769671457233; 
 Wed, 28 Jan 2026 23:24:17 -0800 (PST)
X-Received: by 2002:a05:693c:40db:b0:2b7:97b0:82b3 with SMTP id
 5a478bee46e88-2b797b09390mr2462807eec.5.1769671456728; Wed, 28 Jan 2026
 23:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20260128080121.18878-1-pvorel@suse.cz>
 <20260128205044.GA58055@pevik>
In-Reply-To: <20260128205044.GA58055@pevik>
Date: Thu, 29 Jan 2026 15:24:04 +0800
X-Gm-Features: AZwV_QhIaf3qCf3bDwfU-mOFsXbA87vqct4HftWY80T8BV21poPjAiliwbmb9Is
Message-ID: <CAEemH2fc_C_vGnKtbYqsMzMVKLSNLhCFWLGemSyVTWBzAATDCA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mwxNpIkB6fyT9xI1DO7h91ONIoPPtozIumymvDFl-UE_1769671457
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/ground_rules: Add Kernel features check
 rules
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

PiBJIHdvbmRlciBob3cgYWJvdXQgLm5lZWRzX2tjb25maWdzIHZzLiBuZWVkc19kcml2ZXJzLiBE
byB3ZSBwcmVmZXIgYW55IG9mIHRoZXNlPwo+IEkgc3VwcG9zZSB0aGUgcnVsZSBjb3VsZCBiZSAu
bmVlZHNfZHJpdmVycyB3aGVuIG5vdGhpbmcgc3BlY2lmaWMgZnJvbSBtb2R1bGUgaXMKPiBuZWVk
ZWQsIC5uZWVkc19rY29uZmlncyBvdGhlcndpc2UuCgpIbW0sIHRoaXMgbG9va3Mgb25seSBiZWxv
bmdzIHRvIHRoZSBzZWNvbmQgc2VjdGlvbi4KTWF5YmU6CgogIC0gVHJpc3RhdGUvbW9kdWxlIGZl
YXR1cmU6IElmIHRoZSBmdW5jdGlvbmFsaXR5IGlzIGNvbnRyb2xsZWQgYnkgYSBLY29uZmlnIG9m
CiAgICAgdHlwZSB0cmlzdGF0ZSAoYHRyaXN0YXRlCjxodHRwczovL2RvY3Mua2VybmVsLm9yZy9r
YnVpbGQva2NvbmZpZy1sYW5ndWFnZS5odG1sI21lbnUtYXR0cmlidXRlcz5gXyksCiAgICAgaXQg
bWlnaHQgYmUgYnVpbHQgYXMgYSBtb2R1bGUuIE1vZHVsZXMgY2FuIGJlIGFic2VudCBvciB1bmxv
YWRlZAphdCBydW50aW1lLAogICAgIHNvIGNoZWNraW5nIHRoZSBLY29uZmlnIG9wdGlvbiBhbG9u
ZSBpc27igJl0IGVub3VnaC4gSW5zdGVhZCBvZgoubmVlZHNfa2NvbmZpZ3MsCiAgICAgcmVseSBv
biAubmVlZHNfZHJpdmVycyBvciBhIHJ1bnRpbWUgY2hlY2sgdG8gY29uZmlybSB0aGUgbW9kdWxl
IGlzIGxvYWRlZC4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
