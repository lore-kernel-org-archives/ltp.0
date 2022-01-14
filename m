Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE79C433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 17:44:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1492D3C954B
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 18:44:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8ABFD3C58A8
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 18:44:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 932421000A41
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 18:44:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A38F212C6;
 Fri, 14 Jan 2022 17:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642182247;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uodSqA9Rcyi4HJksl/d2woLJBJxIQVVEEszrtSiYMmQ=;
 b=LxXE8uFsg0NIla7vqbjc5ziyUMUV5/xLjxqLmTHn1OIOELN++0QWrg0ihUTo559vMz7hgz
 EQA4KRhHChCBy9MALjCfWZKA7W3UOrtvkyg8i2ZL0Pmv6xH1nVwSOHBvgV8OWyM+g7MroR
 XVv74FiJjrk3D12L4aNytxRQJpzR2Zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642182247;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uodSqA9Rcyi4HJksl/d2woLJBJxIQVVEEszrtSiYMmQ=;
 b=TDMZlKCOCRuWwZt/vQgWdjXIvWd0JcwPz/TaF7u+qvKaK1OCuHcj/4LVi/mBZ/Gcj15B8T
 ter/a3JUkpCWDmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DE6413E13;
 Fri, 14 Jan 2022 17:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L9PpD2e24WGPFAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 17:44:07 +0000
Date: Fri, 14 Jan 2022 18:44:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YeG2ZTXgpNnkSM0C@pevik>
References: <20220114125513.895-1-pvorel@suse.cz> <YeGEunEuwPvNFxyS@yuki>
 <95394feb-6474-d1ca-13d8-3d1c35e781b9@jv-coder.de>
 <YeGHV+Gnmo59SXeL@yuki>
 <f516568b-fa33-091c-3442-0316a78d96b1@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f516568b-fa33-091c-3442-0316a78d96b1@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] configure.ac: Fix summary for disabled
 metadata
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

Hi Joerg,

> Hi

> Am 1/14/2022 um 3:23 PM schrieb Cyril Hrubis:
> > The JSON metadata file is going to replace the runtest files some day,
> > at least that is the longterm plan. Also the parser that extracts the
> > metadata from the sources is rather fast, compared to the LTP build and
> > it's self contained. There is really no reason to have a switch to
> > disable the metadat extraction step.

> > The documentation build, on the other hand, is rather slow and requires
> > asciidoc, which is the reason why there is a switch that can be used to
> > disable that. The only problem here is that the name is a bit confusing
> > now.
Cyril, maybe we should have kept the way to completely disable building metadata
until we actually use it (i.e. until runtest files are replaced).

OTOH this way give the change to (embedded) distros to fix host build setup
issues :). I was testing Buildroot last night and it has problems with build on
archs which have cross-compile flags (CFLAGS) incompatible with host flags
(HOST_CFLAGS). This might require deeper changes to introduce LTP host build
(Buildroot support host autotools builds, but LTP is not fully autootools
project - we use only autoconf).

> Actually there is, that is where my interest in this flag comes from. We
> don't use runtest files (at least not for execution), so we don't need
> it and we had problems in out cross build environment, that were not
> easily fixed. From looking at the source I am not sure what the problem
> was and cannot spot it from looking at the source. But I know, that it
> wasn't just fixed by setting the correct HOSTCC and HOST_CFLAGS. I have
> a missing library in my head, but I can't see any.
Hard to help without seeing logs.

Kind regards,
Petr

> All I know is that I gave up fixing the build and I don't give up easily
> normally (a little easier if the functionality is not needed at all) :)

> Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
