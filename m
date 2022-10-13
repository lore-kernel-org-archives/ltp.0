Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BF5C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 12:24:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7328C3C3030
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 14:24:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5F263C3030
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 14:24:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DFE15601A86
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 14:24:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 170B620109;
 Thu, 13 Oct 2022 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665663849;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SHqH5/5lNG09lb7oPt1VZYRRhMLQeUDafT7twlZ/Qhs=;
 b=CeMt5Qeq8If1rfXPz8dVg8G9g/4LIaBBjZU4sSrv+fleAB8GuDyR0rwWTblCGumbrmmDtc
 VxVawPSQdpNHKv0O4OZAonJpalQ5zAp01sGAiHVpBMOP7WMrX2jwDUs7KdHBrDGSsYH7zT
 3tkI5H0q0j/Dwn9TCKHmUhqNu5jyxnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665663849;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SHqH5/5lNG09lb7oPt1VZYRRhMLQeUDafT7twlZ/Qhs=;
 b=8lVRJghKxh5pLk4+ts+e7XaAyPA+6/cvu+oMoBTAEr2vb556WxhrBCcuumqGdButLDUGxS
 vqL2yJDT1kughfAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C81A8139F3;
 Thu, 13 Oct 2022 12:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iXQjL2gDSGN5BQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 12:24:08 +0000
Date: Thu, 13 Oct 2022 14:24:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <Y0gDZ/d0TmDA+c8q@pevik>
References: <20221013055845.28904-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221013055845.28904-1-akihiko.odaki@daynix.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test.sh: Unset the locale concerned variables
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Akihiko,

> network/tcp_cmds/tracepath/tracepath01.sh fails with LANG=ja_JP.UTF-8
> because it parses localized output.

it works for me:

# export LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8
# PATH="/opt/ltp/testcases/bin:$PATH" LANG=ja_JP.UTF-8 tracepath01.sh
tracepath01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
tracepath01 1 TINFO: add local addr 10.0.0.2/24
tracepath01 1 TINFO: add local addr fd00:1:1:1::2/64
tracepath01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
tracepath01 1 TINFO: add remote addr 10.0.0.1/24
tracepath01 1 TINFO: add remote addr fd00:1:1:1::1/64
tracepath01 1 TINFO: Network config (local -- remote):
tracepath01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
tracepath01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
tracepath01 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
tracepath01 1 TINFO: timeout per run is 0h 5m 0s
tracepath01 1 TINFO: traceroute version:
tracepath01 1 TINFO: tracepath from iputils 20211215
tracepath01 1 TINFO: test tracepath with 10.0.0.1, pmtu is 1280
tracepath01 1 TPASS: traced path to '10.0.0.1' in 1 hops

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

> To avoid such a problem, we can always unset the locale concerned
> variables. network/stress/ns-tools/check_envval does that, but it is
> limited to the network stress test. Add similar code to tst_test.sh
> so that it can cover more tests.

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  testcases/lib/tst_test.sh | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 28b7d12ba..9a8b62f1e 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -831,3 +831,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
>  		fi
>  	fi
>  fi
> +
> +# Unset the locale cocerned variables
> +for env in $(locale | cut -f 1 -d =); do
> +	unset $env
> +done
If we wanted to keep, we should also unset env, to not pollute the environment.

Instead of requiring locale being installed, prefer to follow kernel approach [1]
(well, they don't handle LANG)

unexport LC_ALL
LANG=C
LC_COLLATE=C
LC_NUMERIC=C
export LANG LC_COLLATE LC_NUMERIC

But as I wrote, is that really needed? Could you post your locale output?

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?h=v6.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
