Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28EAC43458
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 02:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782872841; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GUgFX+YfKAl+BZfohPYpzg+SGBd0CmEJ5SVKE1Oy7o4=;
 b=FCOvLJD4Js6nlgazn4gNYag2PgXDIOq8e7jih6ASLhj+BuK/gcHNEgtpLdiuGOslTCCW4
 fxxOwHznFt+GkC+AXFFGXH7FsSO3NXdhFb88AcA0x2UJxV6xl6Q4ns3hroNXRdNrfzDYoIx
 voqKVM9FiyCO/iDn/VaD4NcHLTkp4qY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3ACB63E5F42
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 04:27:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 720A93E52A4
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 04:27:02 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 18B96200059
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 04:27:01 +0200 (CEST)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-847968ca62fso152587b3a.2
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 19:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782872819; cv=none;
 d=google.com; s=arc-20260327;
 b=hRWVICEdH4CwFqrg6XRFzpmN5Lo15TwXNUiD3Ap5Qz4NtN5Op+QHN08Icr4Pm0IUtO
 aPOrRAJsOoj9y6zvmBBrqSvDvCnDpuYy0vQQDsmET83JTv399pXZ0KQemMgFeyc4o87Z
 ZAJdzQ5SMvqShPkT5ZC4ZlklqEtRTOoerT8L/l90QJkAMi1Jj3DNCMGndVzPSnz5+tbB
 nWDCZ0yhJteNEodgr8UHvQSG+0aeBqFX8TYKLLEuJgBlJpU+oSFxeE71d0vI0CxynWIM
 SndNT5MQh6tOL7r+RM8o1ZngH1WZ9Xh0OkylrKvsFOyHyCznmK635D5MC0OYXJlPsJyr
 iRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RAhAWW4JUhvWhFve4dExeiuIMFRUkq1eJXionXx0baE=;
 fh=yNnHK/muh3qjqGkDDou4X1TuMKHBb3SuKBvJsAk8mAY=;
 b=KBUVX9HFWVawZ/MIpMQzCl008NfT8r4KQgKEttNWGxmT2DPk/JjY+HnfEWqlSQ7KIn
 PvXf2/02QbkqLQvyWdZF9FI9pfHeEg34ikkG/3mDx2t9pVjlxwknSlSdhMqRCNWfkD7d
 vyaOa0ossePBPs2t0HURPBceE2cTr60LergFtiWrMkNseC63cv9HCmjjpvml7dZTsB9b
 K4iRqqmEt6V75rL1LGJDFPbjqg1cYXgJVbtmP8ghQnCL8FXyyUqDf07H3rfhnaMCpp4q
 pXGcu3Xb1OsSW4gjNfD7lbZ4RrIYNEE7Zf/03Hp/rE57PnVBkWL/fH3Rx9Ti/rc94A0K
 RCOA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782872819; x=1783477619; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAhAWW4JUhvWhFve4dExeiuIMFRUkq1eJXionXx0baE=;
 b=mbVWUdoS27Xj3XlXkby88cSvJHtwGbUpCAmq+6k+8GehDQhSRBIE9u2FXyK+o6Ow8n
 zdPl5/XeDPj9tu7YRUa/D0P3fRKjdEWbtMaFTDoC3fhMl2u/aya/DEeYAXa/FLtwZMR3
 iUQTaloc0Wrol83ToKvymzj0PPsrJtb2Yj0vpYpnrDd9vkPrxtInTUZH5370a0R3rlmI
 C50GtDDGY+JcqsqzAlKNWLhR7c3QY9M/tQCerdVbCao6Bohw+JkaZ5/gq+78nJ/oi6ZO
 MJuUNovBpm7NQP1M5ylC6EGbaxpEe30cBMiCrXEq5MJ23kSpidcrL3PHG4iEFdYsDqxz
 Iasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782872819; x=1783477619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RAhAWW4JUhvWhFve4dExeiuIMFRUkq1eJXionXx0baE=;
 b=UrfBC/NgMYDWXpuJvMHdeJ8gyHuemIBOs0IZ9RdUCuDIdmEFLvuFh8yltazS7T3/gn
 cLCQ/raBeAyKwGHnG/we6eRbMpkVIxkYnHQxV7Uf9bYsSoFOocg5XPxgWrvD88n74iJP
 GVEypDu2X9rnUreuKfC1kzY55iNQrbQh8unZiYReisoRrLgodJngKcWI5BMqagm64jJM
 aBGCGc5h4pl5BtY4b/j0nVSqP73t7P5nKYCJvD825YQJx+F8gxr3/6fG+i3/KhT/ODn8
 i/vgp5w4RKmLLqn79lZqXsr7Ip/ukeaabAmXe89Nw1xcMIB5MSWw4j8zlenFvQQlSyQc
 L7kg==
