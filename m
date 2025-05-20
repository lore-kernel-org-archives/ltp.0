Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EC5C3DA6D
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747762221; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=VqUZv0u8BTGTkpq6xn+g0Zv+g096QdCDXsRtnZY+jH8=;
 b=FjU+jEChnJhuI0iC8nMF97hNb7Rt+8jHBzxNinfKx7w6EjhZNnMdhU5jall4388ENPPUW
 HnejeblLeKM/Cg7szlReJ1Nde4N/y77ICYCnwnqAIbIRLBOq88u5cgm6r507/x2lo0wscoO
 bjE1xPh3NVGUEfSKFOAdwShOfHZ+6nc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E63123CC77A
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 19:30:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D8C43C0485
 for <ltp@lists.linux.it>; Tue, 20 May 2025 19:29:58 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EE03E14060D3
 for <ltp@lists.linux.it>; Tue, 20 May 2025 19:29:57 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a35919fa8bso2325331f8f.0
 for <ltp@lists.linux.it>; Tue, 20 May 2025 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747762197; x=1748366997; darn=lists.linux.it;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBxN/28GS0xiXHqHQbfJqLgbBgIbiLs9+FFWX3AzU7U=;
 b=b/JdZZb61RZ6rlP4ilC/BGm0zLr2lE3p4sVX5N04wMN6yu8IA0QiLJ/jt1dzgVGIzA
 rh2nsODURvT71Q9y8EQlWw02ZUNS/h8jRuI0usbNb+NwS5cltQGCI4G4ZKT3x3m1xeCx
 I4qZCBBwTmCDrrCWJjg80cF08kBxMEk2Yzmh2NJU2xxxeyaGZitrvzQPpyuRa3Rs7O6/
 sFtt0quS6zBXXvtZfszjafnKQYk/bPbbO58SzkvWDHxqAhy6ng4pwEu+WxEH+ZagoOFw
 L0UbOAr2KH8zmXPU5qCfVUJRO4h01wyoLpTLs2SJzObilqTsQn1fy4FzSHx4bN34+cZb
 EPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747762197; x=1748366997;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PBxN/28GS0xiXHqHQbfJqLgbBgIbiLs9+FFWX3AzU7U=;
 b=myW2y0deToEL1xUSPghVfuQN+zIfgpTD7qZG/hGN4pygpF+DShkuz9Y/f/UPIZfh6U
 KenUZgY0Fwu+yQmRDiJRsFlcfoGDYx3cSYi514lD+VCo0iBqxyYCkfXsJo29J8MWH9JG
 Qsc35galltTU7rlfRHGgQljeETV0pCoJWPsO4hthIwL8ItKNjyfBLnlEkMysFe3si346
 aG5YrZVpx5CqOWUeg3oiRnIGjA64sKCX9LQR4Uy1plFg4UX1vg0fQfR6D+LA7a8wINiR
 oD3SbPMdSJBwHt+RIn1VZilr5mXxeOx89h5eYPYI6eLMmAK0F4cxhdpNit0zDQQVNayl
 4B0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeMW3DEAhybGxkT6rTK7VMSR9Hc8cAK7RizRwqKl3NGerkHbLWPFk31y6MjYbT1YVWGtA=@lists.linux.it
X-Gm-Message-State: AOJu0Yy089w+clIK+A9iTBDK0c9ahTU+c428lsEaPbwwPBJQme0s19uK
 P+o2IhDgaRXS56Q+McGV+s4gkTSLAkJGNGJ6vlbFICxcdu+0xJ9JZJxy4fMD40ys6PA=
X-Gm-Gg: ASbGncuQsUsu5G3F2S/BI3Rn9kA0XmOFivr6ZuyWQ2SjVwBa40LCZZp7zfKVmfvdQVP
 u6i31JHO8JMOZ1YW//FjNXRhudDFyritQZOohS/GNF4RPqo3DkzvCGnYRKc0TqqbBDtrFQJV6tE
 JZNYAtyoNXFCT7j+ZqJ+PxRWgrKdz+xyj42WV8V2GIkDETOMn8VEuANUYKo+Jas1daw3+hWZCp5
 nAsJLNDxpJZfvo197lCPOMUiGNsBlBvndcZov1U7yisQhwJBj/ueWPiVGv80HYdef7bQwUeKk+v
 dHrGdlpFFEZnRFN4qsRKfgBfJqrQZYxQ6820Gkxla0iQWn+RXw==
X-Google-Smtp-Source: AGHT+IFJmoK6HALsXiY1PAVL9jCcK3csqhCB45ElJXQ3RedTLN5cJs4+e7w3kzGcW+7SlU2ONyJoxg==
X-Received: by 2002:a5d:58fa:0:b0:3a3:655e:d46f with SMTP id
 ffacd0b85a97d-3a3655ed53emr9510762f8f.24.1747762197342; 
 Tue, 20 May 2025 10:29:57 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-52dba940900sm8803727e0c.14.2025.05.20.10.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:29:56 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 20 May 2025 14:29:52 -0300
Message-Id: <DA15ZN1Z19G2.1R2XNP3P03GD5@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Martin Doucha"
 <mdoucha@suse.cz>, "Linux Test Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250520-fixes-modify_ldt-v3-1-a78c79341d0c@suse.com>
 <13b3679f-ca6f-43ee-a56d-865544c2474b@suse.cz>
 <084e07ac-61d7-435b-a5d5-1512bb57b2e5@suse.com>
 <ec0593f8-980e-4e9f-bc61-3e9eb1f0ba01@suse.cz>
 <71939c74-0ddd-459b-a857-b62002ecc71a@suse.com>
In-Reply-To: <71939c74-0ddd-459b-a857-b62002ecc71a@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ldt.h: Add workaround for x86_64
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue May 20, 2025 at 2:04 PM -03, Andrea Cervesato wrote:
> Ok, merged.
>
> Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Thank you Andrea for the review and suggestion! :)

>
> On 5/20/25 16:17, Martin Doucha wrote:
>> On 20. 05. 25 14:23, Andrea Cervesato wrote:
>>> Hi,
>>>
>>> On 5/20/25 13:34, Martin Doucha wrote:
>>>> Hi,
>>>> safe_modify_ldt() should not allow any errors. Let's merge v2. 
>>>
>>> What about the other tests? This check should be applied to them as 
>>> well eventually.
>>
>> That varies by testcase. If the test expects any errors from the call, 
>> it should call modify_ldt() directly and handle the return value 
>> either directly or using one of the TST_EXP helper macros.
>>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
