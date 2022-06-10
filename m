Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EF3C43334
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 05:42:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A43CC3C927B
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 07:42:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11C353C2E42
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 07:41:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28906200045
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 07:41:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D239220A0;
 Fri, 10 Jun 2022 05:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654839717;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=esLjcoaPUNxrLG/YLQ8uqU+G8GOwoOzX//s4XF29i3A=;
 b=tiLtH1IYN688hx2CCINb7lDRIP9GbBmWZqoVhzS9I7EBKlSvYn5sso2F7KGP92MT9a0pxl
 ucr2laddjv/hwi/SZN0qnF0s8gvqSf1h8xx+WRUwX0ClxBfuXOeGwdyBCpt60pjxRm+opC
 yA8V40uMni/azG3EL1kTiaGZlNV2q3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654839717;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=esLjcoaPUNxrLG/YLQ8uqU+G8GOwoOzX//s4XF29i3A=;
 b=ijvC1trvd4qyj6YYkG9uwmu6IzE+X2Dxmxnz9N558D74nkCtC+tvFzsvyaTo6WXiLiE91h
 OqgFQaGqfSBR+2Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E574A132F1;
 Fri, 10 Jun 2022 05:41:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LOh/NaTZomICEQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jun 2022 05:41:56 +0000
Date: Fri, 10 Jun 2022 07:41:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: shatur.linux@gmail.com
Message-ID: <YqLZoyKV2Y8VDIya@pevik>
References: <20220607221816.50955-1-sturlapati@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220607221816.50955-1-sturlapati@vmware.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] run-posix-option-group-test.sh: Log and exit if
 one attempts to run tests without compiling
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
Cc: ltp@lists.linux.it, sturlapati@vmware.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sharan,

> From: Sharan Turlapati <sturlapati@vmware.com>

> Currently, run-posix-option-group-test.sh erroneously
> logs "***Tests Completed***" when no test has actually run if the script is invoked
> to run without actually compiling the tests.

> Check if the .run-test files actually exist before attempting to run them.
> If not found, log a message indicating the problem and suggest to check if
> the tests were compiled. Exit the script without attempting to run other
> tests.
Can you please describe how this happen? open POSIX failed to compile?

...
> +++ b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
> @@ -22,9 +22,16 @@ EOF

>  run_option_group_tests()
>  {
> -	for test_script in $(find $1 -name '*.run-test' | sort); do
> -		(cd "$(dirname "$test_script")" && ./$(basename "$test_script"))
> -	done
> +	list_of_tests=`find $1 -name '*.run-test' | sort`
> +	if [[ -n $list_of_tests ]]
[[ ]] are bashisms, we require support for POSIX shell (i.e. dash, busybox sh)

TL;DR: simply use:
if [ -n "$list_of_tests" ]; then
NOTE [ ] require using quotes (unlike [[ ]]).

You can check similar error yourself:
$ checkbashisms run-posix-option-group-test.sh
possible bashism in run-posix-option-group-test.sh line 26 (alternative test command ([[ foo ]] should be [ foo ])):
	if [[ -n $list_of_tests ]]

All is described in:
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-shell-coding-style

> +	then
> +		for test_script in $list_of_tests; do
> +			(cd "$(dirname "$test_script")" && ./$(basename "$test_script"))
> +		done
> +	else
> +		echo ".run-test files not found under $1. Were the tests compiled?"
> +		exit 1
> +	fi
>  }

I'd prefer slightly different version:
* check for error first, then for can be out of else (readability)
* add local

run_option_group_tests()
{
	local list_of_tests

	list_of_tests=`find $1 -name '*.run-test' | sort`

	if [ -z "$list_of_tests" ]; then
		echo ".run-test files not found under $1. Were the tests compiled?"
		exit 1
	fi

	for test_script in $list_of_tests; do
		(cd "$(dirname "$test_script")" && ./$(basename "$test_script"))
	done
}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
