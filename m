Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CF2C7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 07:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750665122; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=9S8U8wwt3OGrCFp0rW1AC4XFhqc//4IARucfRieCpPA=;
 b=TgdPdmyexpbtX7saahdG31BOQKmCnsWgf7lt57zGu3eAFjiEu2oYvGqSjDOD8I3DBFLC5
 GUtAajZ1HPu+klGfRLWjRbY3TnU32IZNHu3ubqEbnX+YmuD6XdhdLbz671Y4GkPNZstzkje
 WAIcSikAmuTSTNgh3PPEYYaXj7Oekv8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 592673CCA77
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC0363C990D
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 09:51:39 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CADB66001A2
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 09:51:38 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-607cc1a2bd8so5817201a12.2
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750665098; x=1751269898; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i3c+hunsgbZdRSHHaA5EMT8BUmrQkc8nB63JPtPi5ks=;
 b=Qhfxn3FENkNANhy+LQw+P2ar0iW+dAg0Ece4uvzqHwgZuspvx3dR87j1kr1hypeTBG
 Et54hc6ILIEUufynWRddrM/01dOjpKt45gLgVZH+IsirkC0aBdDioxTiYEQIK2Le0XUG
 uEd763c/xnLVINn+gb4uJe9e89xi/jOTQRfcxFVDHkM7WHIRUv11SizVEeUKj5xcvxab
 IEfq2a9+0Os2cNa+4DNNevCpnlThZEBfOtQBY/UzUPb2NLuTFfXVnrbuegIECJozAC2D
 T4311X/ycjm6WzAy8SEG1zPp1J5y+h41qG82x6WONRtnBkpQF2fMG0Qtp9CWpvxGUMw0
 oHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750665098; x=1751269898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i3c+hunsgbZdRSHHaA5EMT8BUmrQkc8nB63JPtPi5ks=;
 b=w5lZsvld9V5uSrH5IYFBXnK76L5KFOkRR57cRzu+yNhZhMKEFVrkekRIKVg6YtAiYn
 xmwCwmPKQ5Etup2AF+jCKCs27bidhoRwyQ7v0mJcFght2ekrN0Is4aPr5LTIPC+ffOVW
 0IsDwyHuwOJGq0HFBwE95xiUjqyZDKUkfzezAbsp+YaiCoSuCUqQT+V108NsLM75oTX9
 9a6po9QweMkizEDBlMLPvhNP7qhsImIFPtYBVGOI0LEhUys1wY0/RhirCqbWFxBy/NgH
 JBFurTtDb4DByQPb2BvWmuQW+uvO+tlDbu+txpfJpyLRN8irhZlDoBfOAgXvDbuf/PII
 PzZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUllbNfjwSp1W6twcGnyInvqSxQa+v7vzn7BzcZAMqMMn28aQ7GMkfLrLh/f6Kf2Q3y2Jg=@lists.linux.it
X-Gm-Message-State: AOJu0YxobR6bw2jHLLFQj5wRRcqCPDAHkv/RisXA6/YNfqJaKuGXymI/
 99g9LTk/Ob6AyJBEFXkSXILzqJjTADdD5f5mpHHY9k7UuLEIbHdGsE5EzLpY0NixeJU=
X-Gm-Gg: ASbGncvbN3OO3AoUWAHOACWvU3jnU06FiHV76OmPwyENDeweMCHlJwuvTUDv/LYs5z6
 3oYnqvLfH0uDJYWq6S5ow5RgBMJ6y8E536P/UjvUzn7YVeRBuEGCUE86hHAp6PspzjZ1vXmOtEb
 xMo3buMJFu62GlJb/IdM3vf3lRcfBbCDMsCw+TUYYVoMBkU5S2GmhO2o2IT3mgbd9ICayNDS5z2
 X/8Fr50DeyiEiGxukxTCQhJpZe8L1qFY1FdDYOh5WBUXzFHaMszpyFCuqjs1+c2QafJBduuKsYz
 ksqPf0NTxdXri3xv3aLEbMyJa4m/001eVWNyhO5MfnH2XDhDHq1sVUPdqxp8N5Imq5sUSShBkyC
 BHFL78qDNRBG0K/s7zTK+i8RRlpQ8CKXTOhddVYk/
X-Google-Smtp-Source: AGHT+IEmXnwoMaxYMIy3g8uHVqERjimlkxcOEVr0MyQzEAOUWOx7eLERlmnSoIe3jvxPfrD7YT+kzQ==
X-Received: by 2002:a05:6402:254a:b0:607:ff13:3a24 with SMTP id
 4fb4d7f45d1cf-60a1cf2e115mr11769925a12.28.1750665098169; 
 Mon, 23 Jun 2025 00:51:38 -0700 (PDT)
Received: from [172.20.10.3] (ip-109-40-48-204.web.vodafone.de.
 [109.40.48.204]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60a18cba650sm5573639a12.55.2025.06.23.00.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 00:51:37 -0700 (PDT)
Message-ID: <bc5821ea-f5bf-4366-bdfc-23817098eed1@suse.com>
Date: Mon, 23 Jun 2025 09:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250620-conversions-shmt-v2-1-56cae20e184f@suse.com>
Content-Language: en-US
In-Reply-To: <20250620-conversions-shmt-v2-1-56cae20e184f@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mem: Convert shmt02 to new API
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

SGkhCgpPbiA2LzIwLzI1IDExOjQxIEFNLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB2aWEgbHRwIHdy
b3RlOgo+IC0Ja2V5ID0gKGtleV90KSBnZXRwaWQoKTsKPiAtCj4gLS8qLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCj4gLQo+
IC0JaWYgKChzaG1pZCA9IHNobWdldChrZXksIDE2ICogS18xLCBJUENfQ1JFQVQgfCAwNjY2KSkg
PCAwKSB7Cj4gLQkJcGVycm9yKCJzaG1nZXQiKTsKPiAtCQl0c3RfYnJrbShURkFJTCwgTlVMTCwK
PiAtCQkJICJzaG1nZXQgRmFpbGVkOiBzaG1pZCA9ICVkLCBlcnJubyA9ICVkIiwKPiAtCQkJIHNo
bWlkLCBlcnJubyk7Cj4gLQl9Cj4gLQo+IC0JdHN0X3Jlc20oVFBBU1MsICJzaG1nZXQiKTsKPiAr
CWtleSA9IChrZXlfdClnZXRwaWQoKTsKPiAgIAo+IC0vKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLwo+ICsJc2htaWQgPSBT
QUZFX1NITUdFVChrZXksIFNITVNJWkUsIElQQ19DUkVBVCB8IDA2NjYpOwoKT25lIGxhc3QgdGhp
bmcgSSBmb3Jnb3QgaW4gdGhlIHBhc3QgdjEgcmV2aWV3OiBpdCdzIGJldHRlciB0byB1c2UgCkdF
VElQQ0tFWSgpIG1ldGhvZCBpbnN0ZWFkLiBBZnRlciB0aGlzOgoKUmV2aWV3ZWQtYnk6IEFuZHJl
YSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+CgotIEFuZHJlYQoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
