Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3E9C6FD1F
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 22:40:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E34F13CE651
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 23:40:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD9C13CD4E8
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 23:40:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A68BE6009CE
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 23:40:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D99C21BCE;
 Tue, 14 Mar 2023 22:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678833645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZhRIVM58FciTXxOywgK8t8GN1F8zaE3Sx38av0cEQo=;
 b=AmF00wNL0Bod7QZpU1S9U9Tm7j6ho7X12WMmce+JJL3BwVKYjN+s01kz9KU4PzvyNfvRCg
 YJgoMpJWLWdk05zRoGc5Me+wWxfM6MXUiHzH46U+Lw5pKE8umVZaOrz173bTDATSES4EVl
 2dxddwteMlUwK38jU6jOW+FsoD3ZhTM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7484913A26;
 Tue, 14 Mar 2023 22:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BW4gE+z3EGTfGAAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 14 Mar 2023 22:40:44 +0000
Date: Tue, 14 Mar 2023 18:40:41 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230314224041.GA9258@localhost>
References: <20230215023438.11370-1-wegao@suse.com>
 <20230221013446.19399-1-wegao@suse.com>
 <20230221013446.19399-2-wegao@suse.com> <ZA9F4vz/qVAjx4OB@yuki>
 <20230314134948.GA7345@localhost> <ZBCg4/dzazACgooL@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBCg4/dzazACgooL@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

On Tue, Mar 14, 2023 at 05:29:23PM +0100, Cyril Hrubis wrote:
> Hi!
> > > We actually does not need most of the code. The only thing that we use
> > > from the architecture specific headers is the RSEQ_SIG constant. So
> > > unless you actually plan to write tests that use the assembly code in
> > > these headers I would put just the RSEQ_SIG into the lapi/rseq.h instead.
> > > 
> > > There is no point in adding complex code that is not going to the be
> > > used.
> > > 
> > Yes, indeed, that's why i have made a patch v5 to ONLY work on x86_64 together with only function/macro to be 
> > used. Try to make test case small but the size is still big. This system call has no easy/friendly end user inteface
> > .
> 
> Now I'm confused, I do not see a v5 rseq patchset. Also there is no need
> to limit the test to x86_64 all that we need is a per architecture
> RSEQ_SIG definition.
> 
https://patchwork.ozlabs.org/project/ltp/patch/20230314093725.3814-1-wegao@suse.com/
Maybe already set to change request so you can not see it?

> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