X-Gm-Message-State: AOJu0Yx6kFdPBvpxczntFyzTtmFvFVUAEy4K8rtrED9HzqXwnratMYWF
 b6hN39plVHblHb/mb+74en7ND1DJeQUqqxw+1XPECQHD2l0rQp9277fdgaYK5yN23CXdNVKSvVT
 tZoGzqzv8JKyh7yC7Rzqo9nsXtvtti3UwqABSpbA1
X-Gm-Gg: AfdE7ckehUlP6av1f5p3k4OmHRhwlKDI3lmk9nMuvilt1QVFkX1t8YZK7bre5VQXFw4
 XulLS87kHhKwMbBRQasBJp0fGAEyJ0qmsr2ZdRhXtuN/7v2CI04X814Bx0sd9+K6pGknNm4Y2nw
 n4OO7N98S1S9oemvV93s53Uvb9dkDcIVPfhG0c2CYQRfD81nWUuNdpAz/U2VlDXh3mAZhPLsfrB
 3LBoRbbDfweeOcEhGoBs82lhkPXy/PVszOwE3u/iBviZZ+gpW2IrpFHYKLhdt/i7jWVB+QxMgGp
 PSTYFLmcrwNbD7EUBsnJ3wtqYSk=
X-Received: by 2002:a05:6a00:1253:b0:845:e2da:91a3 with SMTP id
 d2e1a72fcca58-8479f27b323mr4822949b3a.30.1782872818722; Tue, 30 Jun 2026
 19:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260630071639.2248082-1-wakel@google.com>
 <20260630080916.GA225459@pevik>
In-Reply-To: <20260630080916.GA225459@pevik>
Date: Wed, 1 Jul 2026 10:26:20 +0800
X-Gm-Features: AVVi8CfsYDiFjgiC2or3sTNNye88HLKf-ar94ymYxipD1qpeWDETxr9c7WK-09U
Message-ID: <CAOcRiAGKOhdvnK3OUDeEMZRNKspSaqPjdO1KNync-QutxCCz_w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test.sh: Replace GNU word boundary \b with \<
 in grep
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: ttritton@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKT24gVHVlLCBKdW4gMzAsIDIwMjYgYXQgNDowOeKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+IFRoYW5rcywgbWVyZ2VkLgpUaGFua3MgZm9yIHRoZSBm
YXN0IG1lcmdlIQo+IE91dCBvZiBjdXJpb3NpdHksIGluIHRoZSBlbmQgeW91IHBsYW4gdG8gdXNl
IExUUCBzaGVsbCB0ZXN0cz8gQWx0aG91Z2ggc2tpcHBlZAo+IHRlc3RzIGRpZCBub3QgbWVudGlv
biBhbnkgc2hlbGwgdGVzdCwgd2UgZGlkIG5vdCBleHBlY3QgeW91J2QgYmUgcnVubmluZyBpdC4K
PiBGWUkgdHN0X3Rlc3Quc2ggKGFrYSAibmV3IEFQSSIpIGlzIGJlaW5nIHNsb3dseSByZXBsYWNl
ZCBieSBuZXcgInNoZWxsIGxvYWRlciIKPiBBUEkgWzJdIChvciB0ZXN0cyBhcmUgcmV3cml0dGVu
IGluIEMpLgpXaGlsZSBBbmRyb2lkIFZUUyBtb3N0bHkgcnVucyBDIGJpbmFyaWVzLCBzb21lIHRl
c3Qgc3VpdGVzIChsaWtlCmNvbnRyb2xsZXJzLm1lbWNnX2NvbnRyb2wpIHN0aWxsIHNvdXJjZSB0
c3RfdGVzdC5zaC4gU2luY2UgQW5kcm9pZCdzClRveWJveCB1c2VzIEJpb25pYyBsaWJjLCB3aGlj
aCBzdHJpY3RseSBpbXBsZW1lbnRzIFBPU0lYIHJlZ2V4IHdpdGhvdXQKR05VIFxiLCB0aGlzIGZp
eCBwcmV2ZW50cyByZWdleCBwYXJzaW5nIGZhaWx1cmVzLiBJdCBpcyBncmVhdCBuZXdzCnRoYXQg
bW9yZSB0ZXN0cyBhcmUgbWlncmF0aW5nIHRvIHB1cmUgQy4KPiBJIGFsc28gd29uZGVyIGlmIHlv
dSB1c2Ugb3VyIG5ldyBydW5uZXIga2lyayBhbHJlYWR5IFszXS4KV2UgaGF2ZW4ndCBhZG9wdGVk
IGtpcmsgeWV0LCBhcyBvdXIgTFRQIGV4ZWN1dGlvbiBpcyBkZWVwbHkgaW50ZWdyYXRlZAppbnRv
IEdvb2dsZSdzIFRyYWRlIEZlZGVyYXRpb24gKFRyYWRlZmVkKSBhbmQgVlRTIGF1dG9tYXRpb24g
KHZpYSBhdGVzdCkuCldlIHdpbGwgZGVmaW5pdGVseSBrZWVwIGFuIGV5ZSBvbiBpdCBhcyBpdCBl
dm9sdmVzLgpLaW5kIHJlZ2FyZHMsCldha2UKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
