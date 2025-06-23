Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3B1C7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750666624; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=EM28olA6KYWrmVmLo+FoZGoqT1EMq8uT5uNVfC3DOGY=;
 b=B4LX4z2HA8xQ+uvL39Cg114os33qMUeoSr4NAsacZ955h8fHNrsL8v8Toyw3svJSRvF4c
 4M6xqhKUotrd7CnbQM6VNa6O09DBZWzkZaCTjZkhSI4qu+3i3v2fiBEDxCKp7nzjspVNTtZ
 EV7nbWX24Ssga0I6sAyMY1ek6olBZzc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50E8E3CCA79
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 10:17:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F07BA3C0E44
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 10:16:43 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7B1091400773
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 10:16:43 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ade48b24c97so681553966b.2
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 01:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750666603; x=1751271403; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uT88PuDD/t+ZUZwAZ70KegIkG3WMVXuYI8gmLvYK4u0=;
 b=WLOK7KQTwUNzZbZlwqPOI0tvWaDUTzfeDBv0K+GJwN9mRUvqNwnhYGjBjpt4cR2KeQ
 SJcmn0io6knWJl2plncuLl43vz2SQUk5MZACDtfWYHGDnKI0zA/aiheiDqX5OPgitBw8
 0i/ixKS+A+qqQt+hfpWTqc6tS0uQJDXucve7StCGAvFwDyzDJ0FGXUCNfF19rgBDRxIX
 ho7pmuruh8UQSFKEU46ITHFkbdrn0QieStiGGWdfu0K+DhKOJhP3Nx2RrmPy8V+XGw37
 RqwI+yLENVFm9N2AV4wR9eob1ADX/xktVFzwzX3mNKtiiQEcFAXoAihXhG0+3LoLUx4h
 b0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750666603; x=1751271403;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uT88PuDD/t+ZUZwAZ70KegIkG3WMVXuYI8gmLvYK4u0=;
 b=Ky/Y45O+8e8lJRl/qDbepo3zIDGheRZSiUD7jqbPvJSkKNlAGsuOO4Dn9ht5skRYIu
 QIb9rm3cq3igFogAXtxFriU7L5WAWMSb+C3aj9KTvc+dLGUnGLH1ux7KFls0TZEpo39c
 bfJ2a9PFg68FETGU/MQG6qwa/NhdxfchwuymhDrn81zDDEaN+6uPlhnrLeZXai4OZZ7k
 TaqsjpJvZdUyM6UWG9csS9ZljH95JqW82VXs5f2V2aC1yCvhubSy+zihmK7ongn3x6HM
 i8G2BdwymkwsVUWkeE6MLQaWnu+7JN6/ZIxkOJCivxhFT/pu5jR1mKq4zbndaGMb2LKX
 qxgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9/2pop009YcHYN/Ww1KxIaKnmlpf/UXOgN/u/LTyetG828SRx4D4qqyv+sqN5sjqHTSk=@lists.linux.it
X-Gm-Message-State: AOJu0YxRz05c4b+Qm55w+n5BmdOsj40XDsxVB6gGKkYgitWXCc5kPHZM
 5/9SxhLc9J96AEUncwug2SLuAXzGi4fYoUN9z1u/fQ5vgrJCulyf+f++6i4eL8AqWotjiyjgM36
 YH+u7kSChxYbT
X-Gm-Gg: ASbGncsfk3YbFYIO6FLAmEvBCS7tjlpjMdYCE0X9BnZMV3fs+QenjpMr3YAK8BBiZDJ
 Te+09msy/GZjkdlHZWhpBCcw8XnDi7jSlMnMy+ppOLbTE1AbMKwTBKR9CPveh4pidohnIAi0H9B
 XCXbc1r/aGIueexDB053c/xKlpCplQNhfvFXrbEK0wwQ8uSIUdyE2aPJVy5f1D98wODaL45aIxA
 XXAl1GWveKxS520+UAjyo51+WFKwnQOW+NPnoS1ZyqEX2OIytmemlYPIreuBoPR0eW34fFKaQIW
 aR0HRJEFY0oQ8YEAz+pmku40HTk5OT792MHJp6r5qA8MIRvT3ckEZwbWUHjgdR7mryCrlhZ/oYJ
 PVg9B62TB01QxEnruWcxgCEyga25p8kdhNX8JhgfX
X-Google-Smtp-Source: AGHT+IGOf5CW5DXyqUlXE06q/wM0G4JYro5DXIztIfkFrhlF6KF3oqDNY7KrNVd0NFINrdTTvwofcA==
X-Received: by 2002:a17:907:9215:b0:ad8:a50c:f6b7 with SMTP id
 a640c23a62f3a-ae057b6e710mr749256366b.28.1750666602833; 
 Mon, 23 Jun 2025 01:16:42 -0700 (PDT)
Received: from [172.20.10.3] (ip-109-40-48-204.web.vodafone.de.
 [109.40.48.204]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e821c0sm662114366b.24.2025.06.23.01.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 01:16:42 -0700 (PDT)
Message-ID: <e04bc6c1-1026-4f16-b141-bfbc2270c6d0@suse.com>
Date: Mon, 23 Jun 2025 10:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250620154346.19864-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250620154346.19864-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Two more metadata parser fixes
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 6/20/25 5:43 PM, Cyril Hrubis wrote:
> This series fixes a metadata parser for the ".filesystems" entry of the
> tst_test structure. First patch fixes the data storage to JSON
> serialization and second patch changes the parser to convert structure
> intialization with only designated initializers into a hash (object)
> rather than an arrray.
>
> @Andrea I suppose that the documentation generator needs a fix after
>          this is applied.
I will take a look once is merged. In general, I like the idea of this 
patch-set.
> Cyril Hrubis (2):
>    metadata: data_storage: Fix hash to json object serialization
>    metaparse: Map arrays with designated initializers to JSON objects
>
>   metadata/data_storage.h |  28 +++++++--
>   metadata/metaparse.c    | 134 +++++++++++++++++++++++++++++++++-------
>   2 files changed, 135 insertions(+), 27 deletions(-)
>
- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
