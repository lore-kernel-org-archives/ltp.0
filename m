Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC90C433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Feb 2022 11:18:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB1683CA10E
	for <ltp@archiver.kernel.org>; Fri, 25 Feb 2022 12:18:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E02D3C9544
 for <ltp@lists.linux.it>; Fri, 25 Feb 2022 12:18:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D7E631A01E18
 for <ltp@lists.linux.it>; Fri, 25 Feb 2022 12:18:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D86861F380;
 Fri, 25 Feb 2022 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645787924;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xO7/bc71rfhCkEo7DkTX6U4TB+aLXZAJ+CUVRchEKrw=;
 b=F3FuAudjwVikv4CpJv4PxdR/Gm3aN6Kc6qH0wo8exTRVZd4N+ZneFXM3WEdlhoMkZ8puTS
 2o7Eb3mZFLhXkTf+GGIJtWu775P/F1RbGqSaODU+ctYhvghFZ6x+4rE1TZp0fmRF/vrLdh
 VRMLu223FM/rNqJNSN1kJOkFPgGUtKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645787924;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xO7/bc71rfhCkEo7DkTX6U4TB+aLXZAJ+CUVRchEKrw=;
 b=vgjjI+/+U3KhCBtX5htVuS0YFPWeZhlF44SrO3ctGogcpv6Cl3+eE2fdRj5ORnIDU3ALVB
 sXN3Ytv2F2h3ncDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 930DC13B9A;
 Fri, 25 Feb 2022 11:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PGEtIhS7GGKvDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Feb 2022 11:18:44 +0000
Date: Fri, 25 Feb 2022 12:18:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yhi7EwI9RD6bj4u7@pevik>
References: <20220225110152.26098-1-pvorel@suse.cz>
 <Yhi6BqmKc1zGMUHj@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yhi6BqmKc1zGMUHj@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci/debian: Temporarily not require libmm-dev
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

> Hi!
> > do we even need libmm-dev?

> > https://packages.debian.org/sid/amd64/libmm-dev/filelist
> > ...
> > /usr/bin/mm-config
> > /usr/include/mm.h
> > /usr/lib/libmm.a
> > /usr/lib/libmm.so

> I do not think so. The only places where I found that we include mm.h
> are actually a kernel modules and that include should be satisfied from
> kernel-devel package.

> So I guess that this has been added as a mistake to begin with.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks! I'll remove it with changed message that it was added by accident
in initial Travis implementation.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
