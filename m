Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94429CD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:24:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7033A3E1DBC
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 13:24:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3BB83E5610
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:23:54 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 953CD60046D
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:23:54 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8cce87d7995so51636046d6.0
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780399433; x=1781004233; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OuzqF6HvB2G6oN0s4PfHkNwJRCHmjWjN6M6rmOhjq08=;
 b=d+r4GDaivZh7YVPMq98fPPoI5vyUdA8Mlz9B+WDDSzSF8stE0UToEUVrJAnLkL9X0y
 esMCmJOGTviCzhQrkZsJAs1IOq2nIAG0WAADI6v1VxmWT9NwWNTzfjxlUdvgjfJ7xk+C
 EpUEgtlZWizHRiUIwbe97KT9JKGvtPqVLw+2Bq9yXvME6SjjzFWuAOfQucNDo8ECz7iI
 HkoTZkNsuY1yTfRnfyigbkVj8XuLMepWxvBwvg/gBhDl7P19d/1FNR8PBIpS81NxlTc5
 Dpp2SrxWaPgjhPbXKiZdjLmQTZHWY8N3mq7c911WnKXTESUUe39CKcXzhp6CdLL/3C+h
 Z89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780399433; x=1781004233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OuzqF6HvB2G6oN0s4PfHkNwJRCHmjWjN6M6rmOhjq08=;
 b=pqxhotg3tw/A6sEuOKwSgu236CD8V1t1HAcwB87OYwZ03SSt+PoprCJRJWNzYblzRx
 7SZEYk4ytDf/b6uEPIr6WyQUs3Mt6TXhSLzFYwhFRtaBnF5w8W9dVj8uWsroU30lEskk
 GsNyTrnzK8oS/QbbIrEBaAPpF2mM+4hWLg9k3XMQ7eS4v2Z0l0tiy7OBv0Fkf4Pl4sTi
 /JclaebPSMDCyT+x3AXYx5R35azXK4W8ug+/sxK2t6mq9neOrPA8IG/TGm39B/r8AiUP
 jtN7xiKSRKexL360UGmXz5P1YwBBvfQid3ZXZLT36Rqy0qU4pgWVlO5x4YiR9KTS6Ayk
 vHhw==
X-Gm-Message-State: AOJu0YxPRo7QeSyKkAx/ZLNZLrG+YvIKQnLQ53o9L1V38gTSzsuGXJ5S
 ve8koPjXN2MATE6nXLeVzP22O64KK8Nez8Z5HPx+h/pV3Y6JzVEYZHMRsZRebuHWkSc=
X-Gm-Gg: Acq92OE/Nt6rZz8gbfhjbgodmJPfl6M1Yj7Sh9G/TCVZeVtoXKgrkiNbUx8Fht1rzak
 YNu0s0tHfjIWdF08O4OBAq/zF2jaSNLRNCvb74pKT1a3hon7MIxuM5cidIVgNkmyxowFyI1rVV6
 S9sr+DZpnfvVqHrPDiPzqqGdm1iC3bOdsZrX4MEQjhS8u6F9S3GDzMvnwwWqmXOSbbkgYbx0SLM
 NpqOi35PVfCGCw2alCSMXZYfaWsFPyDvjp6eHzOaxpW19lKwi0zNJ0JFWUpxLBSsXMYOEJlGeEn
 dPMb4A97IlqAZQlxvdmK0I6MUjb9jrWUgEY3mOxPRwkQuYHdE/GWeKWVafeK9gqiKnTVOmp/P+h
 s8g78NyhUGnrkV+IOjNVv8eGjq5yJI00WcXrZCVbyhAJaJmYKG2WSWr8pAVr79UbL0wOs5ECmYr
 IQpdLLtFQOqVWibjJqLo+ukqb8LIdJk0AsFOMgsGvyYrejohFT+1aGxh5fOXZ+K2nYwqvs5pi/e
 W7Vzim5n/o88LRWnY4IlaLr7svuB3DlOvdzUJ+Tmq/e8wWZVZWUObWfz7VA
X-Received: by 2002:ad4:5e87:0:b0:8ce:3868:6700 with SMTP id
 6a1803df08f44-8ce38687aecmr208782536d6.34.1780399433250; 
 Tue, 02 Jun 2026 04:23:53 -0700 (PDT)
