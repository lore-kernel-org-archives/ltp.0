Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13746C7EE24
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 08:59:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 479623CB550
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 10:59:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FE943C0238
 for <ltp@lists.linux.it>; Mon,  8 May 2023 04:50:34 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 82C1D2001D7
 for <ltp@lists.linux.it>; Mon,  8 May 2023 04:50:33 +0200 (CEST)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f139de8cefso25377355e87.0
 for <ltp@lists.linux.it>; Sun, 07 May 2023 19:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20221208.gappssmtp.com; s=20221208; t=1683514233;
 x=1686106233; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=omFhmpWfBFJG0jkrfHOXVs2//eYJEOe02UXxq4pKYA8=;
 b=uDJ+sjSb0CuQi5GnnrqUR9h9rKMW7xJMfg4kMFpcSToQBlkhFiTQOhvMaKjB/P9szY
 ac+Fad1fu7JszhAUD3SRsDHnVa+jn/Bd7A/DNYYpsC7QRQbeh5LI/zDmAYPZOjbILEqF
 Ucz29HJ0/axngV41J5sCWyUYZJY4Ake4ENlTRAcvhZunK+axdR/FRG5WMudrvjLHGzHP
 eVdkGJWKeDTTeLyes/ZBBtV/exVPgSjv7GIMb7AZv0pdL0Hp0Q9MrswEcF+PXax2BQqD
 m8eIcjGmyRyphyaczMG/jU+axi+zgV9xxY9Wy5Oc6iBYNpk992WHHgPGbdj7cCnucWm+
 wKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683514233; x=1686106233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=omFhmpWfBFJG0jkrfHOXVs2//eYJEOe02UXxq4pKYA8=;
 b=AHyNf+Q7bpaoOqMa2ItmKnhfNZzWMyWyOsQoP92dVfdUAGhE1XAbvaUo+pKnbeCRRM
 xkifgAf3b+LfFq6DT+bCq5IFfa+VuxhG4ecz8CmKRg6SzEXYir54bOnnc2Fbx38EjeWj
 Gf7J5uAM+9gsFSFmhWhjp86TnSLF2VUosANQTCMDklighnGEKMLqUikK0UmP1wuFjU82
 TxAEtoDjZ1928vCkhz0+n7y+76VVBWK0Ad+Jr1gsXIEYDIUUTQAoXep5q/pg0bHf6iKM
 TLZS/4Uj3wVWIAGI9MC2usoE2s2FwXFGLLHRCYyZAmqWp9u5Oey6jw+LK9LYlFSWZuhN
 mDvQ==
X-Gm-Message-State: AC+VfDx6rBsv/PODVqaCfBkhER2KaLdFvqI3rSiDx6qOOguETBleMMIj
 qsT10G7P7UZbSsocE1lotQa+Jg==
X-Google-Smtp-Source: ACHHUZ7/7LsA1qi8V7FDWQkIqlJeKKgdJSpCGRN0J3H9cSrGKPBKWdcRg9t16DSKLshSMqYqm3qM0w==
X-Received: by 2002:a2e:8ed2:0:b0:2a7:80d5:a43c with SMTP id
 e18-20020a2e8ed2000000b002a780d5a43cmr2166694ljl.5.1683514232751; 
 Sun, 07 May 2023 19:50:32 -0700 (PDT)
Received: from [192.168.8.148] ([85.193.100.38])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a2e3612000000b002a8c4a26960sm1013180lja.75.2023.05.07.19.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 May 2023 19:50:32 -0700 (PDT)
Message-ID: <81826e4f-aa4c-1213-8b2e-28ef57caf1a3@cogentembedded.com>
Date: Mon, 8 May 2023 08:50:29 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Jeff Layton <jlayton@kernel.org>
References: <20230502075921.3614794-1-pvorel@suse.cz>
 <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>
 <20230502134146.GA3654451@pevik>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20230502134146.GA3654451@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 09 May 2023 10:59:37 +0200
Subject: Re: [LTP] [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 Steve Dickson <steved@redhat.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>> rpcbind was obviously written in a time before namespaces were even a
>> thought to anyone. I wonder if there is something we can do in rpcbind
>> itself to guard against these sorts of shenanigans? Probably not, I
>> guess...
> 
> Maybe Steve or Neil have some idea.
> 
>> Is /var shared between namespaces in this test for some particular
>> reason?
> 
> I hope I got , we talk about /var/run/netns/ltp_ns, which is symlink to
> /proc/$pid/ns/net. Or is it really about /run/rpcbind.sock vs
> /var/run/rpcbind.sock?

The overall picture is:

- by design, filesystem namespaces and network namespaces are independent, it is pretty ok for two 
processes to share filesystem namespace and be in different network namespaces, or vice versa.

- the code in question, while being in the kernel for ages, is breaking this basic design, by using 
filesystem path to contact a network service,

- thus the fix is: just not do that.

I consider kernel contacting rpcbind via AF_UNIX being a bug in the kernel namespace implementation. So 
this is a rare case when a test suite (LTP) helped to find a non-obvious kernel bug. Just need to fix 
that bug, if not yet.

Rpcbind listens both via AF_INET and via AP_UNIX, and did so for ages.
It is even not possible to disable AF_INET listening without patching code. By stopping contacting it 
via AF_UNIX, it is virtually impossible to break anything.

Nikita

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
