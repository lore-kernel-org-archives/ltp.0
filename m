Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3538C77B7C
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 17:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750700629; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Jc5UZ5TQbClgg7Rp7+KTkAfJqZHVezgbkh9+egppxQI=;
 b=hFCyGdrHxXxxQ3pwJSGU3tp0+EqCdGMsVcuH9A8y96qMXhV6fXHN9wKR3NqSSEvcd9pNM
 qY7uslgz4wfKOeXE79Nmh2nssdjho0qSMHmhXO3q+JYxfQHXgSa7dqvyooa7adqsq9Z+5p+
 BEICzxlQh6U1v6ER+JWCN7i3ufyPAlY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34ACE3CCA7A
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 19:43:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D9BC3CCAA5
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 19:43:20 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9BE97600B07
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 19:43:19 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so4413703f8f.0
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750700599; x=1751305399; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nW0s9T1g/TsQVFGWxmw7lQS35oFFQwn7IU+Me2SOyBg=;
 b=BRy4UpPn2drd/4wLQPQ17+K+6Tb3EDxYJ/zMXS9389JjCuo/z9/vk/SxNej4bAtOzK
 JRr5IFwDAT8dHEeu+Ut84FlgsSxme2cWU1DZF2yN5P6K+7mjLRPUsdXcJiJwLXqxEQdu
 3fTUAZTrm7jwpZ+XlB8fZuFCHoxor4BdCHEdA2Xr9ZYHKnjLCsWhHF8rvHuWLoPXpjuZ
 QsHpw990ptQWDgokxabl8klbZE7dGj2m7y+nErPTq8neqivbCsNp0SBx8hQZPAn/7CtM
 9gWe+uwmpX+E7PSphJeS1GWtob+lvqV9seGio06J2CHN0neKiumsFl4wGU8/CEq57SDc
 E1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750700599; x=1751305399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nW0s9T1g/TsQVFGWxmw7lQS35oFFQwn7IU+Me2SOyBg=;
 b=j/O6oOgTNYT0PHKMMQV2I9HJpVha0HpBi4hGS9VJpYtbKgEVBbEVmTD4zD/RaWM6vm
 gtlTZ2z+X2g6Z9T+UIPT5T2oqr4dtR0Wy2wzlEJ6UPrQud+PYSn1rDoIMweHVI1JTywC
 bBsxMzAwP7Sjq18wyRH3tdcV9qthYX0d/LvH/I8J+2OfhFaYS/EXxZQ80kn2PMmrh1/L
 QTP3U6ffgXVzAvHIhHhiSW8SUevSeDuRp98mvfljT6UklLkSMKjnyffE2aC4zfz4hNSM
 TWR5eP2wdBxgv1UxW6glxLd5P5KqtojMqTn/E0mOcqMN34RIsutrgYDcF9vcc49Bk+kF
 s9mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZF6v989YdlyQOOKOKQPI3XeJFodG8UgE+o1wFebqIpqmoimOxtLZ6F8GeB5cefYAwd70=@lists.linux.it
X-Gm-Message-State: AOJu0YzMvRlQbsXf38oUKvfxsPPPEktewTSe9uwK3/u/EnhngZG5O9sk
 nmfDXEHXYHr1hl1XJVAzwTiZYL7MjncTntoY98GkCyaAGGweKKjhHHeEr7nxKqgIulwqlzIIkZ8
 Zc1UHDuBL0w==
X-Gm-Gg: ASbGnctwOhMVDM6WowR4USogF3WE2+Descz/faUETW8oPsm7QGPECOllsQi6EgOLjZb
 2jgV+wB+j7PyO9RXX3ZvzvCER76un8uiRokaPCluo2MtZCmPIH+M8JtHNUpEIp/gZd5aHuM8hSM
 BLWBTMa6TzHXNIDrpqlRf8XOpErv+Nj05vii1hcVHpfy/uGaeGYOpS0/PJX8P6ogkPXDB6Hd38o
 zyaDeJwnzTS3vo4kLApxCEU6BMWrNOduE9OEOOKIzZSdmsxb7QO9/fJm8OIV5I5naeIeKU0MvH4
 05tdg9hm86yvlh5PpI6zC6SJSnua/xyMikzyCzsw52c12Ngi9VfaV06evGms6DBkM8XnJmPoLuU
 tvePr8NFvkbV2QB02+Q6YBgdaHB1ZJApidUFjHzIRoRAB1p/jQUAl4TvtrtZ+Vxpzu9GLtZapRn
 3juTx7ukgcQNkxbHtks0O+7hxOig==
X-Google-Smtp-Source: AGHT+IHdzkTMpu01WUvQu6hlWuwHJdWbNn9XK+Yj1tiHjlH8gNWND4hmnlxziD/0kXTWL9+xjMgk5w==
X-Received: by 2002:a05:6000:210a:b0:3a5:2ef8:34f0 with SMTP id
 ffacd0b85a97d-3a6d12ded04mr7972388f8f.22.1750700599075; 
 Mon, 23 Jun 2025 10:43:19 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646d7fe5sm115676635e9.16.2025.06.23.10.43.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 10:43:18 -0700 (PDT)
Message-ID: <dd349553-7bb4-4399-808e-5389487fdd63@suse.com>
Date: Mon, 23 Jun 2025 19:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250623-conversions-shmt03-v1-1-a5173cf34a34@suse.com>
Content-Language: en-US
In-Reply-To: <20250623-conversions-shmt03-v1-1-a5173cf34a34@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mem: Convert shmt03 to new API
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

Hi Ricardo,

it's probably better to create a unique patch-series with all the 
rewrite together, so tests are easier to review and we can avoid rebase 
issues.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
