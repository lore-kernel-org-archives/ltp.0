Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8FBCDB465
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 18:46:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA1D43CFE58
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 20:46:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79BE63CFE51
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A3D7510009CB
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D21341FECB;
 Mon, 16 Oct 2023 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697481876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/K/OCqEgwrtoHBXH5b142dvX+1rAKDsXU3jKP1+tWiI=;
 b=MjcDr0LkkA9moZbAe5j8zN0iD+xGYs3Z63/ucsgBIiJM2bpMlkm+/EC3z7uhHkUkB7jMSY
 m949AIkInx+dZSgNSUeIgp8F3CCWPoCnV1RlDLcK5/MplQMeF0EhMbVd1imo5/Gj0OoN23
 gZmy9tx1mW0x79fq83rjlrPzfOx45Lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697481876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/K/OCqEgwrtoHBXH5b142dvX+1rAKDsXU3jKP1+tWiI=;
 b=zzzO7+5po7jB0Q1rh76ZGAx8tpG61iQQjFugDXVjI0RmHbz5YydxVSkiVLA6BL1DFXPgZZ
 SVulFJ3wh/Cre9AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88912139F9;
 Mon, 16 Oct 2023 18:44:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eMD/HJOELWXAZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Oct 2023 18:44:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Oct 2023 20:44:06 +0200
Message-ID: <20231016184408.879977-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016184408.879977-1-pvorel@suse.cz>
References: <20231016184408.879977-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-3.00)[-0.999];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 5/7] testscripts: Remove ltp-scsi_debug.sh
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
 testscripts/ltp-scsi_debug.sh | 218 ----------------------------------
 1 file changed, 218 deletions(-)
 delete mode 100755 testscripts/ltp-scsi_debug.sh

