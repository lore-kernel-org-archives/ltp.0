Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2770C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 12:53:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5034D3C9F23
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 13:53:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 975C73C9897
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 13:53:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0D6786975B7
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 13:53:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35E3721138;
 Fri, 11 Feb 2022 12:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644583995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GfGxn/RlBkNaMG9lJUpfpUPDT2Voz3yThaJalyCPkzI=;
 b=MqA9kvzIcclJxr3QQ6/XnW+b1JOLiE+a7cTRx2MG4s7jgjHVG2beEeAWK2ZQdz6t2huEEf
 nMUJA9OsFKA/EzYvXrwJdNJaI/HYfunonlbyJnqdcwbo6HVTf0SmSmTm9gtBGUaQdB20Tk
 P4j3JohsGn1Ot+D9tP4Anz6jIbxMY2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644583995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GfGxn/RlBkNaMG9lJUpfpUPDT2Voz3yThaJalyCPkzI=;
 b=f/NrXvBcHS11BPWwh+tqR15yB4Y0wN9Q+t7YTh6R3voCTJ3Ymt8at/+bGlkDEqb05H/HG9
 E42dBPGGfucDdJCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1563513C72;
 Fri, 11 Feb 2022 12:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yt6oBDtcBmImewAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Feb 2022 12:53:15 +0000
Date: Fri, 11 Feb 2022 13:55:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YgZcu4frLBaKVXL2@yuki>
References: <20220211114401.24663-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220211114401.24663-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Terminate leftover subprocesses when main test
 process crashes
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
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1495,6 +1495,9 @@ static int fork_testrun(void)
>  		return TFAIL;
>  	}
>  
> +	if (tst_test->forks_child)
> +		kill(-test_pid, SIGKILL);
> +

Maybe we can even print a message here if the kill() returns with 0,
which would mean that there were any leftover child processes killed.

Either way this is a nice and clean solution:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

>  	if (WIFEXITED(status) && WEXITSTATUS(status))
>  		return WEXITSTATUS(status);
>  
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
