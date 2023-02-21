Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670AAC636D6
	for <ltp@archiver.kernel.org>; Tue, 21 Feb 2023 02:05:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 364C73CBCE6
	for <ltp@archiver.kernel.org>; Tue, 21 Feb 2023 03:04:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 506373CB422
 for <ltp@lists.linux.it>; Tue, 21 Feb 2023 03:04:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 180021400779
 for <ltp@lists.linux.it>; Tue, 21 Feb 2023 03:04:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F71A33957;
 Tue, 21 Feb 2023 02:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676945086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYIla/Hde7VaYY/eeA3E5KRANEvtm/HgNttUf/iuJkk=;
 b=Dtv4lCeLpFnZBdUhVK7MXDisRmjtsjK+Fy86G7GsR2SA7ws65vZ49p4yTgq9GVQKovMlBI
 SyGq4Mu9IDolPo7UjtLchw9eiN1nnMIFJYdJBQPToORCCnKoEVHNnrD/6ByqKL0P5dXBWz
 8QcFBFR2XrUHrjz5cwlJP2F1kxi6M4E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77BED1339E;
 Tue, 21 Feb 2023 02:04:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WxmTE70m9GP6ZQAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 21 Feb 2023 02:04:45 +0000
Date: Mon, 20 Feb 2023 21:04:42 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230221020442.GA4108@localhost>
References: <20230215144820.17876-1-wegao@suse.com>
 <Y++lsqEyHVZp9uZp@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y++lsqEyHVZp9uZp@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mq_notify03.c: New test CVE-2021-38604
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

On Fri, Feb 17, 2023 at 05:05:06PM +0100, Cyril Hrubis wrote:
> Hi!
> > +/*\
> > + * [Description]
> > + *
> > + * Test for NULL pointer dereference in mq_notify(CVE-2021-38604)
> > + *
> > + * References links:
> > + * - https://sourceware.org/bugzilla/show_bug.cgi?id=28213
> > + */
> > +
> > +#include <errno.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +#include <mqueue.h>
> > +#include <signal.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include "tst_test.h"
> > +#include "tst_safe_posix_ipc.h"
> > +
> > +static mqd_t m = -1;
> > +static const char msg[] = "hello";
> > +
> > +static void check_bz28213_cb(union sigval sv)
> > +{
> > +	char buf[sizeof(msg)];
> > +
> > +	(void)sv;
> > +
> > +	TST_EXP_PASS(!((size_t) mq_receive(m, buf, sizeof(buf), NULL)
> 
> Does this line of code even compile?
Yes, this wrong code can pass complie : )

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
