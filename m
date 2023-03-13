Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D07C6FD19
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 15:47:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D16833CD5AC
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 16:47:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22E853CAE69
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 16:47:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B7BB61A00153
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 16:47:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9219D22138;
 Mon, 13 Mar 2023 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678722450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZdPrWQI65MznDIMN+PM4cimzPo7qLOmsZESEWrUEjLQ=;
 b=ffqltEsANtaTWnm3VQygEwv3nmgw6hksYHMrnBwCliEVXE4qJuVoHEdn2SNpd686Nfimmg
 R73WaYx3k1D4osLT1wuDoUmydbmO0H2g6dEwtAvbmRfbjXHfbalay8EP4FJoNhXrIMNqE5
 bbtR9sFPbtPc6dfbBeY6m+Z72TPA27Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678722450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZdPrWQI65MznDIMN+PM4cimzPo7qLOmsZESEWrUEjLQ=;
 b=GA+jrjUvtIpZm0fWLorw/AxK777zDWUUS4SXaqgPWOGpvpiBrNDqlWftVcOHdJ4poRnOrA
 Eu0eIGVQuwI5bwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CC9A13517;
 Mon, 13 Mar 2023 15:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id u4WsGJJFD2S9dwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Mar 2023 15:47:30 +0000
Date: Mon, 13 Mar 2023 16:48:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZA9F4vz/qVAjx4OB@yuki>
References: <20230215023438.11370-1-wegao@suse.com>
 <20230221013446.19399-1-wegao@suse.com>
 <20230221013446.19399-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230221013446.19399-2-wegao@suse.com>
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/lapi/compiler.h                    |   30 +
>  include/lapi/rseq-abi.h                    |  151 +++
>  include/lapi/rseq-arm.h                    |  827 ++++++++++++
>  include/lapi/rseq-arm64.h                  |  695 ++++++++++
>  include/lapi/rseq-generic-thread-pointer.h |   25 +
>  include/lapi/rseq-mips.h                   |  777 +++++++++++
>  include/lapi/rseq-ppc-thread-pointer.h     |   30 +
>  include/lapi/rseq-ppc.h                    |  791 ++++++++++++
>  include/lapi/rseq-riscv.h                  |  677 ++++++++++
>  include/lapi/rseq-s390.h                   |  610 +++++++++
>  include/lapi/rseq-skip.h                   |   65 +
>  include/lapi/rseq-thread-pointer.h         |   19 +
>  include/lapi/rseq-x86-thread-pointer.h     |   40 +
>  include/lapi/rseq-x86.h                    | 1365 ++++++++++++++++++++

We actually does not need most of the code. The only thing that we use
from the architecture specific headers is the RSEQ_SIG constant. So
unless you actually plan to write tests that use the assembly code in
these headers I would put just the RSEQ_SIG into the lapi/rseq.h instead.

There is no point in adding complex code that is not going to the be
used.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
