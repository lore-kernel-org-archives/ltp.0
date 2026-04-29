Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5860BFF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 08:04:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A41CC3C0E3B
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 10:04:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 320423DD6B7
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 10:04:04 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 66112600BD4
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 10:04:03 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8acb09ddbf6so176287226d6.2
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777449842; x=1778054642; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHA4TZitXJSF5SPys359hwaiAACFVyY2rOUhDgdTVHA=;
 b=SxZ24wdO+Ej16HfGDQUjus6odRD+0yV/LDBfIFs4PBzzB98Gu0imerOIIEq+L/sU4n
 iSfVnLVSnaSLwYh8DNISe3wjCOW3vBFFJ/RD/3Vg/e7oCweT9wB5iKK7tV+mit4AKjwD
 1QgTyAN4ci2SWQZpQTve45KIuvcJA8KBM9Houn/PseethyRUt2tnOPcLPKUCfRdVRhWU
 ZrzhfAvDtht6c+SUNDGJdDdasBGyyVSBAS43/XBCsfpK7iOi7qLd0nLvA9C3FD+vMAtm
 m5YU3N3bN5Jys2eCRLF0uoNaHyXLCHkTS3bElkPlRJzn925L/ElLXDDApt6IOHAg0cFw
 RJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777449842; x=1778054642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xHA4TZitXJSF5SPys359hwaiAACFVyY2rOUhDgdTVHA=;
 b=LKzbk2ImbCfPpxLwH9c59UEqiL1gKDSRdIpVOeX2CNVwIxXyi4zJaW2o2atg1W9Hlv
 fqsTy7MQzQEL19Fnd4q/YLxnMqwlsxtgatLaGNr/1h6j9eo2V8qZ0dy19Hd7tvnCKliK
 R9ic48X1H5QKyBUlCsQRD1ZmHGxVKA2Fb+fZxsy6T0jG/hM7YPXnI3WGYecKoIwYYcE1
 0g1woQbeMS2iTSAiFbOmWCN71XaXcHH20+L2C7NWIPqLJBW2zvs8ZkUnBlapwhWNdqwy
 c2oAFmShalv93rDTrZvgOwJ3R63oFkEmXU7aXYG8ygMYSEwmPMsvX/6cbd6Vc74ZiE6U
 dBpg==
X-Gm-Message-State: AOJu0YzSrsRI0agtzBHUaOvHgDK7v8NV6z5dm3MhcNQ+8dx+O2vVBh19
 R+v/NIKQc7Lx5jSYld7fQKyqFjocqwZ5dEnrlXUAFvcF7Ar0yc6VJKaV
X-Gm-Gg: AeBDieskLOMhsQcYT6SxjLqprNRMmY+/z2m3AQEdbdLLagKoCSD3NvikpazDX8m2zV7
 VD1tNtjTI/iuOfMDOiG3rGHcOADK+3XRddzT2sUuBlTxkcsB3IJqWXarKK3zOoSH/GQ0oB1fZLc
 Gsf5ssyh854TI7Qe37gq/muoTzvwf7olIjfDtyIQIY03aY1CrXJOM0NCGhjs7AfmntL5JjPtfST
 SxQYikyojOjRGBlsO4dt5Fby6Zls3wQyCg8Qic4Mr3rsdZsGtGc7M5Biz6E04ipuVZoC6M11owt
 92myaWGHRs5mE6N/84+CM8JPF8EYq+F3dLJM3uwm7mP4vJmKlopDLJ8H/t1aHQwAARW+SLxUYlu
 d2gmDjXgpakZRIhNGc2zxx96bvJL+oBAEyliFbEWO5BJA14R3Qu5rSCgMHQNxrYCHMuQFn9cxYY
 wjUQezv+534FVpuMbocxkzC6aCaPxk/DSztZG1g0flihl+aUTYbF52UTmBoGvw+r5vo5kVYdOEW
 JS6Sp9OCi00opN+JIhBQw+z7HB+/nz5XrMy3Lm580f1WGwgqZY=
X-Received: by 2002:a05:6214:c22:b0:8ac:a757:c1ef with SMTP id
 6a1803df08f44-8b3e2eacc48mr110138696d6.0.1777449842084; 
 Wed, 29 Apr 2026 01:04:02 -0700 (PDT)
