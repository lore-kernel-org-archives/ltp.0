Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32751CDB474
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 18:45:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E9663CF5A7
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 20:45:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 493EF3CFD6E
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 49B551400BDF
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 674951FEC6;
 Mon, 16 Oct 2023 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697481875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPNK4N09V2MfpuGZCYnQ/SDTVY67AlwY6PcytaqS4Tk=;
 b=Sm6LrtKhgWxIDRY+SGsyVnJGStLtqMMZoz8sa9tb+9aDTvEgzx+skSBeAYbzWdqGbSsNPi
 JfwJVgI7donfKtJPwZ8UJWoqK9ysluOhry5ydmu2CF16ag3Zp40STJtJ5iIiw/Qn0eLBg1
 sG7o+TmP//LSJS5gL5ur+mf0QfGunuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697481875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPNK4N09V2MfpuGZCYnQ/SDTVY67AlwY6PcytaqS4Tk=;
 b=QUQ86N/5aLsD512S0ZBVzsfenBTfuOQ4Yo2GUPXtcIvRtFr/IEcDqBKSTwnYlC5Gm8bKJl
 cvSBCcTX70DzguDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F25CE138EF;
 Mon, 16 Oct 2023 18:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iJs0OZGELWXAZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Oct 2023 18:44:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Oct 2023 20:44:05 +0200
Message-ID: <20231016184408.879977-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016184408.879977-1-pvorel@suse.cz>
References: <20231016184408.879977-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-2.99)[-0.998];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 4/7] testscripts: Remove ltpdmmapper.sh
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Legacy script from 2004, probably not used by anybody.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/ltpdmmapper.sh | 204 -------------------------------------
 1 file changed, 204 deletions(-)
 delete mode 100755 testscripts/ltpdmmapper.sh

