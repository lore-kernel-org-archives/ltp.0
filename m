Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3C8C4332F
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 12:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66EEF3CAED8
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 14:59:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 658443CA91F
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 14:59:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B73782009D5
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 14:59:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BCE733A0B;
 Thu, 13 Oct 2022 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665665962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tSLV3hlCLzbwQHZWscQZ+t6bXEqmhGVr8ho+uPY9kBw=;
 b=ypr0WRpvPjaP717mTva3vtS9zBwpdp+eAMkrMF8KK3Bhc+nZtudlBgRO6M+MQP1kuf2IBG
 /oEAhd9mJOZrVc1qVuccUxz87B9SFUM/0vi42MPsCEBDXrElPmIVNJ2qkGBJz8nCacBcKF
 8u/r3MXMQFv3o1yjSM1capnYCYhB+J8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665665962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tSLV3hlCLzbwQHZWscQZ+t6bXEqmhGVr8ho+uPY9kBw=;
 b=BR9YsHLFVAFf/fLoYW/dg9pSXK/Vaq/vhHaRfLnWjt6iei25QyY2nZ0QoBXLcN/Yl8HuAA
 dAkRCLV5rrpHDaBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 180F0139F3;
 Thu, 13 Oct 2022 12:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AC1MBKoLSGO2HgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 12:59:22 +0000
Date: Thu, 13 Oct 2022 14:59:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <Y0gLqPfEQ1w6vEFy@pevik>
References: <20221013055904.28978-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221013055904.28978-1-akihiko.odaki@daynix.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ftp/ftp01: Use tst_net.sh
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

> This allows to use SSH rather than RSH.

Thanks for your work. First of all, code is not working, because ASCII_FILES and
BIN_FILES are in "$LTPROOT/testcases/bin/datafiles. have look at approach in
testcases/network/nfs/nfs_stress/nfs02.sh:
LTP_DATAFILES="$LTPROOT/testcases/bin/datafiles"

Otherwise it fails:

ftp01 1 TINFO: timeout per run is 0h 5m 0s
Not connected.
Not connected.
Not connected.
Not connected.
ls: cannot access 'bin.sm': No such file or directory
ls: cannot access '/opt/ltp/testcases/bin/datafiles/bin.sm': No such file or directory
ftp01 1 TINFO: Test Successful doing ftp get bin.sm binary
Not connected.
ftp: Can't chdir `/opt/ltp/testcases/bin/datafiles': No such file or directory
Not connected.
Not connected.
Not connected.
ftp01 1 TBROK: 'sum /tmp/LTP_ftp01.e9NUSqkHa3/bin.sm' failed on '': 'sum: /tmp/LTP_ftp01.e9NUSqkHa3/bin.sm: No such file or directory'
ftp01 1 TINFO: AppArmor enabled, this may affect test results
ftp01 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
ftp01 1 TINFO: loaded AppArmor profiles: none

...

Or have I miss something?

When we convert file to use LTP new API (shell API in this case:
https://github.com/linux-test-project/ltp/wiki/Shell-Test-API)
we do cleanup the code.

NFS tests or other shell tests which use tst_net.sh and *not* set
TST_USE_LEGACY_API=1 (i.e. rewritten to use LTP new shell API) are good
examples.

ftp01.sh requires at least this cleanup:
* remove useless comments like "FUNCTION:  do_setup"
* code cleanup of do_test: having several loops is really crazy,
how about write functions and pass them parameters?
* please use $( ... ) instead of ` ... `.
* use local to declare new variables
* I'd remove sleep option
* replace GPL with:
# SPDX-License-Identifier: GPL-2.0-or-later
* update copyright

Proper API use
* tst_require_cmds should be replaced by TST_NEEDS_CMDS at the top.
Even if you keep to use tst_require_cmds awk ftp
this line is useless (1) tst_brk quits testing 2) we use ssh, why to mention
.rhosts?):
[ $? = 0 ] || tst_brk TBROK "Check .rhosts file on remote machine."
* instead of "for i in binary ascii; do" I'd use:

TST_TESTFUNC=do_test
TST_CNT=4
TST_NEEDS_TMPDIR=1
LTP_DATAFILES="$LTPROOT/testcases/bin/datafiles"

test_ftp()
{
	for j in $*; do
	done
}

do_test()
{
    case $1 in
    1) test_get $BIN_FILES;;
    2) test_get $ASCII_FILES;;
    3) test_put $BIN_FILES;;
    4) test_put $ASCII_FILES;;
    esac
}

test_get()
{
	local sum1 sum2

	for file in $*; do
		{
			echo "user $RUSER $PASSWD"
			echo "$i"
			echo "cd $TST_NET_DATAROOT"
			echo "get $file"
			echo "quit"
		} | ftp -nv $RHOST

		sum1="$(ls -l $file | awk '{print $5}')"
		sum2="$(ls -l $TST_NET_DATAROOT/$file | awk '{print $5}')"
		rm -f $file
		EXPECT_PASS "[ '$sum1' = '$sum2' ]"
	done
}


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
