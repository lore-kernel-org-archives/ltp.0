Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE30BC38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 12:43:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C164D3CA788
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 14:43:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 491823C2297
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 14:43:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B928E6009E5
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 14:43:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACEE321FE1;
 Wed, 26 Oct 2022 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666788181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xi4ASynzZNFu8M+mrm3c/bhMycVurhVbuuV17pqfLlI=;
 b=G8Jgxffg0oEx54AD/DBahTbpmgMk+BASTSDzU4t/pFYFmIFzgN1u0PebdIsSN69WmHlzP1
 qpPNlDwrXigPcfJnRb8K/QiuDmPLDlY7gr9bmd2nRCOvAqFkdXMER2ldLfh+cRTiAZ0XxO
 4BA3ZGhQZsq7eDL4P7+P4N+6mA9Q4g0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666788181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xi4ASynzZNFu8M+mrm3c/bhMycVurhVbuuV17pqfLlI=;
 b=QHMQh288W0r+zW0mu9TIlxZdyi1go+cu+B43eOAJHXryH3lOmyjBu2V2cipIRudQxa5lW1
 zMLCLNt2eqdPaFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92E7313A77;
 Wed, 26 Oct 2022 12:43:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L9GxIlUrWWMrSgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Oct 2022 12:43:01 +0000
Date: Wed, 26 Oct 2022 14:44:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y1kruiJsqAQGUQKZ@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-2-tsahu@linux.ibm.com>
 <Y00g0NZYO8pVvC6M@yuki>
 <8ae7d26f5635cc858a657e78b0b806b576a98241.camel@linux.ibm.com>
 <Y1JfP6TMo2BdMr5Y@yuki>
 <ebb30e16cd63fdbff8520c68388f572fc6f5b9e0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ebb30e16cd63fdbff8520c68388f572fc6f5b9e0.camel@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 01/29] Hugetlb: Migrating libhugetlbfs
 brk_near_huge
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Hopt is supposed to be the location which test will use to mount/umount
> the hugetlbfs fs. If Hopt is not provided, it will create a temp
> location. It is only to avoid creating any temporary locations outside
> user concerned test environment.
> 
>      if(!Hopt)
> 	Hopt = tst_get_tmpdir();
>      SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> 
> It is not expecting any already mounted hugetlbfs.

Ah right, this has been changed long ago in:

    7420ed0 hugemmap04: auto mount the temporary dir for testing
    c4dd870 hugemmap03: auto mount the temporary dir for testing
    9b4865f hugemmap02: auto mount the temporary dir for testing
    d8728dc hugemmap01: auto mount the temporary dir for testing

Before that the path had to point to already mounted hugetlbfs. At this
point this option is useless. So I would not add it to new tests at all
and just use the tmpdir unconditionally.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
