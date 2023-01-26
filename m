Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFB1C61D97
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:04:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A4213CD369
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 23:04:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 344023CC73C
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 23:04:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 69EB71A0036A
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 23:04:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AAB0B21891;
 Thu, 26 Jan 2023 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674770662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9Ix9TJLV9KTeCu0ejzNvLJBNLWwY09L8O9Ac704a6Q=;
 b=TQjhCZd7wYwY1yktLXhaDGCvOOW+UH/HaBNDso98c8gPXlDLfVmmI7LFFd0otAbrbNu4aC
 A/eiYwbvPVC8KDmMqdTTcLmYA+89A2s5FupRyZlg+AIrPyN3wcE5QAIHu4E/TqsPH6skYX
 iUgaWVFOtNMZ5JGQS4z4b+X/5UnJekA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674770662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9Ix9TJLV9KTeCu0ejzNvLJBNLWwY09L8O9Ac704a6Q=;
 b=up+kWauP3wKzCRvQugKDTO87N/hyulPWP9zfEQAjg3ls6ZBaKch8ZzmFPIeaJ6+4goBHxZ
 tlMCiZbVSR7ODuBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F46B139B3;
 Thu, 26 Jan 2023 22:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XVVwHOb40mNdZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 22:04:22 +0000
Date: Thu, 26 Jan 2023 23:04:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
Message-ID: <Y9L45DgVD7g+NYFb@pevik>
References: <20230117040132.5245-1-wegao@suse.com> <Y8ZdSla1SoyThtBj@pevik>
 <Y8Zg+PIzLUySx2BI@aa> <Y8pTE3I38qTV2Kez@pevik>
 <Y8p0jyFVMXe8Y3w9@aa> <Y82xaekaeDtdzK00@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y82xaekaeDtdzK00@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> ...
> > > But even if "ip ns_create ns_exec ns_ifmove" are needed to be checked to fix
> > > tst_rhost_run (not yet convinced), why to check them each time tst_rhost_run is
> > > called? It should be checked before first tst_rhost_run call to avoid useless
> > > repeating.

> > tst_rhost_run already be called everywhere so if you need check before call
> > tst_rhost_run, means lot of place/cases maybe need review and update. 

> No, the check would be on single place at tst_net.sh.

> > Furthermore, check each time in tst_rhost_run can make this function more robust, the 
> > old code also do tst_require_cmds if go ssh logic in line 211 for example.

> Well, repeated check for ssh is not ideal either (how likely is that ssh will
> disappear during testing?), but it's a single command which is used here.
> And it's definitely less awkward than checking "ip ns_create ns_exec ns_ifmove"
> which aren't used there. tst_net.sh needs cleanup, not more unneeded code.

> We could document the reason to make this check more obvious, but the code is
> wrong, because for netns (the default) running "tst_net_detect_ipv6 rhost"
> before init_ltp_netspace does not make sense, because interfaces aren't defined
> (probably error code is not detected, I need to recheck that).

> It's actually enough for netns to test IPv6 support only on localhost (it will
> be the same on rhost), I'll send a patch to fix that.

I'm sorry, I was wrong. tst_net_detect_ipv6() checks [ -f /proc/net/if_inet6 ],
which is ok even before interfaces are set. It's a question whether this needs
to be run on netns also on rhost (IMHO the result will be always the same).
We should investigate that.

FYI I changed your patch to use just check in $_tst_net_parse_variables and put
it into larger cleanup. I haven't addressed move tools to testcases/lib/ yet,
nor the case when tools are missing. Instead I fixed few real problems with IPv6
disabled and did cleanup.

https://lore.kernel.org/ltp/20230126215401.29101-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=338700&state=*

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