Received: from
 runnervmeorf1.ewmzc0bqkruufhf1y4x1ywmkfc.ex.internal.cloudapp.net
 ([64.236.135.141]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ef86bce8sm12176606d6.47.2026.04.29.01.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:04:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 29 Apr 2026 08:04:00 +0000
Message-ID: <20260429080400.4043-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260413062002.20324-1-wegao@suse.com>
References: <20260413062002.20324-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix 32-bit compat mode failure by adjusting
 comparisons for compat mode truncation
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

SGkgV2VpLAoKT24gTW9uLCAxMyBBcHIgMjAyNiAwNjoxOTo1MyArMDAwMCwgV2VpIEdhbyB3cm90
ZToKPiBzaG1jdGwwMzogRml4IDMyLWJpdCBjb21wYXQgbW9kZSBmYWlsdXJlIGJ5IGFkanVzdGlu
ZyBjb21wYXJpc29ucyBmb3IgY29tcGF0IG1vZGUgdHJ1bmNhdGlvbgoKPiArI2RlZmluZSBUU1Rf
QVNTRVJUX1NBVFVSQVRFRF9JTlQgICAweDAxCj4gKyNkZWZpbmUgVFNUX0FTU0VSVF9TQVRVUkFU
RURfVUxPTkcgMHgwMgo+ICsjZGVmaW5lIFRTVF9BU1NFUlRfQklUV0lTRSAgICAgICAgIDB4MDQK
ClRTVF9BU1NFUlRfU0FUVVJBVEVEX1VMT05HIGlzIG5ldmVyIHVzZWQgaW4gdGhpcyBwYXRjaC4g
RWl0aGVyIHJlbW92ZSBpdApvciByZW5hbWUgaXQgdG8gVFNUX0FTU0VSVF9TQVRVUkFURURfVTMy
IOKAlCB0aGUgY3VycmVudCBuYW1lIGltcGxpZXMKc2F0dXJhdGlvbiBhdCBVTE9OR19NQVggYnV0
IGl0IGFjdHVhbGx5IGNsYW1wcyB0byBVSU5UX01BWCAoMzItYml0KS4KCj4gK3ZvaWQgdHN0X2Fz
c2VydF91bG9uZyhjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCBjb25zdCBjaGFy
ICpwYXRoLAo+ICsJCQl1bnNpZ25lZCBsb25nIHZhbCwgaW50IGZsYWdzKQoKQ29udGludWF0aW9u
IHNob3VsZCBhbGlnbiB3aXRoIHRoZSBvcGVuaW5nICcoJyB0byBtYXRjaCB0aGUgZGVjbGFyYXRp
b24KaW4gdHN0X2Fzc2VydC5oLgoKPiArCWlmICh0c3RfaXNfY29tcGF0X21vZGUoKSkgewo+ICsJ
CVRTVF9BU1NFUlRfVUxPTkcoIi9wcm9jL3N5cy9rZXJuZWwvc2htbWF4IiwgaW5mby5zaG1tYXgs
IFRTVF9BU1NFUlRfU0FUVVJBVEVEX0lOVCk7Cj4gKwkJVFNUX0FTU0VSVF9VTE9ORygiL3Byb2Mv
c3lzL2tlcm5lbC9zaG1tbmkiLCBpbmZvLnNobW1uaSwgVFNUX0FTU0VSVF9CSVRXSVNFKTsKPiAr
CQlUU1RfQVNTRVJUX1VMT05HKCIvcHJvYy9zeXMva2VybmVsL3NobWFsbCIsIGluZm8uc2htYWxs
LCBUU1RfQVNTRVJUX0JJVFdJU0UpOwoKQWRkIGEgY29tbWVudCBoZXJlIGV4cGxhaW5pbmcgd2h5
IHNobW1heCB1c2VzIHNhdHVyYXRpb24gYXQgSU5UX01BWCB3aGlsZQpzaG1tbmkvc2htYWxsIHVz
ZSBiaXR3aXNlIHRydW5jYXRpb24g4oCUIHRoZSBjaG9pY2UgaXMgbm9uLW9idmlvdXMgd2l0aG91
dAprbm93aW5nIHRoZSBrZXJuZWwgY29tcGF0IHBhdGggYmVoYXZpb3VyLgoKPiArU2lnbmVkLW9m
Zi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+CgpUaGlzIGlzIGEgYnVnIGZpeDsgcGxlYXNl
IGFkZCBhIEZpeGVzOiB0YWcgcG9pbnRpbmcgdG8gdGhlIGNvbW1pdCB0aGF0Cm9yaWdpbmFsbHkg
YWRkZWQgc2htY3RsMDMgd2l0aG91dCBjb21wYXQgbW9kZSBoYW5kbGluZy4KClByZS1leGlzdGlu
ZyBpc3N1ZXMgbm90aWNlZCBpbiB0aGUgc3Vycm91bmRpbmcgY29kZSAobm90IGludHJvZHVjZWQK
YnkgdGhpcyBwYXRjaCk6CgotIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL3NobWN0bC9z
aG1jdGwwMy5jOjEyIOKAlCBpbmNsdWRlcwogIHRzZV9uZXdpcGMuaCB1c2luZyB0aGUgbm9uLXN0
YW5kYXJkIHRzZV8gcHJlZml4IGluc3RlYWQgb2YgdHN0Xy4KCi0tLQpOb3RlOgoKT3VyIGFnZW50
IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4gVGhlIGZ1bGwgcmV2aWV3IGNhbiBi
ZQpmb3VuZCBhdDogaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9saXN0
Lz9zZXJpZXM9NDk5NjQ4CgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBv
c2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBm
aW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3Ig
aWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
