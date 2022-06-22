Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114BCC43334
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 08:50:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D80D3C954B
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 10:50:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D04D3C9354
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 10:50:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 587B314004E3
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 10:50:11 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B92E13D5;
 Wed, 22 Jun 2022 01:50:10 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A650E3F66F;
 Wed, 22 Jun 2022 01:50:09 -0700 (PDT)
Date: Wed, 22 Jun 2022 09:49:59 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YrLXt17z79KbvRBW@e120937-lin>
References: <20220620133746.99167-1-cristian.marussi@arm.com>
 <762be123-13ad-1fcf-e4f3-846c7e1b236a@jv-coder.de>
 <7605268f-8c8b-fe95-3c58-a29544256dee@jv-coder.de>
 <YrLUSjGS4Ld2ibG2@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YrLUSjGS4Ld2ibG2@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Fix mountns01/02/03/04 final umounts using
 more peculiar dir names
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

On Wed, Jun 22, 2022 at 10:35:22AM +0200, Cyril Hrubis wrote:
> Hi!
> > >> --- a/testcases/kernel/containers/mountns/mountns.h
> > >> +++ b/testcases/kernel/containers/mountns/mountns.h
> > >> @@ -10,8 +10,8 @@
> > >>  #include "tst_test.h"
> > >>  #include "lapi/namespaces_constants.h"
> > >>  
> > >> -#define DIRA "A"
> > >> -#define DIRB "B"
> > >> +#define DIRA "__DIR_A"
> > >> +#define DIRB "__DIR_B"
> > > This is the only non-comment change. How does renaming the directories
> > > change anything? Am I missing something?
> > Nevermind, now after I read the v1-thread, I get it..
> 
> We tend to prefix globally visible objects with LTP_ in order to make
> them unique enough and that makes them clearly recognizable as being
> created by LTP as well. So maybe we should put the LTP string somewhere
> in the names too.
> 

Thanks Cyril for the review.
I'll do in v3.

Thanks,
Cristian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
