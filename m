Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD698C83F1D
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752568395; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=3tWytIMkL0ebW2ZDzh0+YzL/dPPAOkOW1YuG7VyExDo=;
 b=RUEhc9bQP2yMHWkWcjWQ30JzRlUvFOAZqnAtHNiZamPFXvZiytvGqtuaraU0H3ed6Jc3k
 zcXWPenfXMlVCinMyR1LcpNeawPqUo7u8OvnKJkTml2rZpAaixRB84+KUvXaVWmH6C3Ii89
 QVUE0EXLIKyltUYlcvJY32PejneoGpg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1250D3CCBD5
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 10:33:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5DAD3CCB8D
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:32:53 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F1FB71A00EEB
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:32:52 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso4969325f8f.3
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752568372; x=1753173172; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=njVWy740nI0Q9XqV22Y6Yk01LjOnDmQHHukRqBAkrNQ=;
 b=GsU8f+tFuet0a8+qC5HsY78REyyDOvv0rCbK5Z2t9OwMt4zwRKJJwwnBY6v+20PDa8
 p1Zb4hetRx95kE4NpFeUI3sonfVvhJ2b40/oL0Vwm1GXAOm+JOni9pxchfGFQ4zBzXR7
 eTm1QnWvjQWKEMJ+nfXk+yDFFDnaCYvNTdyQnyYlX6qHm/wBwtplGv7nWASPngnGplPs
 YJSdk8kgVNkqxB82MvLq8Rqij97rN6RQSNZrLF0GhO2gf6545/IZ4rIK78opOJtqyhFb
 hR9TOc2o4RxD0jElhDKw+ShwsFtE2RACIqowPfWv+7bSs+6GwLbViOBeeJ7LxH2lrwAB
 0GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752568372; x=1753173172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=njVWy740nI0Q9XqV22Y6Yk01LjOnDmQHHukRqBAkrNQ=;
 b=Zen7qofcW8PHc+NrlztnN4FJUldKwQ50GjwwUkpYoEhknHHLCxTI48GP4mrlkB+J8e
 1iRkUFQSi+56MPhvR7XT/SSd+qPGKUt7of/Pc58xG2TYyLrnE+u//3HwA/5cI+pcwDyD
 KXSRTm13XvkGqU0Hps829izQWp/xE7NEoRLZtb2wLK1V+i/FniAVhbiZ0ceEhbD2hcF7
 PbAAqwd6LF/g8cCyKyVH7rUuCGkhEYF5JVmZGYk7CfDO46A2fL6w+bDvSFO1Bu83IEhy
 gubKhl0uIOyEZ6V0dLmCYyFNxeCxB6v2ZGFVwkYviBdKzb7cNLzY7mZCd2oa5YN9Yjq3
 7rbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoxnUNGMC45fW8xws393fk0R84pSJ7loXWi9TUnV1yH/HZy6QN658bxN1K1zCrDV6yiL0=@lists.linux.it
X-Gm-Message-State: AOJu0YxXLQt/UmIyx9yXs59IqYQRRraBRgOvqXbS8bm6BvpjU7iMTgA/
 YK+c4YpaHq36vSeQGSVzXs+yQTar3EhwVlDSQDfLKZoquQmOuKn7IF8LYWYcGaZMl8o=
X-Gm-Gg: ASbGncuehuXWKi5J8wIWwgh0d6P0DVcIW7C0gRGmcOYaEqGi0XOV/yctARfSiDdY/iZ
 rYntnXdaZwxgtTDBhEhNvIkOdYgpljalh3qdsx22tdJwz5EngCwSShDpJVgIABnbyPQRwhDXvn3
 rsspdUdWeIfclKqzpL7/iPBtVe2CmEtkOLPQ1zH/h/h9f3et9V/XOFkWtGDt59K8pNUFdyJ4U20
 RJ5Phudec2xsEfpVpwOZ6RoPDSAZgxisvhzuVYWhCkjeb6wsaFBepk2TbFJJJG8DU3BlPmwX5+D
 qLtusIqfy7uLaZUAM4T+tE2VWRzrzpNXJAb7L9KdBwPAhUspr8Vpfypa1ZYWPRN/20CpxQgavpC
 TE2PY+mLUD+h4e15pC4n5F+duVDDbXknL46Onh3ZUfXuwJ2OnWAu6Dnqs6t3GSozfgXqsFuaoNC
 bjxh1CT9oFAJNOijbT4eJoh4H3am9EOQ3vviUwYpVDhCHSviavKbGzV2G4dHYfT9Dm3QDox2pT
X-Google-Smtp-Source: AGHT+IHI/QkLE0cYnasjdF++ebYNfghWVRMJ9r/uCP2MkfX/6bSdI4OOHDqZXb5mqJ7WnoPXUpJDpQ==
X-Received: by 2002:a5d:5d8a:0:b0:3a1:fe77:9e1d with SMTP id
 ffacd0b85a97d-3b60a1503f9mr1328406f8f.16.1752568372342; 
 Tue, 15 Jul 2025 01:32:52 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd18ffsm14272343f8f.9.2025.07.15.01.32.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 01:32:52 -0700 (PDT)
Message-ID: <18808f18-5e97-4d90-ac72-a3fe25b9e94f@suse.com>
Date: Tue, 15 Jul 2025 10:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250702-conversions-kill12-v1-1-4ba219bbfe52@suse.com>
Content-Language: en-US
In-Reply-To: <20250702-conversions-kill12-v1-1-4ba219bbfe52@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: kill: Remove kill12
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

Merged! Thanks.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
