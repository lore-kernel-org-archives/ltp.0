Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF769C433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 09:28:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E12493C96CC
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:28:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFB0B3C9232
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:28:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 73F07200D22
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:28:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B81501F45E;
 Fri, 21 Jan 2022 09:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642757316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCRyBaxEgYzaS4PsBMAdciBpyFacZXK3j+azjlpT8ME=;
 b=3YLSHIJsL2NvSkrWikJT3XBwB7DioL0pSn0gjsTDXcw4ZNIrB+3uZCeTutWkBbGs69RUFy
 7tSNo1nVf4YjjEtamdfHKTJluB62G1CgsHdBgYecASJZmTQuSRkma+FXMiwIu697+8qI9U
 Y4hkGYzCElNBZeDQ+h89HNl3uJqK7i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642757316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCRyBaxEgYzaS4PsBMAdciBpyFacZXK3j+azjlpT8ME=;
 b=8IaBI1gxhuiHhYvw8ILmf6V5wwPzjF2AJSgRpNvfzC8S2MukZVwb85bauFdQtMylDtirp0
 rg+xGnNgFVKYOXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9B7D13C1A;
 Fri, 21 Jan 2022 09:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SHFwKMR86mFfUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Jan 2022 09:28:36 +0000
Date: Fri, 21 Jan 2022 10:30:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yep9LbxzJ5s3S8Gn@yuki>
References: <20220120150421.26639-1-andrea.cervesato@suse.de>
 <YemAQcXuJMGLh/kc@yuki> <Yep1Wm84sKzl3iB6@pevik>
 <Yep6u4N+phjB32Xd@pevik> <Yep8ntzBsWApxU8c@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yep8ntzBsWApxU8c@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Reduce needed memory by the dio_read test
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
> Also I do plan to fix this properly by V2 of the runtime patchset once
> the release is finished, so I would go for minimal fix just before the
> release which would be setting tst_test.timeout to sufficiently large
> value.

And I guess that we should do that for all the rewritten aio tests.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
