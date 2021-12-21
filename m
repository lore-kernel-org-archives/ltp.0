Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AC2C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:36:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 710003C926A
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 11:36:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D13143C0667
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:36:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 64F18200FF5
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:36:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B468B21114;
 Tue, 21 Dec 2021 10:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640083003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J8AbVM/jTIj/B8506IjgCqBkpAuxg/A5qCyA3m96vCI=;
 b=IiKQJ2qLtJPqyG8XcO0mk9o5JIBeJBv6JWo/YiJsIza8etM+uAQJHIdS4/1E0iAM0dJc4h
 0I033udUeqMKe3QV+sX59m7s6XnzpWs17Xw0EzfKToPdWIR2Eq0JTCfntDYy7CM3qtMCep
 uvlag5TthwzLKmWJeAADFtTU72j2yvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640083003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J8AbVM/jTIj/B8506IjgCqBkpAuxg/A5qCyA3m96vCI=;
 b=vBQbVmSNZKhvVnfnKG9ohZva9ntVpWkNMMia/2x+C/SCmvXuPR7OZti4ERqUduaFPlLjqS
 qZfwo84fqc3x+1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C4D113A5F;
 Tue, 21 Dec 2021 10:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WxhPJDuuwWGXYgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Dec 2021 10:36:43 +0000
Date: Tue, 21 Dec 2021 11:38:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YcGuliqt4hj/M0pX@yuki>
References: <20211221091302.26904-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211221091302.26904-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Complete help message adding option before desc
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
>  static void print_help(void)
>  {
>  	unsigned int i;
> +	char msg[1024];
>  
>  	/* see doc/user-guide.txt, which lists also shell API variables */
>  	fprintf(stderr, "Environment Variables\n");
> @@ -498,8 +499,13 @@ static void print_help(void)
>  	if (!tst_test->options)
>  		return;
>  
> -	for (i = 0; tst_test->options[i].optstr; i++)
> -		fprintf(stderr, "%s\n", tst_test->options[i].help);
> +	for (i = 0; tst_test->options[i].optstr; i++) {
> +		snprintf(msg, 1024, "-%c\t %s",
> +			tst_test->options[i].optstr[0],
> +			tst_test->options[i].help);
> +
> +		fprintf(stderr, "%s\n", msg);
> +	}
>  }

I got rid of the useless temporary buffer here and pushed, thanks.

This is actually a step into a right direction and it also makes the
generated documentation a bit better too. Ideally the tst_test structure
could be also improved to include the default value for the option
too...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
