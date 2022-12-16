Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517B4C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 10:03:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D2F23CBC2C
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 11:03:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F4923CBAF1
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 11:03:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E00A91A00CD7
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 11:03:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E30C5CC0B;
 Fri, 16 Dec 2022 10:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671185014;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+BjGAJFiqyEWQ9qIvFQh4sYwFrIyBwRVHCy+/ee7jco=;
 b=VcKMBbx+YH/jWhipXD/cuM9yGVzgQ8gn5d7xr7Gn9Wdp4ah9SZI3ACKBvSSObnc2J0Fsck
 eJMg43rZp/YBBbhwRR7d6A2j6XGkqVWpAu/NKoL7qudFd8QCYPg4+ZAIGAoanbtWWpo+YO
 TgfZiSw9OFhqYbZbBtHxKhBSAsvX+Gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671185014;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+BjGAJFiqyEWQ9qIvFQh4sYwFrIyBwRVHCy+/ee7jco=;
 b=OFl3wgY2Wi+BsRJTQ6hEkBO4b7zLhMEhDT34Yj7L8F/nIgV5oerpI2lYgXLmVvIMzTU/Wj
 pOjQV7APKfmVH9Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CA18138F0;
 Fri, 16 Dec 2022 10:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2vrOAXZCnGOdXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 10:03:34 +0000
Date: Fri, 16 Dec 2022 11:03:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y5xCdDRf+B+OFQKh@pevik>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671166923-2173-5-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1671166923-2173-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/7] Remove old kernel version check in C case
 when using tst_kvercmp
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> The oldest supported kernel version is 3.0, so remove them.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/testcases/kernel/syscalls/sysctl/sysctl03.c
> @@ -68,14 +68,10 @@ static void verify_sysctl(void)

>  static void setup(void)
>  {
> -	if ((tst_kvercmp(2, 6, 32)) <= 0) {
> -		exp_eno = EPERM;
> -	} else {
> -		/* Look above this warning. */
> -		tst_res(TINFO,
> -			 "this test's results are based on potentially undocumented behavior in the kernel. read the NOTE in the source file for more details");
> -		exp_eno = EACCES;
> -	}
> +	/* Look above this warning. */
> +	tst_res(TINFO,
> +		 "this test's results are based on potentially undocumented behavior in the kernel. read the NOTE in the source file for more details");

NOTE after you get this merged, I'm going to update sysctl03.c.
This warning is really old, it was added in b49b375167 ("Make test pass with
undoc'ed sysctl(2) behavior.") (in 2010) and references
https://bugzilla.kernel.org/show_bug.cgi?id=15446, which was fixed in 2012.

Thus warning is not needed any more. But as the test also requires converting to
docparse, I'll do it in separate patch.

Kind regards,
Petr

> +	exp_eno = EACCES;
>  }
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
