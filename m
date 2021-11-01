Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7566C433F5
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 15:09:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D889F60EE3
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 15:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D889F60EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DDCF3C70E8
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 16:09:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB8E13C1D1A
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 16:09:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AC457600922
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 16:09:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C3B8B1FD45;
 Mon,  1 Nov 2021 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635779348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Nsj41RtWL5aVjZrzsXh1q7oB4E0WtUQujAwdFf17dA=;
 b=ve6yIqD9uCnmvCopmsFprKeMlq3mmzCBt6nQriofHQcj5/0M0xBbKygZjQFqhpcvhvZ+zD
 MlnAa2whH084e0GA4MoXZHxm0hQiMnbj+MHaHeDcnGLTR8Url9pmUsmSdaLaZ5c08Da7eS
 HvMXxlLT4X/3ViAyFEK/h31fl4hdNY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635779348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Nsj41RtWL5aVjZrzsXh1q7oB4E0WtUQujAwdFf17dA=;
 b=xYwQ/2Xyof1uGyJF/8hQTgDzxKzD0upE9UY2Qm+/avossleJTgkIsFZRmZpVi7IYaAiE3e
 VpZcm6+h0Ct21ZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A538B13A4A;
 Mon,  1 Nov 2021 15:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id s2DYJxQDgGGOMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 01 Nov 2021 15:09:08 +0000
Date: Mon, 1 Nov 2021 16:10:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YYADS5YGDVcGrxBT@yuki>
References: <20211018154800.11013-1-chrubis@suse.cz> <87tuh2poue.fsf@suse.de>
 <YXlYwi7+VUIitM7H@yuki> <87pmrppj9u.fsf@suse.de>
 <YXu2q1Uj4xIJvO7G@yuki> <87h7cwp5x6.fsf@suse.de>
 <YX+6iWEzwaTqbYua@yuki> <87cznkoxyc.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87cznkoxyc.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/7] docparse improvements
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
> >> > Still working on a prototype based on tree-sitter would take a week or
> >> > two worth of time and I would like to get the metadata fixed now, so
> >> > that I can finally move on with runltp-ng. So I would slightly prefer
> >> > merging the patches for the current solution first, then we can have a
> >> > look on tree-sitter in the next LTP release cycle. What do you think?
> >> 
> >> I think there is a small risk
> >> 
> >> 1. It turns out that with tree-sitter it would make more sense to use a
> >>    different meta-data format.
> >
> > What do you have in mind? I do not think that we should dramatically
> > chante the json structure we do have now.
> 
> Whatever tree-sitter produces most naturally and requires the least
> amount of massaging.

I do not think that there will be a big differences though, the only
difference would be that we would get proper types, i.e. strings vs
integers. The rest of the processing we do filters out fields we are not
interested in, or checks if implied flags are not defined, etc. that is
going to stay regardless.

> >> Note that in general I think it's best (on bigger projects) to have an
> >> alternative branch for big changes where one needs to "rush" to an
> >> end-to-end solution. Most likely we need an alternate branch for
> >> integrating runltp-ng and the executor.
> >
> > We can even do this in a separate github repository or whatever works,
> > but still we have to agree on general direction.
> >
> > I still think that the best solution here is to apply this patchset and
> > put the tree-sitter on TODO. Unlike tree-sitter this is neither big nor
> > radical change and it would allow us to proceed with other stuff that
> > has been blocked for several releases at least.
> 
> As discussed in IRC, I prefer the route of trying either Sparse or
> Tree-sitter first to produce the metadata. However please go ahead and
> make the decision. After all once we have better automation it will
> reduce the burden on reviewers.

I've send a v2 for the patchset. I still think that we should merge
that in order to get usable metadata now so that we can finally
implement/fix several issues, namely:

https://github.com/linux-test-project/ltp/issues/868

Here we really need the metadata available and loaded in the testrunner
so that we know that reboot is comming. This one can be implemented only
with the last patch of the series that installs the json metadata
unconditionally.


https://github.com/linux-test-project/ltp/issues/824

This one is more complicated though, also the mmap1 is not the only test
that suffers from this condition, there is at least writev03 that
suffers from timeouts.

In order to compute the test runtime properly we need to know the upper
limit for the test iterations, which is currently multiplication of
.test_variants and supported filesystems if .all_filesystems is set,
which is the main motivation behing pushing this patchset forward along
with the runtime patchset. Once these two are merged, the test runtime
and safe enough timeout can be easily computed from the test metadata
and used by the testrunners.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
