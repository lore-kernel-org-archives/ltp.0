Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A8AC001B0
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 12:29:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EA433CE1D4
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 14:29:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96BFA3CD1CF
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 14:29:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9FB071400DC4
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 14:29:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D73A61FD73;
 Mon,  7 Aug 2023 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691411377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BPc8C/nx77r3WZpNRIhCI958U7qkgsYy4gce3kN+UGU=;
 b=04HwOx9i39E65ccuIDNcrUaNmkFYddZmso8KrjxDD/c2l7faEDzc7j/O+pE3RFNYqvNP1e
 bkz3ZlRMGZxuVca/CxMTN+LSCqykE7Kaw+Ny5+pIhQH7SorO93YnR0WIXdlsOtJIld+ykj
 wdGj14wUl3z7+pxEaVByFHIZEuKHJZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691411377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BPc8C/nx77r3WZpNRIhCI958U7qkgsYy4gce3kN+UGU=;
 b=+1IK7uKfGP6b1P6dlHo42f7ybJMJcB3a+vlLexca9qCRRUPzXC2vzXunwlDmXx95ZQ5o5d
 UdvjtH0S//kHRaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3C9F13487;
 Mon,  7 Aug 2023 12:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IAlnLrHj0GQnfAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 07 Aug 2023 12:29:37 +0000
Date: Mon, 7 Aug 2023 14:30:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZNDj6o3UViMIbvkT@yuki>
References: <1690888046-18662-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1690888046-18662-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] syscalls/setgroups01: Convert to new API
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

Hi!
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include <sys/param.h>
> -#include <unistd.h>
> -#include <grp.h>
> -
> -#include "test.h"
> -
> -#include "compat_16.h"
> +/*\
> + * [Description]
> + *
> + * Check the basic functionality of the setgroups() system call.
> + */
>  
> -void setup();
> -void cleanup();
> +#include "tst_test.h"
> +#include "compat_tst_16.h"
>  
> -TCID_DEFINE(setgroups01);
> -int TST_TOTAL = 1;
> +static int len = NGROUPS, ngrps;
>  
> -int len = NGROUPS, ngrps = 0;
> -GID_T list[NGROUPS];
> +static GID_T list[NGROUPS];
>  
> -int main(int ac, char **av)
> +static void verify_setgroups(void)
>  {
> -	int lc;
> -
> -    /***************************************************************
> -     * parse standard options
> -     ***************************************************************/
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -    /***************************************************************
> -     * perform global setup for test
> -     ***************************************************************/
> -	setup();
> -
> -    /***************************************************************
> -     * check looping state if -c option given
> -     ***************************************************************/
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/*
> -		 * Call setgroups(2)
> -		 */
> -		TEST(SETGROUPS(cleanup, ngrps, list));
> -
> -		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL,
> -				 "setgroups(%d, list) Failed, errno=%d : %s",
> -				 len, TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			tst_resm(TPASS,
> -				 "setgroups(%d, list) returned %ld",
> -				 len, TEST_RETURN);
> -		}
> -
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_POSITIVE(SETGROUPS(ngrps, list),
> +			 "setgroups(%d, list)", len);
>  }
>  
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup(void)
> +static void setup(void)
>  {
> -
> -	tst_require_root();
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	ngrps = GETGROUPS(cleanup, len, list);
> -	if (ngrps == -1) {
> -		tst_brkm(TBROK, cleanup,
> -			 "getgroups(%d, list) Failure. errno=%d : %s",
> -			 len, errno, strerror(errno));
> +	if (GETGROUPS(len, list) < 0) {
> +		tst_brk(TBROK,
> +			"getgroups(%d, list) Failure. errno=%d : %s",
> +			len, errno, strerror(errno));
                             ^
			     use TERRNO instead of printing the values
			     by hand


>  	}

Also after this change the ngrps is no loger set and we pass 0 as the
number of groups to the setgroups call.


The rest of the changes looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
