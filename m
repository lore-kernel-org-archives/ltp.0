Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BEBC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 18:41:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35A663CB19F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 20:41:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 448D33CB0C2
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 20:41:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B9B81600FE8
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 20:41:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 21D891FB39;
 Thu, 20 Oct 2022 18:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666291264;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0P9/WNLSbagjND9gk87zxKFNV+Eu7THqkTeZzTblkbY=;
 b=D9jZ6cWZJvBE3cr9kY4m/wjtwxLHvjhh+4GTQU1h7AtrSKBwUvkGqDzTL1bjK2yaVE11i4
 oD+lnKDa5W3xzK/X7qb3fiKNdqdvw6nyN77CI97pz+5sb5Xvg6raB/HKq4l04ADW/aIwQT
 M2HSujb3BEV1l/3SnpoJ0uHKY10uNxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666291264;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0P9/WNLSbagjND9gk87zxKFNV+Eu7THqkTeZzTblkbY=;
 b=n3tNCM6kcOuOi/RVtkUdsTQLaJhDmTl6rri0i7sD2rB4arPVTj+UvgZ1niK+7rXfWdfZLi
 K0RS95Ug3UC4baBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 803BF13494;
 Thu, 20 Oct 2022 18:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iOKsHD+WUWPGYAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Oct 2022 18:41:03 +0000
Date: Thu, 20 Oct 2022 20:40:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <Y1GWOPpb+Z8hwhQd@pevik>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221020120741.212671-1-akihiko.odaki@daynix.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] ftp/ftp01: Use tst_net.sh
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

we do this rewrite in a single commit. It does not make much sense to split it.
I'd squash it, if it were ready, but we're not there yet.
Also, you're supposed to replace GPL verbose text at the top, history etc.
with just:

#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (c) 2022 Akihiko Odaki <akihiko.odaki@daynix.com>
# Copyright (c) 2003 Manoj Iyer <manjo@mail.utexas.edu>
# Copyright (c) 2001 Robbie Williamson <robbiew@us.ibm.com>

TST_TESTFUNC=do_test
TST_CNT=4
...
You forget TST_CNT=4, thus only single test is being run.

i.e. all the useless and now even outdated comments (even mentioning .rhosts, history, setup)
must go away.

The main problem is, that with improperly installed data files test happily
passes, because compares empty strings:

ftp01 1 TINFO: timeout per run is 0h 5m 0s
Not connected.
Not connected.
Not connected.
Not connected.
ls: cannot access 'ascii.sm': No such file or directory
ls: cannot access '/opt/ltp/testcases/bin/datafiles/ascii.sm': No such file or directory
ftp01 1 TPASS: [ '' = '' ] passed as expected
Not connected.
Not connected.
Not connected.
Not connected.
ls: cannot access 'ascii.med': No such file or directory
ls: cannot access '/opt/ltp/testcases/bin/datafiles/ascii.med': No such file or directory
ftp01 1 TPASS: [ '' = '' ] passed as expected
Not connected.
Not connected.
Not connected.
Not connected.
ls: cannot access 'ascii.lg': No such file or directory
ls: cannot access '/opt/ltp/testcases/bin/datafiles/ascii.lg': No such file or directory
ftp01 1 TPASS: [ '' = '' ] passed as expected
Not connected.
Not connected.
Not connected.
Not connected.
ls: cannot access 'ascii.jmb': No such file or directory
ls: cannot access '/opt/ltp/testcases/bin/datafiles/ascii.jmb': No such file or directory
ftp01 1 TPASS: [ '' = '' ] passed as expected

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0

When installing it properly, it does not work:

ftp01 1 TINFO: timeout per run is 0h 5m 0s
Not connected.
Not connected.
Not connected.
Not connected.
ls: cannot access 'ascii.sm': No such file or directory
ftp01 1 TFAIL: [ '' = '220' ] failed unexpectedly
Not connected.
Not connected.
Not connected.
Not connected.
ls: cannot access 'ascii.med': No such file or directory
ftp01 1 TFAIL: [ '' = '4020' ] failed unexpectedly
Not connected.
Not connected.
Not connected.
Not connected.
ls: cannot access 'ascii.lg': No such file or directory
ftp01 1 TFAIL: [ '' = '80020' ] failed unexpectedly
Not connected.
Not connected.
Not connected.
Not connected.
ls: cannot access 'ascii.jmb': No such file or directory
ftp01 1 TFAIL: [ '' = '1600020' ] failed unexpectedly
ftp01 2 TINFO: AppArmor enabled, this may affect test results
ftp01 2 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
ftp01 2 TINFO: loaded AppArmor profiles: none

Summary:
passed   0
failed   4
broken   0
skipped  0
warnings 0

First, there should be some check for $sum1 or $sum2 not being empty,
and probably if the file exists (probably in the setup).

The reason is in your version of setup function:
do_setup()
{

    TC=ftp
    RUSER=${RUSER:-root}

}

Here you have
* empty lines (remove it)
* TC=ftp is useless (remove it)
* RUSER could be defined above the setup function
(more readable, no need to be in the setup function)

But somehow cd into $TST_NET_DATAROOT in ftp code does not work.
I've tried to copy it instead:

do_setup()
{
    local file

    for file in $ASCII_FILES $BINARY_FILES; do
        ROD cp -v $TST_NET_DATAROOT/$file .
    done
}

But that does not work. I need some time to figure out what's wrong
(not an FTP expert).

Other things to fix:

Also file variable in test_get() and test_put() should be also declared with
local.

I don't like list_files() at all, why not just define
at the top of the test and then use them as I suggested before?

ASCII_FILES='bin.sm bin.med bin.lg bin.jmb'
BINARY_FILES='ascii.sm ascii.med ascii.lg ascii.jmb'

do_test()
{
    case $1 in
    1) test_get $BIN_FILES;;
    2) test_get $ASCII_FILES;;
    3) test_put $BIN_FILES;;
    4) test_put $ASCII_FILES;;
    esac
}

Also, thinking about the tool which gets the size. Looking at
https://stackoverflow.com/questions/1815329/portable-way-to-get-file-size-in-bytes-in-the-shell
https://unix.stackexchange.com/questions/16640/how-can-i-get-the-size-of-a-file-in-a-bash-script
'ls -l | awk '{print $5}' might be really the best tool to get file size as both
ls and awk are probably everywhere. And although we wrote some C code to avoid
external dependencies, here I'd keep it, because other alternatives has
drawbacks:

'du -b' is fast, but might not be everywhere.

'stat -c %s' is reported not to be portable:
https://stackoverflow.com/questions/1815329/portable-way-to-get-file-size-in-bytes-in-the-shell#comment21604978_5258707

'wc -c' is reported to be slow and also might not be everywhere:
https://stackoverflow.com/questions/1815329/portable-way-to-get-file-size-in-bytes-in-the-shell#comment21604978_5258707

'find "$file" -printf "%s"' would also work, but might not be everywhere.

I'll try to fix the problem, but not sure when I get time to fix it.
I've added all fixes into my fork, feel free to use it if you have time to post
new version. But please, test it before whether it works.
https://github.com/pevik/ltp/commits/akihiko_odaki/ftp01.v2.fixes

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
