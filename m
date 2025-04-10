Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540BCC3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744308774; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=zTnDfyeYfQaEk/c2uDV0CADaIJMj5D2hai6xIZa7cvg=;
 b=mXNK7nJOGlXaGjBwj9x+LMQ/8bKsdWkBuWUnmz2PR1t4gSeRIIxpJWkxl2vwk25YnONuv
 kYGXcAKZwk/DVn4frMrdzRC1qjsBt0MkFzksWxy9Ewyt2qlHt6tT3vX+kttFUtWsiCxG28W
 iEeZpkFK74QSnXs1JiiibxRiRG2Fkrg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C38783CB536
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 20:12:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C1B43CABDF
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:12:32 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 21615600479
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:12:31 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso11912905e9.1
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744308750; x=1744913550; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h9y9jg6TLhoaFTU86osy5pft3n5Fkcawa/eBzQ/ZxUY=;
 b=gs+o9fowaNg1MDX/GR38odlV8MXTj/7DVHGa3E3CUs/ziFJ279Y1VoxIFFvchf/Mcm
 I6VI+L6K/MI/SCOPwEwPKkVqNpf12D/+JxCoL9Gubm+iJSm6dHFskmPLZ+0bPEyBa8Dd
 M0e8IFuJOxOr7POda5j+p8fv9CW86wTWlr8T2/t5AAhnsNAPwQmuXyufSQuXujEbddkB
 cdz6Euip6AORIFBAJZVCvJgIFSsWzc6hFuJhrRmu2Ye4bO9E9Yg1MWaEz/f0qOXSRHwo
 IhcJGQDmluurjwWpgAqKc8hwTI6buPjkA6/JnxTe+84MU7TKH8bTSeWuVd9v0voh3Xst
 tOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744308750; x=1744913550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h9y9jg6TLhoaFTU86osy5pft3n5Fkcawa/eBzQ/ZxUY=;
 b=O1fADFPcI18AsqvTCri4IG/jASPSKIZOGhLS6LUYQukrpYN50VBlPXJE/Mb6ezOrOm
 wLgUmpUTk+NEQfp87yGmFxrKzIyyt52IPzUfFH3tQha0NB5ysrzdxLsGpi3rntNNv7k2
 k+9l5h1SwLvErOXTnp1j8Tbr0Wwa6eKbkkc2fL8QJrFT8/FOId9fSX3/X/XAeX+bY2oD
 JSCywan4whSV+5mWsQScu2mnaj2dYqOqTmeBrvLYYs+jmidIaQW0VeE2MJI/zcLNRKu7
 YLECtuwhPVFoRwb+6uXgFW+PpHcHF1zsXIQxxxqGZGjB+5aL6cIp4cNOzfR6gGqzgR0S
 9YXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/SSzuYAEhSWIXZJc7tpETSmqsUbx0TzqB+4cdEEiEqlXdEBooRHUkJ8dB2GYewh1lTt0=@lists.linux.it
X-Gm-Message-State: AOJu0Yzbbm6VDxXf1GUzOY1dVj9MWBE58cNVVojiJkH+8Kgz22SQyNkA
 hiiCObwD/SRqFmCbsPH4k6CRhJnq90FxPW3pjK2kzpaqX+61ZETkZbmjHmxRncisGB3IR0rDeY8
 h
X-Gm-Gg: ASbGncsVCKBiJLKWo71aoT2a1eBlKDH419FvSHmoLDJv+ROy9hslMFRiEV3FlGQ/d16
 ALooJgj2PXG/9lV6rAN6VvkHDuWVDPOxqW5qY90a9XRs+Id0YMw/BPSfcHbJtAYO7US0I5LMzS3
 AP2QSNyOk1YEpoAxzCCKzVgjeakBsPK7RK6JSFNZrGJVrWUUYqhx9wmfw+dBAW+77ISO5m+1ppx
 m/7SZU3lW4pwZK5Xa72yJNoQUOG9rs763JsZJrFx4Sy5ZmfM8P70IjD9hnaU5T8Yaw4PGfoo8Sp
 67UyuylnBqiJk62WNNx7L4UvwMwj9l0W52kaUOlSTbI0qakjC9zRpgKg/bNGOW6GbTB2nwCB+Vs
 MuY7TB0qewu2cDzSYoNEFwn0flYf6sqszorJqGD+TPk35Wbh7SToA4HOYUT2Kvio689mpOHN/Vy
 YqEXQ=
X-Google-Smtp-Source: AGHT+IGrtpPdICDdX3hdQlTa5YcPFi2oNniNWsGgbX10DD+doy9wW7a1bMmehKc2KD/ukEMoIvw0pg==
X-Received: by 2002:a05:6000:18a5:b0:39a:c9ed:8657 with SMTP id
 ffacd0b85a97d-39d8fd72838mr3193225f8f.17.1744308750474; 
 Thu, 10 Apr 2025 11:12:30 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893fdf3bsm5411910f8f.83.2025.04.10.11.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 11:12:30 -0700 (PDT)
Message-ID: <58db04c5-2bce-4aa8-8806-b41757fc63fa@suse.com>
Date: Thu, 10 Apr 2025 20:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250410-patchwork_ci-v1-0-def85825f46a@suse.com>
 <20250410-patchwork_ci-v1-3-def85825f46a@suse.com>
Content-Language: en-US
In-Reply-To: <20250410-patchwork_ci-v1-3-def85825f46a@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] ci: add ci-patchwork-trigger workflow
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

