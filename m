Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4533CC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:57:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F8243E937C
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:57:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AA283E936C
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:56:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D467B1401213
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:56:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6387F22AAE;
 Fri,  4 Sep 2026 08:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788512172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOhmk/oKmJv8nELaf/NAgpq6pF6XIu2W6C8l3l+QGzI=;
 b=yoo7gv2EUKTn+mWtyNa0kZt1APFGc2CBQDKbX5c90fz8Zhld9D07WA09vhVtMVa7us8+ex
 vr2it/aLnB2DmASQhZfK2SyDY5Ny0xti7TsLVzXlrwdyant9sW/7WLWkgYTDOC71RJap6U
 SYw4lOyK4xgTJ4IwXyqnIZemZ0q1Pjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788512172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOhmk/oKmJv8nELaf/NAgpq6pF6XIu2W6C8l3l+QGzI=;
 b=qG+P13jOXYLf815/GWGA4cBT5O6v+a/XUGxoRcsaU2VoxU8yl/NBHzdOH9stTcGHeNVyhs
 hrH7as97kR/PZbDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lguuqy5V;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/Or+T1fq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788512168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOhmk/oKmJv8nELaf/NAgpq6pF6XIu2W6C8l3l+QGzI=;
 b=lguuqy5V81Klia7KMzk0vF4dmkxPA8cNgElBLUF7Wdy3jmQU40QcJQUoU4qDs5hN+HSjYf
 6Q9401xLhql+9kfQEbFyjFT1nAAabokBrPdLkmdKCq9jqJZL0xjIZe9UdoKlsFnNwiAbvb
 MoM194hFNSpBF3qXT+aHdA7CdMoMRPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788512168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOhmk/oKmJv8nELaf/NAgpq6pF6XIu2W6C8l3l+QGzI=;
 b=/Or+T1fqt+4C0+atLZakF3Y2kBuhRxwPl4TWzIlZzFd3u27etpbs2KpMYBZmdrLdK8mJ5E
 /NZl0huL7o/Y+8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5EE013738;
 Fri,  4 Sep 2026 08:56:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MIMZM6eHmmqraAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 04 Sep 2026 08:56:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  4 Sep 2026 10:55:53 +0200
Message-ID: <20260904085555.1202288-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904085555.1202288-1-pvorel@suse.cz>
References: <20260904085555.1202288-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6387F22AAE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.com:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 R_RATELIMIT(0.00)[to_ip_from(RLyt8qdqawmekjwcg7jeyjsbk4)];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] Remove testscripts/tpm_tools.sh
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
Cc: Tim Bird <tim.bird@sony.com>, Steffen Jaeckel <sjaeckel@suse.de>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Script was using ltp-pan (already removed), kirk should now be used.

Fixes: 5e5fd4a1ae ("pan: Remove")
Reported-by: Steffen Jaeckel <sjaeckel@suse.de>
Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>
Acked-by: Avinesh Kumar <avinesh.kumar@suse.com>
Acked-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v1.

 testscripts/tpm_tools.sh | 173 ---------------------------------------
 1 file changed, 173 deletions(-)
 delete mode 100755 testscripts/tpm_tools.sh

