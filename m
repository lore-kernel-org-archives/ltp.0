Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB72C433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 09:54:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 138353CA0A3
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 10:54:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4822A3C0309
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 10:54:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B2C841401445
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 10:54:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E54C31F37D;
 Thu, 17 Feb 2022 09:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645091640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ce3XAXOnsVh6eXPTSQDZt9DWrZieHLQsSF+P0ypZmuI=;
 b=LjglO9OwOKMKX96EUT03q9vLnHRubtpGuurALC3+eWzIH9uQeow3wKbGTtXoR1HUf9kEJR
 d2SyXARXyaEPXRZRzhDfqSUBjzZ6ArZpyz0He3ZUws4eEbLSS5FqjI6s8mfEIUXGd9ij9x
 eMSxQfGznxbZN/tdhFH+FFf66CCqDxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645091640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ce3XAXOnsVh6eXPTSQDZt9DWrZieHLQsSF+P0ypZmuI=;
 b=hRTpKhk1NKDpSx8DHIYEXEfnkYn+dapKujvKqWGfw+lML3i03N7ij3NnLwoDTiOxK0M5Xl
 kNEsFSddjOqEErAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 816A013BBF;
 Thu, 17 Feb 2022 09:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YWmLHjgbDmI/LwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 17 Feb 2022 09:54:00 +0000
Date: Thu, 17 Feb 2022 10:56:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yg4bt2V6rrircZ+x@yuki>
References: <20220203170522.22051-1-pvorel@suse.cz>
 <20220203170522.22051-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220203170522.22051-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] sctputil.h: TCONF on EAFNOSUPPORT
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
Cc: Vlad Yasevich <vyasevich@gmail.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Neil Horman <nhorman@tuxdriver.com>, ltp@lists.linux.it,
 linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/utils/sctp/testlib/sctputil.h b/utils/sctp/testlib/sctputil.h
> index 1e21760bec..c4bedb47cf 100644
> --- a/utils/sctp/testlib/sctputil.h
> +++ b/utils/sctp/testlib/sctputil.h
> @@ -133,9 +133,14 @@ extern int TST_CNT;
>  static inline int test_socket(int domain, int type, int protocol)
>  {
>  	int sk = socket(domain, type, protocol);
> +	int res = TBROK;
>  
> -	if (sk == -1)
> -		tst_brkm(TBROK, tst_exit, "socket: %s", strerror(errno));
> +	if (sk == -1) {
> +		if (errno == EAFNOSUPPORT)
> +			res = TCONF;
> +
> +		tst_brkm(res, tst_exit, "socket: %s", strerror(errno));
> +	}

I would keep the messages separated here, i.e. do something as:

	if (errno == EAFNOSUPPORT)
		tst_brkm(TBROK | TERRNO, "socket(%i, %i, %i) not supported",
			 domain, type, protocol);

	tst_brkm(TBROK | TERRNO, "socket()");


Btw this code actually duplicates the safe_socket() function we do have
already, so it may as well be easier to just replace the test_socket()
with SAFE_SOCKET() in the tests...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
