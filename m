Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BFAC64ED8
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 15:17:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 852263CBA67
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 16:17:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EA483CB726
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 16:17:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A463F703263
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 16:17:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 137761FD65;
 Mon, 27 Feb 2023 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677511034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hDwDVnXENMul8u4lNJIZLO+wCTq7DY2+CBsTMGk6/nA=;
 b=WwJwTkEuPTm8at6QsXqrN9Rv15cRMANcJehBf+e69WNHryVBmsyyNes/6yX2Gr8SBfJcVB
 CW7zerOfDcxf4HQnUlwTOe/4JUTcRmotARloLuim/JAnZCyUN1/KqXAj3TxmVVAIvddxOK
 Jsxb08jVJOauOi+vzeZwezUM5p24ahQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8C7C13A43;
 Mon, 27 Feb 2023 15:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4aWnJHjJ/GPOIgAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 27 Feb 2023 15:17:12 +0000
Date: Mon, 27 Feb 2023 10:17:09 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230227151709.GA12774@localhost>
References: <20230227144402.GA23697@localhost>
 <Y/zFIdiWccmVzddV@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y/zFIdiWccmVzddV@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Question on .needs_cgroup_ctrls for cgroupv2
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Feb 27, 2023 at 03:58:41PM +0100, Cyril Hrubis wrote:
> Hi!
> > How to setup correct test case for cgroupv2 check? I try to put following parameter but failed.
> > 
> > struct tst_test test = {
> > 	...
> >         .needs_cgroup_ctrls = (const char *const []){ "unified", NULL },
> >         .needs_cgroup_ver = TST_CG_V2,
> > };
> > 
> > 
> > After some investigation i found cgroup_find_ctrl which called by tst_cg_require seems not implement 
> > how to check cgroupv2, the controllers has no "unified" memeber, should we add CGROUP_CTRL_MEMBER("unified", xxx)
> > into controllers?  Correct me if any misunderstanding.
> > 
> > 
> > void tst_cg_require(const char *const ctrl_name,
> >                         const struct tst_cg_opts *options)
> > {
> >         struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
> 
> I think that you are misunderstanding something, controllers that are
> checked by the .needs_cgroup_ctrls and tst_cg_require() are cgroup
> controllers such as memory or cpu controller.
> 
> And unified can be the hierarchy, that means that all controllers are in
> a single mount point which is how controllers are presented in the
> cgroup V2.
> 
> You can have a mix of V1 and V2 controllers on a system and LTP library
> abstracts away all the details so that you can focus on the test logic
> rather than on how things are set up on the system. You have to start by
> specifying which controllers is the test going to use, that's the
> .needs_cgroup_ctrls array and if the test is V2 only you pass the
> TST_CG_V2 in the flags.

So .needs_cgroup_ctrls can not used anymore for ONLY V2 case?
Since i encounter "tst_cgroup.c:848: TCONF: V2 'memory' controller required, but it's mounted on V1" when i add ".needs_cgroup_ctrls = (const char *const []){ "memory", NULL }". 

If yes then i have to manual create V2 cgroup in test case?

BTW is there any example for V2 case? I try to run some case with V2 enalbed but both failed.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
