Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B49FF8875
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 10:12:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FEEB3E49C0
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:12:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 161C33E1A9F
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:12:07 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BACF220015B
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:12:06 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2d868d014a5so12222208eec.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 03:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777457525; x=1778062325; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EzMJs/KfUS/wYg1X35fA9CPv5i85EUrqzlWCcpBu3E=;
 b=cb5Ei8HrR6a6h0wrv5oDXMpO4MLGZpDPyzcx3ElJh31zWpvy952bDPEP/K8PgRT8sa
 5iBMexrkbl9x0l5IbogLAPyrAqO+Bt1m2ACp25dsjFZgLmvpPBV/HArYBuj9uLjgrSod
 zGSeyj5JYKKK7J7tddK8fEX0TCuXB4C1PSFeiuGIg9qHE/K/Ayxyh8QEhverTxt3Gc9H
 /oBpp1lMPYbwUYYPlK0Bau0qD3iKMjlgo9AltNXCTBH/+UCUvvTcA18VqfV91JPiLcoy
 YeyRrAKQpjgil7sgyoucfc6N/O2vZ7d1wwj+PeAvcS8v6U3bQvIsryC9gejgpM40Lxgv
 TmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777457525; x=1778062325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8EzMJs/KfUS/wYg1X35fA9CPv5i85EUrqzlWCcpBu3E=;
 b=oEX2jvM15J2b0frXcE7vi9NSOjSlVx8ODGWTMNINaggy88SR/LRLulhtuyCkJLJ2c5
 98xhcc9rBtd22KoSJGfSDTyLRHg96w91wmFDsdQhLFlrk9T6kHjGHv8Tcd/H0q5yZj1j
 rvzWx98NfwbD+avwi1agw7OjGZJtLn6/eVgRUSFUWD3umb7ksrU3v5+c3OZf5ZtOC93X
 lot0rHRzR1d0W8Sq4sXQQ7ZZdJajWf81xgtW/U8frccp12Mfky0R0ycgx23AchXMeE8k
 QW9xLxf7akKoobaZVUB2nf5ycgN26PsvvzxFd51bb0wArhGRBoCRrI3nw0VEY1PpA6z3
 Hm7w==
X-Gm-Message-State: AOJu0YweQqo9MK/5pWcjA0jMOOEGwA4IoNS5Vxn9OmFloOpsE44/fK1s
 REjdybrdr5YNk2idimx2+C4hTugu6/M9nOtYo+gu1uso9KVd18dXic5B
X-Gm-Gg: AeBDievMRoFyRSOihYcnRNpQDDMkczis5c0qPQ2TKndFpWzO0CwaH2ankRQ8/HgIt06
 VORQ3jGCQCqIbZ9GhPit2tm9m5lZ8p5mRhkKcJT428D3y2mxMAxfJntt3Ea40Ndn0FBOrrBxlWP
 1ybYUzskRMMSMFZ81ZP9lvPyay2YJt+ABqeoRBb1EJ5nKKJOxPEF1bUoWB+q+2xWOZvoCONqd77
 ukJNCUMH53ExVHtNBXWi0Cx6swL6aIjLxpJYxH1Yuj6iA12XXkYGA3drd+WJl2eYXzCWldE3pKN
 2PF2gRS8orcdoGpxHdnFlt9opE2Ao0pYjW4KK69s+43qC6cHpQ3iOi8SJwLzA1+8zELsCGjPiKk
 sxTbhlWem5jFRkQIrLTlmaCix1fwtEf9HsonoP/lmOU9ccfhArpmO8qtci1YyBqSIo5UkmGVWaW
 oYklEPjtgJaKxMrChd5jlCjfuhr0klkl1I53BE+AmO1KqrcIU3791VOCu0TG9b2QirLEBUMBtyp
 r8Zbv4kF6sE8qLlAMGEPhisXon88804SRTVUlyebw9Zs9O0vGc=
X-Received: by 2002:a05:7301:d8f:b0:2d8:b814:29af with SMTP id
 5a478bee46e88-2ed19716925mr1418130eec.3.1777457524960; 
 Wed, 29 Apr 2026 03:12:04 -0700 (PDT)
Received: from
 runnervmeorf1.gqycc2zpl1wenkeeoydy3zbfbh.dx.internal.cloudapp.net
 ([52.159.247.231]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d315sm1639269eec.1.2026.04.29.03.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 03:12:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 29 Apr 2026 10:12:03 +0000
Message-ID: <20260429101203.4058-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429-fix_clock_settime_helper-v3-1-2608c39d8499@suse.com>
References: <20260429-fix_clock_settime_helper-v3-1-2608c39d8499@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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

SGkgQW5kcmVhLAoKT24gV2VkLCAyOSBBcHIgMjAyNiAxMDoyODozNSArMDIwMCwgQW5kcmVhIENl
cnZlc2F0byB3cm90ZToKPiBjbG9ja19zZXR0aW1lOiB1c2UgUE9TSVggcnVudGltZSBkZXRlY3Rp
b24gZm9yIENMT0NLX01PTk9UT05JQwoKPiArLyoKPiArICogQ29weXJpZ2h0IChjKSAyMDI2LCBM
aW51eCBUZXN0IFByb2plY3QKPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXIKPiArICovCgpNaXNzaW5nIGBDcmVhdGVkIGJ5OmAgYXR0cmlidXRpb24gbGluZS4g
T3RoZXIgaGVhZGVycyBpbiB0aGlzIGRpcmVjdG9yeQoocG9zaXh0ZXN0LmgsIG1xX3NlbmQuaCkg
Y2FycnkgaXQuIEFkZDoKICAqIENyZWF0ZWQgYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5j
ZXJ2ZXNhdG9Ac3VzZS5jb20+CgpbLi4uXQoKUHJlLWV4aXN0aW5nIGlzc3VlcyBub3RpY2VkIGlu
IHRoZSBzdXJyb3VuZGluZyBjb2RlIChub3QgaW50cm9kdWNlZApieSB0aGlzIHBhdGNoKToKCi0g
Y2xvY2tfc2V0dGltZS80LTEuYyAoYW5kIHNpYmxpbmdzKSDigJQgdXNlcyBgdGVzdF9tYWluYCBp
bnN0ZWFkIG9mIGBpbnQgbWFpbmAKLSBjbG9ja19zZXR0aW1lL2hlbHBlcnMuaCDigJQgYGdldEJl
Zm9yZVRpbWUoKWAvYHNldEJhY2tUaW1lKClgIGNhbGwgcGVycm9yKCkKICB3aXRob3V0IGluY2x1
ZGluZyA8c3RkaW8uaD4gaW4gdGhlIGhlYWRlciBpdHNlbGYKCi0tLQpOb3RlOgoKT3VyIGFnZW50
IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4gVGhlIGZ1bGwgcmV2aWV3IGNhbiBi
ZQpmb3VuZCBhdDogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAtYWdl
bnQvYWN0aW9ucy9ydW5zLzI1MTAyNzc4NTAzCgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9k
dWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVp
bmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRo
aXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZp
ZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
