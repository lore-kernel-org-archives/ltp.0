Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FFDC6FD1C
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 13:50:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0A0C3CD4E7
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 14:50:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C7CB3CAE69
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 14:49:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4B9EE1A00991
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 14:49:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7AF3A1F8A8;
 Tue, 14 Mar 2023 13:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678801793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HyxfHDrt4rIkwK6EFcPawEq/dKU/djalU+5Kwsm85MQ=;
 b=p1Cglf0x9MWWGUg08wDsc1AoR8QEC0ESRXNhoxJUsVbIKcf0WjdcSEZu+NlKuBObghUlXX
 NgjDkArLwlsuJPtc5pl4yM5d8+hnuRKmzEwdXZjIhBS1UEVu0velylH21tcNFxQQZcVG/l
 whblU+RKxjSSw395rHnZpS61kHHOGcw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 642E013A26;
 Tue, 14 Mar 2023 13:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WrqiB4B7EGSJBwAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 14 Mar 2023 13:49:52 +0000
Date: Tue, 14 Mar 2023 09:49:48 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230314134948.GA7345@localhost>
References: <20230215023438.11370-1-wegao@suse.com>
 <20230221013446.19399-1-wegao@suse.com>
 <20230221013446.19399-2-wegao@suse.com> <ZA9F4vz/qVAjx4OB@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZA9F4vz/qVAjx4OB@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] rseq: Copy linux rseq test header files to
 ltp
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

On Mon, Mar 13, 2023 at 04:48:50PM +0100, Cyril Hrubis wrote:
> Hi!
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  include/lapi/compiler.h                    |   30 +
> >  include/lapi/rseq-abi.h                    |  151 +++
> >  include/lapi/rseq-arm.h                    |  827 ++++++++++++
> >  include/lapi/rseq-arm64.h                  |  695 ++++++++++
> >  include/lapi/rseq-generic-thread-pointer.h |   25 +
> >  include/lapi/rseq-mips.h                   |  777 +++++++++++
> >  include/lapi/rseq-ppc-thread-pointer.h     |   30 +
> >  include/lapi/rseq-ppc.h                    |  791 ++++++++++++
> >  include/lapi/rseq-riscv.h                  |  677 ++++++++++
> >  include/lapi/rseq-s390.h                   |  610 +++++++++
> >  include/lapi/rseq-skip.h                   |   65 +
> >  include/lapi/rseq-thread-pointer.h         |   19 +
> >  include/lapi/rseq-x86-thread-pointer.h     |   40 +
> >  include/lapi/rseq-x86.h                    | 1365 ++++++++++++++++++++
> 
> We actually does not need most of the code. The only thing that we use
> from the architecture specific headers is the RSEQ_SIG constant. So
> unless you actually plan to write tests that use the assembly code in
> these headers I would put just the RSEQ_SIG into the lapi/rseq.h instead.
> 
> There is no point in adding complex code that is not going to the be
> used.
> 
Yes, indeed, that's why i have made a patch v5 to ONLY work on x86_64 together with only function/macro to be 
used. Try to make test case small but the size is still big. This system call has no easy/friendly end user inteface
.

> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
