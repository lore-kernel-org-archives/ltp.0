Return-Path: <SRS0=YkbW=OY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52892C433EF
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 08:36:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF956115C
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 08:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BF956115C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44DC43C7FE8
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 10:36:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2007B3C6815
 for <ltp@lists.linux.it>; Mon,  4 Oct 2021 10:36:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8C2BC200CF5
 for <ltp@lists.linux.it>; Mon,  4 Oct 2021 10:36:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC725221D1;
 Mon,  4 Oct 2021 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633336576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yIWGQr8Lnr0kyrAqAbdsmi9EQz3ds3pFiPrqrIIpI04=;
 b=xCJtFVADgGUekhJXtujYxzdnAhO1FFfI715Gh90bqbWnWPYEtjeSnRUgS53Dns1pZ07Ow6
 u0LxlrXZRJMjq0/n8Jm50NpV/ES2HgWCUoO9u8daqT7efL4ScMLSMmpleN2LXFF3rxNhws
 7IPNjWH/KrJKp0LveI8VXSM1+8RMSIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633336576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yIWGQr8Lnr0kyrAqAbdsmi9EQz3ds3pFiPrqrIIpI04=;
 b=mkpF3LE3Ajx1Bm+dkRis4A1s7vVQY+ojxidc9aX1sVcEigjyF2b/mKWlAFIs29+PVqXoj5
 32RwxCiCRi09P+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E885139C1;
 Mon,  4 Oct 2021 08:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id reCRIwC9WmEtIQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 04 Oct 2021 08:36:16 +0000
Date: Mon, 4 Oct 2021 10:36:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YVq8/nj/x8ZEvmmt@pevik>
References: <20210925174703.7675-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210925174703.7675-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setgroups03: Fix running more iterations (-i 2)
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

Hi Zhao,

> When run the test with option "-i 2", test will fail and
> report "setgroups03.c:157: setgroups(65537) fails, Size
> is > sysconf(_SC_NGROUPS_MAX), errno=1, expected errno=22".
good point, thanks for addressing this.

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  .../kernel/syscalls/setgroups/setgroups03.c   | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
> index 490b06996..3ddea5635 100644
> --- a/testcases/kernel/syscalls/setgroups/setgroups03.c
> +++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
> @@ -88,6 +88,7 @@ GID_T *groups_list;		/* Array to hold gids for getgroups() */

>  int setup1();			/* setup function to test error EPERM */
>  void setup();			/* setup function for the test */
> +void cleanup1();		/* cleanup function for setup1 */
>  void cleanup();			/* cleanup function for the test */
This test really deserves porting to new API. cleanup() function is empty
(thus we should actually delete it and use NULL instead of cleanup in tst_resm
and other functions, but that'll be cleaned in new API rewrite) and there are
other wrong parts (e.g. setup1() return only 0, but not 1 on failure) and really
ugly style (useless comments).

>  struct test_case_t {		/* test case struct. to hold ref. test cond's */
> @@ -156,6 +157,9 @@ int main(int ac, char **av)
>  					 gidsetsize, test_desc, TEST_ERRNO,
>  					 Test_cases[i].exp_errno);
>  			}
> +			if (Test_cases[i].setupfunc != NULL) {
> +				cleanup1();
> +			}
>  		}

>  	}
> @@ -191,7 +195,7 @@ int setup1(void)
>  {
>  	struct passwd *user_info;	/* struct. to hold test user info */

> -/* Switch to nobody user for correct error code collection */
> +	/* Switch to nobody user for correct error code collection */
>  	ltpuser = getpwnam(nobody_uid);
>  	if (seteuid(ltpuser->pw_uid) == -1) {
>  		tst_resm(TINFO, "setreuid failed to "
> @@ -212,6 +216,24 @@ int setup1(void)
>  	return 0;
>  }

> +void cleanup1(void)
> +{
> +	struct passwd *user_info;
nit: blank line here.
> +	if (seteuid(0) < 0)
> +		tst_brkm(TBROK, cleanup, "seteuid failed");
SAFE_SETEUID(cleanup, 0);

> +
> +	if ((user_info = getpwnam("root")) == NULL)
> +		tst_brkm(TBROK, cleanup, "getpwnam(2) of root Failed");
SAFE_GETPWNAM(cleanup, NULL)

> +
> +	if (!GID_SIZE_CHECK(user_info->pw_gid)) {
> +		tst_brkm(TBROK,
> +			 cleanup,
> +			 "gid returned from getpwnam is too large for testing setgroups16");
> +	}
> +
> +	groups_list[0] = user_info->pw_gid;
> +}

Actually setup1() and cleanup1() could be single function if it takes uid_t euid
parameter, because this part of setup1() should IMHO be SAFE_GETPWNAM():

	if (seteuid(ltpuser->pw_uid) == -1) {
		tst_resm(TINFO, "setreuid failed to "
			 "to set the effective uid to %d", ltpuser->pw_uid);
		perror("setreuid");
	}

I'll send v2 under your name.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
