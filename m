Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2D4CD5BA6
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725533157; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=8FNZ8mu6ZIsThKr5NSvMQYl3RhMAkgERw2kfCOLM57E=;
 b=cliSRUmVBDGRKH4etyLBrNHoX7DrzSQ1A3A22h3nJfeBcwupRMmED6zWwu3iOyjRk/jmX
 FYKNEEuuGNcrj7mfPcTJzqrUeNS0PYTuKXG6oBClHHgu9w4s4pMTYEJHi4J1g+swDbkAKbK
 XbPSnyG9LjwdjXplQS4lzcinWpR12Iw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 352E43C23EA
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 12:45:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B57E73C00D5
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 12:45:35 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C1321601BA9
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 12:45:34 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a16c53d3cso89109766b.1
 for <ltp@lists.linux.it>; Thu, 05 Sep 2024 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725533134; x=1726137934; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kusk0AWbeB3Zdils9uO4djCl5878Rtq4jPKcKNZbJzs=;
 b=IAchiHDyHpFsWhJ8bBtrW7MlqB67Ix3U4UWwzsj0/4OgaGUzjJA6CEVOH5UUZJSVMK
 sHS+PMIgpWCFyBQ+qs0fhtTeobB0JRZx3J4w1W7JggjPoMTdutN6Ouz+0sh/CEsi2NoZ
 n2bpPz/kp0R/Azf7bke5n4oF7upfHrJuM4Mfw5+91Bt0bUAtVDP6AFrtFaWp2n4ZbZF3
 pr6V3bUut3sQU71RQ779/wmPEOqm+2va64LOTqSKoxHZ/S7a79Z0AirMcKo+lf2hEtQg
 YdWWWJQ5MrMzP3PKAEf01TVHVJqYeb3159WGq5AZnF1U9mlEnEIOpr4qU/lTo3/dDO+r
 pUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725533134; x=1726137934;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kusk0AWbeB3Zdils9uO4djCl5878Rtq4jPKcKNZbJzs=;
 b=wbiHO0RqzGvXtA2kiquwqvWaH8jl6JbztaL4MRxAL+SmjqHL6vkaB3y4xk/mgNKcpx
 7TY3F2dFmgs5lQt69ELJ62xNWZv8s6Lx8XAQCIRARD7GDPEgsjO0DKGf/yekgmYy/X2T
 QkeDElbEZnZRbrsDnObCZNrG8CyvuyT+J8WRy8X8BxJC37D4VvSLZ0rXwTCYt1IJNm/0
 dVWy2bvlQFPpI5QsWJDDubX3hsPScd2jiOYbYeekN5HDiCMYGVNF2qJRuirjSMgBLr7e
 okDSzefggvBOdql+mMOooalh0YQuPktu8PSE9dPZfVpw/gNFOxsQiPLfaHRmTDDqVo6r
 OfNg==
X-Gm-Message-State: AOJu0YweTZodnonPJyp3s1IBEfdcRVcbSze6J1Sg+wswb1G0g2sxiDb1
 lH7D+kSJh43uEEFxbgec1oI+dSi+EeJ2uJ81ftYJzID2jvtljc846R7Q6W5HXKufGMrTQ89JC1L
 GIGE=
X-Google-Smtp-Source: AGHT+IGQGpPgpsy4eUJKRN5SVnLdQB/cqsZOclqlkPdwbkEFbkeQzwQVTp6aOu0QOlFjOfjOk/jjZg==
X-Received: by 2002:a17:906:794b:b0:a7d:ea41:d865 with SMTP id
 a640c23a62f3a-a897f77ee0emr1913877966b.4.1725533133255; 
 Thu, 05 Sep 2024 03:45:33 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a623e5012sm117809566b.222.2024.09.05.03.45.32
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 03:45:32 -0700 (PDT)
Message-ID: <45853a0c-bff4-48be-9fba-b44038655741@suse.com>
Date: Thu, 5 Sep 2024 12:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Open LTP meeting 11th of September 09:00 UTC
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

Hello everyone,

this is a friendly reminder for the LTP mailing list about the next LTP 
meeting.

We missed a couple of meetings due to vacations. This is a personal 
suggestion and I would like to ask your opinions about having the next 
LTP meeting in the 11th of September, 9:00 UTC.

Let me know, so we fix the date.

Best regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
