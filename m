Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AFEC8303D
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 12:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751630854; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=TeT2mTUSipnN6p6XCTtqb0h6BaUhDj0PnioQ1gTQJp0=;
 b=RoGNjk66sa4TTybjyBSz2ekU+dr20k3XP0WxKnrf81tRkuM8j6U7Y44yQpOpxA1usWBtG
 LVvNgYpcytrnSw1b4fSkYYXhDm3EvudiUBdx7v7uxiiXGnaNt7I4fzgH5IZwecDrpA+nuxV
 bmm4G91RlHXP0oiCIHLBl5wc/etN8T0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 707F23C9ED7
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 14:07:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43E8B3C2648
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 14:07:13 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B578D6000F7
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 14:07:12 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae0c571f137so177626966b.0
 for <ltp@lists.linux.it>; Fri, 04 Jul 2025 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751630832; x=1752235632; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D30Q+rqh6gdDuCcdawOVpHOa6wlg6QdA8zWbCT9c/o8=;
 b=CKCwRRQX7N1SfonkpbGxZfpSe68nWGzkDfb3f7ou8iNUBD4ProMyl4HdlF/A4UA3bF
 3iYR03ADiTwRztb+yIUJlC06FHuk8A6sSjwoHtcGNrlPtWYD2RIrPceLF2qd5/ffBmH/
 jky+3L3R4UmQoxjF1PIYWexUQMuwfL8kibQUioVJMc10wf/0aH70XQHalf+Va7ZwjiOw
 EvOTh7yzKL5kQxV+bhO9ftNF0gfkrj/r0IyRx15D62OYnYG+Gp+8oVCncVCW8gqjyLQA
 tDl8LWfZH4gTlEXtRes3UkNHKSFVcqbbc0s4589Vftxf289h/i/lzICdUmPR35HjVn3b
 H1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751630832; x=1752235632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D30Q+rqh6gdDuCcdawOVpHOa6wlg6QdA8zWbCT9c/o8=;
 b=aj8jjQMx4i2U7Pxs/J1m3gYvnh1ztDltnuytqo32e/ZSdHJgv7CEB+MqWTPrC6CJ44
 VoAqludDlQM5R7JXAgs50ok0jmWXLwHlaTBTqycb8t/qzZHkyzZViwXXLrAq9S7U9xub
 D+2qbpmdUWUi9MnlJi3WI0Eg3MuF5/GQFHNO89Y4lTBfa8ZOWQ4ShpOgscN6wR/w1TTW
 EXfhgOsok6TPh/332udIc/+MB+jrTVLRhZvxGARAeG/K/KeHHW9gersZecMcYQqI/YrY
 hkPrqC10eNtD8OYFgmhgIof8exCP1RiFzJNHnbGVCisYNTLNSb3jv4RmW7ezI27d6mAU
 95KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRZMpadyFiL+YFfjUHBJ4ebJ/NOB1R88Lq8q/6j9ue2s26NXPNN2OPLHMu/OHU8jscHDs=@lists.linux.it
X-Gm-Message-State: AOJu0Yz2+FPtLgrBpTruTVBLIV1YCqwY0K53QEXi1hK/kQpfhh0PDi+o
 6O8ClAb8IcNDg653BJCT3PC62da0f/7Lb8CE0P1iQZpNNeCpB+URhoZRz/VYrWDY2s6HzZIZKph
 zCJLIBf8=
X-Gm-Gg: ASbGncuK22tKHD7iGLKJWe6drMMTfCit9IUZ/zxSuoCd1GKNtYeI9V0wEa0OISX9ycN
 no4ZCh/iVsWqTsEY4GjYdkG7MG3BGGQZhwSHHEs8eYFdDRsYpqKOJIypwaIYKwpexZaTPoksQvm
 8gkjdmXAyCEaVWHJX3So2PjFaL9lani00v4C/2AKA3Oo2Vv/lKtC+hbe2yDnLu13tb/wkiTu+IU
 Ry+c6VdTDDXs8JQ7ZtjgF/l/yfaSFrSsVimNaMMz4LJqVHWb0aMBQ01G8Fd+q8lsfdUIuSYbTSs
 GqqwraKszdwr3I1KFzbXM21tdr3xfwo0qbaTIFr/MXwssEcKWWrUAbDloGg4jDLy9/XinsxfLL6
 EDMvRWrD1JJeP9zM6djoj4b61osO9V8EHG/OUmXBnJRKiWMf4
X-Google-Smtp-Source: AGHT+IG5cbhjaaph2Gw+LCGwtipgVn0EqiYuCmzeFDZiCKvSXuShtulxDmNKPB3r5zGZoFl+RqP5jw==
X-Received: by 2002:a17:907:1c90:b0:ae3:60e1:11bc with SMTP id
 a640c23a62f3a-ae3fbc74d0dmr236652066b.16.1751630831924; 
 Fri, 04 Jul 2025 05:07:11 -0700 (PDT)
Received: from ?IPV6:2a00:20:6352:18eb:c039:9047:2cde:cb48?
 ([2a00:20:6352:18eb:c039:9047:2cde:cb48])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b0335fsm158870466b.129.2025.07.04.05.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 05:07:11 -0700 (PDT)
Message-ID: <25881028-30bf-4a7f-bbe2-97a8de421c70@suse.com>
Date: Fri, 4 Jul 2025 14:07:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250703-conversions-munmap-v1-0-30de82d59004@suse.com>
 <20250703-conversions-munmap-v1-1-30de82d59004@suse.com>
Content-Language: en-US
In-Reply-To: <20250703-conversions-munmap-v1-1-30de82d59004@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] syscalls: munmap01: Convert to new API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNy8zLzI1IDg6MzkgUE0sIFJpY2FyZG8gQi4gTWFybGnDqHJlIHZpYSBsdHAgd3JvdGU6Cj4g
K3N0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKPiAgIHsKPiAtCXRzdF9yZXNtKFRQQVNTLCAiRnVu
Y3Rpb25hbGl0eSBvZiBtdW5tYXAoKSBzdWNjZXNzZnVsIik7Cj4gLQo+IC0JLyogSW52b2tlIHRl
c3QgY2xlYW51cCBmdW5jdGlvbiBhbmQgZXhpdCAqLwo+IC0JY2xlYW51cCgpOwo+IC0KPiAtCXRz
dF9leGl0KCk7Cj4gKwlpZiAoZmQpCj4gKwkJU0FGRV9DTE9TRShmZCk7Cj4gICB9CgpBbHNvIHJl
bWVtYmVyIHRoYXQgdGVzdCBjYW4gYmUgcnVuIHdpdGggLWkwLCBzbyBpZiB5b3UgZG9uJ3QgdW5t
YXAgCm1lbW9yeSBpbiB0aGUgY2xlYW51cCgpIGZ1bmN0aW9uLCB0aGF0IHdpbGwgcmVtYWluIGFs
bG9jYXRlZCBpbiB0aGUgc3lzdGVtLgoKLSBBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
