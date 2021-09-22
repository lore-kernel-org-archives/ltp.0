Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D5C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:47:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C428561156
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C428561156
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BF7E3CA211
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 13:47:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C01F3C22CD
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 13:47:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2E3C7600CC6
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 13:47:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2CF5A22213;
 Wed, 22 Sep 2021 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632311257;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=36IdXHp84eA5CEsGV/yfxQgW/yw20QXQ/3FNdo+o1yg=;
 b=s4YSv0mRzORoRTAOpOWpRsC10u2/OTMoIiQFUiiAISGmJv66z0KsYOY3HQe3ukPE4mw2wx
 TLjcIKFTNwt6pg29Pw9G2OjfIo43lyxIRqhM2RBUrfqGpgT+xZSjFCZY7E0g2Lm+b1wTdm
 Q8Kn4gtNUR/vihG9GkuRbTnyTi+qhBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632311257;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=36IdXHp84eA5CEsGV/yfxQgW/yw20QXQ/3FNdo+o1yg=;
 b=RHBIz4Mk5kwpH3KxjgN/lrzjlJI7/7seRWdb5TIFfKkF1KOQbXlnZdWWcW63+GKf6R25qI
 pQC05g8gk56Ac5Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED87013D76;
 Wed, 22 Sep 2021 11:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id la5iONgXS2H+BgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Sep 2021 11:47:36 +0000
Date: Wed, 22 Sep 2021 13:47:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alex Henrie <alexh@vpitech.com>
Message-ID: <YUsX1/4HmzHO01GW@pevik>
References: <20210922020801.466936-1-alexh@vpitech.com>
 <20210922020801.466936-2-alexh@vpitech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210922020801.466936-2-alexh@vpitech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH ltp v5 2/3] IMA: Move ima_check to ima_setup.sh
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Signed-off-by: Alex Henrie <alexh@vpitech.com>
> ---
>  .../integrity/ima/tests/ima_measurements.sh   | 28 -------------------
>  .../security/integrity/ima/tests/ima_setup.sh | 28 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 28 deletions(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> index 1927e937c..807c5f57b 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> @@ -17,38 +17,10 @@ setup()
>  {
>  	require_ima_policy_cmdline "tcb"

> -	TEST_FILE="$PWD/test.txt"
>  	POLICY="$IMA_DIR/policy"
>  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
>  }

> -ima_check()
> -{
> -	local algorithm digest expected_digest line tmp
> -
> -	# need to read file to get updated $ASCII_MEASUREMENTS
> -	cat $TEST_FILE > /dev/null
> -
> -	line="$(grep $TEST_FILE $ASCII_MEASUREMENTS | tail -1)"
> -
> -	if tmp=$(get_algorithm_digest "$line"); then
> -		algorithm=$(echo "$tmp" | cut -d'|' -f1)
> -		digest=$(echo "$tmp" | cut -d'|' -f2)
> -	else
> -		tst_res TBROK "failed to get algorithm/digest for '$TEST_FILE': $tmp"
> -	fi
> -
> -	tst_res TINFO "computing digest for $algorithm algorithm"
> -	expected_digest="$(compute_digest $algorithm $TEST_FILE)" || \
> -		tst_brk TCONF "cannot compute digest for $algorithm algorithm"
> -
> -	if [ "$digest" = "$expected_digest" ]; then
> -		tst_res TPASS "correct digest found"
> -	else
> -		tst_res TFAIL "digest not found"
> -	fi
> -}
> -
>  check_iversion_support()
>  {
>  	local device mount fs
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 9c25d634d..976c6a86c 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -188,6 +188,7 @@ ima_setup()
>  	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
>  		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
>  		mount_loop_device
> +		TEST_FILE="$PWD/test.txt"
This is wrong, it's causing error, unless you have $TMPDIR (usually /tmp) on
tmpfs it's not defined and leads to error:

ima_measurements 1 TINFO: verify adding record to the IMA measurement list
tst_rod: Missing filename after >
ima_measurements 1 TBROK: echo Wed Sep 22 12:24:17 CEST 2021 this is a test file > failed

And even on tmpfs it fails (maybe caused by old kernel 3.10):

ima_measurements 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_measurements 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
ima_measurements 1 TINFO: not using default policy
ima_measurements 1 TINFO: verify adding record to the IMA measurement list
ima_measurements 1 TBROK: failed to get algorithm/digest for '/tmp/LTP_ima_measurements.dLS7yCTHLY/mntpoint/test.txt': measurement record not found
ima_measurements 1 TINFO: computing digest for  algorithm
                                               ^
                                               => notice space - algorithm not detected
ima_measurements 1 TCONF: cannot compute digest for  algorithm
                                               ^
                                               => also here.

It's also wrong that $PWD is unique for each test and TMPDIR is removed after
test, thus TEST_FILE will not exist for the second test (ima_conditionals.sh).
Also, ima_setup(). Also, I put into ima_setup.sh IMA related variables.
TEST_FILE is not that case thus I'd keep $TEST_FILE in ima_measurements.sh and
define local test_file="$PWD/test.txt" in the only function in ima_conditionals.sh.

Also I intent do remove duplicity in ima_conditionals.sh, thus I'll send v6 in a minute.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
