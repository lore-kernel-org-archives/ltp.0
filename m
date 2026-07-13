Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52A5C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 01:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783905551; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bBkeZDvQcBteSGcqLe/U7dGrB5ItPS4mHgyjWR8XrAg=;
 b=gKn+VaPcq551+iKMuDrvUooDjpAB4P9lc57StKBhPBCtCOLPcsh0KNJ28XUgw470heb/9
 ytydyZwAcdsZ1kfgmyWVT3vjQ3jCGd3jOlO1toZA2HDT4+9tmlK0/qIyg5wva1rqV//fxrj
 cV2zhY4h2jzhmyGg8MWPB2XAWQPvxog=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAE603E2AD6
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 03:19:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2FE43CC91F
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 03:18:51 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4FA5C60004C
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 03:18:51 +0200 (CEST)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81dfdbd86d1so23902357b3.1
 for <ltp@lists.linux.it>; Sun, 12 Jul 2026 18:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783905530; cv=none;
 d=google.com; s=arc-20260327;
 b=rJ7EDYpVlCFDVgqT+i+/GKhHJSxg7YxNS7i6qEsTYKMoFo6nISuvglwwGtaLG8Ulek
 GS+kLBj1KB9wWN6nb+7dlzuFEjENwYEeOVPva7O6iP4hgCX/X7RCorBQU/CjXESfEY6z
 NT7UgMmOiSJUIW8hnglALPXCg6W2NngGpxmoRum+aBILnE67qhQ06dthxRU005ESXZ1B
 KxUnC8HfJvHGAGyxoezYwtiIDkYR0R9cSgsRzc6SSyU3ggqOB29ZUWANfW+a1W+SwmBr
 rwnRB6nZP5mVoeIZtguQ+V/NB4YE+LheDtgL7pCKSAVWB9cF5rj5JkEUjX1BDKgTMgz7
 rJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N5c1FPhVgpaJJSU0N8vigUjGjcW58AzpgBs43wGo+so=;
 fh=cmR4S6Ly0xc3yKBvbQzAzwuxrXJZLhA//6ubmxpeQ5A=;
 b=rdzgDJNHWo21Mv2/iprbjEl1ZYFywJgCor8cumw2tMrkp5f+rrBIEHoVXHig0Blxon
 BfROoDp9G65VtnRVb2brjkwnHd8eXWEVcUN5gFxBvAawW5ETmgzzqHTIosOtp3vU+Z5a
 ECsDyNshBl7f25yiwIH14mCaw5zswtF5DjgrPJqxPRCAy/miwBPtZRfhhaSYPd/wOht+
 Q6bI6r0m0kLRd8RumtKElFGuo00iIjj7ana0yS7FqBpYCu+Qxf/tszd96NtWQUN8JPxU
 bPLHvRPQwtiYaC1VCg38e+tMa81lFsGeWn0ya9mlmEy7LWjOAQQVIxn+xbNll6XaVi6+
 Ncwg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783905530; x=1784510330; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N5c1FPhVgpaJJSU0N8vigUjGjcW58AzpgBs43wGo+so=;
 b=To9DP0IRKW7kXjWYQW6TVn53cdS0wm697wTnuX31bE5CRzU6acKbJeC5vo7J/7cSxR
 U/8ge2k6WsViWX0hUVLY+Nd3kUeKicSBk4/akvKwQ/x+Ndzr9f1XjQ2BBfwB9NHNtnEc
 FpFI+fgAQ2hISm5esziS4hU6cJdBO/0YnLwfGCvHkC9R/2v0oLnYQlO69w4BlywOlCqh
 5FosCXpLiLyUcPRhzVH7sKOOG253SordcoTYLSP0Z/sQ5flJ3sEz4f+2Lil37SUwsMQr
 ltQ4MMQS+DDMeBePyzzt3lu7wV8ZiTKdaqTARe7MfF4D5aps29dOJZHP7svkZbTvOl8P
 eTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783905530; x=1784510330;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N5c1FPhVgpaJJSU0N8vigUjGjcW58AzpgBs43wGo+so=;
 b=IRB52ixWoWXqhpzh3y9gJfeN+G1BRAH3Ea6/JqZ3oYdy2/GnzJBkQFwwQicsca+zfP
 ZzWUNdFhzo5XXwAJJfE5bF5CZoe3WJuT260FVy1f2f1YJEpF28h2BoU3TdwWD7zQ3Wnb
 XSl6+kQ8jjGVBhTM/RvXApkyLq4TSgHaHBtH6TUl3M6X19z+wEZQBYNegR/8ivFQI9th
 YCZ5UFTE4drA9NN9kQ/gIZugZt2w2VvwoN3/Gfl2ZofRod8Zr35hcg3nTrO/KzyofBGD
 KIYBNE3epJLwY/VQnkeMzXqox/M8k4+XnSFFUOtOFCy958aBQvyvm0DBNfqRlGPsv14y
 7lpg==
