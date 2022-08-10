Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EA6C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 15:09:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0738A3C954A
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 17:09:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DFDE3C013B
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 17:09:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 815641400335
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 17:08:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8935D378F1;
 Wed, 10 Aug 2022 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660144139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJyftLZ0jgmepYKyv4s8d/yRjYwub6T6595kT36xtc8=;
 b=E0I0AIeDnxkAawBwtjFTziF90+JDwhE+dCCMoYuRMUYJtYAEVc2MDdCzVYMdewamrVCWrf
 yz+ZYoPNljrELCkUpbvzzFMHlfRyKh+1nNqhiFw2ZH9OE2ZwAzES2i+DsJEUE+sDmQlT7q
 xzAK0cuv6v9UAX7WIdHx7T9+JUW4QvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660144139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJyftLZ0jgmepYKyv4s8d/yRjYwub6T6595kT36xtc8=;
 b=wk9X/3HLEkbJjxeP/PUZnh6Ba5no84glCq13yVvjwBIg4QpSIcOY1oTfH/gTJmgWO2cMGp
 zPVLdioIgMXlqIBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B72613A7E;
 Wed, 10 Aug 2022 15:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P+k+GQvK82LXSAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 10 Aug 2022 15:08:59 +0000
Message-ID: <7d501d57-2438-cd28-5e49-019ea06fb8f2@suse.cz>
Date: Wed, 10 Aug 2022 17:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-4-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220808113756.11582-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] tst_test.sh: Fix _tst_cleanup_timer() on
 set -e
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
a comment explaining why this is needed would be nice, otherwise looks
good. For patches 2 and 3:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 08. 08. 22 13:37, Petr Vorel wrote:
> If test exits on time (i.e. no timeout) kill in _tst_cleanup_timer()
> have nothing to kill therefore following wait exits 143.
> 
> set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit code,
> fix hardens _tst_cleanup_timer() to be able to be used on scripts with it.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I can use 'if ...; then ; fi' if you prefer:
> 
> 	if [ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0" ]; then
> 		return 0
> 	fi
> 
> 	if [ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" = "1" ]; then
> 		return 1
> 	fi
> 
> ...
> 	if [ "$color" = 1 ]; then
> 		tst_flag2color "$1"
> 	fi
> 	printf "$2"
> 	if [ "$color" = 1 ]; then
> 		printf '\033[0m'
> 	fi
> 
> 
> Kind regards,
> Petr
> 
>  testcases/lib/tst_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 356af0106..1d2bf06cc 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -518,7 +518,7 @@ _tst_cleanup_timer()
>  {
>  	if [ -n "$_tst_setup_timer_pid" ]; then
>  		kill -TERM $_tst_setup_timer_pid 2>/dev/null
> -		wait $_tst_setup_timer_pid 2>/dev/null
> +		wait $_tst_setup_timer_pid 2>/dev/null || true
>  	fi
>  }
>  


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
