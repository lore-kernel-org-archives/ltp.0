Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A5EC3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 08:47:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936063CD5B7
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 09:47:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F27C43C8B55
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 09:47:17 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE7EF6009D6
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 09:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704703635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h8/UtGVcpq1NybE/XaMuViHKT5wM/epcwmXv3SU64MU=;
 b=akvmJ0bpuiqY75pFr6YG/g6ceEFO8NaItaGUCPZ/A1Dvt4pGFgeFEhKg6Gxk++Xk4boAcK
 BjQD9RwqONKYBVsEQ5ZNK608/nR8XGDo056Al6YphIBMGZtnxGZr6gDP/OeJ+uepDof7C0
 /34sRXdFlI2vzYcgHl60jGN+9Y5sUTs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-x9oMDWgAOvC4xKKsPxb1ew-1; Mon, 08 Jan 2024 03:47:12 -0500
X-MC-Unique: x9oMDWgAOvC4xKKsPxb1ew-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ccc7c01bd7so10477711fa.0
 for <ltp@lists.linux.it>; Mon, 08 Jan 2024 00:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704703631; x=1705308431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h8/UtGVcpq1NybE/XaMuViHKT5wM/epcwmXv3SU64MU=;
 b=hivxC8PsmyYmIrjCDaFI9XaojvjRpGoDS/lIDXPK6ENDeVIcULhjFNP6wuGBLr+wUB
 qSjtayvCvCQwFkMdn4DdQRZxoXPHMvk4zk0MlDUzHOL7lKbU6M9hi2Uw1OToPURcqKZO
 PnfPiKHlscKG+ny5q5JthXl9JpY/ApZLXsfwERZLYwNqKagZglG+tSRydmMNopO0OYPh
 VsDWXVfLhKR3ml7JSkMfs6SC6VdUYc2iRFHWjByEqdT/vUeB+qNuvnebX42FUw40h9TF
 n90tNmEE7V8xiPLIvcmADJQKmEdaGCDmE1fF6k2aYJjH6z4XEjUtPf8R5Qw/W2S1d3tp
 AtBQ==
X-Gm-Message-State: AOJu0Yxn5QqKQlMYnTeqlYRnQWS5iqi85e6vLVDwKfTHx669asP2mO5c
 hb0dpzfg4q2eshlA8RL284YGHYj4uvefQj0LqH9DC57SQrf3FL/6jSXL3S/VslXiTArYuaVCSui
 O1UNzQN1vmQ1CyaE04//agmNtk85Og7nWGFM=
X-Received: by 2002:a2e:a553:0:b0:2cd:4f3b:d0bb with SMTP id
 e19-20020a2ea553000000b002cd4f3bd0bbmr736201ljn.8.1704703630960; 
 Mon, 08 Jan 2024 00:47:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuYpFvYHzkdU86RTl2EtJ50/scWaj1JeW3xXUdPY+P7Fv16LkXPb9jLALjvaJADV6rD2Zr2DBf9OIHZMQztoU=
X-Received: by 2002:a2e:a553:0:b0:2cd:4f3b:d0bb with SMTP id
 e19-20020a2ea553000000b002cd4f3bd0bbmr736198ljn.8.1704703630672; Mon, 08 Jan
 2024 00:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20240108012252.2496776-1-lizhijian@fujitsu.com>
 <20240108012252.2496776-2-lizhijian@fujitsu.com>
In-Reply-To: <20240108012252.2496776-2-lizhijian@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Jan 2024 16:46:58 +0800
Message-ID: <CAEemH2eOGARwTdaQuy7O_LsgaNtt3dMH1+zvvYvNgPSmYQQ6-w@mail.gmail.com>
To: Li Zhijian <lizhijian@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RESEND PATCH 2/2] lib/newlib_tests: Add missing gitignore
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

UGF0Y2ggYXBwbGllZCwgdGhhbmtzIQoKT24gTW9uLCBKYW4gOCwgMjAyNCBhdCA5OjIz4oCvQU0g
TGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPiB3cm90ZToKCj4gc3RfcmVzX2ZsYWdz
IHNob3VsZCBiZSBkb2N1bWVudGVkIGluIC5naXRpZ25vcmUKPgo+IFNpZ25lZC1vZmYtYnk6IExp
IFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4KPiAtLS0KPiAgbGliL25ld2xpYl90ZXN0
cy8uZ2l0aWdub3JlIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2xpYi9uZXdsaWJfdGVzdHMvLmdpdGlnbm9yZSBiL2xpYi9uZXdsaWJfdGVz
dHMvLmdpdGlnbm9yZQo+IGluZGV4IDAyNTZiZWY3NmMuLmE2OWIyOWUyNGEgMTAwNjQ0Cj4gLS0t
IGEvbGliL25ld2xpYl90ZXN0cy8uZ2l0aWdub3JlCj4gKysrIGIvbGliL25ld2xpYl90ZXN0cy8u
Z2l0aWdub3JlCj4gQEAgLTU2LDMgKzU2LDQgQEAgdHN0X25lZWRzX2NtZHMwOAo+ICB0ZXN0X3J1
bnRpbWUwMQo+ICB0ZXN0X3J1bnRpbWUwMgo+ICB0ZXN0X2NoaWxkcmVuX2NsZWFudXAKPiArdHN0
X3Jlc19mbGFncwo+IC0tCj4gMi40MS4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
