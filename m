Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1A7C61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787915280; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=x0I4VQjAye8SrIUcRey77whQfzCITg4CLZIUsXxfxWE=;
 b=k7W9WlwfQa8X1d7i+jxbFIDLABwjnnqmNBzmsWmbKs7BUPnexd7HdJocbunVSPHoccRFv
 1aaQqCvwL3hJIzjgJj8ocNqAFt9/3n/4NU4p9HMULduNTHv7ki/w6+CAkvy4Ffr3e9qba/6
 HZGEzTUk42q1tAH0nQbmEzkzDR3Pc1I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BD883DD385
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:08:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 140183C6EBE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:07:39 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 600471000A5C
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:07:39 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so11724255e9.1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787915259; x=1788520059; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n3SNRGKlFP35ID6VvXQRbYSod8boR8uEbZ1yx8oA66E=;
 b=G4RycdNW/N6/6fmAdkPYXK3q4AZWED+faYSACKV6VRLN+CiALmeH5Qk8KfQbrwPthb
 TrFB88+Ni26rHwa+KjneG5Ls+TUlsDssnPBFVfMlYHVxO4lgHLTqqVJbGOOJLXkyeylo
 /SWimR2yH3CVcLtBeBmOZzUOMBx5yRcT8JLbJcc7prrtQ2rbzn84p4/GVb5IFS0GDHH8
 m9IKSeBhu0tQRXZcZg/tpcrhtWX6d6zv6dxuPPgYtEsm/ROJg1NLQDPQnu8wTieYMb1s
 usUCA+6OcOeSoXMz97w3RuTKfFr70GyW0QB6RdJrmBMy03KKewglbIgHNgpFI+XP+AQ1
 nNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787915259; x=1788520059;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n3SNRGKlFP35ID6VvXQRbYSod8boR8uEbZ1yx8oA66E=;
 b=IILlBgFrljjh46SeRRPVM77hhX8zt8ebgmbJIDiRx9gETUQ72XLVidzH3AISYrpuG+
 2AJrT0NKcUCNLEbXR33/t2xFt13Dc9NiNNsk6x+dPFHclboEvcGM/ugkSjiQDnl+NxYH
 7UgAPH4fHplUcYTOXuTg6kcC5BMl0ziiJ7V2TgWQDeYPFbFrLzHN8AxFOMIWd1Snxmw+
 IToPG8H8HTksEw2BFQLWZDRybd+SogkzF5i+eyKCt6TcZVr4od+Rd85fsvpberM4xlt4
 URANx+Cvqy/QqgOvCGhf3IsArT3g25rh15E7oUi+w12iEIzOf6v3I6UhP+SO77KKnceM
 Gbjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBxpdCnRrGtDcg/dvBspvfCEcVk4+zbGYl1uFTuhYiRzAR2ZC1u0vRmQuTkOTc17vPUQo=@lists.linux.it
X-Gm-Message-State: AFuF++mxwIsUBMlVAZwh/0jvkysxmuALXizMwgW/XxercbnjPPBnLFn6
 O7EOMGIttO0WBL45GnzPvJIj1n7eVdCHdVVBy106JhPTvLbEE1ATUFBMjPRl0X+CqM4=
X-Gm-Gg: AR+sD10/nKQNhQj5t5jGheYaHQivHiDWyCS8fPcprlSyohpUWp/s5Z3v5aCtNuSsAVZ
 FPfPVw7dMhx4VzrFcuC909Z4BbiIbUHWobNvTXsHpaQkEfYo6logc1xlMsSZT9ect4VlBqHvdkU
 8bIii8wMv5hInG3RY7t5yA2eMbpopwgRAQqn5it5KPjF6xC32i9eNlBN6E3/v0FIS3KzIerXIBT
 nPFuupePh0VmLDVfz6a5CN+9YrwyHwi/doB/+pGnrrUOdaqQgtMmmBlldei1ZlNptVQk3xmEipC
 pWg7fgefc1kf37evHVHj896vH7jqGRS2nDbizdwhfN+oayVv9IbhRqOFf8POchq5M0+i3uYtJsw
 hgl1CpalM06k7zuDmQTpt+eDoSEs7pbRi0+skDGU/w9zl0Zt3F7gSlEljTX2fenyHZh8C57YQU+
 TB08tvHRxNu3E7UYiZvGrR3deR3II62SEIM6rGpVteKXO1LAyeYIAzY8T7bGpqd2QktUYuL0tiy
 4Oxp8NJuZgK5l+O31R2Lsd2m9nBZTcy3GakZA==
X-Received: by 2002:a05:600c:474f:b0:49b:e22:4ee4 with SMTP id
 5b1f17b1804b1-49b91a58979mr70759405e9.4.1787915255205; 
 Fri, 28 Aug 2026 04:07:35 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91ca11d0sm48022635e9.1.2026.08.28.04.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:07:34 -0700 (PDT)
Message-ID: <6a916bf6.50a5bfbe.5b7f7.5041@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260828094632.9559-1-linuxtestproject.agent@gmail.com>
Date: Fri, 28 Aug 2026 11:07:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: fallback definitions for swapon syscall
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> --- [PATCH 1/3] ---
> 
> > lapi: fallback definitions for swapon syscall
> >
> > Introduce fallback definition inside lapi for:
> 
> Could the subject and body name include/tse_swap.h rather than lapi? The
> fallback definitions are not added under include/lapi/, so the current
> component and location do not match the patch.
> 
> --- [PATCH 3/3] ---
> 
> > +	TST_EXP_FAIL(tst_syscall(__NR_swapon, tc->path, tc->flags), tc->exp_errno,
> >  		     "swapon(2) fail with %s", tc->err_desc);
> >
> >  static void cleanup(void)
> >  {
> >  	if (do_swapoff && tst_syscall(__NR_swapoff, USED_FILE))
> >  		tst_res(TWARN | TERRNO, "swapoff(alreadyused) failed");
> >  }
> 
> Could an unexpected successful swapon() of SWAP_FILE be tracked and undone?
> This is the failure mode these new cases are intended to detect, but
> TST_EXP_FAIL() only reports TFAIL. The swap area remains active, the next
> case gets EBUSY, and cleanup only disables USED_FILE, so the test filesystem
> cannot be unmounted.

These are both correct, I will fix them in the next version.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
