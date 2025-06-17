Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06740C7114A
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 07:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750143607; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=jJ0kYnh4LmbP6gTaiiGfPS/zgWOpnnUoYjq0R8zuXI8=;
 b=XfZT/SL1usb7IIi72p6LS1P7xoAlHdjkLa8JXQ2LHNRPnI6WRtPSrN0qCJqsrtC3q7U1y
 Luy7QPhtuaeP8M5iuY24JPoYqgLQAco6t4RJe/hvt3noELIH5KBPbMR8uYmoTVpLOn+n4Mb
 F7W5RighY2TMszbMsrJcvJBwloS7OFQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7177A3CC1E5
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 09:00:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B21483CA644
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 08:59:43 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DC0B160071C
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 08:59:42 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso5166340f8f.1
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 23:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750143582; x=1750748382; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mrPsyANatyG7D+/i9QpVwrj97jdOFeZON0XtRhNoiLk=;
 b=XwdmroLaU7c5VRMYrO1twLb7mV7lp+LoqGcG0Q7vw9//TNdg+A3YU6Eh6UtdnY0EVX
 3m2QOJ7swvE8roJOe5O/tSE7YCjg/hw/E62OAEnqGgYsriEGbNo4zO4VhLqoWm9fUaCz
 WSEx0YivyngbmqU7iKdoJi8q82DzU6avCPZdUKdGjEtp60cY8yfM7dhaArLOR4nuKS2Q
 iGZrN43AcYgz56py8hgssXCiK0BSuxLJMV9EkGAI4xYX4uOBlGNHyHCrEth1SUPoh5cy
 gmc1RNydXwzYlTsae/E0bR0i5/McFZGirCnCornHEpDlD9RKJn3T5jBi7gz/z4bYjCxd
 CwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750143582; x=1750748382;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mrPsyANatyG7D+/i9QpVwrj97jdOFeZON0XtRhNoiLk=;
 b=qeaEx3mvNhe/VqY+CBE6I/TJpJS2KqHiYJpZL3ePK8zTRFm0aeocjV8f5st0+w4Nm/
 uuCPRw7UY+TiYi2E+InEZomsHSmqYYvqLxHKr8OqddTSA7bpQDBqw24sLPI5YecE8Z+u
 v/rLFrlHiKklQa0XZDDfHBim4LvEK08Xy7XAibynV9voG9CtFgx2Y1K0dPoegokiMHTP
 XTzd82KgVrrDfJhk5Uhmj8Kq8uXOcgfTU8w7OjbKCmfIsIlAoycnVUsKVXKA7iLZuYE6
 T0kulc6h/m/WFj5jEIOBZZgobKbGYFkD7uXwpu5MG5wNgOlgtbtEOxVNItIOynHCGkx1
 XMQA==
X-Gm-Message-State: AOJu0YwpPy/90FdPSEkM6BuyAT6fPpQITzseFrNT3x48Y2VhgpuN9FNT
 QbEFW7MRlk9S7PuZvLqZ645r0GFdxUGUu+5DLXRM+xxCxWg2L4Q0o3DuoRMMHdjAbjM=
X-Gm-Gg: ASbGncvMOaDxphE/sccraXtNhhtofH0eIvwCNTimMTnl8+5EegniTYcgksw8UAdgvcQ
 xNOB3aA7cKepOGJSgjW6Tzs0bU9wB4eSZJAHJC93EcOP0mxfxlAcuYVLMs6ZwL5OJ4gtan0pFCp
 f7spQXHF0Y7m9plyEGsZmNbo3Xnfac/AkGwiqqepf+LP++vuDy9Uyi4e30V9so5ZtL7RHUSBx9o
 XG5QBC6ia3H+MNjHcWUGd3gC7jWqZlhTQhpsAoAVwmfPyxmSLT55fTtkEORsfMWygzaGZEDiRZk
 ItirjUM124g2L2wPdbIR5Uz+u36QVug608AK9rXcOzhWz6wxaAZ7d02wewXMst5ikGLJr8ub
X-Google-Smtp-Source: AGHT+IE5gtyNwlAkQKBuwjT85NoxBbwPhmQsdz83/vLwyws3NkW40ayBW8VDpUQF2tR/9DP2cfkK6A==
X-Received: by 2002:a5d:5c84:0:b0:3a5:3e64:1ac4 with SMTP id
 ffacd0b85a97d-3a5723a2742mr10223169f8f.33.1750143582205; 
 Mon, 16 Jun 2025 23:59:42 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.139.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313c1c6a80bsm9840303a91.44.2025.06.16.23.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 23:59:41 -0700 (PDT)
Message-ID: <3f164456-7eb0-4724-846c-e345a2d09246@suse.com>
Date: Tue, 17 Jun 2025 08:59:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250617-ci_docs_build_fix-v1-1-7d0654f0cd7d@suse.com>
 <aFERx8dRidPTqsvi@yuki.lan>
Content-Language: en-US
In-Reply-To: <aFERx8dRidPTqsvi@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: revert "Run sphinx test only when files
 changed"
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

Done and Merged.

- Andrea

On 6/17/25 08:57, Cyril Hrubis wrote:
> Maybe add a note here that the test catalog and statistics has to be
> rebuild on each push.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
