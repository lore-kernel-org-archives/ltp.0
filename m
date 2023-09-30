Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5DEE77354
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 06:34:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CFAB3CE0C5
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 08:34:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EEAA3CB9EA
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 08:34:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C46B1400B7B
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 08:34:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 632C81F8C0;
 Sat, 30 Sep 2023 06:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696055681;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkEsPUjuJ6dyc+N5Izkh+VH/Q9J53wyuQ6ITuA2qrEo=;
 b=L69v1bIbJxpUnDF/x9FM4JjdgXQs+35CNLCIJ98ayEh8fUf6rjC89GRuNc/zRyW7w4JohS
 S0+01RIcpXHRsoujR2SpPbB/bqp65/GrpxLV0ndeZlffwidvwzxtgXQ4Xh0FyaevhzsbNy
 W+CSWXiy0r8Z3X+o3aQOxgFnmxbxJqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696055681;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkEsPUjuJ6dyc+N5Izkh+VH/Q9J53wyuQ6ITuA2qrEo=;
 b=xRyDNK1RUxT47uZ3MYhied6dcKQSpmCWpPcJyL6gjPWI9TJHZVunuIOoSTLEcyNgo0L6uU
 K/ijHRy1RfdjMHDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F410A13456;
 Sat, 30 Sep 2023 06:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FHyaOIDBF2W+FwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 30 Sep 2023 06:34:40 +0000
Date: Sat, 30 Sep 2023 08:34:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230930063438.GB414289@pevik>
References: <20230930000007.4052837-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230930000007.4052837-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pipe07: close /proc/self/fd after counting fds
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> Leaving the directory fd open will count against the max number of fds
> opened, so the final expected count will be off.

> Also, removed the halving / doubling of exp_num_pipes since it is
> redundant.

> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  testcases/kernel/syscalls/pipe/pipe07.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

> diff --git a/testcases/kernel/syscalls/pipe/pipe07.c b/testcases/kernel/syscalls/pipe/pipe07.c
> index 196485684..01f6b78f8 100644
> --- a/testcases/kernel/syscalls/pipe/pipe07.c
> +++ b/testcases/kernel/syscalls/pipe/pipe07.c
> @@ -45,6 +45,8 @@ static int record_open_fds(void)
>  		opened_fds[num_opened_fds++] = fd;
>  	}

> +	SAFE_CLOSEDIR(dir);
IMHO this changes counting from 1020:

pipe07.c:56: TINFO: getdtablesize() = 1024
pipe07.c:60: TINFO: expected max fds to be opened by pipe(): 1020
pipe07.c:75: TPASS: errno == EMFILE (24)
pipe07.c:76: TPASS: exp_num_pipes * 2 == num_pipe_fds (1020)

to 1021, which leads to failure:

pipe07.c:58: TINFO: getdtablesize() = 1024
pipe07.c:62: TINFO: expected max fds to be opened by pipe(): 1021
pipe07.c:77: TPASS: errno == EMFILE (24)
pipe07.c:78: TFAIL: exp_num_pipes (1021) != num_pipe_fds (1020)

> +
>  	return num_opened_fds;
This is not elegant, but get's the correct count. Will it fail on AOSP?

return num_opened_fds + 1;
>  }

> @@ -56,8 +58,8 @@ static void setup(void)
>  	tst_res(TINFO, "getdtablesize() = %d", max_fds);
>  	pipe_fds = SAFE_MALLOC(max_fds * sizeof(int));

> -	exp_num_pipes = (max_fds - record_open_fds()) / 2;
> -	tst_res(TINFO, "expected max fds to be opened by pipe(): %d", exp_num_pipes * 2);
> +	exp_num_pipes = max_fds - record_open_fds();
> +	tst_res(TINFO, "expected max fds to be opened by pipe(): %d", exp_num_pipes);

It'd be slightly more readable if this was in separate patch
(as it modifies the same variable), but it's up to you.

Kind regards,
Petr

>  }

>  static void run(void)
> @@ -73,7 +75,7 @@ static void run(void)
>  	} while (!TST_RET);

>  	TST_EXP_EQ_LI(errno, EMFILE);
> -	TST_EXP_EQ_LI(exp_num_pipes * 2, num_pipe_fds);
> +	TST_EXP_EQ_LI(exp_num_pipes, num_pipe_fds);

>  	for (int i = 0; i < num_pipe_fds; i++)
>  		SAFE_CLOSE(pipe_fds[i]);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
