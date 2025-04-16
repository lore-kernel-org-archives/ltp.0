Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA18C369BD
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 08:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744791842; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=wcnt8JH8T/OpqoumECh4ZLd9MZbSYGAECv/jHW7DNIA=;
 b=CbGQOp37jco5FB4Vzv+ezquHYiVWrQf8pz+bpyCljD2LtLI3W5Hvz90lbyS4L1C6Qe6CQ
 sMcE/Yp+pI/kaLNqEhpLCaSOKfVp8Ve2ZoUyJZI570TGI90Lnq/DWfRMurA3s7P86oxZXWY
 6ZMKoO+uogxxxxY+LoAqFLG5arLcAlo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0331D3CB95C
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 10:24:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08C7E3CAB65
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:23:40 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0DF3360072D
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:23:39 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4749600f8f.3
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 01:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744791819; x=1745396619; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TYznuz5Gv7iYZuR7BR6KmRiY6OInuOEbkx7nqgBRSw=;
 b=Zxqgaz45P9p/t9StbZvJWg5KT+vPYqTNYceSlWS8LOgtACnJhjSiler3A0ck0YPcOv
 GHq29J5sXQlO7cmXMQpNPpUZEK7ekHcGhiIExq4sA6fT76erMxwDV26RT+TbxptKfd1s
 pQXaMCTfXOfoIkdjOa+NZYyElKDLTQUAKfnWDzBzZJAC+vGgmZ7OF1HvYYac4C2oXAEs
 nQjqx/Lw/woFnyRhUcWay2igp53ISNbJU4yJAC6KNR7V3/KVIJLb6BvNu1migkl7knN8
 amY/Bl75oA9TpZUHWivnAZhxJrhjBimxuW0ebofcqE1TG7CshLrddXBdVwI+Kp82EVy3
 F7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791819; x=1745396619;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6TYznuz5Gv7iYZuR7BR6KmRiY6OInuOEbkx7nqgBRSw=;
 b=bedwzFmWPn65ign5l5Fnj4FW2Ray1vS42+/NvhJ5WuLr7W/DQaciO8SJQF39rNzKT4
 5jd2QK5PKkFyxYRQ/ZEyDluykDGsCZ+vOdoR6Lt5zeODEFufiUEP+VraELlcCi9FCQh8
 0/BR+9jAWSpyuCRkwWCRicHO03s1OzhxuWyTzOy1k+QvtgOPVwZ/64hIykPRbGvYLH2D
 pLDiWW5z0JXvYYPW7/8vT51b0/xc/1mU3Bm77tHdqPl8V1BjJPDykbQKLr+PsyVhKTl6
 QX2zJ0NL/00jwBlM9bU65ykeapv0zj68RSBm1GfQVp4ZvplduR3LgZ8Db8+VnN68Xi8i
 HvnQ==
X-Gm-Message-State: AOJu0YwlWf2mob+223/5+soJMXdpXV10Xj+odmwpK3HPvHC2m7y/WrCD
 wRYQqpBCoOlVfoaREB7+oqTU/HvdLi6iaihiFx2IZ0WdGl+wj4mAbEyEXGSoTGB7rMjeWTVtPQu
 4
X-Gm-Gg: ASbGncu9WZjQ3IgQDbQMQVKx9YhrxXjY0C48Rjt1Jp761znnaz19ebQkuXbUGu2GHah
 EOxyNfIZKMa4hU6KM7mjV5KgOuMf7Cku8nd+ieupLIWtA1Rw8qI+OEBo55h8PgJ6Uv8NJnI2OKu
 3fXOPd6wPKdijeDIwm271TOvFL/C7XsviF8FWHO+KaesjJkWYlLRZ6g0ouKxEZ903zGer0JEpmF
 d/jIOBI+ATtZsd1p1hKTLwQSqLJTCagex3wIeULwXfYM1JtLksTbdf3YTVMR1f0mxTYsAateplc
 LghwDSZayTQXQUbKnO7l1T3idBykPa5lSrWlc+yeUks5S3JTNfqIiTBGhI24iE0wvQ20oG7a8Wo
 vkfmPk6GAopx1iFgTyybASE5tp0yFZ9cH50wxIkli5awsNHbCn9x1mgmlj8ina2R2wmG1GSiQC0
 PsjsqYe9XL022RYQ==
X-Google-Smtp-Source: AGHT+IGbfVGEVel7ZYWOZqXofBhjVadt0KtwjVGgEXluQFv5I5OpHRsBBJeD3/1lUaiarSpnrQVlTw==
X-Received: by 2002:a05:6000:381:b0:39e:cbc7:ad2c with SMTP id
 ffacd0b85a97d-39ee5b2f2a0mr829259f8f.25.1744791819327; 
 Wed, 16 Apr 2025 01:23:39 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae978018sm16233444f8f.49.2025.04.16.01.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 01:23:39 -0700 (PDT)
Message-ID: <3cfc1784-dbf1-4230-a1ff-3cce2336997f@suse.com>
Date: Wed, 16 Apr 2025 10:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
 <20250415-patchwork_ci-v7-2-bc0b9adca971@suse.com>
 <CAEemH2e3CX4-oW98HhPt7+CaiNf4OYE8k7EkvNnZCV7spuwQmA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2e3CX4-oW98HhPt7+CaiNf4OYE8k7EkvNnZCV7spuwQmA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7 2/4] ci: add patchwork communication script
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgpPbiA0LzE2LzI1IDA5OjA0LCBMaSBXYW5nIHdyb3RlOgo+IE1heWJlIGJldHRlciB0
byBtb3ZlIHRoaXMgaW5kZXBlbmRlbnQgdG9vbCB0byB0aGUgc2NyaXB0LyBkaXI/Cj4gVGhpcyBj
aS90b29scy/CoGlzIHNvIGhpZGRlbiB0aGF0IGl0IGNhbiBlYXNpbHkgYmUgb3Zlcmxvb2tlZC4K
CldlIHRob3VnaHQgYWJvdXQgaXQsIGJ1dCBzaW5jZSBpdCdzIG1vc3RseSBhIHJlbGF0ZWQgQ0kg
c2NyaXB0IHdlIApkZWNpZGVkIHRvIG1vdmUgaXQgaW50byBjaS90b29scy4gVGhlIHNjcmlwdHMv
IGZvbGRlciBzZWVtcyB0byBiZSBtb3JlIApyZWxhdGVkIHRvIExUUCB0ZXN0cyBkZXZlbG9wbWVu
dCwgc28gSSdtIGEgYml0IHB1enpsZWQgbm93IDotKQoKSSBsZXQgUGV0ciBWb3JlbCB0aGUgbGFz
dCB3b3JkIGFib3V0IGl0CgotIEFuZHJlYQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
