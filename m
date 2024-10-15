Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE18D1F9C2
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 19:40:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB1593C6789
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 21:40:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3838A3C654D
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 21:40:04 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6F8181A010BD
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 21:40:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 847F01F834;
 Tue, 15 Oct 2024 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729021200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=POxsQIlIL1bi5ZuYPquk/JDPD8FWquHzaVBaElHLQvw=;
 b=DCAN8XYV0zIkdAXcfgEPwo6ysd/WTntdk5ijIV0LtFQjnRVKxwBiDXaKQ3NCFu+MWN4OwF
 vQlmpxXQuDZW+2WWsSeAStAbxjLXUyKMgwKDClb9Zm/tGViFz0qW8uJqYwhqGUVDPn0SET
 a3B02B96/YzU8UJQsKravebCETn52+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729021200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=POxsQIlIL1bi5ZuYPquk/JDPD8FWquHzaVBaElHLQvw=;
 b=AoDJu15YB5P0l6rNGPYS7U71aSE649zKoLtEpFIF35I9dW9MKSXGr5+U+WW1pk8s7K4y7M
 7dJr8aISLn5xIfAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729021200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=POxsQIlIL1bi5ZuYPquk/JDPD8FWquHzaVBaElHLQvw=;
 b=DCAN8XYV0zIkdAXcfgEPwo6ysd/WTntdk5ijIV0LtFQjnRVKxwBiDXaKQ3NCFu+MWN4OwF
 vQlmpxXQuDZW+2WWsSeAStAbxjLXUyKMgwKDClb9Zm/tGViFz0qW8uJqYwhqGUVDPn0SET
 a3B02B96/YzU8UJQsKravebCETn52+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729021200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=POxsQIlIL1bi5ZuYPquk/JDPD8FWquHzaVBaElHLQvw=;
 b=AoDJu15YB5P0l6rNGPYS7U71aSE649zKoLtEpFIF35I9dW9MKSXGr5+U+WW1pk8s7K4y7M
 7dJr8aISLn5xIfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52EEA13A42;
 Tue, 15 Oct 2024 19:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 79xXEhDFDmduXgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 15 Oct 2024 19:40:00 +0000
Date: Tue, 15 Oct 2024 21:39:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20241015193958.GC46536@pevik>
References: <20240918100344.21316-1-wegao@suse.com>
 <20240925035756.14873-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240925035756.14873-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.36 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.06)[-0.305];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ftp01.sh: Add support for test lftp
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

I suppose the v1 is
https://patchwork.ozlabs.org/project/ltp/patch/20240918100344.21316-1-wegao@suse.com/

To be honest, I would rather to remove this FTP test because FTP protocol is
legacy. I know it is supposed to be a smoke test, but maybe using modern tools
would be better than keeping test working among various old FTP implementations.
(Also nontrivial setup is required just for few FTP tests:
https://github.com/linux-test-project/ltp/tree/master/testcases/network )
But probably Cyril would be against. @Cyril @Martin WDYT?

@Wei I suppose the reason for adding lftp (you did not explain it in the commit
message) is that is the only supported client in SLE Micro? Or something else?

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/network/tcp_cmds/ftp/ftp01.sh | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

> diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
> index 53d1eec53..12d32a9a9 100755
> --- a/testcases/network/tcp_cmds/ftp/ftp01.sh
> +++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
> @@ -4,6 +4,7 @@
>  # Copyright (c) 2003 Manoj Iyer <manjo@mail.utexas.edu>
>  # Copyright (c) 2001 Robbie Williamson <robbiew@us.ibm.com>

> +TST_SETUP=setup
>  TST_TESTFUNC=do_test
>  TST_CNT=4
>  TST_NEEDS_CMDS='awk ftp'
> @@ -11,6 +12,16 @@ TST_NEEDS_TMPDIR=1

>  RUSER="${RUSER:-root}"
>  RHOST="${RHOST:-localhost}"
> +FTP_CMD="ftp -nv"
> +
> +setup()
> +{
> +    if tst_cmd_available lftp; then
> +        FTP_CMD="lftp --norc"
> +    else
> +        tst_brkm TCONF "No FTP client found"
Test was converted to the new API, it must be tst_brk.
Also, this code basically means that testing is done only for lftp,
otherwise TCONF.
+ You keep requiring ftp in TST_NEEDS_CMDS, but at least on Tumbleweed and
current Debian testing lftp does not provide symlink to ftp, only tnftp does
this. Therefore you require both lftp and tnftp for testing.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
