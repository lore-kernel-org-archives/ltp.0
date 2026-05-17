Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786AECD4F4A
	for <ltp@archiver.kernel.org>; Sun, 17 May 2026 17:13:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67FDE3C2953
	for <ltp@archiver.kernel.org>; Sun, 17 May 2026 19:13:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C85613C2953
 for <ltp@lists.linux.it>; Sun, 17 May 2026 19:13:10 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 54D276001B2
 for <ltp@lists.linux.it>; Sun, 17 May 2026 19:13:08 +0200 (CEST)
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so733852a34.1
 for <ltp@lists.linux.it>; Sun, 17 May 2026 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779037987; x=1779642787; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkCgxYTJ8O5Ly/nketyCeJ68HWWF4wTcQB/2G5XsWjs=;
 b=l+wwD2ltsRs7x5FfoWDGj6+cY9LXqrMt0r0Ij7tcQIbJUqlHMLd+cKIhsh4zDrB8zM
 CR43X521mSiLslvkYSK2I8etnUhSrNVRH3Ku+7g+flChY0xFyBnvXeY3vFkFhdEFVbPQ
 aiaqrmuTBpIDzl+4p8zttV1342Eswiqo+XSrodaqCg0gnige6XQvPlLfq0q5TM+I27St
 zQTdhd6fEFtkJjgbMKgFtWAK3rpPJF4A0fHK0njQyC5qq6qDaf0YVfIdipj1T3pcP2I5
 APC8zfpA3IhlaikOv5hrN+G/1am6QLbNUCfUXGl9xsj4hSgnaFuKatVU1q4NzddMe8iD
 nUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779037987; x=1779642787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bkCgxYTJ8O5Ly/nketyCeJ68HWWF4wTcQB/2G5XsWjs=;
 b=tFvmr9oRn/B1zcdp4/zYaa5twGbodhT6prIBrQBIzLxXg9mD83ZiWF68pD6r1RznK0
 LWU+hd9qwYz8ls1YctR4auMyLewjCHV5rJYrUYsdzbRuyja84PftaPsydM8h1c14TDBn
 O32llzTWP7u23Ji1z88+1OIBhQu4gTvW8BXdn6HFQw0IrWGcuQkJbs5DxxPRgV8zRXDF
 zp81zy7SjKyzZUjgb6dU7w3+A3Ppakc7aVasXbyARX1jgmN57cYDKd+Ce7LLWFpmwa8P
 lE5LlEQvP0XTxy2pJDZWAnvjVxl7c0ALmXzfVYcm9AsvFvw60rx2gD5NBKu5p0gyByLV
 pj5Q==
X-Gm-Message-State: AOJu0Ywa5vgITRlAtEY1GiDIX1oeAY/esiGBpblFRKLV58WcBEOt9Ccc
 u0D+tBcAEGt9O3dzJCTt9VvYwTF13N9skg2FZvEXbu9bbU6FB1f32vRn
X-Gm-Gg: Acq92OFtrwVRuayvOxfO0K8J54t44nv04EK9LWFDvX3zfQqzlTBVCH/ohLdRCO/vt9e
 qAzEMdaRfq4MXhpt00GUUDwFjGe9XOIc5H6HT3a3F6CYXWFa7yTDNGtBo0sYftfiRtSimq4/PoB
 OFVA7lR44g8l4pvjA2HOUR1I2fHAbMQmwyzn9hfOqDuhWfx7tyop25LgtQMbb9oeaVfSo7S3LQ7
 UixLUDFuhtm0MQXlhdIKKxtzIuuI3kBqt7N8eWZeA3zOpB4YaR7u/yKjh2fK3CUa9o2kw/7mFTC
 PIyTl4+OOTLsYODngs3+JwJkWK/tUdJKOWufeZKSmd34TYe+OcgKJMwUmq4driwCG+uxVW+zz6j
 m2yFO94iatL213hA7W/xJSrtyIwQBCr4sOG+HUnJPGieuvVMEgY0UzBWeY1I6BKmyvuZQV8cD6c
 BSoIjBioELaIpy+ETz1jlRBmvn2kvNdC5YuaRBkxVYu665Nw6RAeTVe3PSwwYM8H825jSvYtftq
 TflYcvRxFCpho68o1AD1Em5S1LZEoaocBt2Xr45FuDwujFjDzwH
