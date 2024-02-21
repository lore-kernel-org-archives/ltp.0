Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67F7C48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708527109; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=wwU91CBWWWkioRcXsKTGzyFNeiffuGtMro1OJiawj+c=;
 b=IQfU25T9P8RcgEUMZ2rD826WM6Yvi6R02CkiucVRN4qVK+b9bndnt3sEJSrZ81zsnLNTY
 LyJy1CiwnBjYXv4HEU9Vy6vAi0vhpJNALzLz87KBzsfzlmWGEGYfvAv+q/LcQLrDTUzgHXe
 kd72FpDJqn7NYMAcGBwR6cRN/dVD4uk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 209FB3D0870
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 15:51:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 189473CF395
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 15:51:26 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EF67D1A02375
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 15:51:25 +0100 (CET)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3d5e77cfbeso1172513966b.0
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 06:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708527085; x=1709131885; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4HuN5Os5bKQv6LF8rg+8IX/I9cniixOyHC79dO0LfnU=;
 b=IcXxpZ6narY7wTJ0+nINjGnCPVV2AxByb2hIR+3tL6bjrM5K30LAa2jBIrJQqf6kwN
 hLnC7/OIfL0HnvUpHlyhkpaCcDWL8ywqEwSwEkqvyuti5lqM1f4AF7d2oy5iHzgBNpwQ
 KpJYizwctrMIFw/6S+G2IkMi7MY/u9+XzUKaIuWxMO3W9WPdih0yryL1D+YnT8BjG+3p
 R/TjiB23mjeenD41MUGAQ7fjdDMuGMZrtga2GQgq1f4O5DeBwN+QTWjt+rQerMm6Q15J
 7TV0Ftq5iEgmSGavgE5dREwjK8IpleXKi2HzDWSpwn3ty98iN8At2ovJ0m5eCzdxf/Z/
 3SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708527085; x=1709131885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4HuN5Os5bKQv6LF8rg+8IX/I9cniixOyHC79dO0LfnU=;
 b=ljhIHy8zgJUI5CSf+JhTXORDi6h4fQKZ22MGeZ2M51A5aLTsZ1n9fRq8Zh0hIs/Xnf
 pfubNzeZydEIX8/Bggml3+g8ODVxD3zqXSk1103faJKUHifuLRBXgGYp14pOHwXdCBal
 zU8AdlfqbLLNpXbAnMNyhTq9kSfNDQfEZJ2EOklEHjvDDJzcpCRHVTyM+x8rAAQt1Nhw
 492057wWIVJgsYLiRL3jKSfp5XnYUc5Ew+dpzzR4BQz1w19mww8WS7s40DN0aUG4+mTo
 3ZKXE8yEepDKFQupFKz02rI+uX0ReJqYkDGLhHtaSi+TRYr9vxYCQq9rN6ljuiUsoCji
 FO3Q==
X-Gm-Message-State: AOJu0YzXQ8GHaMuKqafG3xaZqW2iS8ocIbRdL+1DSs67Zv/uPmdRyRar
 WoeK0RIv/r/o9++MBk5ywj87gOVynYIp8P+DomAA1aXTYek344hyZXNJkrE1/2A=
X-Google-Smtp-Source: AGHT+IF0VFiQuIyYnWgaNArvl5Hop8J5UKdo9OI10KKmzTg/0sOYJHCwhQ/SU+WPBPaOVlC0CdM6vg==
X-Received: by 2002:a17:906:4a10:b0:a3e:8bd8:b711 with SMTP id
 w16-20020a1709064a1000b00a3e8bd8b711mr7573135eju.37.1708527085394; 
 Wed, 21 Feb 2024 06:51:25 -0800 (PST)
Received: from [10.232.133.81] ([88.128.88.5])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a1709063c5200b00a3d5d8ff745sm5069870ejg.144.2024.02.21.06.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 06:51:25 -0800 (PST)
Message-ID: <7ba2d4d2-46ce-4064-9ffe-6be02b3b7231@suse.com>
Date: Wed, 21 Feb 2024 15:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240220123743.7181-1-andrea.cervesato@suse.de>
 <ZdYNZcSmezIeGKsq@yuki>
In-Reply-To: <ZdYNZcSmezIeGKsq@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add more testcases in mkdir03
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

Hi!

On 2/21/24 15:49, Cyril Hrubis wrote:
> Hi!
>>   runtest/syscalls                           |  2 +-
>>   testcases/kernel/syscalls/mkdir/.gitignore |  1 +
>>   testcases/kernel/syscalls/mkdir/mkdir03.c  | 10 ++++
>>   testcases/kernel/syscalls/mkdir/mkdir10.c  | 57 ++++++++++++++++++++++
> I guess that the whole mkdir10.c addition is a accidental...
Quite accidental...
> And the mkdir03 misses the "/dev/null" addition, otherwise it looks
> good.
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
