Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D7ACD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 07:32:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D6003E4E3E
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:32:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D4023D0EF6
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:32:35 +0200 (CEST)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B8EE2200AF6
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:32:34 +0200 (CEST)
Date: Tue, 16 Jun 2026 15:32:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781595152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EbvbcVQYgjBLFkU98qt3+SI9KOZRIlZrx7+90aLGpgM=;
 b=TKdAd5O7eDMioT+EgCnDHmbu9hA53MwjEU9Zopzv29y4udUPLoSjedb+bVguayOqHUAy6u
 gb/5u/nnIu2EfyxO+eQb5Kw1aYeMoC4yaEeqWynzeRFcATiTVDbpPE594wGCxQUyOPhnxZ
 jYj+p1KN6+jcFrH+cJE2JNlf0QNNeSM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ajD8B3bQenC30Lp_@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260615-fix_pids_errors-v1-0-99a54a205180@suse.com>
 <20260615-fix_pids_errors-v1-1-99a54a205180@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615-fix_pids_errors-v1-1-99a54a205180@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] pids: fix cleanup of orphaned pids_task1
 children
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> pids_task1 forks a child that calls pause(), then the parent exits.
> The orphaned child remains in the cgroup but gets reparented to init,
> so it is not a child of the test shell.
> 
> stop_pids_tasks_path() reads cgroup.procs which includes this orphan.
> kill -9 succeeds but wait fails with 'not a child of this shell'.
> Using ROD for kill also unnecessarily aborts if the process is already
> dead.
> 
> Fix by suppressing errors from both kill and wait, and add killall
> for pids_task1 in cleanup() to catch any remaining orphans.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
