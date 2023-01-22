Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEA6C38142
	for <ltp@archiver.kernel.org>; Sun, 22 Jan 2023 21:58:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88BFD3CB954
	for <ltp@archiver.kernel.org>; Sun, 22 Jan 2023 22:58:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51EBB3CB3FD
 for <ltp@lists.linux.it>; Sun, 22 Jan 2023 22:58:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E84B600054
 for <ltp@lists.linux.it>; Sun, 22 Jan 2023 22:58:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7C033384A;
 Sun, 22 Jan 2023 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674424683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mwl14S+89KcBy48EASGIHFjDTe6WpBvp0mo5q59hbrU=;
 b=c1tv5yvqfWOqeJEacFV0qxmVVCHEk98Vi3zc9wUqF8Rol7Rh7xMasQ7q7o8fNpx2O+K+z+
 wMx4cfQTey8xe+qtrNtTDE6GEsFRS7gwlLibHD5KpRKB03XDwTVx/pg5xR7QGsGASA64Nr
 gb1mAh5tHCAkQdvNNnBcq8Ydy0zDTiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674424683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mwl14S+89KcBy48EASGIHFjDTe6WpBvp0mo5q59hbrU=;
 b=vMa6y2jHSEJTeUCM1KOqRpeDf/CtqukxTfM0Wxp9IloqdbrLcSjKum/YbSnxI3hmXh2FmR
 PSbdYQ1aEPyVTPCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC652139F8;
 Sun, 22 Jan 2023 21:58:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fdujJ2uxzWOhUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 22 Jan 2023 21:58:03 +0000
Date: Sun, 22 Jan 2023 22:58:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y82xaekaeDtdzK00@pevik>
References: <20230117040132.5245-1-wegao@suse.com> <Y8ZdSla1SoyThtBj@pevik>
 <Y8Zg+PIzLUySx2BI@aa> <Y8pTE3I38qTV2Kez@pevik>
 <Y8p0jyFVMXe8Y3w9@aa>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8p0jyFVMXe8Y3w9@aa>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_net.sh: Add more tst_require_cmds check
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

Hi Wei,

...
> > But even if "ip ns_create ns_exec ns_ifmove" are needed to be checked to fix
> > tst_rhost_run (not yet convinced), why to check them each time tst_rhost_run is
> > called? It should be checked before first tst_rhost_run call to avoid useless
> > repeating.

> tst_rhost_run already be called everywhere so if you need check before call
> tst_rhost_run, means lot of place/cases maybe need review and update. 

No, the check would be on single place at tst_net.sh.

> Furthermore, check each time in tst_rhost_run can make this function more robust, the 
> old code also do tst_require_cmds if go ssh logic in line 211 for example.

Well, repeated check for ssh is not ideal either (how likely is that ssh will
disappear during testing?), but it's a single command which is used here.
And it's definitely less awkward than checking "ip ns_create ns_exec ns_ifmove"
which aren't used there. tst_net.sh needs cleanup, not more unneeded code.

We could document the reason to make this check more obvious, but the code is
wrong, because for netns (the default) running "tst_net_detect_ipv6 rhost"
before init_ltp_netspace does not make sense, because interfaces aren't defined
(probably error code is not detected, I need to recheck that).

It's actually enough for netns to test IPv6 support only on localhost (it will
be the same on rhost), I'll send a patch to fix that.

Kind regards,
Petr

>  205         sh_cmd="$pre_cmd $cmd $post_cmd"
>  206
>  207         if [ -n "${TST_USE_NETNS:-}" ]; then
>  208                 use="NETNS"
>  209                 rcmd="$LTP_NETNS sh -c"
>  210         else
>  211                 tst_require_cmds ssh
>  212                 use="SSH"
>  213                 rcmd="ssh -nq $user@$RHOST"
>  214         fi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
