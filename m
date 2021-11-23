Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA3DC433EF
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 05:40:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46FC63C8DC6
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 06:40:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 235523C25EC
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 06:40:31 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3FDAC2001DB
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 06:40:31 +0100 (CET)
Received: by mail-pl1-x629.google.com with SMTP id u17so16090535plg.9
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 21:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=FhE2Kl5+Nas+DPYFngW7PLZABksoTO5VQc057aohVVc=;
 b=ASe71yEcAASXMSriYncEhYuEN14wrIuJBBhFKwatdnDXIbc9cc9Y5TjkpMRZebD02p
 gvp9HA4vMt1eJMrkkxjGalUPX05TbMecQyI13FQ8fNU8Xo19RZJPtaO/9RTRu+TwavtV
 jM4/UhQ+MoldkQrFJ51BTnObYA8KW5WaCvXYeCAIwAIdQq71lDDehX+C4MHwxGzK726l
 Q5scKLU1/+JiNEHfD5k9EJRJCPqGEBso4JeDsVMpkWsnHdGFvMra2Vg6FskKoR3RYVs/
 QEtSHsOVA6RQTvv+orCZgb1GZ7HEH03BMFh/6iao2eG24moURHZuCfc79QCqZ3X9MT/C
 Qaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FhE2Kl5+Nas+DPYFngW7PLZABksoTO5VQc057aohVVc=;
 b=FBFfZ9lLfapiGaVqVdzvQmY9aWOslILmnZJ4SA31FB+93URdgni0C7WbtOUw28G/1C
 7Ouyte4xbyqx25Re/MnleAceqZLZtwYyuN1xhQSITb2oPsCGjQjKyXMz4XUkBXlenhgj
 s+Zwr0K/AZAx0AEVUZITcZPE5D/hsQp1BSpDGUQeXGgCtWrjHyntiyLPUpbSyL95pthn
 /DeM8GnLQ263R8PjoHciYTOVv6N8j1rTN713/PuAQvTfes+C7LmhmvlPqjgFpKa/9WDG
 jtVoJmtJQHIxWkWbi7ezE1SG3dRMlotJXYaEifE3HgN5P/o3jlrPUXGLENT4HdW9BKAr
 0Ypw==
X-Gm-Message-State: AOAM532MGJBrnKyU0033mo5RSqGFcsWQtennFITF1SAlGMdZig57Q2ot
 qgH5S+IKUjOxlJl0gmsN9pgCHw==
X-Google-Smtp-Source: ABdhPJwA/jliDGdWqW6a95FIFHVGwTFHNOrdfFe2H5xXxDftuDdf/X1cUWRvRmdNin/7g/al2KokNg==
X-Received: by 2002:a17:90b:3b43:: with SMTP id
 ot3mr39515856pjb.205.1637646029388; 
 Mon, 22 Nov 2021 21:40:29 -0800 (PST)
Received: from google.com ([2401:fa00:9:211:de12:dd5f:8d5c:4e51])
 by smtp.gmail.com with ESMTPSA id s28sm11347527pfg.147.2021.11.22.21.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 21:40:28 -0800 (PST)
Date: Tue, 23 Nov 2021 16:40:17 +1100
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YZx+wb6LdMP4hcTB@google.com>
References: <20211122082146.59895-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211122082146.59895-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/fanotify07: Add stop_children() to
 cleanup()
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Nov 22, 2021 at 04:21:46PM +0800, Zhao Gongyi wrote:
> When we run the testcase simultaneously, and the ulimit of open
> files is small, the testcase will fail and remain many while(1)
> tasks in system, it makes the system very stuck.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>

This patch looks OK to me. Have you taken the time to verify whether
this fix addresses the issue you've outlined in the patch description?

FTR, please remember to also explicitly CC those who you'd like to get
feedback from. Most of us are exceptionally busy and miss things that
are flying around in the many mailing lists.

> ---
> v2->v3: replace memset() with assignment statement in loop
> 
>  testcases/kernel/syscalls/fanotify/fanotify07.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> --
> 2.17.1
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
> index cc56d9019..8220213b1 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> @@ -86,13 +86,19 @@ static int stop_children(void)
>  	int child_ret;
>  	int i, ret = 0;
> 
> -	for (i = 0; i < MAX_CHILDREN; i++)
> +	for (i = 0; i < MAX_CHILDREN; i++) {
> +		if (!child_pid[i])
> +			continue;
>  		SAFE_KILL(child_pid[i], SIGKILL);
> +	}
> 
>  	for (i = 0; i < MAX_CHILDREN; i++) {
> +		if (!child_pid[i])
> +			continue;
>  		SAFE_WAITPID(child_pid[i], &child_ret, 0);
>  		if (!WIFSIGNALED(child_ret))
>  			ret = 1;
> +		child_pid[i] = 0;
>  	}
> 
>  	return ret;
> @@ -190,6 +196,8 @@ static void setup(void)
> 
>  static void cleanup(void)
>  {
> +	stop_children();
> +
>  	if (fd_notify > 0)
>  		SAFE_CLOSE(fd_notify);
>  }

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
