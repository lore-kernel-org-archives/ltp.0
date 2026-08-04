Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76483C55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 04:20:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A92E3E729E
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 06:20:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AB663E2AB5
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 06:20:23 +0200 (CEST)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CFE771A00930
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 06:20:20 +0200 (CEST)
Date: Tue, 4 Aug 2026 11:58:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785815919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BVMCWGnAAp67sguV66AjIdmDOLKpha0HQrD7yC3YzJ8=;
 b=jcu1Rn0G+7kR42bC+HuM7OWCCNcud9ruz6SSgYfcusIlgFlYndDGN/PSYpbdkmg2wSW4a2
 +sMIadRCf5gQQK0PPD0v2r1EngUwR/z0e4UKKoINsufeB3tS94WItg/wcENJV4Tx09yJrY
 y486D9Qd7lXQN26ud3ixK3PpnisBFno=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Wake Liu <wakel@google.com>
Message-ID: <anFjaQ--3q38-psW@linux.dev>
Mail-Followup-To: Wake Liu <wakel@google.com>, ltp@lists.linux.it
References: <20260803152754.3991113-1-wakel@google.com>
 <20260804015905.74573-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804015905.74573-1-wakel@google.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Use backoff polling to wait for loop
 device nodes
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

Wake Liu via ltp wrote:

> From: Wake Liu via ltp <ltp@lists.linux.it>
> 
> On systems where loop device node creation is asynchronous (such as Android
> containers or systems with slow udev startup), calling stat() or open()
> immediately after LOOP_CTL_GET_FREE can transiently fail because the
> device file (e.g. /dev/loopX) has not been fully populated in time.
> 
> Introduce an exponential-backoff retry loop in both
> tst_find_free_loopdev() and tst_attach_device() (starting at 1ms delay,
> doubling each try, capped at 100ms) to wait for the device node to be
> successfully populated.
> 
> This improves the robustness of loop device allocations on asynchronous
> virtualized environments while minimizing unnecessary delays on responsive
> systems.
> 
> Link: https://lore.kernel.org/ltp/20260803152754.3991113-1-wakel@google.com/
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
> v1 -> v2:
>  - Strictly clamp backoff delay to 100ms (prevent overflow exceeding cap).
>  - Skip usleep on final loop iteration to avoid unnecessary idle delay.
>  - Reduce max attempts to 30 (stat) and 15 (open) to bound worst-case timeout.
> 
>  lib/tst_device.c | 32 +++++++++++++++++++++++++++-----
> 
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 744173ffef..19e1a8a25c 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -82,7 +82,7 @@ static int set_dev_loop_path(int rc, char *path, size_t path_len)
>  
>  int tst_find_free_loopdev(char *path, size_t path_len)
>  {
> -	int ctl_fd, dev_fd, rc, i;
> +	int ctl_fd, dev_fd, rc, i, path_set;
>  	struct loop_info loopinfo;
>  	char buf[PATH_MAX];
>  
> @@ -94,8 +94,18 @@ int tst_find_free_loopdev(char *path, size_t path_len)
>  		if (rc >= 0) {
>  			if (path) {
> -				if (set_dev_loop_path(rc, path, path_len))
> -					tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
> +				unsigned int usec = 1000; /* start with 1ms */
> +
> +				for (i = 0; i < 30; i++) {
> +					path_set = set_dev_loop_path(rc, path, path_len);
> +					if (!path_set)
> +						break;
> +					if (i < 29) {
> +						usleep(usec);
> +						usec = usec * 2 < 100000 ? usec * 2 : 100000;
> +					}
> +				}

LTP has already provided the exponential-backoff macro in tst_common.h

  TST_RETRY_FN_EXP_BACKOFF()

Maybe you can reuse it directly?

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