diff --git a/testscripts/tpm_tools.sh b/testscripts/tpm_tools.sh
deleted file mode 100755
index bf42b14728..0000000000
--- a/testscripts/tpm_tools.sh
+++ /dev/null
@@ -1,173 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2005
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-# test_tpm_tools.sh - Run the tpm-tools test suite.
-
-# Must be root to run the testsuite
-#if [ $UID != 0 ]
-#then
-#	echo "FAILED: Must be root to execute this script"
-#	exit 1
-#fi
-
-# Set the LTPROOT directory
-cd `dirname $0`
-export LTPROOT=${PWD}
-echo $LTPROOT | grep testscripts > /dev/null 2>&1
-if [ $? -eq 0 ]
-then
-	cd ..
-	export LTPROOT=${PWD}
-fi
-
-# Set the PATH to include testcase/bin
-# and the sbin directories
-export LTPBIN=$LTPROOT/testcases/bin
-export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin:$LTPBIN
-
-# We will store the logfiles in $LTPROOT/results, so make sure
-# it exists.
-if [ ! -d $LTPROOT/results ]
-then
-	mkdir $LTPROOT/results
-fi
-
-# Check for programs/daemons/groups...
-USER="`whoami`"
-RC=0
-if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-then
-	LTPTMP="/tmp"
-else
-	LTPTMP="$TMPBASE"
-fi
-export TPM_TMPFILE="$LTPTMP/tst_tpm.err"
-rm -f $TPM_TMPFILE 1>/dev/null 2>&1
-
-# Check for the expect command
-rm -f $TPM_TMPFILE 1>/dev/null 2>&1
-which expect 1>$TPM_TMPFILE 2>&1
-if [ $? -ne 0 ]
-then
-	echo "The 'expect' command is not available.  Be sure the expect package has been installed properly"
-	RC=1
-fi
-
-# Check for TrouSerS and that it is running
-rm -f $TPM_TMPFILE 1>/dev/null 2>&1
-which tcsd 1>$TPM_TMPFILE 2>&1
-if [ $? -ne 0 ]
-then
-	echo "The trousers TSS stack is not available.  Be sure trousers has been installed properly"
-	if [ -f $TPM_TMPFILE ]
-	then
-		cat $TPM_TMPFILE
-	fi
-	RC=1
-else
-	rm -f $TPM_TMPFILE 1>/dev/null 2>&1
-	ps -ef 1>$TPM_TMPFILE
-	grep tcsd $TPM_TMPFILE 1>/dev/null
-	if [ $? -ne 0 ]
-	then
-		echo "The trousers TSS stack is not running.  Be sure to start the trousers daemon (tcsd)"
-		RC=1
-	fi
-fi
-
-# Make the opencryptoki testing optional
-if [ -z "$TPM_NOPKCS11" ]
-then
-
-	# Check for the pkcs11 group and that the user is a member of it
-	grep -q ^pkcs11: /etc/group
-	if [ $? -ne 0 ]
-	then
-		echo "The 'pkcs11' group does not exist.  Be sure openCryptoki has been installed properly"
-		RC=1
-	fi
-
-	groups | grep pkcs11 1>/dev/null 2>&1
-	if [ $? -ne 0 ]
-	then
-		echo "User '$USER' is not a member of the 'pkcs11' group"
-		RC=1
-	fi
-
-	# Check for openCryptoki and that it is running
-	#   Additionally, delete the user's TPM token data store.
-	rm -f $TPM_TMPFILE 1>/dev/null 2>&1
-	which pkcsslotd 1>$TPM_TMPFILE 2>&1
-	if [ $? -ne 0 ]
-	then
-		echo "The openCryptoki PKCS#11 slot daemon is not available.  Be sure openCryptoki has been installed properly"
-		if [ -f $TPM_TMPFILE ]
-		then
-			cat $TPM_TMPFILE
-		fi
-		RC=1
-	else
-		rm -f $TPM_TMPFILE 1>/dev/null 2>&1
-		ps -ef 1>$TPM_TMPFILE
-		grep pkcsslotd $TPM_TMPFILE 1>/dev/null
-		if [ $? -ne 0 ]
-		then
-			echo "The openCryptoki PKCS#11 slot daemon is not running.  Be sure to start the openCryptoki slot daemon (pkcsslotd)"
-			RC=1
-		else
-			P11DIR=`which pkcsslotd | sed s-/sbin/pkcsslotd--`
-			if [ "$P11DIR" = "/usr" ]
-			then
-				P11DIR=""
-			fi
-
-			grep libpkcs11_tpm $P11DIR/var/lib/opencryptoki/pk_config_data 1>/dev/null
-			if [ $? -ne 0 ]
-			then
-				echo "The TPM PKCS#11 token is not active.  Be sure openCryptoki has been installed properly"
-				RC=1
-			fi
-			if [ -d $P11DIR/var/lib/opencryptoki/tpm/$USER ]
-			then
-				rm -rf $P11DIR/var/lib/opencryptoki/tpm/$USER
-			fi
-		fi
-	fi
-fi
-
-if [ $RC -ne 0 ]
-then
-	exit 1
-fi
-
-# Set known password values
-export OWN_PWD="OWN PWD"
-export NEW_OWN_PWD="NEW OWN PWD"
-export SRK_PWD="SRK PWD"
-export NEW_SRK_PWD="NEW SRK PWD"
-export P11_SO_PWD="P11 SO PWD"
-export NEW_P11_SO_PWD="NEW P11 SO PWD"
-export P11_USER_PWD="P11 USER PWD"
-export NEW_P11_USER_PWD="NEW P11 USER PWD"
-
-echo "Running the tpm-tools testsuite..."
-$LTPROOT/bin/ltp-pan -d 5 -S -a $LTPROOT/results/tpm_tools -n ltp-tpm-tools -l $LTPROOT/results/tpm_tools.logfile -o $LTPROOT/results/tpm_tools.outfile -p -f $LTPROOT/runtest/tpm_tools
-
-echo "Done."
-exit 0
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
