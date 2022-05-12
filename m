Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80D5C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:35:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED85F3CA9DF
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 16:35:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 916843CA98A
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:35:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E3A2D1400E7F
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:35:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 181B621B57;
 Thu, 12 May 2022 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652366146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SsXS3qPPAsS+aLUE42n2KTk/EFaibSTdM3Xf/eGrFW0=;
 b=LuSzqyq6jO4ohBEz6LxDUiTKl1lrOu+lN/XJ5CnW+cJT1SDFgh86JbKI35CMDrv4R/5LlC
 ws9+Y9+0pLrQf4zjh8/sEEVfzkTHVzYZ3EoJCYj3Klm5vHyI/qeG81eGR+OUuk6FujgOga
 dyDOyb10PvtCSDFGNvkXai3+i1seAd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652366146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SsXS3qPPAsS+aLUE42n2KTk/EFaibSTdM3Xf/eGrFW0=;
 b=7hf10TAV/m1/x4IaH7OdUuLXz6Oplxmu/BSH1wWi80+vB5M0gaS9yckIYVDOx+ItBlcMM0
 mQUNzrV9piUidUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6A5013A84;
 Thu, 12 May 2022 14:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZwHcMkEbfWJgVwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 14:35:45 +0000
Date: Thu, 12 May 2022 16:37:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yn0bxyweYWKgY8SB@yuki>
References: <20220428144308.32639-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428144308.32639-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/3] Remove RPC rup and rusers tests
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
Cc: "J . Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org,
 automated-testing@yoctoproject.org, Steve Dickson <steved@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, libtirpc-devel@lists.sourceforge.net,
 Trond Myklebust <trondmy@hammerspace.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Looks like rstatd wasn't included in distributions to begin with, so
there is no point to keep tests for it.

https://bugs.gentoo.org/show_bug.cgi?id=115806
https://access.redhat.com/solutions/34127
https://www.ibm.com/support/pages/rstatd-not-installed-or-distributed-suse-linux-enterprise-server-10

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
