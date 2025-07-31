Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458B5C87FCC
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 17:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753982218; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=+cL61rz2AV2UQazvL23yHmIWMoXo3JTHd700/uJBsrI=;
 b=cr5Im5CuL9ZW/cv8WlSn6PggrDSs3nVWR244+vJyY8Xy8PoBEPnKGws5WqeJju7DS4+R+
 EfZHpb96/JnCUkZzxkDibvlt2j7+/BK1tBCx6Aurwi5DRdT5gqYTvKq37FhGhVkVuadsh5H
 uvyVtGxFaACOVFSfYhMHJ/v+09I3JYI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DD4D3CC279
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 19:16:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E76A33CB93E
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 19:16:37 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9C7AA10006BD
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 19:16:36 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so1102774f8f.2
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753982196; x=1754586996; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4QdWIMNA0YiNiHmGBYu5LwY2KomVwG3CH2pEtH+d7bA=;
 b=IM3lLsQ4LxsAJJKeqLjj5NYrvfINh4D0kJNYgn4qfpIxqhqFXGhy/QEo0FqjB3s94s
 9tS8xwUyESto75AuiU8miquZ2hwB4Mj6PL6SDWn+WgGWdPTsvZ2Db9U+w4Pdr5hI2Y/0
 Xo1JhlkPqGqp5BspQWr4u838IMKe2K3NPFNIy6zhl6Q1MqrNj52pw/W/Wg6b/Lt7K75M
 hztF1JqBmyzpMLAwTDPIK0uUYLOBZPxHcgaDGStFh4HHRaSY2mfvgUBS8h+dh5zPKEXD
 E+NTWboXhRIYWMNbf+mJeDjvAcRj8mXkAapXiVDM0uEtHR9R78CHUeTDOBzjHGn9pFyQ
 HfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753982196; x=1754586996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4QdWIMNA0YiNiHmGBYu5LwY2KomVwG3CH2pEtH+d7bA=;
 b=ZX4GjlQiVyvFnDrSP/4PtXmAoGgdMSy5xk1FrTgaVBgnFJODbdy4f/cV6glkKxaegS
 D2nDf+pN11WNwwRxq301ZoV5O4wm/3WewEQkE/wwymFefxwufM95kwD9saYkeBKDjLRo
 wNVGVAH5DuTRSBi/RSmlyTpAV1Tc5e2XQVeYULYLta3iiNPwVzM52XL9oBGhURnt9Nzc
 LJGgQ/o5ibw0OORscPak+uIm2L4Up2kNO0z32X2wU1fquW86HJQwNmWrsEbQQuMQ9iuZ
 2xYflxRYvd3N4bmmpo0fdg7XiFav2PDk3juWZKrtpIVxozeNrtKGpihzGPNPbWwjX4vY
 2uow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4vYDElC6f7+i1Gwhc/OOjCzD74xazXXZxuVc1o9Cr+N2NYSsS7TkvDXJoYZEaShfsmT4=@lists.linux.it
X-Gm-Message-State: AOJu0Yx661jRd1jIqz5nWG0JLu3f3MwWNg6FS+ojsbDPha1xJ6WyAvHI
 t0QnH18F7RTb0r+7/APaTHFhNwU++3uDgoRNkdl2VuCTysNvtuUqFO7jE+hJtqSA/Dg=
X-Gm-Gg: ASbGncvlGfrRlY7Zpytg8ygYV1FF9I/L/Z5/mz8ENBOO8mlQcN6joNPrLDybeN3EKCH
 zFJw4MMkrk9Cw1r/bDGX9uq3yjH0s/CbGBE41C7hJHK9u4l3TWc9DGRH/fWks/DaaobjfGQ2Ngr
 0aPEbPVbbB+IEZ4uj4jkOXEF/wNzNu3alBitf8Uz/yst6od7dO1iXom+N9itmDkugZjzdL2wFWt
 17ntwoQeRCPzxmIxDSlmtuYw9T7k6ZYqmSzHCfX0NNP8gTFTh2mrREzowuMyIAbFulYQMQJ5HGg
 ofaYRSFT0w2rM1IEg3rbXbE9Gpf28CdG1LcY5d91bVKVnmw8rOFiwLj4/4PRnJPKOb8O1eC5dlh
 FJIL2LJ1rH++85V59xgO4NDeJlCVZgBvhaw==
X-Google-Smtp-Source: AGHT+IGt2L6yf68Fne8fgJrAg06XnmPt3ujepMI+oX+anKls/ig5/Xk3RAh0B0ytz7hbo7yTLDbT3g==
X-Received: by 2002:a05:6000:26c4:b0:3a5:2ef8:34f9 with SMTP id
 ffacd0b85a97d-3b79501ed31mr7239161f8f.27.1753982196033; 
 Thu, 31 Jul 2025 10:16:36 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.222.116])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89768fcsm22994675ad.82.2025.07.31.10.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 10:16:35 -0700 (PDT)
Message-ID: <4146ca31-462f-4e9b-8af2-36adf2605bdb@suse.com>
Date: Thu, 31 Jul 2025 19:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250731143550.777289-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250731143550.777289-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] munmap04: Fix 'base' overflow
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
Cc: Andrea Cervesato <andrea.cervesato@mailbox.org>,
 =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Good catch, feel free to merge.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
