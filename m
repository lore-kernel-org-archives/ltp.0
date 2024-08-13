Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75EDC52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723539253; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=KSqXXntlgIiwdGqkiiFVq+losXg+cYWb1GEDc5Z7q4U=;
 b=B3i5vNP2uX1CKbmaej73PbGzCHs/C1y8XRUsEd27w2aD4M+mNjrnQ++2Cyr6RcvJvtaIR
 /T/jPUNklB9g9FwaK0HEcrCj+0O6jtWJsocuZ8URQMJZ3WW3oF1m2VlyoimMpAO1/u7PNX7
 5U4uKfpYprxFDZDpmF0uxVZe58y8FtY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 254973D211F
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 10:54:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74ECD3CCB17
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 10:53:53 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A0A0E200925
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 10:53:52 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7d89bb07e7so559563466b.3
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723539232; x=1724144032; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=STmzI+HDlhVVnS3GGoeblDUGyJIyoTKgDEZW5LBJlD0=;
 b=RF9WWuPgYm/JaTiThumL/E5yeW38Ilkxhryv5uK7AD7ake34DBFc9xi2HHCqNHXDoH
 VO413Ko+rr5ZaMSvM3obghHmpa+tT4YsifGufeLviN9CGaZZLLFJHvv9Bd/hEOF8hxuo
 Hj8y39afBlbwB/e2TeEhT/eFR7qyAO0T3VoP4FJ3MkLIA6PBamO9WJESsict6BpC4qSH
 wWc7/v8V9e6veFGApy33ZqLYPuKIWlfKi3zxTg/SqJvOvWoDN5EzmMCCj6GSJV03QCg6
 2MT8DpNjmum3NUE38IShc/bf9t7cxfJU4eT9j4pQdJzezZrLoCP2xwhU44id966F+apz
 wn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723539232; x=1724144032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STmzI+HDlhVVnS3GGoeblDUGyJIyoTKgDEZW5LBJlD0=;
 b=E5SAVqzfePWwFsinf9uKeyyqkJLKv3AAPAnXyNwetJTvTLg+9c5Lz2+83XGu+5NFfl
 ZHRBQ7QF8A21joq5Dn9aYCpz7GfoixVjkzaWU+t6OtrDyZeGYJ+q+AUX8rqqXjVfu9no
 7GYJwy3FC3lwJge03hgixcH1y22S2REzQEGZEDxMiYIEeq8q32xXH/zfwG4lH1fTgQrM
 QVTKISyvoEcd2PaZrbtcl3M79VOK7NYEWfmatRZDcJeC6l5RSM45NU+UGLhEqb95w6An
 cFIzKfRdwtmHdNM8PVhv/sQ6GbyhBCyGRF2NkDjdEu3cdTWayieS7AzjmiqInGVbmFBb
 08XA==
X-Gm-Message-State: AOJu0YwICdBa1O3K10zOY5+R5ZSBa1cVFeUE0dPKtthb+n4YnVGmEL/k
 lTf8Xx6oo0uuv+3WvOPrW7dM2NYIpMUKbIJ85UPD8N8FQXF1ygf/TTALdPdaMto=
X-Google-Smtp-Source: AGHT+IFvZmG8vBxBOOkKXjcWJE+vSloV/NvuaBlhjkWTnb3LBvFeoiY6+YLVHYlNz9lwGDOZ76xwQA==
X-Received: by 2002:a17:907:e6e7:b0:a7a:aa35:409e with SMTP id
 a640c23a62f3a-a80ed1c1eb6mr209424266b.25.1723539231358; 
 Tue, 13 Aug 2024 01:53:51 -0700 (PDT)
Received: from [10.232.133.86] ([88.128.88.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411b0f7sm51474066b.112.2024.08.13.01.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 01:53:51 -0700 (PDT)
Message-ID: <210cbd45-5df1-466f-897e-069a51c40d24@suse.com>
Date: Tue, 13 Aug 2024 10:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andreas Schwab <schwab@suse.de>
References: <mvm7cckdeqf.fsf@suse.de>
 <4b3c0504-93c9-4359-ab50-35fef5f7ee9c@suse.com> <mvm34n8dd1q.fsf@suse.de>
Content-Language: en-US
In-Reply-To: <mvm34n8dd1q.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix landlock06 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We had some testing failures in openSUSE TW which can be reproduced 
publicly in openQA, both for Jeos and x86_64:

https://openqa.opensuse.org/tests/4394255#step/landlock06/7
https://openqa.opensuse.org/tests/4398508#step/landlock06/7

My question was if you tested it locally, or you have a link to a public 
testing for different platforms. I can eventually trigger them otherwise.

On 8/13/24 10:47, Andreas Schwab wrote:
> On Aug 13 2024, Andrea Cervesato wrote:
>
>> Do you have a validation test (for example in openQA) for this patch?
> I don't understand this question.  Please expand.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