Received: from
 runnervm3jyl0.vwavxida512uxjabvyoesfa4yd.bx.internal.cloudapp.net
 ([172.208.13.89]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea216beesm115157546d6.39.2026.06.02.04.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 04:23:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: XiaoLei Wu <wxl18715129466@gmail.com>
Date: Tue,  2 Jun 2026 11:23:52 +0000
Message-ID: <20260602112352.4044-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602064502.718525-1-wxl18715129466@gmail.com>
References: <20260602064502.718525-1-wxl18715129466@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: skip ntfs3 in ioctl_fiemap01 and mount03
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

SGkgWGlhb0xlaSBXdSwKClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLiBSZXZpZXcgYmVsb3cuCgo+
IHN5c2NhbGxzOiBza2lwIG50ZnMzIGluIGlvY3RsX2ZpZW1hcDAxIGFuZCBtb3VudDAzCj4KPiBT
aW5jZSBjb21taXQgN2RjOGU5YTUxNWNlICgibGliOiBUcmVhdCBrZXJuZWwgbnRmczMgYXMgYSBz
ZXBhcmF0ZSBGUyIpLAo+IHRlc3RzIHdpdGggYWxsX2ZpbGVzeXN0ZW1zPTEgcnVuIG9uIG50ZnMz
IGluZGVwZW5kZW50bHkuCj4KPiBpb2N0bF9maWVtYXAwMSBhbmQgbW91bnQwMyBhbHJlYWR5IHNr
aXAgbnRmcywgYnV0IHN0aWxsIHJ1biBvbiBudGZzMy4KPiBpb2N0bF9maWVtYXAwMSBmYWlscyBi
ZWNhdXNlIHRoZSByZXR1cm5lZCBGSUVNQVAgZXh0ZW50cyBkbyBub3QgbWF0Y2gKPiB0aGUgbGF5
b3V0IGV4cGVjdGVkIGJ5IHRoZSB0ZXN0LiBtb3VudDAzIGZhaWxzIGJlY2F1c2UgZGlyZWN0b3J5
Cj4gdGltZXN0YW1wcyBhcmUgbm90IHVwZGF0ZWQgYXMgZXhwZWN0ZWQgdW5kZXIgc3RyaWN0YXRp
bWUuIEFkZCBudGZzMyB0bwo+IHRoZWlyIHNraXAgbGlzdHMsIG1hdGNoaW5nIHRoZSBleGlzdGlu
ZyBudGZzIHNraXBzLgo+Cj4gU2lnbmVkLW9mZi1ieTogWGlhb0xlaSBXdSA8d3hsMTg3MTUxMjk0
NjZAZ21haWwuY29tPgoKQ29tbWl0IG1lc3NhZ2UgbG9va3MgZ29vZC4gVGhlICJTaW5jZSBjb21t
aXQgLi4uIiByZWZlcmVuY2UgY2xlYXJseQpleHBsYWlucyB0aGUgbW90aXZhdGlvbi4gT3B0aW9u
YWxseSwgYSBmb3JtYWw6CgogIEZpeGVzOiA3ZGM4ZTlhNTE1Y2UgKCJsaWI6IFRyZWF0IGtlcm5l
bCBudGZzMyBhcyBhIHNlcGFyYXRlIEZTIikKCnRyYWlsZXIgd291bGQgYWlkIGF1dG9tYXRlZCB0
cmFja2luZywgdGhvdWdoIHRoZSBpbmxpbmUgcmVmZXJlbmNlIGlzCmFjY2VwdGFibGUgcGVyIExU
UCBjb252ZW50aW9uLgoKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9p
b2N0bC9pb2N0bF9maWVtYXAwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9p
b2N0bF9maWVtYXAwMS5jCj4gQEAgLTExOSw3ICsxMTksNyBAQCBzdGF0aWMgc3RydWN0IHRzdF90
ZXN0IHRlc3QgPSB7Cj4gIAkubW50cG9pbnQgPSBNTlRQT0lOVCwKPiAgCS5hbGxfZmlsZXN5c3Rl
bXMgPSAxLAo+ICAJLnNraXBfZmlsZXN5c3RlbXMgPSAoY29uc3QgY2hhciAqY29uc3RbXSkgewo+
IC0JCSJleGZhdCIsICJ2ZmF0IiwgImZ1c2UiLCAibnRmcyIsICJ0bXBmcyIsIE5VTEwKPiArCQki
ZXhmYXQiLCAidmZhdCIsICJmdXNlIiwgIm50ZnMiLCAibnRmczMiLCAidG1wZnMiLCBOVUxMCj4g
IAl9LAoKQ29ycmVjdC4gbnRmczMgaXMgcGxhY2VkIGJldHdlZW4gdGhlIGV4aXN0aW5nIG50ZnMg
YW5kIHRtcGZzIGVudHJpZXMsCmFuZCBtYXRjaGVzIHRoZSByYXRpb25hbGU6IEZJRU1BUCBleHRl
bnQgbGF5b3V0IG9uIG50ZnMzIGRvZXMgbm90IG1hdGNoCnRoZSB0aHJlZS1leHRlbnQgbGF5b3V0
IHRoZSB0ZXN0IGJ1aWxkcyBieSB3cml0aW5nIGF0IGJsb2NrIG9mZnNldHMgMCwKMiwgYW5kIDQu
Cgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwMy5jCj4gQEAgLTI1Niw2
ICsyNTYsNyBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gIAkJImV4ZmF0IiwK
PiAgCQkidmZhdCIsCj4gIAkJIm50ZnMiLAo+ICsJCSJudGZzMyIsCj4gIAkJTlVMTAo+ICAJfSwK
CkNvcnJlY3QuIG50ZnMzIGlzIGluc2VydGVkIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBleGlzdGlu
ZyBudGZzIGVudHJ5LgpUaGUgY29tbWl0IG1lc3NhZ2UgY29ycmVjdGx5IGlkZW50aWZpZXMgdGhh
dCB0ZXN0X3N0cmljdGF0aW1lKCkg4oCUCndoaWNoIGNhbGxzIHRlc3RfZmlsZV9kaXJfbm9hdGlt
ZSgxLCAxKSBleHBlY3RpbmcgYm90aCBmaWxlIGFuZApkaXJlY3RvcnkgYWNjZXNzIHRpbWVzIHRv
IGJlIHVwZGF0ZWQgdW5kZXIgTVNfU1RSSUNUQVRJTUUg4oCUIGZhaWxzIG9uCm50ZnMzIGJlY2F1
c2UgdGhlIGtlcm5lbCBudGZzMyBkcml2ZXIgZG9lcyBub3QgdXBkYXRlIGRpcmVjdG9yeQp0aW1l
c3RhbXBzIGFzIHRoZSBMaW51eCBWRlMgZXhwZWN0cy4KCkJvdGggdGVzdHMgYXJlIGxpc3RlZCBp
biBydW50ZXN0L3N5c2NhbGxzLiBObyBNYWtlZmlsZSBjaGFuZ2VzIGFyZQpuZWVkZWQgc2luY2Ug
bm8gbmV3IGZpbGVzIGFyZSBhZGRlZC4KCi0tLSBQcmUtZXhpc3RpbmcgaXNzdWVzIChpbmZvcm1h
dGlvbmFsLCBkbyBub3QgYWZmZWN0IHZlcmRpY3QpIC0tLQoKaW9jdGxfZmllbWFwMDEuYzogdmVy
aWZ5X2lvY3RsKCkgYWxsb2NhdGVzIGZpZW1hcCBhbmQgYnVmIHZpYQpTQUZFX01BTExPQywgYW5k
IG9wZW5zIGZkIHZpYSBTQUZFX09QRU4sIGJ1dCBvbmx5IGZyZWVzL2Nsb3NlcyB0aGVtCmF0IHRo
ZSBmdW5jdGlvbidzIGVuZC4gSWYgYW55IFNBRkVfKiBtYWNybyBpbiB0aGUgbWlkZGxlIGFib3J0
cyB2aWEKdHN0X2JyaygpLCB0aGUgYWxsb2NhdGlvbnMgYXJlIGxlYWtlZCBmb3IgdGhlIGR1cmF0
aW9uIG9mIHRoZQphbGxfZmlsZXN5c3RlbXMgbG9vcCBpdGVyYXRpb24uIEluIHByYWN0aWNlIHRo
aXMgaXMgaGFybWxlc3MgYmVjYXVzZQp0aGUgbW91bnRzIGFyZSB0b3JuIGRvd24gYmV0d2VlbiBp
dGVyYXRpb25zLCBidXQgYSAuY2xlYW51cCBjYWxsYmFjawpjbG9zaW5nIGZkIHdvdWxkIGJlIGNs
ZWFuZXIuIFRoaXMgaXMgcHJlLWV4aXN0aW5nIGFuZCBub3QgaW50cm9kdWNlZCBieQp0aGlzIHBh
dGNoLgoKLS0tIEVuZCBwcmUtZXhpc3RpbmcgaXNzdWVzIC0tLQoKVmVyZGljdDogUmV2aWV3ZWQK
ClJldmlld2VkLWJ5OiBMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
