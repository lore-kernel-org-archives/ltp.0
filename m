Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E38CD98E4
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781634697; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ZWTmZxWCBr8dCLTisg4yq3t/4rDYx8j5Jpt6cKG+iD0=;
 b=oUy+kYI6RQTjTivlz15y3auU71QrK209GI6tPRFcEdLZy61eOQK40lskiG+9N7blFs9Z5
 OhxmtaI1wKH4eosng9uR/ATxsHqG/knoAgssw7IeMLwX/DDw0NlfoDIaNheog+q1P42rlrt
 yF3DVQs8byelqoYUEEOCT8ZUAersrDQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF5AD3E5B5F
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 20:31:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28AF93E69FE
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 20:30:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1E18960086D
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 20:30:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781634632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RF3yl7/LHVBK8A2cvMnFI8ETt3/C9ME68mUBdM6RLO0=;
 b=Tm+wOFW2Xjk9X3gEtvuyX91PrmN0xc6tiObccmvzDdGhiegyRcQ2Y93d6r+bbloU5uUVtb
 odwz+m8JVQyqW96UZFnpER3V2rc0njXDgr5v+CmlPzm9EuXFIVUo2tLnO4HYD77Wx7zF2Q
 /c9EVWkhLdnJJRTUZYLZw5UZAvQwmt8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-xK6X_oXvOCabCgo0RMjwug-1; Tue, 16 Jun 2026 14:30:29 -0400
X-MC-Unique: xK6X_oXvOCabCgo0RMjwug-1
X-Mimecast-MFC-AGG-ID: xK6X_oXvOCabCgo0RMjwug_1781634628
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490abeb7298so54408455e9.2
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781634628; x=1782239428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RF3yl7/LHVBK8A2cvMnFI8ETt3/C9ME68mUBdM6RLO0=;
 b=h6XPk7IUVdBc8Idj00WRG+m7P1uu2WuTW+4YR3OBkQa6v8GNkpFEoXAh4VPdi17xXS
 IQosBdN1uFydiROoh2uZoE2n23brnxV+wUpkLLOlZudgVN74TraDC2Flt4lCsl4Miox4
 snGm5b08094tvgZtRrHDgvpHkHMnvyYsQc6Okrf+SSPGe9Px7maWr4c5oNkLwMxHnXG5
 IOlS4sl4xs8bJashGtyElLc3kSQ7KS2WYU6Rm78KQM/1g3zItEysg5wQDgnLdDcgzvHE
 Zx8fjFASIoidxgv8EXn1xWZAuxKBUXkQY/GNK6CrpRSU5MUKjePizaLOc+Fg60qhnFaa
 Zpsw==
X-Gm-Message-State: AOJu0YzcK17IZiZMkgLaSFU4z+2YsUuP2zSRFxGUpIjD7+wBBKYV8TvK
 QIxQ1MNrbzA7xB7WNpLJigUgliUmke2Dz6fpxtYxTNOumDT18S2fmOMuFx0BtI+PsA6YYjT/mX7
 9PKJJXFYsgX391iNH68hDwLLdicCRYSiu/tdDRy6wzseovMfmN9Qs045s9WihCo2uYZE8cqAqOi
 hpIZPOpHDl3oI/KxkOTWfRYOPVotmmi0fXzaeZ
X-Gm-Gg: Acq92OER344rfMYNWfgesw22HUwaZZXWtUJDEh1j5ln5/amYidFPE79ns+pm0sINXdZ
 vsL38qEe14eS277snyUuBBcTs7YZ8aSA6T4mUBOxG2eHk7i0NW7QoaYnR6AlEsMbpQ4Ov4W10W2
 obAoZO7yTfvkpetZxvsC3aCKOc5iphK+wvei4Xloo3T6xv90l7PsmbbgbtqtA7AyKJGiUU32OuT
 Omilo06WhtYDHlFpierRB7y5foQoIJluaFKTXxA7OqtqEFN8vrevGBwXly3SeUEzRnTXRACUPzh
 VWfBvM4lEmd7670rHwlf5v4s61WyVA0sdPFDe5wf4REKuJCzJ4tm/Cbh0yb38ZYpdiYalSDSecI
 9yWSPziu0nDXrhJ5CBYTNskilPA34U4U7LPDnVG1SiCF1li0NCKYsDI52Ld53xriEAFY2HYM=
