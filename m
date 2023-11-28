Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB21C07E97
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 13:58:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20BB53CDB6F
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 14:58:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D4A73C88DB
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:58:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9EF5214000E5
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:58:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701179918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pof1k06P68NWBEN7tDhpErru4t1NWmSZYWazYwfq+Q4=;
 b=KUSJr8HjOrcfSqb/EZsGjNBrBooUqd4ai5qqA3SC0Nix9kd7eW36ixGMR19K02afQEgNe8
 XUS+k6xrqdPvoIrmFuG6O5NSSXolSM4ltVaQ5lB7mejRYxLquWc0cuDS0lhtm4nqtUqedx
 hLP7zo5Rau7YC39wOIfULCJkExW5Iec=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-XEmJ_JEKPWODjagtZ8RQfg-1; Tue, 28 Nov 2023 08:58:36 -0500
X-MC-Unique: XEmJ_JEKPWODjagtZ8RQfg-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4b279f28ddeso149459e0c.3
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 05:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701179916; x=1701784716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pof1k06P68NWBEN7tDhpErru4t1NWmSZYWazYwfq+Q4=;
 b=hNBLS3TAj7tS7uwKRhKzupRldbLJ5YKDl6p+feUoEXWj04iDFEz2lnxsxO5hJwk1Io
 FNdb9EoDz+EHMiqOte4HcZuC+Qojtrenc0ZpMFaE+hzlMcdQ1J8LlQYJokPoJzaHlr1b
 EEJOhFRCCgTudjxYVjUHftwue5qUtzM4o072peoDlyCOGss3PMRk/1muM2rFMuRxv+2N
 Vc0m2n70bbAhsICmEV96qdxUI5rUBuUTIsMapArnpzzjvttEnrWJyDVAahUaICmcoT84
 fV6CDk0/A8xdyk4uXeTo/zCjZ1kslMJ+IvkphN6KX28ZOqnpdKfX22idAMyqOGnr35+J
 0+9w==
X-Gm-Message-State: AOJu0YxZkbLeBERE3o5XbRtDmSYx7YnDkx7nBGfFzA1w2fhDYCPzi+bo
 aUU3jkusu8Lqe4ZQjudEpVJFKBXPvZGVmUd9pkkdAXh9t6KDzD9+IYd7P9EN/DP11/+xG9dYok6
 0LLdvzkJDhFB7lnjL18hrs88l9zQ=
X-Received: by 2002:a05:6122:3106:b0:4ac:22c7:89d5 with SMTP id
 cg6-20020a056122310600b004ac22c789d5mr10441178vkb.2.1701179916255; 
 Tue, 28 Nov 2023 05:58:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR+7/ulOTDv15QYixKYOMroQ/rSOvLVR45cnsjnzsd9Ke8vgW6uZi/CEIc3USwzNWJxf6A1saQq4bwQy7POhc=
X-Received: by 2002:a05:6122:3106:b0:4ac:22c7:89d5 with SMTP id
 cg6-20020a056122310600b004ac22c789d5mr10441166vkb.2.1701179915895; Tue, 28
 Nov 2023 05:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20231120154842.17037-1-andrea.cervesato@suse.de>
 <20231128125919.GC381183@pevik>
In-Reply-To: <20231128125919.GC381183@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Nov 2023 14:58:18 +0100
Message-ID: <CAASaF6xTTexWFo1720V4EDDL7hpn8d-gtO-49a2r-mCjpy3T9Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Delete getdtablesize01 test
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

T24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgMTo1OeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEFuZHJlYSwKPgo+ID4gVGhlIGdldGR0YWJsZXNpemUgc3lzY2Fs
bCBoYXMgYmVlbiBjcmVhdGVkIGluIHRoZSBlYXJseSBMaW51eCB2ZXJzaW9ucwo+ID4gYW5kIGl0
IGhhcyBiZWVuIHJlcGxhY2VkIGJ5IGdldHJsaW1pdCwgd2hpY2ggaXMgbm93IHRlc3RlZCBieSBp
dHMgb3duCj4gPiB0ZXN0aW5nIHN1aXRlLiBGb3IgdGhpcyByZWFzb24gd2UgZG9uJ3QgbmVlZCB0
aGlzIHRlc3QgYW55bW9yZSwgc2luY2UKPiA+IGl0cyByZWZhY3RvcmluZyB0byBuZXcgQVBJIGNh
biBiZSBjb25zaWRlcmVkIGEgd2FzdGUgb2YgdGltZS4KPgo+IEFja2VkLWJ5OiBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4KPgo+IEknZCBsaWtlIHRvIGdldCBtb3JlIGFjayBmb3IgdGhpcy4K
CkFja2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
