Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31759C43458
	for <ltp@archiver.kernel.org>; Sat,  4 Jul 2026 09:16:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98A423E2F0D
	for <ltp@archiver.kernel.org>; Sat,  4 Jul 2026 11:16:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 466DB3E2F0D
 for <ltp@lists.linux.it>; Sat,  4 Jul 2026 11:16:00 +0200 (CEST)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [91.218.175.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3BE8C1A001E0
 for <ltp@lists.linux.it>; Sat,  4 Jul 2026 11:15:58 +0200 (CEST)
Date: Sat, 4 Jul 2026 17:15:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783156557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wT1oFyGrcwvimNHsM1b3TZSlz6on20sNyDf0daGLUDM=;
 b=Ltvl+rLe5udOvnUGC61a6FWHT/RUglpZ9hXx/d9boDz6BQsIBdZoe2sE6gqPBmxBVRsiVC
 YmPWMWcIPF7TFEzs8iD/UyRRtBupUV9Q+Az74kCwdwTOt0lBJTtVsHu4BbYf25IoLFGleS
 89jgcmp817M26skypHwN9/ktYsJ49qw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <akjPRHhWL6xSNF8u@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>,
 Petr Vorel <pvorel@suse.cz>
References: <aki2AjzuU7_ayxrZ@linux.dev>
 <6a48bb3c.bc1d6770.394c18.b078@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a48bb3c.bc1d6770.394c18.b078@mx.google.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_stress: survive OOM by targeting the
 stressors
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Andrea Cervesato wrote:

> > What do you think about doing this in the shell lib so all shell
> > tests benefit, rather than only memcg_stress?
> 
> this patch was sent with a wrong assumption indeed. As you can see
> from the log, the OOM message is wrong and I pasted the wrong example :)

Ah, the memcg_stress test already done and kirk start a new
one memcg_control, that oom trigged by there.

> But this raised a good point that I think you spotted quite well. It
> would be nice to implement this indeed, since shell tests are often
> causing issues when it comes to containers or stressing the memory.

Sure, if the shell part encounters same situation, appropriate
measures should be taken.

> I will leave to @Petr the last word because he's more expert than me
> on the shell tests.

+1

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