X-Received: by 2002:a05:6820:1f06:b0:686:48b7:d822 with SMTP id
 006d021491bc7-69c94372dadmr7366252eaf.39.1779037986728; 
 Sun, 17 May 2026 10:13:06 -0700 (PDT)
Received: from
 runnervmrw5os.zjjzc5dizynenb0vrs4axiekve.gx.internal.cloudapp.net
 ([130.131.195.137]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d049384f6sm4377794eaf.14.2026.05.17.10.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 10:13:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Sun, 17 May 2026 17:13:04 +0000
Message-ID: <20260517171305.4052-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516200015.12689-1-always.starving0@gmail.com>
References: <20260516200015.12689-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] power_management: rewrite runpwtests04.sh in C
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

SGkgSmluc2VvaywKCk9uIFN1biwgMTcgTWF5IDIwMjYgMDU6MDA6MTIgKzA5MDAsIEppbnNlb2sg
S2ltIHdyb3RlOgo+IHBvd2VyX21hbmFnZW1lbnQ6IHJld3JpdGUgcnVucHd0ZXN0czA0LnNoIGlu
IEMKPgo+IENvbnZlcnQgdGhlIGNwdWlkbGUgc3lzZnMgc21va2UgdGVzdCBmcm9tIHNoZWxsIHRv
IEMgdXNpbmcgdGhlIG1vZGVybgo+IExUUCB0ZXN0IEFQSS4KPgo+IFRoZSBuZXcgaW1wbGVtZW50
YXRpb24gcHJlc2VydmVzIHRoZSBvcmlnaW5hbCB0ZXN0IHNlbWFudGljcwo+IHdoaWxlIHJlbW92
aW5nIHNoZWxsIGRlcGVuZGVuY2llcy4KClRoZSBjb21taXQgYm9keSBuZWVkcyBhIHNlbnRlbmNl
IG9uICp3aHkqIHRoZSBjb252ZXJzaW9uIGlzIGJlaW5nIGRvbmUKbm93IOKAlCB3aGF0IHByb2Js
ZW0gb3IgZ29hbCBtb3RpdmF0ZXMgaXQgKGUuZy4gb2xkIEFQSSByZXRpcmVtZW50LCBDSQpjb3Zl
cmFnZSBnYXAsIGV0Yy4pLgoKWy4uLl0KCj4gK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gK3sK
PiArCWlmIChhY2Nlc3MoQ1BVSURMRV9QQVRILCBSX09LKSkKPiArCQl0c3RfYnJrKFRDT05GLCAi
JXMgaXMgbm90IGF2YWlsYWJsZSIsIENQVUlETEVfUEFUSCk7Cj4gK30KClRoZSBydW50ZXN0IGZp
bGUgd2FzIG5vdCB1cGRhdGVkLiBgcnVucHd0ZXN0czA0IHJ1bnB3dGVzdHMwNC5zaGAgaW4KcnVu
dGVzdC9wb3dlcl9tYW5hZ2VtZW50X3Rlc3RzIHN0aWxsIHBvaW50cyB0byB0aGUgZGVsZXRlZCBz
aGVsbCBzY3JpcHQuClJlcGxhY2UgaXQgd2l0aCBgY3B1aWRsZTAxIGNwdWlkbGUwMWAuCgotLS0K
Tm90ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBm
dWxsIHJldmlldyBjYW4gYmUKZm91bmQgYXQ6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0
LXByb2plY3QvbHRwLWFnZW50L2FjdGlvbnMvcnVucy8yNTk5NzI4MDE4MQoKVGhlIGFnZW50IGNh
biBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZp
bmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBw
bGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdh
cmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