diff --git a/testscripts/ltp-scsi_debug.sh b/testscripts/ltp-scsi_debug.sh
deleted file mode 100755
index 37853002e..000000000
--- a/testscripts/ltp-scsi_debug.sh
+++ /dev/null
@@ -1,218 +0,0 @@
-#!/bin/bash
-
-# Check if scsi_debug module was built or not
-export kernel=$(uname -r)
-
-ls /lib/modules/$kernel/kernel/drivers/scsi | grep scsi_debug > /dev/null 2>&1
-if [ $? -ne 0 ];
-then
-	echo "scsi_debug was not built in the kernel as a module"
-	echo "Build scsi_debug as a module first before running the test"
-fi
-
-# Unload scsi_debug moudle if it was already loaded:
-lsmod | grep scsi_debug > /dev/null 2>&1
-if [ $? -eq 0 ];
-then
-        echo "The scsi_debug module was already loaded, unload it before test..."
-	rmmod -f scsi_debug
-fi
-lsmod | grep scsi_debug > /dev/null 2>&1
-if [ $? -eq 0 ];
-then
-        echo "The scsi_debug module was not unloaded - unload error"
-else
-        echo "The scsi_debug module was unloaded successfully"
-	echo "start testing..."
-fi
-
-orig_count=$(cat /proc/partitions | wc -l)
-
-echo " Load the scsi_debug module..."
-modprobe scsi_debug
-if [ $? -ne 0 ];
-then
-        echo "Can't load scsi_debug modules"
-	exit
-fi
-
-echo "Check if scsi_debug was loaded..."
-lsmod | grep scsi_debug > /dev/null 2>&1
-if [ $? -eq 0 ];
-then
-        echo "scsi_debug module was loaded successfully"
-else
-	echo "scsi_debug module was not loaded"
-	exit
-fi
-
-
-echo "Remove the scsi_debug device..."
-dev_name=$(ls /proc/scsi/scsi_debug)
-# echo $dev_name
-rm_dev=$dev_name:0:0:0
-# echo $rm_dev
-echo 1 > /sys/class/scsi_device/$rm_dev/device/delete
-
-echo "Check if the scsi_debug device was removed..."
-ls /sys/class/scsi_device | grep $rm_dev > /dev/null 2>&1
-if [ $? -eq 0 ];
-then
-        echo "The device was not removed - remove error"
-else
-	echo "The device $dev_name was removed successfully"
-fi
-
-echo "Add the device back..."
-echo "0 0 0" > /sys/class/scsi_host/host$dev_name/scan
-ls /sys/class/scsi_device | grep $rm_dev > /dev/null 2>&1
-if [ $? -ne 0 ];
-then
-        echo "The device was not added - add device error"
-else
-        echo "The device $dev_name was added back successfully"
-fi
-
-echo "Add a new host..."
-echo 1 > /sys/bus/pseudo/drivers/scsi_debug/add_host
-num_host=$(cat /sys/bus/pseudo/drivers/scsi_debug/add_host)
-if [ $num_host -ne 2 ];
-then
-	echo "The new host was not added - add host error"
-else
-	echo "The new host was added successfully"
-fi
-
-echo "Romove hosts..."
-echo -2 > /sys/bus/pseudo/drivers/scsi_debug/add_host
-num_host=$(cat /sys/bus/pseudo/drivers/scsi_debug/add_host)
-if [ $num_host -ne 0 ];
-then
-        echo "The hosts were not removed - remove hosts error"
-else
-	echo "The hosts were removed successfully"
-fi
-
-echo "Unload scsi_debug moudle..."
-rmmod -f scsi_debug
-lsmod | grep scsi_debug > /dev/null 2>&1
-if [ $? -eq 0 ];
-then
-        echo "The scsi_debug module was not unloaded - unload error"
-else
-        echo "The scsi_debug module was unloaded successfully"
-fi
-
-echo "Load scsi_debug with multiple hosts..."
-modprobe scsi_debug max_luns=2 num_tgts=2 add_host=2 dev_size_mb=20
-lsmod | grep scsi_debug > /dev/null 2>&1
-if [ $? -eq 0 ];
-then
-        echo "The multiple scsi_debug modules were loaded successfully"
-else
-        echo "The multiple scsi_debug modules were not loaded - load error"
-fi
-
-echo "Check if modules were loaded as required by premeters..."
-max_luns=$(cat /sys/bus/pseudo/drivers/scsi_debug/max_luns)
-add_host=$(cat /sys/bus/pseudo/drivers/scsi_debug/add_host)
-num_tgts=$(cat /sys/bus/pseudo/drivers/scsi_debug/num_tgts)
-# echo "max_lunx is $max_luns"
-# echo "add_host is $add_host"
-# echo "num_tgts is $num_tgts"
-
-premeter_err_ct=0;
-
-if [ $max_luns -ne 2 ];
-then
-	echo "max_luns was not correct"
-	premeter_err_ct=$premeter_err_ct+1;
-fi
-if [ $add_host -ne 2 ];
-then
-        echo "add_host was not correct"
-	premeter_err_ct=$premeter_err_ct+1;
-fi
-if [ $num_tgts -ne 2 ];
-then
-        echo "num_tgts was not correct"
-	premeter_err_ct=$premeter_err_ct+1;
-fi
-if [ $premeter_err_ct -eq 0 ];
-then
-	echo "multiple scsi_debug was loaded as required premeters"
-else
-	echo "multip.e scsi_debug was not loaded as required premeters"
-fi
-echo "scsi_debug first part of test has been done."
-
-echo "Now we are doing fs test for scsi_debug driver..."
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
-# check if the newly created scsi_debug partitions are in /proc/partitions file
-check_count=$(cat /proc/partitions | wc -l)
-save_count=$(( $check_count - $orig_count ))
-if [ $save_count -lt 4 ]; then
-	echo "Not enough scsi_debug partitions to run the test"
-	exit
-fi
-
-# Get the 4 partitions created by scsi_debug for testing
-cat /proc/partitions | awk '{print $4}' | tail -n 4 > $TMPBASE/partition-test
-echo "The 4 partitions used to run the test are:"
-part1=$(cat $TMPBASE/partition-test | tail -n 1)
-echo $part1
-part2=$(cat $TMPBASE/partition-test | head -n 3 | tail -n 1)
-echo $part2
-part3=$(cat $TMPBASE/partition-test | head -n 2 | tail -n 1)
-echo $part3
-part4=$(cat $TMPBASE/partition-test | head -n 1)
-echo $part4
-
-export PATH="${PATH}:${LTPROOT}/testcases/bin"
-
-mkdir /test                   >/dev/null 2>&1
-mkdir /test/growfiles         >/dev/null 2>&1
-mkdir /test/growfiles/ext2    >/dev/null 2>&1
-mkdir /test/growfiles/ext3    >/dev/null 2>&1
-mkdir /test/growfiles/reiser  >/dev/null 2>&1
-mkdir /test/growfiles/msdos     >/dev/null 2>&1
-
-echo "----- make ext3 fs -----"
-mkfs -V -t ext3     /dev/$part1
-echo "----- make ext2 fs -----"
-mkfs -V -t ext2	    /dev/$part2
-echo "----- make reiserfs fs -----"
-mkreiserfs -f          /dev/$part3
-echo "----- make msdos fs -----"
-mkfs -V -t msdos -I     /dev/$part4
-
-echo "----- Mount partitions -----"
-mount /dev/$part1 /test/growfiles/ext3
-mount /dev/$part2 /test/growfiles/ext2
-mount /dev/$part3 /test/growfiles/reiser
-mount /dev/$part4 /test/growfiles/msdos
-
-echo "----- Running tests ----- "
-echo "The test may take about 2 hours to finish..."
-sort -R ${LTPROOT}/runtest/scsi_debug.part1 -o ${TMPBASE}/scsi_debug
-
-${LTPROOT}/bin/ltp-pan -e -S -a scsi_debug -n scsi_debug -l ${TMPBASE}/fs-scsi_debug.log -o ${TMPBASE}/fs-scsi_debug.out -f ${TMPBASE}/scsi_debug
-
-wait $!
-
-umount -v /dev/$part1
-umount -v /dev/$part2
-umount -v /dev/$part3
-umount -v /dev/$part4
-
-echo "Look into /tmp/fs-scsi_debug.log and /tmp/fs-scsi_debug.out for detail results..."
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
