Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A6CEE6431
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 07:56:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C54B53CE69C
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 09:56:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DB673CE70C
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 17:20:00 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B9B6A617621
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 17:19:59 +0200 (CEST)
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-44ee1123667so1433312137.0
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694704798; x=1695309598; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgA7PcwmgwXejCiJKRlHdUH5uK+0JkyppZjxMRcSh+s=;
 b=b0ZE9d996qOqaWngkiMMdnq2AjMoIEuiMy2u0vqXna4FHNl6hz7prlbepkLme4J8rT
 C/9cbLGPYN3DGeyKp5cQZnjivuv6C9IWMrV88rv1j+YRxrDtDcCcLlfdxWncigdpEq5H
 CWOQ4gvh2mMK5ywv7CAZxZwDtqNJv1KOOn0xdnNEY0DKHV7xPM0g823MTkNBZOmxfmhC
 KtFQiQeEkgOu273bPrwtubP/1PdzdM6tcJgmnVGPwCIuS7gkbxGt65iNz0/cXnfgSrPB
 yNJh3ORawGv7XgvdjEhS8DarC4XGU71Ovn1cwVdNbe9mW2kzrRVQbqF4iWW/KRwOQ+AQ
 VRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694704798; x=1695309598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgA7PcwmgwXejCiJKRlHdUH5uK+0JkyppZjxMRcSh+s=;
 b=kkbK9kzXeYkfYM3R8Va9GZYI+Ew2swetv4wY0eB+7HGnA/2YWuqINUhdoVUPbR13Hc
 w9yCf84kfyfiTBilmKqNuPOmXp1nqCpgr8bjiKYfxPPkXAs1AbnoMs8jGBsbmMkSvwD9
 wLHtBAWbaG2TaacFCpGn8sLPge1j6nK5XwiSavbFi6n4KYLA43IiUFUqvo7LSqzmH5ZM
 3QdZNVOcuuPKqgEeinORFcioG5xOKLLet6jh+aG5s4hhq8zzX7j5U0acyIa0DYx9iRXd
 EB4O2ZEx9OtckwpoH08lgCo5bn81mB6Cnuc1SwSFpfQ4Ix/RG0QTqoxwY0s3Me5Sbg9F
 EYFg==
X-Gm-Message-State: AOJu0YyQp45W/VSXBxCmzbJgRZgEcl732VzNI6NjNdWmZwzoz42yggFU
 E4zKjDWJycjJbxTZfhX1Yio=
X-Google-Smtp-Source: AGHT+IGSlm6UqcoGzTxdPnKwkOkMH2W7gTDRm/2Fmh7Lspov7kgxMbOYMHyDV8LJCq8qMOfoh9EVsw==
X-Received: by 2002:a67:ee50:0:b0:44e:837a:25e with SMTP id
 g16-20020a67ee50000000b0044e837a025emr1010521vsp.11.1694704798503; 
 Thu, 14 Sep 2023 08:19:58 -0700 (PDT)
Received: from localhost.localdomain (vps-035beda1.vps.ovh.us. [51.81.85.161])
 by smtp.gmail.com with ESMTPSA id
 g2-20020ab016c2000000b0079b44af2af8sm193838uaf.30.2023.09.14.08.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:19:57 -0700 (PDT)
From: Yong Wang <yongw.pur@gmail.com>
X-Google-Original-From: Yong Wang <wang.yong12@zte.com.cn>
To: chrubis@suse.cz,
	naresh.kamboju@linaro.org
Date: Thu, 14 Sep 2023 23:18:39 +0800
Message-Id: <20230914151839.3635-1-wang.yong12@zte.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+G9fYvHhiiGKhNd=L9+xYFVwv0Q8k6gUBeFQGWCWw1cWhb50Q@mail.gmail.com>
References: <CA+G9fYvHhiiGKhNd=L9+xYFVwv0Q8k6gUBeFQGWCWw1cWhb50Q@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 15 Sep 2023 09:56:43 +0200
Subject: [LTP] LTP: cfs_bandwidth01: Unable to handle kernel NULL pointer
 dereference
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
Cc: ran.xiaokai@zte.com.cn, arnd@arndb.de, linux-pm@vger.kernel.org,
 peterz@infradead.org, wang.yong12@zte.com.cn, linux-kernel@vger.kernel.org,
 yang.yang29@zte.com.cn, vincent.guittot@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello!
>Following kernel crash noticed on Linux stable-rc 6.5.3-rc1 on qemu-arm64 while
>running LTP sched tests cases.
>
>This is not always reproducible.
I also encountered this problem on linux 5.10 on arm64 environment.
The prompt information is as follows:
[ 2893.003795] ================================================================== 
[ 2893.003822] BUG: KASAN: null-ptr-deref in pick_next_task_fair+0x130/0x4e0 
[ 2893.003880] Read of size 8 at addr 0000000000000080 by task ksoftirqd/0/12 
[ 2893.003901]  
[ 2893.003914] CPU: 0 PID: 12 Comm: ksoftirqd/0 Tainted: P           O      5.10.59-rt52#1 
[ 2893.003959] Call trace: 
[ 2893.003968]  dump_backtrace+0x0/0x2e8 
[ 2893.004009]  show_stack+0x18/0x28 
[ 2893.004032]  dump_stack+0x104/0x174 
[ 2893.004067]  kasan_report+0x1d0/0x258 
[ 2893.004098]  __asan_load8+0x94/0xd0 
[ 2893.004126]  pick_next_task_fair+0x130/0x4e0 
[ 2893.004164]  __schedule+0x220/0xbd0 
[ 2893.004192]  schedule+0xec/0x1a0 
[ 2893.004216]  smpboot_thread_fn+0x124/0x548 
[ 2893.004246]  kthread+0x24c/0x278 
[ 2893.004277]  ret_from_fork+0x10/0x34 
[ 2893.004306] ================================================================== 
[ 2893.004325] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080 
[ 2893.152267] Mem abort info: 
[ 2893.152639]   ESR = 0x96000004 
[ 2893.153045]   EC = 0x25: DABT (current EL), IL = 32 bits 
[ 2893.153739]   SET = 0, FnV = 0 
[ 2893.154143]   EA = 0, S1PTW = 0 
[ 2893.154560] Data abort info: 
[ 2893.154940]   ISV = 0, ISS = 0x00000004 
[ 2893.155443]   CM = 0, WnR = 0 
[ 2893.155838] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000188edb000 

The source code where the problem occurs corresponds to:
  se = pick_next_entity(cfs_rq, curr);		
  cfs_rq = group_cfs_rq(se); //se is NULL!

It is found that pick_next_entity returns null, so null-ptr-dere appears when accessing the members of se later.
But it is not clear under what circumstances pick_next_entity returns null.

In addition, in my environment, the following operations often recur:
  stress-ng -c 8 --cpu-load 100 --sched fifo --sched-prio 1 --cpu-method pi -t 900 &
  runltp -s cfs_bandwidth01

Hope it helps to solve the problem.
Thanks.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
