Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEFBC433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 11:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6431C3C9338
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 13:44:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01D8B3C921F
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 13:43:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 749E61000F23
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 13:43:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 982071FA0C;
 Fri, 10 Jun 2022 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654861438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ox8Vsiv/us8Fv0wCKG2UYMyOyxZXlO7yagLRy8ZU8Io=;
 b=IitoSabZZON26mG+ItlfzLfkHp4gGOXZnSvcF2qKwSMThXxi9teqdAtfY/mdyql4f3q72S
 GsxEBz0wptv9lP0i3qCSfQGHgbIP3gJiIuNUfwKSp+iIKiTKCQ+TZeCqpBkNDsuCZykxlP
 gM3JnrjhjQOa+TdbNbTfZ271o02rxJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654861438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ox8Vsiv/us8Fv0wCKG2UYMyOyxZXlO7yagLRy8ZU8Io=;
 b=uz6MZXgMn5y6Uld51E2qHU8nn6B+lj0gqjjsziFryhMJnJGRvHRAf9848Hr30MVPZL8MHH
 NT2z6Cy90eY3tZAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84789139ED;
 Fri, 10 Jun 2022 11:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T2YBH34uo2JQHQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jun 2022 11:43:58 +0000
Date: Fri, 10 Jun 2022 13:46:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: songkai <songkai01@inspur.com>
Message-ID: <YqMu/4Qh9hU333xL@yuki>
References: <20210907235746.112665-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210907235746.112665-1-songkai01@inspur.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix the statistical number of results in the html
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
Cc: wangkaiyuan@inspur.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
First of all, sorry for the delay in response.

Secondly the genhtml.pl is basically unmaintained and we hope to replace
runltp and the tooling around that with runltp-ng ideally within a year,
at least I hope to do so.

The patch itself looks reasonable, minus some whitespaces that break the
indentation. So unless somebody is against it, we can as well apply it,
that is after you fix the whitespaces. I think that in reality nobody
really cares about the script anymore so noone will block the change.

> According to the statistical method of ltp-pan on TFAIL TBROK TCONF
> TPASS..., the statistical method of the ltp test result type in 
> genhtml.pl is modified to ensure that the .log format of the ltp 
> result is consistent with the test result in the .html format.
> 
> The original statistical method policy expression "/\ TFAIL\ /" in 
> the original genhtml.pl for the test result type cannot match the 
> "TFAIL:" in the normal test result, causing problems in the 
> calculation result. At the same time, the statistical method in 
> genhtml.pl cannot guarantee that each test item has only one test 
> result, because the output of a test item may include TFAIL, TCONF,
> and TPASS at the same time.
> 
> Signed-off-by: wangkaiyuan <wangkaiyuan@inspur.com> 
>                Chunsing.dey <daichx@inspur.com>

Each line here has to start with the 'Signed-off-by: '

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
