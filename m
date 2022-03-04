Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD83C433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 12:00:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2122E3CA37C
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 13:00:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D31653CA34F
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 13:00:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 313A8200921
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 13:00:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 082F81F384;
 Fri,  4 Mar 2022 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646395215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GHLMgrb0domhMNxzxWtuWq5i4SA+IJ9xHiJS5c6hwcI=;
 b=VWKuAfcJ0XcJXsI5+IXlJr4ot8pc+XBYMC2Qx4NfpOyiOSKOMvQC1I35W612hE+rhmSX6D
 sFjMky14uxV/YVYPO7SleE1nYCmukH4L/Equu1EDiOu5PaEk52DnK+lqTZfyJFEM/g9v4S
 BEyWhPN1KHbv5LGnRdgnyUMM1NIneMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646395215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GHLMgrb0domhMNxzxWtuWq5i4SA+IJ9xHiJS5c6hwcI=;
 b=K86C2kASfugQKGbfSxryaAFyRuz5nwDLSUy43WxUqp0gpUlK306QCCN5bUUsoZDwBmG5+Q
 XCLNtb6bKf/2kyCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8DE613B2D;
 Fri,  4 Mar 2022 12:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ngsxOE7/IWI2SgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 04 Mar 2022 12:00:14 +0000
Date: Fri, 4 Mar 2022 13:02:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YiH/2240VRU1OlAe@yuki>
References: <20220303145032.21493-1-chrubis@suse.cz>
 <20220303145032.21493-6-chrubis@suse.cz>
 <CAEemH2cnCNdUaoWqe=-dyuFq2Zc7gF79yi8XND8ieTvg8iEaRg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cnCNdUaoWqe=-dyuFq2Zc7gF79yi8XND8ieTvg8iEaRg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/7] mem/ksm06: Move ksm restoration into the
 tst_test struct
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The mem library verifies the max_page_sharing validity before
> setting because some old kernels do not have it. Thus it is fine
> to use the prefix '?'.
> 
> +               "?/sys/kernel/mm/ksm/run",
> > +               "?/sys/kernel/mm/ksm/merge_across_nodes",
> > +               "?/sys/kernel/mm/ksm/sleep_millisecs",
> >
> 
> 
> But for the two knobs(run, sleep_millisecs) that should exist unless
> the kernel disables KSM. So here we'd better start with prefix '!' and
> add .needs_kconfg for ???CONFIG_KSM=y' check.
> (This also fit for other ksm tests)

I guess that if we put ! before the merge_across_nodes that would cause
TBROK on systems without CONFIG_NUMA or kernels without that feature.

So what about just removing the question marks there and adding
.need_kconfigs for KSM and NUMA?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
