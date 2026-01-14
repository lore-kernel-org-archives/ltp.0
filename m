Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C36D29FF7
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 12:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768393152; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WMHkR4Iv9WezsQ+i8stheKP9TPgQwBcs/u/Fyj+uO/4=;
 b=FWYzB8tlY6XfOLUYSZJAwuTKHvxyP73FvpRS4rPd9uW27vyqh3uWm+pPSzR7Vpkb2b3sU
 DGyquDgQXNcyEOntYqlsgIKMjSZGv/kVXkhto81Pcfi+0a5A5yGcbBs9NcsX7IEl3iEWdfB
 bYtyYFW934oQltCeJBZwQlFwhU7rDyM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BBB13C9A81
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 13:19:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E18AC3C01E9
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:18:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59C6A200AEE
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:18:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768393125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5pLSZt5Sh11T8Q1fWT/Wg+93Be0qlm3VAARU+rzXx84=;
 b=icI51YhqrYKvzS3sm+gPGzqe839xR3uWVpzRnU4SRv3WyQiqzxNHCteTNcXNCXaXLgeWUo
 fbXnNCQIxJSp02nACjf0mZteasUzOQ1ICMOl6cjiWChNBDXY9zfiOGzjSXD21iW9EfpO1K
 eN5ufnsABHliBgxJOsqtOJ9wZRTvtDg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135--onhjKJbP9SYkNqMWtBcxw-1; Wed, 14 Jan 2026 07:18:44 -0500
X-MC-Unique: -onhjKJbP9SYkNqMWtBcxw-1
X-Mimecast-MFC-AGG-ID: -onhjKJbP9SYkNqMWtBcxw_1768393123
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee868f5adso2120335e9.0
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 04:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768393123; x=1768997923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5pLSZt5Sh11T8Q1fWT/Wg+93Be0qlm3VAARU+rzXx84=;
 b=V1Im0cQPW5HDrA8AD3c5tL6Mkjq038hO7fNa5y2aZE8NZsKMMrn6HQh4ZvKB7ifu0N
 cFSTnsDusAKO+D24pRQSFdfrHmjdWSutR4ZpWXwoQuezvGLS1IGejgh9ISrUw64sKAUQ
 M/p5OeppewEYX+sWRVBG6FZg/iCg2hdPwNRijMCxDw3yA+iVw2yPv4uioHrMK/TZvnMR
 Nso8kEhnrTMoEdaTGY+YKaKH2l2fAowpG4DKO+gXlT8iMR3ILo+7vp2JB3aAoQYd3lGs
 SxhtU1r7JeOdiRNVT0juBSnI127ROi+qYyItYz8WXhhfqxLzxMCW4rcQmIWDWTtSFbbW
 d9Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbebh6H2BPvaKaRyl94OyesghB/PQOxyPod99GAkvcRoovKOAQ3OFWHlln01wKWX4qj80=@lists.linux.it
X-Gm-Message-State: AOJu0Yy3ofFYIBtZsMbHBxnbmUWqoPysdhO5DuA+7I+rafmlpXcDQsQc
 7fPNDhwR2AHiWecrP9doISFsf4BVOterRDyOZP/8hAcRR+mMSzM0FiBYZqSLWzy1wImm9/KJzMn
 ObF9runQDmuKBSkbEVi1CJmjtA8/z9CBc87ENTvHT7Gb3/jITRWe3TTLO8Vjs1Hry9IJmOZvPSG
 7Y3Yw/NUtgNnb9wlcHgGb6CAk3TRo=
X-Gm-Gg: AY/fxX4T/7BhsgLejGlS/duOe3sMog6hBUZ6ymHvVpFRnJlOtg/2BB3jFM0lkOLtgvT
 SRwqvsojrHb9T6bsptn77H2Jxc4NjyKYDHnYyy3yB7bfmlVrCK8xlN05/AdDtrQlI/DUO/gSdAd
 akCP1VzKh84VdKZv7GmRI84VJ/gNMy9wlHGeN8EQ4TOFWoEqrfzNHB9p3hov/YkMjVxQ==
X-Received: by 2002:a05:600c:19c6:b0:477:97ca:b727 with SMTP id
 5b1f17b1804b1-47ee3391765mr31385735e9.19.1768393122965; 
 Wed, 14 Jan 2026 04:18:42 -0800 (PST)
X-Received: by 2002:a05:600c:19c6:b0:477:97ca:b727 with SMTP id
 5b1f17b1804b1-47ee3391765mr31385385e9.19.1768393122569; Wed, 14 Jan 2026
 04:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
 <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
 <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
 <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
 <20260114085116.GB334250@pevik>
 <CAEemH2e1MVNjLJR+_h9Bvkk3b0roVxhtJRvedFhxH4ckzhW==A@mail.gmail.com>
 <20260114113349.GB344144@pevik>
In-Reply-To: <20260114113349.GB344144@pevik>
Date: Wed, 14 Jan 2026 13:18:26 +0100
X-Gm-Features: AZwV_QhTxLom0i0MQ5iBcEPnNKrBFzW5-hFLlw4uurXHyahwf_R41rOum5QQo6U
Message-ID: <CAASaF6zy-rtVAZJ+-bXPTg4JsEFU-LcukQDUQoU8Dc-qJruKhA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MCN58EPbMyf0EZZf-0kv9JXS6ndauAoQkFgNma_DQFs_1768393123
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gMTQsIDIwMjYgYXQgMTI6MzPigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+IGx0cCogcHJlZml4IHNvdW5kcyB0b28gc2VyaW91cyB0byBtZQoKbHRw
eF8gPwoKPiBJJ20gbm90IGEgYmlnIGZ1biBvZiAnbHN0XycgKEkgbWlnaHQgbmVlZCB0aW1lIHRv
IGdldCB1c2VkIHRvIGl0IDopKSBidXQgSSdtIG5vdAo+IGFnYWluc3QgaXQuICBJZiB3ZSBhZ3Jl
ZSBvbiB0aGlzIGl0J2QgYmUgZ3JlYXQgdG8gZG9jdW1lbnQgaXQsIHNvIHRoYXQgbmV3Cj4gY29u
dHJpYnV0b3JzIHdpbGwgbm90IGhhdmUgdG8gdGhpbmsgd2hpY2ggcHJlZml4IHRvIHVzZS4KCk1l
IG5laXRoZXIsIGl0J3MgYSBiaXQgdG9vIHNpbWlsYXIgdmlzdWFsbHkgdG8gInRzdCIuIE90aGVy
cyBJIGNvdWxkCnByb2JhYmx5IGdldCB1c2VkIHRvLgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRy
Cj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
