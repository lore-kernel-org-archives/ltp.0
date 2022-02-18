Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84117C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 06:59:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEB6D3CA0DD
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 07:59:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A30F33C9893
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 07:59:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7368E1A019AA
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 07:59:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7ECD7210F2;
 Fri, 18 Feb 2022 06:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645167571;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfkUydjQyn3GF4kt3NbRCbwOMWAEBCtHXcbT3IuzpMA=;
 b=3Qxow9N/5iy9oyvgr9+XwFNx3c7slEx9urN8IHUEVtVfCjjoWadd0M5p8BmcgQ3rJIiAdz
 rCqzw8UEXFlnk37kvuf7+yPntbi2vA5Qbjz4Nsbm1KXr2wMfgvKcDjz6XXRUjV87pu24ZB
 +43dKUQtHfzlmj/Jg3kgkn+nBGrNJxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645167571;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfkUydjQyn3GF4kt3NbRCbwOMWAEBCtHXcbT3IuzpMA=;
 b=3vjrUgvsyC9T2VXarOEKWigpFDbbQsHPf5TkC80LIA17AYm0LDAxc+LRCA20jEYEe36lCF
 4kT43KQwHDJ5shCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 455E613BD8;
 Fri, 18 Feb 2022 06:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L4+/DdNDD2LmKgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 06:59:31 +0000
Date: Fri, 18 Feb 2022 07:59:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yg9Dy1IvZXoRMpfw@pevik>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6h4jTszPhDT36J@pevik> <620F149A.2070305@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <620F149A.2070305@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> >> +++ b/testcases/kernel/syscalls/pidfd_getfd/.gitignore
> >> @@ -0,0 +1 @@
> >> +pidfd_getfd01
> > /pidfd_getfd01
> Thanks, will add it in v2.

> The two ways also work well.
/ causes pattern to be relative.  Because we have mostly unique files, we
wouldn't worry whether the pattern is relative or global. And we have 47
.gitignore files in testcases/ not following this rule :).

> ps:pidfd_open also miss "/". Shoud we add this rule in maintainer review 
> list and .gitignore info in doc?
I'm not sure myself if we want to follow this rule. If yes, it should be there.

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
