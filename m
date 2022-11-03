Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CD1C4332F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 09:55:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E15723CAB99
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 10:55:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2AE13CA6CD
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 10:55:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 53FC3600681
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 10:55:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4896122155;
 Thu,  3 Nov 2022 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667469311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+YcaEvpQ3Z8CZq/XphoSdWmNIoVoFinBal7JX16Hq0A=;
 b=1SZCaTiFyPfPMC742hq4BJF7cRK4vKTDLIpERds40qi3SbLnrWI9xNop90WUlJBxsag/Ov
 1+oSeVWkawZTMwBl2a/wdLDRq6FjPdxOmS1HSOCLZA2j+tLpyd/3bIhGf7gafyeV9TqMk2
 peOGyJmq5lp6HkItKEPEcWK0ON6Ubtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667469311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+YcaEvpQ3Z8CZq/XphoSdWmNIoVoFinBal7JX16Hq0A=;
 b=kVJqVCLkzqL3PhNfRf46ujbpxXH03ZODjlxFHVH2iMNL83+D+jfJrqr9gK18rgteAcVavy
 U+1TRJx09FIWweCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3302113AAF;
 Thu,  3 Nov 2022 09:55:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sYKzCf+PY2MzZwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 03 Nov 2022 09:55:11 +0000
Date: Thu, 3 Nov 2022 10:55:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y2OQDryqaU8bu5N4@rei>
References: <20221103054317.499221-1-tsahu@linux.ibm.com>
 <20221103054317.499221-3-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221103054317.499221-3-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/4] Hugetlb: Migrating libhugetlbfs
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> index 2d651b4aa..0199f8446 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> @@ -9,3 +9,9 @@ include $(abs_srcdir)/../Makefile.inc
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>  
>  hugemmap06: CFLAGS+=-pthread
> +
> +ARCH ?= $(shell uname -m | sed -e s/i.86/i386/)

This will break cross-compilation. We cannot assume anything during
compilation based on the system we compile LTP on.

What are we trying to detect here?

Looking at:

https://github.com/libhugetlbfs/libhugetlbfs/commit/cc0717ca0deee9dc0bb84acc8c80fd468b180f6f

it seems that we are looking for native 32bit PPC, that means that we
have to check on runtime, because we don't know if we are going to run
in 32bit compat mode or on native 32bit machine when we are compiling.

We do have tst_kernel_bits() function exactly for this purpose.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
