Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6A3E9A03B
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 08:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771490318; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=qH2Q1Njfg/ENHc9dKyavF3ZI4uHeyz6JQdid5p6sddE=;
 b=IgXx50tUmFm5MOjwgf9foaLDKT+vtpvrp7supSEFayRDa4TYdRmDW9+/s5MFjJH+yb2Fy
 +oJZ76u5tp9xYGxJzmPM5ZgFEiqvNlOyt9IImBbQysykdK3ADV+qQw+AiYHoXPfOIE1ZGkL
 B1j+3vjg09eyYuNddkYc+CJrReuG3y4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A56773D0680
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 09:38:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99A713D0652
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 09:38:14 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 774B01000364
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 09:38:11 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48069a48629so6758055e9.0
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 00:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771490291; x=1772095091; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBJ6t8MBYkiGa7wuYa4wuApgJZslzW/EAXV/pm1Pyz4=;
 b=dL2/WDpYzzXrkVQBVr5nMVCyGxcoKNdoL0zvAtQV5zH78dOADtiN9zacgJ+xEIn3At
 7FoZ27UobTXS7o+cCsRxlPqz3VpJuvVWvjfHEFfLa+kbR9vVl9FQ/VAxynOeZlZ7qFvp
 ZTxorOvWVQ2vs2lCjZ0nTSFZNVMasCchGovqJERO3a/naXesYEJzWA+9+LRNwITKJZUm
 7CW10HQY75FdEscPP2KfhrFwasfWJFqIlXTbOokJSYw66q6BX7bQ0ZVSumQgOxqieTst
 m18LOfpicH0crLuzcSHXYClhXDP9/O/6XssQzAsJINaOJVLOVsSCP22l3XGBSTsP6fNM
 GqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771490291; x=1772095091;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oBJ6t8MBYkiGa7wuYa4wuApgJZslzW/EAXV/pm1Pyz4=;
 b=oHRV7GVEFijBhAUehFA0XMECh4YvbPsG4m2OSX1lNHCjqplsEPdbwtpljuzwovxShF
 UhOt9JEHByKI5o1KXjynROleBbITd4cZZYoDiy/c0xMUvOf0DpHRffaEtxfrlxn2zxsZ
 s/Z8BfVK+FkzlBe3RAdooVLxRdJdChMDmrfAo4fzPiSyqZnufFtpzVQERj8I/TwNwixf
 DyFnVVXrnBZ4AnOihvg0pbnfp+xwA0Fkjz/9a+XkTDA67Eaoj/hrIrn7UE9E+gL55Avo
 vD9UOZ7D4agoHCyC2Arasu78a8D+9Coj0NFy9LK120M5nQLPQfkHz7XKU+dbOfMIqI+8
 LJ0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL4GWuV71iVR1ulKh1tGIqB4VKybDiXYeakFLzqZeXTgjVDkl/Kz/hCaEC2P2K6lKwXis=@lists.linux.it
X-Gm-Message-State: AOJu0YxYna3CIKA/+flgbEFMF0YNqUnAoFM8hbfqevKzuT9YR2GJdIPP
 i4ZkLSqO5Qw4R1yIOMxgHlmU/BFgpUnO4gj1xI9WbiO/ZoYQzJOC9Ksuy4PmSeLLkKNPGMUt3OY
 GtM87
X-Gm-Gg: AZuq6aKarCIwhGoYByJCUEWje07VSIA0a6Tn0xvE5+kdnVVlc7qXacuezGZeLwyHl64
 ff0OLGyeLEXjWBUZYrWD4bDsCPUdiXv/HBXgm8q89kgOihQpyGHNIQ5u27zvaygKuz5Ul73kKul
 +XqNAwKfM5zAq1sj5p9wiJeNgds3c2F7ycN9o0Fujgdo3L69YD/2s3OugV7gRKCdivafbLOC0NJ
 hWghmfdenDaRECXXRGMF5tn1i4Mty92abqsfUTv4pOvSzLJzmB/6iVRrgHXBBJcl0KG4L1L+84W
 yJbqUmTKJza9vxFLykea3R9bj5ymJdpntSba8x5AUqA9DUBjGxYQtBsGQsiUo+EgxBkT7xJ05HO
 aAdz529VQDFuidthVybRGNMW05XIdJp4kg9ZAWQiM8xHQjy2xH4FVk6Zb9SVQlev6sLt5l6Auv4
 mIx/RDnRGe6uYJeORn9+1uN41UnvryA91B+R5sVI7MUzCqV/GZLQs/ieXzyFoVabnek1ktQWGUX
 w8z+LUcH7zBgWWHXuBfU854eLSW7g==
X-Received: by 2002:a05:600c:820f:b0:480:3b4e:41b8 with SMTP id
 5b1f17b1804b1-48373a5baa7mr356656775e9.33.1771490290798; 
 Thu, 19 Feb 2026 00:38:10 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4839f98abb6sm22740845e9.4.2026.02.19.00.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 00:38:10 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 19 Feb 2026 09:38:09 +0100
Message-Id: <DGISWCDUHBMA.2F7A9PHRPABQT@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260218174139.94454-1-mdoucha@suse.cz>
In-Reply-To: <20260218174139.94454-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] readahead02: Always allow at least 100ms for
 cache to fill
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
