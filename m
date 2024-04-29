Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBF2C4345F
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714431455; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Ijv/4mNw4frTEuSyqiXuZmUtpnYvspKT9D+Ui3vhodA=;
 b=GorjhB6ea47q89Wh/fE7830ntzqrJVqIUGfeIJwgOMEmPwOrlzfv1vbRop/UI7eP08ZWC
 6DJ7O6mKFlnaBIgCotNncU1L5teO1n8Ini1y5XRV9UcpGPoBDDuobt/DLd03lMf4e9vu1Fu
 kABDGjoQE6vXH5XUvycH6f9DVycOM9c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F0503C8B51
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 00:57:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63E963C0311
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 00:57:10 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2029E140033D
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 00:57:10 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41bff91ecdcso13395e9.1
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714431429; x=1715036229; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+PgiAESGbFFbp3T9dRz2+CZP1AQfjbVJj81YEx9xO4=;
 b=ITTIwmsjVFWi1xb8zmdIYutKGmmj4DeaYRy3e7E8kfmhZz0WKTpKWVHR9/eczDmnuF
 vDY4Poqd3W7R06VetIPf0ikUOYoZ+m5zeOuzEi9k3PqbFd9JsxSxnQ9zwHu09BFabzgv
 cytyap4WWqwRXrxEnPmVBi/D3rIs0ZJKJ1W1Xj2ZXlKOfQ5Kgh7hoDxFEtOEVcnX+sru
 X/hUyPj+5KZBu9kHyyntX5nxfaywxUzdSv+0syGbu7OmAFS9VW+Z61oGC+uX40RhTTfS
 qnZNzdllqX4t6izn9mmPHa3IefcKNBjNKn7ZSYh4wrQfUQD1O6yYcZODoq6enmkFawZu
 MqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431429; x=1715036229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+PgiAESGbFFbp3T9dRz2+CZP1AQfjbVJj81YEx9xO4=;
 b=cjUZ/Gdu1uPXq0yH3glMnU/75Xqic9e6f0QfN/hLSX77YTcmp/o1b70z9bxfXovW5S
 /95mNSJQw+R4ksZvDJ5wNFwCGsoMatCAAP1sw9azrE8m77RQ/Nq5f4HvvjdvpeEFn4ef
 VxxKPE05l+Z1HMU9e5+W8ZrCQMzXC52GxSJ3nmiJwLWDjblZh1EpRxppQJoXV0eugi7o
 sLV+eDWsxwLusffiduTlQCo7DxDROiUGb//UB+PKq40chSlrtOJy5tJlWmUcjMdYlWJH
 tLg2O5X7gn1rGHn/yftV53bT7KjZnK+XUvIZL1YFXwQeBX/SFwUvAGBCYeay+ATGkWau
 aXaw==
X-Gm-Message-State: AOJu0YzGNJbBluB8aoD1gcYHycZAimCAeiDZUZdyx4H4dKbzxZ9Vjk3Z
 5Mt6AWOqxNYahZBU5lFMtG12K2pzvsfbMMpTAYsScWTXcUZ6SEbcEoMS0P9UtyPA4yNZUbzJJlX
 91l2dpvQFDuHsNQFPyrRUL39NSBMAITApBSc=
X-Google-Smtp-Source: AGHT+IEZHvvUNkhN+sBAgq7O2cBVFHDDFcBjkadMaSq/HXgYQtgthVChTYUeKI2yzHDCZb3GjCRlBo+K6g2Jmz4Da3I=
X-Received: by 2002:a05:600c:5021:b0:419:fa3c:fb46 with SMTP id
 n33-20020a05600c502100b00419fa3cfb46mr36091wmr.5.1714431429504; Mon, 29 Apr
 2024 15:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-3-jstultz@google.com>
 <Zi9jL1jycx6oo37g@yuki>
In-Reply-To: <Zi9jL1jycx6oo37g@yuki>
Date: Mon, 29 Apr 2024 15:56:58 -0700
Message-ID: <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBcHIgMjksIDIwMjQgYXQgMjowN+KAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+IFdvdWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0byB1
c2UgdGhlIGluY2x1ZGUvdHN0X2F0b21pYy5oIG5vdyBpbnN0ZWFkCj4gb2YgdGhlIGZ1bmN0aW9u
cyBmcm9tIGxpYnJ0dGVzdC5oLiBBdCBsZWFzdCB0aGUgdmVyc2lvbiBpbiB0aGUKPiB0c3RfYXRv
bWljLmggaGF2ZSBwcm9wZXIgbWVtb3J5IGJhcnJpZXMgZm9yIGxvYWQsIGZhbGxiYWNrIGluIHRo
ZSBjYXNlCj4gdGhhdCBjb21waWxlciBkb2VzIG5vdCBzdXBwb3J0IF9fYXRvbWljX2ZvbygpLCBl
dGMuCgpJIGRvbid0IG9iamVjdCwgYnV0IHRyeWluZyB0byBpbmNsdWRlIHRzdF9hdG9taWMuaCBj
YXVzZXMgbG90cyBvZgpyZWRlZmluaXRpb24gd2FybmluZ3MgZm9yIFBBQ0tBR0UsIFBBQ0tBR0Vf
KiwgYW5kIFZFUlNJT04gd2hpY2ggYXJlCmFsc28gc2V0IGZyb20gbGlicnR0ZXN0LmggLT4gcmVh
bHRpbWVfY29uZmlnLmgKClN1Z2dlc3Rpb25zIG9uIGhvdyB0byBwcm9jZWVkIHRoZXJlPwoKdGhh
bmtzCi1qb2huCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