diff --git a/testscripts/ltpdmmapper.sh b/testscripts/ltpdmmapper.sh
deleted file mode 100755
index f49e59626..000000000
--- a/testscripts/ltpdmmapper.sh
+++ /dev/null
@@ -1,204 +0,0 @@
-#!/bin/sh
-# This script should be run prior to running executing the filesystem tests.
-# valid devices need to be passed for Device Mapper to work correctly
-# 03/14/03 mridge@us.ibm.com added instance and time command line options
-
-cd `dirname $0`
-export LTPROOT=${PWD}
-echo $LTPROOT | grep testscripts > /dev/null 2>&1
-if [ $? -eq 0 ]; then
- cd ..
- export LTPROOT=${PWD}
-fi
-
-export TMPBASE="/tmp"
-
-
-usage()
-{
-	cat <<-END >&2
-	usage: ${0##*/} [ -a part1 ] [ -b part2 ]
-
-	Note: In order to run this test, you must turn on "device mapper"
-        component in kernel (it is under device drivers item when you
-        run make menuconfig); and you must install userspace supporting
-        files (libdevmapper and dmsetup). They are in the device-mapper
-        package. You can download it from http://www.sistina.com. Follow
-        the README/INSTALL file within the package to install it.
-
-
-	defaults:
-	part1=$part1
-	part2=$part2
-	ltproot=$LTPROOT
-	tmpdir=$TMPBASE
-
-	example: ${0##*/} -a hdc1 -b hdc2
-
-
-	END
-exit
-}
-
-while getopts :a:b: arg
-do      case $arg in
-		a)	part1=$OPTARG;;
-                b)      part2=$OPTARG;;
-
-                \?)     echo "************** Help Info: ********************"
-                        usage;;
-        esac
-done
-
-if [ ! -n "$part1"  ]; then
-  echo "Missing 1st partition. You must pass 2 partitions for testing"
-  usage;
-  exit
-fi
-
-if [ ! -n "$part2" ]; then
-  echo "Missing 2nd partition. You must pass 2 partitions for testing"
-  usage;
-  exit
-fi
-
-echo "Starting Device Mapper Tests..."
-
-echo "0 10240 linear " $part1 "0" > ltp-dev-mapper-table1
-echo "0 100000 linear " $part1 "0" > ltp-dev-mapper-table2
-echo "0 100000 linear " $part2 "0" > ltp-dev-mapper-table3
-echo "0 200000 striped 2 16 " $part1 "0" $part2 "0" > ltp-dev-mapper-table4
-
-echo "Creating Devices..."
-
-dmsetup create dm-test-1 ltp-dev-mapper-table1
-dmsetup create dm-test-2 ltp-dev-mapper-table2
-dmsetup create dm-test-3 ltp-dev-mapper-table3
-dmsetup create dm-test-4 ltp-dev-mapper-table4
-
-echo "Device Info..."
-
-dmsetup info dm-test-1
-dmsetup info dm-test-2
-dmsetup info dm-test-3
-dmsetup info dm-test-4
-
-echo "Device Dependancies..."
-
-dmsetup deps dm-test-1
-dmsetup deps dm-test-2
-dmsetup deps dm-test-3
-dmsetup deps dm-test-4
-
-echo "Device Status..."
-
-dmsetup status dm-test-1
-dmsetup status dm-test-2
-dmsetup status dm-test-3
-dmsetup status dm-test-4
-
-echo "Device Tables..."
-
-dmsetup table dm-test-1
-dmsetup table dm-test-2
-dmsetup table dm-test-3
-dmsetup table dm-test-4
-
-echo "Device Mapper Version..."
-
-dmsetup version
-
-echo "Device Waiting..."
-
-#dmsetup wait dm-test-1
-#dmsetup wait dm-test-2
-#dmsetup wait dm-test-3
-#dmsetup wait dm-test-4
-
-echo "Device Mapper Removing Devices..."
-
-dmsetup remove dm-test-1
-dmsetup remove dm-test-2
-dmsetup remove dm-test-3
-dmsetup remove dm-test-4
-
-echo "Device Mapper Re-Creating Devices..."
-
-dmsetup create dm-test-1 ltp-dev-mapper-table1
-dmsetup create dm-test-2 ltp-dev-mapper-table2
-dmsetup create dm-test-3 ltp-dev-mapper-table3
-dmsetup create dm-test-4 ltp-dev-mapper-table4
-
-echo "Re-Naming Devices..."
-
-dmsetup rename dm-test-1 dm-test-1-new
-dmsetup rename dm-test-2 dm-test-2-new
-dmsetup rename dm-test-3 dm-test-3-new
-dmsetup rename dm-test-4 dm-test-4-new
-
-echo "Suspend Devices..."
-
-dmsetup suspend dm-test-1-new
-dmsetup suspend dm-test-2-new
-dmsetup suspend dm-test-3-new
-dmsetup suspend dm-test-4-new
-
-echo "0 102400 linear " $part1 "0" > ltp-dev-mapper-table1
-echo "0 200000 linear " $part1 "0" > ltp-dev-mapper-table2
-echo "0 200000 linear " $part2 "0" > ltp-dev-mapper-table3
-echo "0 400000 striped 2 16 " $part1 "0" $part2 "0" > ltp-dev-mapper-table4
-
-echo "Re-loading Devices..."
-
-dmsetup reload dm-test-1-new ltp-dev-mapper-table1
-dmsetup reload dm-test-2-new ltp-dev-mapper-table2
-dmsetup reload dm-test-3-new ltp-dev-mapper-table3
-dmsetup reload dm-test-4-new ltp-dev-mapper-table4
-
-echo "Resuming Devices..."
-
-dmsetup resume dm-test-1-new
-dmsetup resume dm-test-2-new
-dmsetup resume dm-test-3-new
-dmsetup resume dm-test-4-new
-
-echo "Device Info..."
-
-dmsetup info dm-test-1-new
-dmsetup info dm-test-2-new
-dmsetup info dm-test-3-new
-dmsetup info dm-test-4-new
-
-echo "Device Dependancies..."
-
-dmsetup deps dm-test-1-new
-dmsetup deps dm-test-2-new
-dmsetup deps dm-test-3-new
-dmsetup deps dm-test-4-new
-
-echo "Device Status..."
-
-dmsetup status dm-test-1-new
-dmsetup status dm-test-2-new
-dmsetup status dm-test-3-new
-dmsetup status dm-test-4-new
-
-echo "Device Tables..."
-
-dmsetup table dm-test-1-new
-dmsetup table dm-test-2-new
-dmsetup table dm-test-3-new
-dmsetup table dm-test-4-new
-
-echo "Device Mapper Remove-all..."
-
-dmsetup remove_all
-
-echo "Device Mapper Checking Status - Shouldn't be anything to check"
-
-dmsetup status dm-test-1-new
-dmsetup status dm-test-2-new
-dmsetup status dm-test-3-new
-dmsetup status dm-test-4-new
-
-
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