X-Received: by 2002:a05:600c:3b0f:b0:491:731c:892a with SMTP id
 5b1f17b1804b1-492333df11bmr11667535e9.35.1781634628492; 
 Tue, 16 Jun 2026 11:30:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0f:b0:491:731c:892a with SMTP id
 5b1f17b1804b1-492333df11bmr11667055e9.35.1781634628055; 
 Tue, 16 Jun 2026 11:30:28 -0700 (PDT)
Received: from fedora.redhat.com (85.64.196.200.dynamic.barak-online.net.
 [85.64.196.200]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49233438eebsm8244805e9.0.2026.06.16.11.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:30:27 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 21:30:23 +0300
Message-ID: <20260616183025.26554-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R6V40gy-cCpon_YIZpiUN1omwCagKKhHZXh7fYYBQ7Q_1781634628
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v15 0/2] futex: Add EFAULT coverage for wake and
 cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ZnV0ZXhfd2FpdDA2IGFuZCBmdXRleF93YWl0MDcgd2VyZSBhbHJlYWR5IG1lcmdlZC4gVGhpcyBz
ZXJpZXMKY29udGFpbnMgdGhlIHR3byByZW1haW5pbmcgcGF0Y2hlcy4KClBhdGNoIDEvMiAoZnV0
ZXhfd2FrZTA1KSBpcyB2MTUg4oCUIHVwZGF0ZWQgYmFzZWQgb24gcmV2aWV3IGZlZWRiYWNrCnRv
IGFkZCBhIGtlcm5lbC1zcGFjZSBhZGRyZXNzIHRlc3QgY2FzZSBhbmQgY2xhcmlmeSB0aGUgY29t
bWVudApleHBsYWluaW5nIHRoZSBkaWZmZXJlbnQgY29kZSBwYXRocyBpbiBnZXRfZnV0ZXhfa2V5
KCkuCgpQYXRjaCAyLzIgKGZ1dGV4X2NtcF9yZXF1ZXVlMDMpIGhhcyBub3QgeWV0IHJlY2VpdmVk
IGEgaHVtYW4gcmV2aWV3LgpJdCB3YXMgcGFydCBvZiB0aGUgcHJldmlvdXMgc2VyaWVzIGFuZCBh
ZGRyZXNzZXMgRUZBVUxUIGNvdmVyYWdlIGZvcgpGVVRFWF9DTVBfUkVRVUVVRS4gV291bGQgYXBw
cmVjaWF0ZSBhIHJldmlldyBvZiB0aGlzIHBhdGNoIGFzIHdlbGwuCgpHaXRIdWIgUFI6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3B1bGwvMTMwMQoKTWljaGFlbCBN
ZW5hc2hlcm92ICgyKToKICBmdXRleF93YWtlMDU6IEFkZCBFRkFVTFQgZXJyb3IgY292ZXJhZ2Ug
dGVzdAogIGZ1dGV4X2NtcF9yZXF1ZXVlMDM6IEFkZCBFRkFVTFQgZXJyb3IgY292ZXJhZ2UgdGVz
dAoKIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAr
CiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Z1dGV4Ly5naXRpZ25vcmUgICAgfCAgIDIgKwog
Li4uL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4X2NtcF9yZXF1ZXVlMDMuYyAgICAgIHwgMTAyICsrKysr
KysrKysrKysrKysrKwogLi4uL2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRleF93YWtlMDUuYyAg
ICAgIHwgMTAxICsrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDIwNyBpbnNlcnRp
b25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mdXRl
eC9mdXRleF9jbXBfcmVxdWV1ZTAzLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4X3dha2UwNS5jCgotLSAKMi41NC4wCgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
