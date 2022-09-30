Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F13C433F5
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 12:05:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DA513CA8CB
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 14:05:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4226D3C0895
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 14:05:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6DA8F1401356
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 14:05:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 252EA1F8C5;
 Fri, 30 Sep 2022 12:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664539524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=//mi48wMjfG5HqTCsqWUvtwK3I/H2PFTqgBwR8Usahg=;
 b=M2oHOFXjgR3ne0ED9ZGmhtrlp7GSwDmBGO1pqPdLi2CTj+U5Z0g+UI1pQCNan3uB0g9XZK
 +BNZfIqWymMlgkzoYQyrTDBWXKXLL5gd0LYQQiHtugOF0/tnecIQXeCnj8cSoKx828xEs+
 DoYH+qGIpNlBAVY6Zes4Wi6jmfunBNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664539524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=//mi48wMjfG5HqTCsqWUvtwK3I/H2PFTqgBwR8Usahg=;
 b=V7Tcyo/+TwVUKcYv3zYpmJ9kBLn+3jVU/w4i9ldeuS0GxUJxPoZTqMm5fdDHGoDAsrQqDB
 wmy5LFd4la3KjwAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA65913677;
 Fri, 30 Sep 2022 12:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rP6vN4PbNmNSHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 12:05:23 +0000
Date: Fri, 30 Sep 2022 14:05:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YzbbgS6O0vBPUXbp@pevik>
References: <20220930112434.13038-1-pvorel@suse.cz>
 <YzbV5JFPNNoVmqth@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YzbV5JFPNNoVmqth@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Fix missing cleanup run from
 setup
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Hi!
> Looks like an obvious regression that should be fixed.
+1

> But we should at least re-run all shell tests to make sure that this
> does not break anything. I would vote for this to go in before the
> release but after you did enough testing.

I'm testing with these 2 patches (this and zram01.sh) in my fork:
https://github.com/pevik/ltp/commits/ltp-202209.2022-09-30.pre-release

I rerun whole LTP tests on 3 SLES versions, most of the shell tests on
Tumbleweed, I'll also try some shell tests on some Debian version.
Also CI passed (which runs make test-shell), + I run make test-shell manually
(covers more than CI), but that's not that relevant as we don't cover much.

> And also it would be better if anyone else had a look.
That'd be great, but not sure if anybody jumps in.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
