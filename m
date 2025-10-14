Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EC6CCD184
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 11:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760440604; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wX3bMvXHWTgpOmSlQ1NsoyIZq3eJZiwnk1Y5M3uDW/Q=;
 b=jB8gNV4cyrQZVaiFbeIBN6RzUrGtCPjs47ukh0vV/E2F6kKHEp9kAOmGUK384+RSrys2s
 XaIaMnYvjcwAvGXYHIGR+sq7sDOsddUaBuzuaKt6R7iLDtkpFjwr/lcRlt1rjs7NSKXcXtN
 jXNvzKzsBnUSLCPuCgoj9FWS0SAGztQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 948C93CEC33
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 13:16:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50C2B3CE83A
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 13:16:23 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84696200753
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 13:16:23 +0200 (CEST)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso1109287666b.3
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760440583; x=1761045383; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbZSWuwC8F5hyuMfLmzzyQFptvhcVkLQaeT5PS/RMis=;
 b=cn9AYRuFuHz40oNCJEdhO+YC/mWiRCMvzRjLMD7AmYZnW9C8+MZZb0ZG13Px6wVeq/
 mrJCNDr23rvhsuDF4IBGcwqpJpo/qJqLIy+yWNOc3bheNwmLaWBx4WJCa+4f78BfOXdt
 b3RDToH2iDmHCW3kJdeS1Xed67Ayyv5lPqM4aNdTaHA6mzeRqbkJczjvjmCNhQ/d0gCq
 Ya12JKB4YXd2kX58jXfRDaL54ZrUPESfpCSj4pYmfrQqW2HSRSKTGZnwysj54uIEaX9V
 Un6V90x2f6AeTTiaM20GqZsuloU5LSHgiA6zKBFjGULvO6OeO6X9Wyfn/dmmSoSbOu0D
 /VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440583; x=1761045383;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vbZSWuwC8F5hyuMfLmzzyQFptvhcVkLQaeT5PS/RMis=;
 b=rZH09bhL4xSQItbz9Ft8AXw605q1rGKuhfVY1hpF++t/38mRQ/wCbZLhwOIB9lZED/
 4sHDYJ93DPPKKhHZGyf5TPoZuIvvBLtUx2qnA8Jc4yZQsuy9xlQNqlOhkBpd7WJnGsHP
 DE4KzunEZz09dYJidELloucwu5vA21R4h10O7++pE8ZOk+UfvwF5Xzob0JzV8etjMwuR
 R2lyJW5iL2iUEZUGoCGzQk4VEDrj6aKnIDOw4FxZ+46BaMeuRskYK8j2ppgVtFAad36H
 TkUeUaRiuJE8N5Ggga5Dupyj0F2XKXp3VoncJdx7DCh4Q69GNbfwvWjYA3NtB1WgbGPJ
 JUtw==
X-Gm-Message-State: AOJu0YxautCOqFxGjDp5obYB1M3fjh1epUD4FAmDi94jlXXt/0nzJt8q
 sBBPVRYFuaYS1oaHqiElbK2y0BOS/o8gRiFmTLvLpEEFZ/ANYyutHZb1ator7+Eo3oo=
X-Gm-Gg: ASbGncvERaHgemGrRxwaXwDk8Vp5A4HW7unXOV6eM7VQkVBiJVZNCLhwXlQwKuRV5Yi
 hV+rDxte/ta2Z578DLGk8nxx/mt5XmuDhuagGW7NWBtiH+ZMLJn+VTsV9LfloftSX+LJ3rYXsQV
 cailn3oviIrwwNjAMEw6sfC3OMwA0egOrf+2JHHh4ZYZ87fD3o96Mzj5q4qaIz4EXPnjuY7h8Jk
 l1tu7VXphyI0edQxxXrzgJJ9Lj3NuF4zEY57fib+Pv9WdcrTYSqmHSU/2SUoeizgmcdc/CTkL0y
 N9c7QZyU8/ZLYlq0ZVd6l3UgwfFE2AvIa6aHs3V6L5MZi8/GftLfSPtIbp/dMeq/o67hvwSQWAj
 lAkTIcoaZJQD22juFvOO6gfW2FO/Z7v1qsAf4aASba7h9NLHme37xKjo08Vh9LWDKtLmbDfkCxG
 rtykPZ3k/saziRQ3bI4wkR16o/o37hk5gVMqiraW0lE2Av
X-Google-Smtp-Source: AGHT+IE5PK/UVLfVa0xUlzZ05VF7iBztpCkHSE9Ega0nBxPU2nH1iW9vifWH/W+3JWkGthOGksn/og==
X-Received: by 2002:a17:907:7fa4:b0:b3c:82d5:211c with SMTP id
 a640c23a62f3a-b50aae981e1mr2931810866b.27.1760440582666; 
 Tue, 14 Oct 2025 04:16:22 -0700 (PDT)
Received: from localhost
 (p200300ef2f1c890086c8658517a2433a.dip0.t-ipconnect.de.
 [2003:ef:2f1c:8900:86c8:6585:17a2:433a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c129c4sm1145953366b.41.2025.10.14.04.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 04:16:22 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 14 Oct 2025 13:16:21 +0200
Message-Id: <DDI03QN6YGXI.2KFEOPT9TYMTN@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.21.0
References: <20251014-remove_todo-v5-1-2793dffdec2d@suse.com>
 <20251014105117.GB133774@pevik>
In-Reply-To: <20251014105117.GB133774@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Remove TODO
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue Oct 14, 2025 at 12:51 PM CEST, Petr Vorel wrote:
> Hi Andrea,
>
>> TODO file is not updated and it talks about goals we already reached via
>> new LTP documentation. In general, it contains generic and random topics
>> which none is updating anymore, so it's better to remove it in order to
>> create less confusion for newcomers.
>
>> Instead, we create a todo list in the new documentation, providing a
>> more clear intention of what are the current LTP goals.
>
>> Acked-by: Petr Vorel <pvorel@suse.cz>
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Thanks for your patience!
>
> Kind regards,
> Petr

Merged thanks.



-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
