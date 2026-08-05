Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09F3C55182
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 07:35:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 414923E1501
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:35:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 505403E1501
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 09:35:20 +0200 (CEST)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com
 [95.215.58.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 84D481400DA9
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 09:35:18 +0200 (CEST)
Date: Wed, 5 Aug 2026 15:34:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785915317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6+J074n73uIATPM/xzDvqpnu6h62xmQBD0w42vJIZIw=;
 b=ttvyCykgVUOykLhQQKwxmIHhjq+gnn2OkvE7dRQ15Jdlc2FS3Hb9yYlNt75bj01ac+nXrZ
 aJsNeW7Ypa3WhLyKZSDWrfF1j0PYguT/9XaoXp/uJ4TmGbHWdk3Flv0JtXsPwz3dtyERNh
 idfaBPZo+1RbCEV5vuEc/HTJ47RXdro=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Xuewen Wang <wangxuewen@kylinos.cn>
Message-ID: <anLnmVKGARAsrV6O@linux.dev>
Mail-Followup-To: Xuewen Wang <wangxuewen@kylinos.cn>, ltp@lists.linux.it,
 liwang@hygon.cn
References: <20260805064053.916492-1-wangxuewen@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260805064053.916492-1-wangxuewen@kylinos.cn>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] memcg/functional: fix memcg_failcnt
 intermittent timeout by disabling swap
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
Cc: ltp@lists.linux.it, liwang@hygon.cn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xuewen,

Xuewen Wang wrote:

> memcg_failcnt.sh tests the memory.failcnt counter by allocating
> reclaimable memory (mmap-anon/mmap-file/shm) beyond a tiny cgroup
> limit (1 page). It relies on the process being OOM-killed so that
> signal_memcg_process()'s wait loop exits.
> 
> With swap enabled the kernel usually still OOM-kills the process,
> but on arm64 reclaim (swap out) sometimes succeeds instead:
> usage_in_bytes stays at the limit and the process keeps running,
> so the wait loop times out (TBROK) intermittently.
> 
> Example failure on arm64 (kernel 6.6):
>   memcg_failcnt 2 TBROK: timed out on memory.usage_in_bytes 4096 0 8192
> 
> Disable swap around the allocation and re-enable it afterwards,
> mirroring what memcg_limit_in_bytes.sh already does for the same
> reclaimable memory types.

This fix make sense, but I'd rather go with a tidy way:

...
TST_SETUP=do_setup
TST_CLEANUP=do_cleanup

do_setup()
{
        memcg_setup
        swapoff -a
}

do_cleanup()
{
        swapon -a
        memcg_cleanup
}

...

My Red Hat email address is no longer used. Please CC my new
address for future versions:

  li.wang@linux.dev
or:
  liwang@hygon.cn

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
