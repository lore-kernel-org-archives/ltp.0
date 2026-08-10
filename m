Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D47C5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 03:56:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69B693CB39C
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 05:56:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A2C53CB270
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:56:32 +0200 (CEST)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ba])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 97A2C2000F3
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:56:30 +0200 (CEST)
Date: Mon, 10 Aug 2026 11:55:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1786334190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MEEi7iiQ0KWcj/efSTLbO49Z5MuUGynMPI/PD6ELhI0=;
 b=ZFL7kGaAdn58EF2xPSGH7JrrdstYx5+lkoIPEBVJyDdagkMcViDOgzEDhtNA3XTpzMF+CG
 VS6wAzSdKYV5WWSiC1NERIRW5w2IhNENw4eCPQbRJlwLTZuDZBYO0wFfR0de0sO99SVb8Z
 gcXu/pqaoVG7ieTfoXlZEaOWAWIi1RY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: linuxtestproject.agent@gmail.com
Message-ID: <anlLyuZW-8dHISLB@linux.dev>
Mail-Followup-To: linuxtestproject.agent@gmail.com,
 Wake Liu <wakel@google.com>, ltp@lists.linux.it
References: <20260807234935.3248935-1-wakel@google.com>
 <20260808013246.12398-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260808013246.12398-1-linuxtestproject.agent@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Use backoff polling to wait for loop device nodes
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

On Sat, Aug 08, 2026 at 01:32:46AM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wake,
> 
> On Fri, 7 Aug 2026, Wake Liu wrote:
> > lib: Use backoff polling to wait for loop device nodes
> 
> > +				path_set = TST_RETRY_FN_EXP_BACKOFF(
> > +					set_dev_loop_path(rc, path, path_len),
> > +					TST_RETVAL_EQ0, 1);
> 
> Could the backoff arithmetic be made overflow-safe before these two new
> uses?
> 
> LTP_TIMEOUT_MUL=3000 is accepted by parse_mul(), which makes

Theoretically, this is correct, but I don't think anyone will
need a timeout as large as 3000 * 30s for one of LTP test.
It would take nearly 25 hours to trigger, which is unrealistic.

IOW, your patch v6 is good enough. Sometimes AI agent is too strict.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
