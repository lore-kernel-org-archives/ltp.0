Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A46C6FD1F
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 16:28:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9486A3CD4F4
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 17:28:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0EA33CACC1
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 17:28:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CC3DB14002C8
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 17:28:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BBE6F218FE;
 Tue, 14 Mar 2023 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678811283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Es0Suax/Z9kAMm5RX4ZsinZFNzObzEmBb3eJU5D1kAc=;
 b=HWoOAI7JhvjiGpfBO/yaJ/+twDgc/gcBxg+YOlLJc64hm6hCMvWgMNGouNlTGNlPzmxI/b
 KdcMSpR7Wd4vXn9Zl2zUswMZPqr4UaLDZdxk9tiJCARLABGigZeHypjGjXg+94HvpMHJvO
 uDSXHI2sa62I6mwpluvHp6ImWw5yCtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678811283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Es0Suax/Z9kAMm5RX4ZsinZFNzObzEmBb3eJU5D1kAc=;
 b=UGR2DWPGbUNV4Pvmf8TJsE1VAmLQoEcAvjccnBB3w3AzQqLkwVeKDuLAQ+uzRJFQghYVDu
 /QxQUFp52boZnXBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A610A13A26;
 Tue, 14 Mar 2023 16:28:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CUoKKJOgEGSrZAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Mar 2023 16:28:03 +0000
Date: Tue, 14 Mar 2023 17:29:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZBCg4/dzazACgooL@yuki>
References: <20230215023438.11370-1-wegao@suse.com>
 <20230221013446.19399-1-wegao@suse.com>
 <20230221013446.19399-2-wegao@suse.com> <ZA9F4vz/qVAjx4OB@yuki>
 <20230314134948.GA7345@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230314134948.GA7345@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > We actually does not need most of the code. The only thing that we use
> > from the architecture specific headers is the RSEQ_SIG constant. So
> > unless you actually plan to write tests that use the assembly code in
> > these headers I would put just the RSEQ_SIG into the lapi/rseq.h instead.
> > 
> > There is no point in adding complex code that is not going to the be
> > used.
> > 
> Yes, indeed, that's why i have made a patch v5 to ONLY work on x86_64 together with only function/macro to be 
> used. Try to make test case small but the size is still big. This system call has no easy/friendly end user inteface
> .

Now I'm confused, I do not see a v5 rseq patchset. Also there is no need
to limit the test to x86_64 all that we need is a per architecture
RSEQ_SIG definition.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