X-Gm-Message-State: AOJu0YzXNN8zcDHxBrxO+9PxAL2i7v/+lviQy/a72G+0nNCGhnKOIYop
 BAaitN2ViH+VOnpZwOoywbUXfwXmqu7nkitVeqPx5IU9QDBjdSWwnq4Naj0uUkOrLAx5QvtGTZY
 R/PUqQ8CSsBLB0zvDtDfpjwf9kYuuoPY9Kra6VZvi
X-Gm-Gg: AfdE7ckAjdjfnmq/hEDgtABs8Zd11W28UNvoxkD2OmHNAMy9Y9KEDGlNKLoDRvBVyWA
 dw+xCC1+EItr7BOMxNEjI1CLtlErEhi4GYDsZ2sivkBZRl8mJj2I5eiKkkOVjXSf6SPQmzoVwQN
 5Mamb6/GaeIIZwaR0HtAZoxFdobIFygBT8K89fIHNzkE+SFrQPjuLzOMHBw08lrDu1a8oupP1o8
 uiGGbBBSao0Et6cJegLuo16BAxGSv+BouzIkGbnpmDsonTNEUOx6IYMy0y1OGTy8rB58Kc3vzjk
 LXFIpm17ymR1Usn5mAuX67V+ZIE=
X-Received: by 2002:a05:690c:c4c4:b0:80e:ff00:479 with SMTP id
 00721157ae682-81e90052157mr56740127b3.18.1783905529466; Sun, 12 Jul 2026
 18:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260710021502.1798161-1-wakel@google.com>
 <6a50969d.c5b9c171.16682a.3705@mx.google.com>
In-Reply-To: <6a50969d.c5b9c171.16682a.3705@mx.google.com>
Date: Mon, 13 Jul 2026 09:18:12 +0800
X-Gm-Features: AUfX_mxPPRLf4l7ae4Lnlfy6xWNdTkZoF_xkaQBcMLcQlIIh7LXpMntBLeE-yyo
Message-ID: <CAOcRiAFAmLML2hgFuceCN5LMw=sxKXA1N8BGDoKo8EascOBmeA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ltp: syscalls/madvise09: Reset cgroup memory
 limits before test retries
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
Cc: Wake Liu via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QWNrLiBBcG9sb2dpZXMgZm9yIHRoZSBub24tc3RhbmRhcmQgY29tbWl0IG1lc3NhZ2UuIEkgd2ls
bCBjb3JyZWN0IHRoZQpjb21taXQgbWVzc2FnZSBhY2NvcmRpbmcgdG8gdGhlIGd1aWRlbGluZXMg
YW5kIHNlbmQgdjMuClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrIGFuZCB0aGUgbGluayB0byB0aGUg
bHRwLWFnZW50IHJlcG9zaXRvcnksIHRoZXkKYXJlIHVzZWZ1bC4KCk9uIEZyaSwgSnVsIDEwLCAy
MDI2IGF0IDI6NTLigK9QTSBBbmRyZWEgQ2VydmVzYXRvCjxhbmRyZWEuY2VydmVzYXRvQHN1c2Uu
Y29tPiB3cm90ZToKPgo+IEhpIFdha2UsCj4KPiB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgdW53YXRj
aGFibGUuIEl0J3Mgbm90IGZvbGxvd2luZyBhbnkgY29tbWl0IHN0YW5kYXJkLAo+IGluY2x1ZGlu
ZyB0ZXh0IGxlbmd0aCwgZm9ybWF0IGFuZCBkZXNjcmlwdGlvbi4gUGxlYXNlIGZvbGxvdyB0aGUg
YmFzaWNzLAo+IG90aGVyd2lzZSB3ZSB3aWxsIHJlamVjdCB0aGUgcGF0Y2ggYmVmb3JlIHJlYWRp
bmcgaXQ6Cj4KPiBodHRwczovL2NiZWEubXMvZ2l0LWNvbW1pdC8KPgo+IElmIHlvdSByZWFsbHkg
d2FudCB0byB1c2UgQUksIGFzIGl0IHNlZW1zLCBwbGVhc2UgdXNlIHRoZSBydWxlcyBpbiB0aGlz
Cj4gcmVwbzogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAtYWdlbnQK
Pgo+IFJlZ2FyZHMsCj4gLS0KPiBBbmRyZWEgQ2VydmVzYXRvCj4gU1VTRSBRRSBBdXRvbWF0aW9u
IEVuZ2luZWVyIExpbnV4Cj4gYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQoKCgotLSAKQmVzdCBS
ZWdhcmRzLApXYWtlIExpdQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
