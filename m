Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F03C05027
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 04:17:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6E513CBF29
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 05:17:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 892363CB073
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 05:17:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B82B3200170
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 05:17:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F286F20B5A;
 Fri, 17 Feb 2023 04:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676607450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEtW3IgQmbUpZQ2NsS0vnLU20q94wMoFjrUkWe2EABY=;
 b=NCgWbM9aWsSvAG/3A3LnCzl/qgMnBJAqwC0I9KbxKlfQi6T/8kd3nkYpVBb5vXk7ScWamt
 veq78Z5G+rZLCTG4Js8oe08vauNvgnN/cw81+codoxQ5Tgdyx5V8khFyLVlXbatcKOxeOf
 f+69HZZz7R2l0Pw8f5J9fyugNfymk10=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 507941323E;
 Fri, 17 Feb 2023 04:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id f2jSCdr/7mNhNAAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 17 Feb 2023 04:17:30 +0000
Date: Thu, 16 Feb 2023 23:17:27 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230217041727.GA30450@localhost>
References: <20230213134619.27486-1-wegao@suse.com>
 <20230215023438.11370-1-wegao@suse.com> <Y+4MTlm9O/sN3Ety@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+4MTlm9O/sN3Ety@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] rseq01: basic test rseq
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 16, 2023 at 11:58:22AM +0100, Cyril Hrubis wrote:
> Hi!
> > Add basic check for the newly added glibc API in LTP.
> > This test references the glibc test case tst-rseq.c.
> > 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> > +#if defined(HAVE_SYS_RSEQ_H) && defined(RSEQ_SIG)
>                                              ^
> 					     Where is this macro
> 					     defined?
RSEQ_SIG is arch specific macro , following are result in my test system:

find / -name "*.h" | xargs grep RSEQ_SIG
/usr/include/x86_64-linux-gnu/bits/rseq.h:#define RSEQ_SIG        0x53053053

dpkg -S /usr/include/x86_64-linux-gnu/bits/rseq.h
libc6-dev:amd64: /usr/include/x86_64-linux-gnu/bits/rseq.h

> > +#include <stdio.h>
> > +#include <sched.h>
> > +#include "lapi/rseq.h"
> > +
> > +static void run(void)
> > +{
> > +	check_rseq_available();
> > +
> > +	TST_EXP_PASS(!(sched_getcpu() >= 0));
> 
> This does not actually check anything useful.
This case used to test against glibc's implementation, correct me if i am wrong.
Once i saw following commit in glibc, so i think we can use sched_getcpu 
do some sanity check for rseq implementation in glibc. 
1d350aa060 Linux: Use rseq to accelerate sched_getcpu

> 
> Very basic test would register rqseq, then loop over available CPUs, pin
> a process to the CPU and check that rqsed did register the buffers. The
> very basic test would look like:
> 
> https://github.com/torvalds/linux/blob/master/tools/testing/selftests/rseq/basic_test.c
> 

Thanks for your feedback, i have a question on test direction, which one is our target?

1) Check system call ONLY regardless glibc version/implementation then we move linux kernel test(as above link you mentioned) into our test.

2) Check glibc's implemenation for rseq(from 2.35), such as 1.check sched_getcpu, 2.check glibc API 
how to disable rseq feature which support automaticly from glibc start. (e3e589829d nptl: Add glibc.pthread.rseq tunable to control rseq registration). Then our target is move glibc test case to our test.

> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.needs_root = 1,
> > +};
> > -- 
> > 2.35.3
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
