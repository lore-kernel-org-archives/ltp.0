Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153A4C3DA7A
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 09:31:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4214B3CB615
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 10:31:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BC473C19D9
 for <ltp@lists.linux.it>; Fri,  6 Jan 2023 10:31:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 043F21400C50
 for <ltp@lists.linux.it>; Fri,  6 Jan 2023 10:31:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A4DCC25CE3;
 Fri,  6 Jan 2023 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672997492;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tab6pyVxm5AbaomiaIE9+IRhN+1/700PzruXGyak98=;
 b=rzl77KVpgH/zC9HuooIWMpe+bI/7Gafou7zxz6hjk+Me7BmzLEAT07V30kpNnQQzBlVW5m
 0/uiI/mkcn/8BtWDnCdyC020Hs0+YeNa5B6nnAlhgYOt1uMH9DPTNOoBGysHqyRK8NB00a
 w7YFV9larHU8nHYwNJdoGYhlUYRoJD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672997492;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tab6pyVxm5AbaomiaIE9+IRhN+1/700PzruXGyak98=;
 b=5SnPDn3Yl2q67akb43RIr/w6SbfKofu4fcsSTGMfJwRM1X8v6RvAbm44GmbjL17GCBQr04
 kT9habp/nZJLyYDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8620813596;
 Fri,  6 Jan 2023 09:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MuxBH3Tqt2PEaQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jan 2023 09:31:32 +0000
Date: Fri, 6 Jan 2023 10:31:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: coolgw <coolgw1126@gmail.com>
Message-ID: <Y7fqcrPRV1KNsagV@pevik>
References: <20230105142559.20174-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230105142559.20174-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add containers/share to PATH when call
 init_ltp_netspace
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

Hi Wei,

> When run single test case use command such as:
> LTP_SHELL_API_TESTS=shell/net/tst_rhost_run.sh make test-shell
> Error msg such as "ns_create: command not found" will popup, so
> need update PATH before call ns_create etc..

Once fixed, it should be here:

Fixes: #991

> Signed-off-by: WEI GAO <wegao@suse.com>
> ---
>  testcases/lib/tst_net.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index ceb45c98d..cd370e26f 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -128,10 +128,13 @@ tst_net_require_ipv6()

>  init_ltp_netspace()
>  {
> +	PATH="$PWD/../../testcases/kernel/containers/share/:$PATH"
> +	tst_res TINFO "PATH='$PATH'"
This is not acceptable. The path should go to the test itself (tst_net.sh should
be either proper installed, then it expect ns_clone and other binaries to be
properly in /opt/ltp/testcases/bin and $PATH set to it. Or, if it's used for a
development, user is required to set the correct $PATH already.)

The reason why it should be in tst_rhost_run.sh is to allow testing instead of
make install. But user still needs to run make in required directories to have
required binaries at least compiled (if not installed).

NOTE: there are only 2 network shell API tests and the other tst_ipaddr_un.sh
does not use namespaces, that's why it goes just to this test.

> +
>  	local pid

>  	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
> -		tst_require_cmds ip
> +		tst_require_cmds ip ns_create ns_exec ns_ifmov
This is wrong:
s/ns_ifmov/ns_ifmove/

(copy & paste is your friend to prevent silly errors)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
