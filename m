Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32063C87FCF
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 18:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754331210; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=xMVXkCk/hhlnd9NsiTE0jqZtj8rlB6nD6QmEsYaFbwc=;
 b=BPnWgmogeCDNoe7wyyBepC9qkEYRUBqOUKGeJUAvYNm21988lkwY8xslQjWiWV2SzTSzG
 Yw/dgEFP2ocL0U4zzgkUAp36N8Grs6XnEKbFYlWjzGbF+UpG2vKge+PAb7DpTN9mRnpKMia
 YWofFeX1ZmErVCUNXfQftdSvLWapMhM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B50EE3CCFD9
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 20:13:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D88AC3C81CB
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:13:09 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2CE906007B0
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:13:09 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-615d1865b2dso5400522a12.0
 for <ltp@lists.linux.it>; Mon, 04 Aug 2025 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754331188; x=1754935988; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WkcJDOd14JEhkL+YxpbZhSAGIMAWskM6NqoO3wbV4h4=;
 b=P4C8Vfj0C0//pn8ZSi8IHFcc9byflPNx62BxS+yAVoWAnB4/Lsd28wMjY/naJNV4EV
 on9RY94Cfd30JfKry8K1z+EL2U24Ygcg/Wxk1/Kaos7/db0n47XzkQ177gsfe88cD8MV
 Xh2xuJ3VfMGZEwBVaneFli2owQetjNFQsg9seVFbhQN1sXAvVVDxgan2kW7Lcblu1/oG
 yNBUo4vDSgxysghUFIMeoQmy+x+ZoXOOJEgpWhAAXcq6N58xyeXA+Ybegt+uyxW0bDG2
 WU52gu3Q1jz28pkSlFHg8N0F/LmrciRWzMgq00WD+kAja74J7HtyqFgLHgApXOs9ZCjp
 vCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754331188; x=1754935988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WkcJDOd14JEhkL+YxpbZhSAGIMAWskM6NqoO3wbV4h4=;
 b=UEdx4AELlXvuAUitFNLlhcf51GjkH4c9m2YqHv3cHV/EOwsrqD9YrA11aZ56xHM9hx
 YpfzhYh0GcgmNci3YYXih1zkPoPCkUIuPYIuT6WnGUayOiZKkzDcxxos9ALUoCGK+4aj
 IjZRI21GUAaS9AVjUZSoMsT3ST70HemuUQNO7irs2UPyr3oACwjKcq11CpoMyeGZ8McV
 rWowltVJuysQC1VrPXybG2lvx4ILy4ArJ9s7koGF3OkkOk2NAWFVJEZ4PSQ4hbfLK+l2
 JIe0c41eVQU9e/ZyX4tLUhFxyN4tqsliZEs5GrXT8D0RmXBzQTuqYvrQ4875hFyR+zaf
 fMgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU10mRuLNe8K00pISFvDtjzcKbeXXCj66YsqHhcF8rCvnHFC6lJ5ciIhwYyC5bw4XFYfUQ=@lists.linux.it
X-Gm-Message-State: AOJu0YweEMlD7gS5T3oYNCvO9ov3jMZVevibheMI4Hcm/fV7KnOX2WhB
 /YiO6lu2+laNfPHbPZejzeP9v/zwlWEjl/4Dw7/2GdTjulK5g71m0nus2PsQ+KWxVLtjTFc2E+e
 GjHSR
X-Gm-Gg: ASbGncsJQhqkrYt0wksFn3WLTtwlWq6y5O4j/8VOkIoJ+GxAaiTLkLZg7rhHXEiloh8
 Q1lgW8XGwSAbz+FUxO+MaYXFcK68LnzBCebqLb7e5VrkLzwWfRUFPr5s8Ma7ZKEkCVo/41BDJiI
 ju8uHfpPsGukBy1gQKLuEC2OZaO2E9716Mg76TiKAqi2qQOuvRkM9WJ79Xzyu9UDjGw6BczMHog
 VylbHi+Sd7JsT0TLj6oErwwJIEaRr4DshRQL5ratpp4c4/PApiA14SciBJZatuKWCke71ij1p9R
 4rx0+etFfjJvflgsCPOqUbvwmakxngCZ2Em4QXZdoq3wiw/Vx5XA8peLm2FcsqWejJ+cO8J7tUQ
 nZELYl2inEbkNZgNxnfaoiFcradeFMVwgpA==
X-Google-Smtp-Source: AGHT+IGBlt91qWBZ3RmX6G5Y0PjzjuoZUdnf6SsOy6KKNwLG1XkBAXN8a+9MJoWj48tK8RAxbzEt+A==
X-Received: by 2002:a17:907:948c:b0:ae6:d47a:105d with SMTP id
 a640c23a62f3a-af940248379mr1141285966b.55.1754331188507; 
 Mon, 04 Aug 2025 11:13:08 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.162.118])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a21c081sm759342266b.97.2025.08.04.11.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 11:13:07 -0700 (PDT)
Message-ID: <71ff54f2-1cb3-46fa-9974-9d6d760d6a4a@suse.com>
Date: Mon, 4 Aug 2025 20:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
Content-Language: en-US
In-Reply-To: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/6] file_setattr/file_getattr testing suite
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

Sending v2 because there's a file that is not belonging to the test suite.
Sorry.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