QXBwYXJlbnRseSB0aGlzIHBhdGNoIGlzIHRvdGFsbHkgbWlzc2luZyBmcm9tIHBhdGNod29yayBb
MV0uIEl0J3MgCmNsZWFybHkgYSBidWcgb2YgdGhlIHBsYXRmb3JtIGFuZCBpdCBtaWdodCBhZmZl
Y3Qgb3VyIGF1dG9tYXRlIHRlc3RpbmcsIApzaW5jZSB0aGUgInNlcmllcy1jb21wbGV0ZWQiIGV2
ZW50IGlzIHRyaWdnZXJlZCBvbmx5IHdoZW4gYWxsIHRoZSAKcGF0Y2gtc2VyaWVzIGFyZSByZWNl
aXZlZCBhbmQgaXQncyB0aGUgb25lIGNoZWNrZWQgYnkgb3VyIHNjcmlwdHMuIEknbSAKc2NhcmVk
IHdlIHdpbGwgbmVlZCB0byB0ZXN0IGVhY2ggc2luZ2xlIHBhdGNoIHZpYSAiYjQgc2hhemFtIiBj
aGVja2luZyAKInBhdGNoLWNvbXBsZXRlZCIKCkFsc28gYjQgY29tcGxhaW5zOgoKR3JhYmJpbmcg
dGhyZWFkIGZyb20gCmxvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA0MTAtcGF0Y2h3b3JrX2NpLXYx
LTQtZGVmODU4MjVmNDZhQHN1c2UuY29tL3QubWJveC5negpCcmVha2luZyB0aHJlYWQgdG8gcmVt
b3ZlIHBhcmVudHMgb2YgCjIwMjUwNDEwLXBhdGNod29ya19jaS12MS0wLWRlZjg1ODI1ZjQ2YUBz
dXNlLmNvbQpDaGVja2luZyBmb3IgbmV3ZXIgcmV2aXNpb25zCkdyYWJiaW5nIHNlYXJjaCByZXN1
bHRzIGZyb20gbG9yZS5rZXJuZWwub3JnCkFuYWx5emluZyA0IG1lc3NhZ2VzIGluIHRoZSB0aHJl
YWQKTG9va2luZyBmb3IgYWRkaXRpb25hbCBjb2RlLXJldmlldyB0cmFpbGVycyBvbiBsb3JlLmtl
cm5lbC5vcmcKQW5hbHl6aW5nIDAgY29kZS1yZXZpZXcgbWVzc2FnZXMKQ2hlY2tpbmcgYXR0ZXN0
YXRpb24gb24gYWxsIG1lc3NhZ2VzLCBtYXkgdGFrZSBhIG1vbWVudC4uLgotLS0KIMKgIOKclyBb
UEFUQ0ggMS80XSBjaTogaW5zdGFsbCBkZXBlbmRlbmNlcyBmb3IgcGF0Y2h3b3JrLWNpIHNjcmlw
dAogwqDCoMKgIOKclyBObyBrZXk6IGVkMjU1MTkvYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQog
wqDCoMKgIOKclyBCQURTSUc6IERLSU0vc3VzZS5kZQogwqDCoMKgIOKclyBCQURTSUc6IERLSU0v
c3VzZS5kZQogwqDCoMKgIOKclyBCQURTSUc6IERLSU0vc3VzZS5kZQogwqDCoMKgIOKclyBCQURT
SUc6IERLSU0vc3VzZS5kZQogwqAg4pyXIFtQQVRDSCAyLzRdIGNpOiBhZGQgcGF0Y2h3b3JrLWNp
IHNjcmlwdAogwqDCoMKgIOKclyBObyBrZXk6IGVkMjU1MTkvYW5kcmVhLmNlcnZlc2F0b0BzdXNl
LmNvbQogwqDCoMKgIOKclyBCQURTSUc6IERLSU0vc3VzZS5kZQogwqDCoMKgIOKclyBCQURTSUc6
IERLSU0vc3VzZS5kZQogwqDCoMKgIOKclyBCQURTSUc6IERLSU0vc3VzZS5kZQogwqDCoMKgIOKc
lyBCQURTSUc6IERLSU0vc3VzZS5kZQoKLS0tLS0tLS0tLS0tLS0tLS0tPsKgIEVSUk9SOiBtaXNz
aW5nIFszLzRdISA8LS0tLS0tLS0tLS0tLS0KCiDCoCDinJcgW1BBVENIIDQvNF0gY2k6IGFwcGx5
IHBhdGNod29yayBzZXJpZXMgaW4gY2ktZG9ja2VyLWJ1aWxkIHdvcmtmbG93CiDCoMKgwqAg4pyX
IE5vIGtleTogZWQyNTUxOS9hbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCiDCoMKgwqAg4pyXIEJB
RFNJRzogREtJTS9zdXNlLmRlCiDCoMKgwqAg4pyXIEJBRFNJRzogREtJTS9zdXNlLmRlCiDCoMKg
wqAg4pyXIEJBRFNJRzogREtJTS9zdXNlLmRlCiDCoMKgwqAg4pyXIEJBRFNJRzogREtJTS9zdXNl
LmRlCgpUaGlzIGlzIHNvIGZydXN0cmF0aW5nIGFmdGVyIGRheXMgb2Ygd29yayA6LSkKClsxXSAK
aHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9wYXRjaC8yMDI1MDQxMC1w
YXRjaHdvcmtfY2ktdjEtNC1kZWY4NTgyNWY0NmFAc3VzZS5jb20vCgotIEFuZHJlYQoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
