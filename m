Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10D9C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 10:42:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA6CB3CA460
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 12:42:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A31A93C762C
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 12:42:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 205591000952
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 12:42:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2F3F210F5;
 Tue,  5 Apr 2022 10:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649155365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jA6ZtD7Om4aRVodKHP7nJ8ENpI48Dyq94w8kEsK78s0=;
 b=PWd4JYxH2SYEm2nAysKlaX0m14AWwoQd84xy0QgHORCkb39qQHHYdWYeiw2RwxOt3rvHzT
 kkqIRuK2P415GERjeh7y21z/dJ3plHmNCFGRJCm55gp80+le/stsTD5OLZ+qjf77Mtmi2A
 LzxqM1F6+auJApbPuEdsopNAgm7qp+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649155365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jA6ZtD7Om4aRVodKHP7nJ8ENpI48Dyq94w8kEsK78s0=;
 b=HaYI0+dMQl8X0OzRmRRDQNxCmIOW2MF6PY4QW+1YvXWf8oilGI0lQSA1Lk+g5yyxAbi8y7
 hEJ1XbdkpdBTQ+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B604313A04;
 Tue,  5 Apr 2022 10:42:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1x3MKiUdTGLXWQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 05 Apr 2022 10:42:45 +0000
Date: Tue, 5 Apr 2022 12:42:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ma Feng <mafeng.ma@huawei.com>
Message-ID: <YkwdJDzkr3sjt2Ic@pevik>
References: <1645492786-67242-1-git-send-email-mafeng.ma@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1645492786-67242-1-git-send-email-mafeng.ma@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syslog: Add TPASS log
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

Hi Ma, Li, Cyril,

> Add TPASS log to facilitate the analysis of cases.
nit: in some tests you added both TPASS/TFAIL.

> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
> ---
>  testcases/kernel/syscalls/syslog/syslog01 | 7 +++++--
>  testcases/kernel/syscalls/syslog/syslog03 | 3 +++
>  testcases/kernel/syscalls/syslog/syslog04 | 5 ++++-
>  testcases/kernel/syscalls/syslog/syslog05 | 5 ++++-
>  testcases/kernel/syscalls/syslog/syslog06 | 5 ++++-
>  testcases/kernel/syscalls/syslog/syslog07 | 5 ++++-
>  testcases/kernel/syscalls/syslog/syslog09 | 4 ++++
>  testcases/kernel/syscalls/syslog/syslog10 | 6 +++++-
>  8 files changed, 33 insertions(+), 7 deletions(-)

> diff --git a/testcases/kernel/syscalls/syslog/syslog01 b/testcases/kernel/syscalls/syslog/syslog01
> index 2f3aea0bb..f99c44914 100755
> --- a/testcases/kernel/syscalls/syslog/syslog01
> +++ b/testcases/kernel/syscalls/syslog/syslog01
> @@ -88,8 +88,11 @@ syslog_case1()

>  		newvalue1=`grep -c "syslogtst: mail info test" $MAILLOG`
>  		if [ "x$(( $newvalue1 - $oldvalue1 ))" != "x1" ]; then
> -			status_flag=1
> -		fi
> +                        tst_resm TFAIL "mail info test: messages are not logged to $MAILLOG"
> +                        status_flag=1
> +                else
> +                        tst_resm TPASS "mail info test: messages are logged to $MAILLOG"
> +                fi

I'm going to merge this fix, thus I'll fix wrong indentation myself before merge
(it's in more tests). But please next time pay attention to the whitespace.

...

> index 573ab755e..97f7c54cc 100755
> --- a/testcases/kernel/syscalls/syslog/syslog10
> +++ b/testcases/kernel/syscalls/syslog/syslog10
> @@ -85,12 +85,16 @@ syslog_case10()
>  		tst_resm TFAIL "Expected message was not logged...."
>  		status_flag=1
>  		return
> -	fi
> +        else
> +                tst_resm TPASS "Expected message was logged..."
> +        fi

Here I'm going to remove useless '...' in newly added TPASS and the original
TFAIL (and in other tests).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

@Cyril, Li: do we want to still keep syslog0[1-9] and syslog10 which tests syslogd?
I suppose so, but I'm asking because they are not using even legacy shell API
(test.sh) and use several other legacy libraries (syslog-lib.sh, cmdlib.sh, daemonlib.sh).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
