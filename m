Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3614C43334
	for <ltp@archiver.kernel.org>; Sun, 10 Jul 2022 11:02:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F07C3CA504
	for <ltp@archiver.kernel.org>; Sun, 10 Jul 2022 13:02:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97FC33CA417
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 13:02:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 422996000EE
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 13:02:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7AABD221C8
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657450933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/hNVngdsEdEeX0DYq4qE3etZr8JA/kLn934GEDq38A=;
 b=aZBvmZKMu4OUbZi4wTKQgHtMpUJW8fKQVqTpCJv7k6ZRCLWmn2TNIE7ZtRmMpB+RTXgtzv
 YMltqd+6wodwMPH7Yh3QQBoyAUjmmmjaN9nqI77EgF7DCYUVzHqn/P5tvWdCN8bxs5mBv3
 FeKKxsHcN41IkexogzncY0++eAUNzFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657450933;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/hNVngdsEdEeX0DYq4qE3etZr8JA/kLn934GEDq38A=;
 b=4cNuN60LYa2X4TL7wx/DhHYZQ72TQp3UlLBVmMr1bpisfbs63p2VGEPejmMos8v0RyPr0g
 8/laDGCvlrHQmBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 711AC132FD
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 11:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KgBaG7WxymJoKQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 11:02:13 +0000
MIME-Version: 1.0
Date: Sun, 10 Jul 2022 11:02:13 +0000
From: akumar <akumar@suse.de>
To: ltp@lists.linux.it
In-Reply-To: <20220709165000.27830-2-akumar@suse.de>
References: <20220709165000.27830-2-akumar@suse.de>
User-Agent: Roundcube Webmail
Message-ID: <101388b3853f309be53ab44864caadb0@suse.de>
X-Sender: akumar@suse.de
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open08.c: Make use of TST_EXP_FAIL() and
 SAFE_CLOSE()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Posted a v2 for this as I realized I should use TST_EXP_FAIL2() here.

--
Avinesh

On 2022-07-09 16:49, Avinesh Kumar wrote:
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/open/open08.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/open/open08.c
> b/testcases/kernel/syscalls/open/open08.c
> index 29a23c2f7..8bb151447 100644
> --- a/testcases/kernel/syscalls/open/open08.c
> +++ b/testcases/kernel/syscalls/open/open08.c
> @@ -68,25 +68,10 @@ static struct test_case_t {
>  	{&unmapped_fname, O_CREAT, EFAULT}
>  };
> 
> -void verify_open(unsigned int i)
> +static void verify_open(unsigned int i)
>  {
> -	TEST(open(*tcases[i].fname, tcases[i].flags,
> -		S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH));
> -
> -	if (TST_RET != -1) {
> -		tst_res(TFAIL, "call succeeded unexpectedly");
> -		return;
> -	}
> -
> -	if (TST_ERR == tcases[i].error) {
> -		tst_res(TPASS, "expected failure - "
> -				"errno = %d : %s", TST_ERR,
> -				strerror(TST_ERR));
> -	} else {
> -		tst_res(TFAIL, "unexpected error - %d : %s - "
> -				"expected %d", TST_ERR,
> -				strerror(TST_ERR), tcases[i].error);
> -	}
> +	TST_EXP_FAIL(open(*tcases[i].fname, tcases[i].flags, 0644),
> +				tcases[i].error);
>  }
> 
>  static void setup(void)
> @@ -105,7 +90,7 @@ static void setup(void)
>  	SAFE_SETUID(ltpuser->pw_uid);
> 
>  	fildes = SAFE_CREAT(existing_fname, 0600);
> -	close(fildes);
> +	SAFE_CLOSE(fildes);
> 
>  	unmapped_fname = tst_get_bad_addr(NULL);
>  }
> --
> 2.36.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
