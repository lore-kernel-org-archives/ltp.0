Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEB7C27C5F
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 14:25:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 525743D0AA5
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 16:25:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F1FA3CFBD1
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:24:32 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D0FE1BBD888
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:24:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 57CEB21B5A;
 Fri,  7 Jun 2024 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717770270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNNnwvwUAA2omJGuQChUf0zOj3nz+LfGd0hnoz9OgPI=;
 b=n6d/8CCqQIlVef0NF/lk547nFFzmIlT+nrXxWjpM4upS2/1bObAsIU8/6JHR+XBg/oPD01
 GZJP99ctSmzgKnxuqqQuP+mjoaVqHlNsXbSJyZfqeNkMTvezJtkBk2jy87H5GQmJhaDn5b
 baFls2cjk6tgtPkyXbSRJ+vEi3TaCGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717770270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNNnwvwUAA2omJGuQChUf0zOj3nz+LfGd0hnoz9OgPI=;
 b=cLr4+/4Ga1Vvn4+e+y1B9twjlo1aFfaQlHAf0Iri0vUcUefv6dlUwIR8N/Khv/NMse86OK
 KtyVFSXaUe3wryDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="n6d/8CCq";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="cLr4+/4G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717770270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNNnwvwUAA2omJGuQChUf0zOj3nz+LfGd0hnoz9OgPI=;
 b=n6d/8CCqQIlVef0NF/lk547nFFzmIlT+nrXxWjpM4upS2/1bObAsIU8/6JHR+XBg/oPD01
 GZJP99ctSmzgKnxuqqQuP+mjoaVqHlNsXbSJyZfqeNkMTvezJtkBk2jy87H5GQmJhaDn5b
 baFls2cjk6tgtPkyXbSRJ+vEi3TaCGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717770270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNNnwvwUAA2omJGuQChUf0zOj3nz+LfGd0hnoz9OgPI=;
 b=cLr4+/4Ga1Vvn4+e+y1B9twjlo1aFfaQlHAf0Iri0vUcUefv6dlUwIR8N/Khv/NMse86OK
 KtyVFSXaUe3wryDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B38D13A79;
 Fri,  7 Jun 2024 14:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2P8CAh4YY2a0CAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jun 2024 14:24:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Jun 2024 16:24:22 +0200
Message-ID: <20240607142423.116285-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607142423.116285-1-pvorel@suse.cz>
References: <20240607142423.116285-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 57CEB21B5A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 2/3] ltpmenu: Remove legacy script
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile |   6 -
 ltpmenu  | 548 -------------------------------------------------------
 2 files changed, 554 deletions(-)
 delete mode 100755 ltpmenu

diff --git a/Makefile b/Makefile
index d7d2815f1..ae0247761 100644
--- a/Makefile
+++ b/Makefile
@@ -210,9 +210,3 @@ test-metadata: metadata-all
 help:
 	@echo "Please read the Configuration section in $(top_srcdir)/INSTALL"
 	@exit 1
-
-## Menuconfig
-menuconfig:
-	@$(SHELL) "$(top_srcdir)/ltpmenu"
-
-## End misc targets.
diff --git a/ltpmenu b/ltpmenu
deleted file mode 100755
index 38d38c0cd..000000000
--- a/ltpmenu
+++ /dev/null
@@ -1,548 +0,0 @@
-#!/bin/bash
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
-#
-# File:        runltp
-#
-# Description: This program is a Graphical User Interface (GUI)
-#              Control Centre for LTP. The Control Centre provides
-#              functionality to Compile, Execute and View Results of
-#              LTP test cases.
-#
-# Author:      Manoj Iyer - manjo@mail.utexas.edu
-#
-# Thanks:      Jim Choate - For suggesting the use of dialog command.
-#
-# History:     March 26 2003 - Created.
-#
-#	       March 28 2003 - Removed gauges and put make commands in foreground.
-#	                     Robbie Williamson - robbiew@us.ibm.com
-#
-#	       March 31 2003 - Made scenario menu creation dynamic and code
-#                              to pull the test descriptions from the scenario files.
-#                            Robbie Williamson - robbiew@us.ibm.com
-#
-#	       April 17 2003 - Added menu selection to list contents of selected
-#			       scenario file.
-#			     Robbie Williamson - robbiew@us.ibm.com
-#
-#	       April 23 2003 - Added PID to results filename.
-#			     - Added code to allow users to redirect output and
-#                              specify test execution duration.
-#			     Robbie Williamson - robbiew@us.ibm.com
-#
-#	       April 30, 2003 - Recoded results display to allow selection
-#				of results file.
-#			      - Created variable to hold results filename
-#		 	      - Added time to results filename.
-# Function:    cleanup
-#
-# Description: Remove all temporary files created by this program. Cleanup
-#              always called on program exit.
-#
-# Input:       NONE
-#
-# Output:      NONE
-cleanup()
-{
-    rm -f /tmp/runltp.*
-}
-
-
-# Function:    display_info_msg
-#
-# Description: Displays informational messages window. This window may
-#              may be used to display information like errors, instructions
-#              etc to the user. The window is dismissed when the user hits
-#              the [ENTER] key.
-#
-# Input:       $1 - Title the needs to be displayed on the window.
-#                   eg: ERROR: Compiling LTP
-#              $2 - Message text.
-#
-# Output:      Information message window.
-display_info_msg()
-{
-    dialog --backtitle "Linux Test Project Control Centre" \
-           --title " $1 " \
-           --msgbox " $2 " 10 70
-    return $?
-}
-
-
-# Function:    compile_ltp
-#
-# Description: Checks for commands that are pre-reqs for compiling and
-#              installing LTP. It displays a confirmation window inorder to
-#              confirm the choice made by the user.
-#
-# Calls:       do_make_clean()
-#              do_make()
-#              do_make_install()
-#
-# Input:       NONE
-#
-# Output:      Confirmation window.
-compile_ltp()
-{
-    dialog --backtitle "Linux Test Project Control Centre" \
-           --title "Compiling LTP testsuite"\
-           --yesno "This will compile all the test cases in\
-                    LTP test suite and place the executables\
-                    in testcases/bin directory. Do\
-                    you wish to continue ??" 7 70 || RC=$?
-    case $RC in
-        0) \
-            for cmd in cc make lex ;
-            do \
-                which $cmd >/tmp/runltp.err.$$ 2>&1 ;
-                if [ $? -ne 0 ] ;
-                    then \
-                        display_info_msg "Compiling LTP testsuite" \
-                                 "ERROR: command $cmd not found, $cmd is\
-                                  required to compile LTP test cases. Please\
-                                  install $cmd or export PATH correctly before\
-                                  running this program" ;
-                    return ;
-                fi ;
-            done ;
-            make clean;
-	    if [ $? -ne 0 ];then
-              echo "ERROR in \'make clean\' - exiting."
-	      exit
-	    fi
-            make ;
-	    if [ $? -ne 0 ];then
-              echo "ERROR in \'make all\' - exiting."
-	      exit
-	    fi
-            make install ;
-	    if [ $? -ne 0 ];then
-              echo "ERROR in \'make install\' - exiting."
-	      exit
-	    fi
-            return ;;
-
-        1)  return ;;
-
-        255) return ;;
-    esac
-}
-
-
-# Function:    disp_ltpres
-#
-# Description: The results generated after the ltp execution located under
-#              ltp-mmddyy/results/ directory in a text (ASCII) file called
-#              results.todaysdate. This function displays this file in a
-#              window. If the results file does not exit it displays an
-#              info message window notifing the user that LTP test cases
-#              need to be executed inorder to view results.
-#
-# Input:       ltp-mmddyy/results/results.todaysdate.time
-#
-# Output:      Window displaying results of testcases that were executed.
-disp_ltpres()
-{
-    RC=0
-
-    RESULTS_LIST=$(for i in `ls -1 -A -I "CVS" results`;do echo -n "$i [more...] "; done)
-    if ! [ -z $RESULTS_LIST ] ;then
-      while [ $RC -ne "1" ]
-      do
-        dialog --clear
-        dialog --backtitle "Linux Test Project Control Centre" \
-               --title "LTP Test Results" \
-               --menu "Move using[UP] [DOWN], Select using [ENTER]" 15 70 8 \
-                      $RESULTS_LIST \
-                      2>/tmp/runltp.results.$$ || RC=$?
-        results_item=$(cat /tmp/runltp.results.$$)
-        if ! [ -z $results_item ];then
-          dialog --clear
-          dialog --backtitle "Linux Test Project Control Centre" \
-                 --title "LTP Test Results" \
-                 --textbox results/$results_item 17 70
-
-          dialog --backtitle "Linux Test Project Control Centre" \
-                 --title "LTP Test Results." \
-                 --yesno "Would you like to share these results with the LTP \
-                          community by posting it to the LTP results mailing list?" \
-                          7 70 || RESPONSE=$?
-          case $RESPONSE in
-              0) \
-                  mail ltp-results@lists.sourceforge.net < \
-                          ./results/$results_item ;
-                  ;;
-
-              1)  ;;
-
-              255)  ;;
-          esac
-        fi
-      done
-    else
-      dialog --clear
-      dialog --backtitle "Linux Test Project Control Centre" \
-             --title "LTP Test Results" \
-             --msgbox "ERROR: No files to view in /results directory." 5 53
-    fi
-    return
-}
-
-
-# Function:    flags_prompt
-#
-# Description: Prompt for and record user options for run duration and
-#	       test output direction
-#
-# Input:       none
-#
-# Output:      none
-flags_prompt()
-{
-    dialog --backtitle "Linux Test Project Control Centre"\
-           --title "Output Direction" --clear\
-	   --yesno "Would you like test output recorded to a file, instead of STDOUT?" 7 80
-    RC=$?
-    if [ $RC -eq "0" ]
-    then
-	dialog --backtitle "Linux Test Project Control Centre"\
-               --title "Output Direction" --clear\
-               --inputbox " Please enter the full path and \
-                            name of the file where you wish \
-                            to redirect output to" 17 80 \
-                          2>/tmp/runltp.outdir.$$ ;
-        flags_outfile=$(cat /tmp/runltp.outdir.$$ | awk '{print $1}')
-        ./ver_linux > $flags_outfile 2>&1
-	RUNALL_FLAGS=" -o $flags_outfile"
-    fi
-
-    dialog --backtitle "Linux Test Project Control Centre"\
-           --title "Test Duration" --clear\
-	   --yesno "Would you like to specify test duration? \
-                    Default is the length of one loop." 7 80
-    RC=$?
-    if [ $RC -eq "0" ]
-    then
-	dialog --backtitle "Linux Test Project Control Centre"\
-	       --title "Test Duration - Interval Selection" --clear\
-               --menu "Move using[UP] [DOWN], Select using [ENTER]" 15 70 4 \
-                       s    "Seconds" \
-                       m    "Minutes" \
-                       h    "Hours" \
-                       d    "Days" \
-                  2>/tmp/runltp.interval.$$ ;
-	flags_interval=$(cat /tmp/runltp.interval.$$ | awk '{print $1}')
-	case $flags_interval in
-                s)	INTERVAL="seconds" ;;
-                m)      INTERVAL="minutes" ;;
-                h)      INTERVAL="hours"   ;;
-                d)      INTERVAL="days"    ;;
-        esac
-
-	echo $INTERVAL
-	WINDOW_MSG="Please enter the number of $INTERVAL to run"
-	dialog --backtitle "Linux Test Project Control Centre"\
-               --title "Test Duration - Length Specification" --clear\
-               --inputbox "$WINDOW_MSG" 7 80 \
-		          2>/tmp/runltp.length.$$ ;
-	flags_length=$(cat /tmp/runltp.length.$$ | awk '{print $1}')
-        flags_duration="$flags_length$flags_interval"
-	RUNALL_FLAGS=" $RUNALL_FLAGS -t $flags_duration"
-    fi
-}
-
-# Function:    exectest_screenout
-#
-# Description: Execute tests by calling runltp, display test status
-#              in a window.
-#
-# Input:       none
-#
-# Output:      messages printed by testcases.
-exectest_screenout()
-{
-    RC=0    # setting return code to 0, to loop in while
-
-    RESULTS_FILE=$(date +%Y-%m-%d.%H.%M.%S).$$
-
-    # execute runltp with user defined command file.
-    ./runltp -q -p $RUNALL_FLAGS -l results.$RESULTS_FILE \
-	-f /tmp/runltp.test.list.$$
-
-    sleep 2
-
-    return
-}
-
-
-# Function:    execute_ltp
-#
-# Description: This function provides a menu of testcases that can be
-#              selected for execution. If networking tests are selected,
-#              they require a remote machine and remote machines root
-#              users password. The user will be prompted to enter this
-#              information in a text box.
-#              The function checks to see if the ltp-mmddyy/testcases/bin
-#              directory was created, this directory is created when the
-#              testcases are compiled and installed, if it is not found
-#              an info message window will notify the user that LTP needs to
-#              be compiled before tests can be executed.
-#              This function creates the senatrio file based on the users
-#              choice of testcases and uses the runltp script to
-#              execute these tests.
-#              The messages printed by the testcases are displayed on this
-#              terminal.
-#
-# Input:       Users selection of testcases; scenario file.
-#
-# Output:      Test selection window, Message window,
-#              information message window
-execute_ltp()
-{
-    RC=0
-    host_name=" "
-    rhost_passwd=" "
-    run_net_test=" "
-
-    if ! [ -d ./testcases/bin ]
-    then
-	display_info_msg "Executing LTP testcases" \
-	    "The testcases must to be compiled inorder\
-       to execute them. Returning to main menu. \
-       Please select the Compile option."
-	return
-    fi
-
-    LIST=$(for i in `ls -1 -A -I "CVS" runtest`; do echo -n "$i "; j=$(head -n1 runtest/$i | cut -d: -f2|sed s/" "/_/g); echo -n "$j off "; done)
-    dialog --backtitle "Linux Test Project Control Centre"\
-           --title "Execute LTP" --clear\
-           --checklist "Select [SPACEBAR] tests to run" 20 80 5 \
-    	    $LIST \
-            2>/tmp/runltp.choice.$$ || RC=$?
-    size=`wc -m /tmp/runltp.choice.$$|awk '{print $1}'`
-    if [ $size -eq 0 ];then
-      tst_choice=$(echo "NULL")
-    else
-      tst_choice=$(cat /tmp/runltp.choice.$$)
-    fi
-    if [[ $tst_choice == NULL ]];then
-      RC=1
-    fi
-    case $RC in
-        0)    \
-            for i in $tst_choice ;
-            do \
-                cat ./runtest/$(echo $i | sed -e 's/"//g') \
-                   >> /tmp/runltp.test.list.$$ ;
-                if [[ $(echo $i | sed -e 's/"//g') == "tcp_cmds" || \
-		      $(echo $i | sed -e 's/"//g') == "tcp_cmds_noexpect" || \
-                      $(echo $i | sed -e 's/"//g') == "multicast" || \
-                      $(echo $i | sed -e 's/"//g') == "ipv6" || \
-                      $(echo $i | sed -e 's/"//g') == "ipv6_noexpect" || \
-                      $(echo $i | sed -e 's/"//g') == "nfs" || \
-                      $(echo $i | sed -e 's/"//g') == "multicast" ]] ;
-                then \
-                    run_net_test="Y" ;
-                fi ;
-
-            done ;
-            if ! [ -z $run_net_test ] ;
-            then \
-                dialog --backtitle "Linux Test Project Control Centre"\
-                       --title "Execute LTP test cases" \
-                       --clear \
-                       --inputbox "You have chosen to execute testcases \
-                                  that require a Remote Machine. \
-                                  Please enter the fully qualified host \
-                                  name" 17 80 $(hostname --long) \
-                                  2>/tmp/runltp.out.$$ ;
-                host_name=$(cat /tmp/runltp.out.$$ | awk '{print $1}') ;
-                unset $RHOST ;
-                RHOST=$host_name ;
-                export RHOST;
-
-                dialog --backtitle "Linux Test Project Control Centre"\
-                       --title "Execute LTP test cases" \
-                       --clear \
-                       --inputbox " Please enter the root password \
-                                     of this remote machine" 17 80 \
-                        2>/tmp/runltp.out.$$ ;
-                rhost_passwd=$(cat /tmp/runltp.out.$$ | awk '{print $1}') ;
-
-                PASSWD=$rhost_passwd ;
-                export PASSWD;
-            fi ;
-
-            if ! [ -d ./testcases/bin ] ;
-            then \
-                display_info_msg "Executing LTP testcases" \
-                    "The testcases must to be compiled inorder\
-                     to execute them. Returning to main menu. \
-                     Please select the Compile option." ;
-                return ;
-            fi ;
-
-            dialog --clear ;
-
-	    flags_prompt ;
-
-            exectest_screenout ;
-
-            return ;;
-        1)    \
-            # echo "Cancel pressed" ;
-            return ;;
-        255)    \
-            # echo "ESC pressed" ;
-            return ;;
-    esac
-}
-
-
-# Function:    about_ltpcc
-#
-# Description: This function displays a window containing a brief message
-#              describing this programs functionality, and credits the author.
-#
-# Input:       NONE
-#
-# Output:      Message window, description of LTP Control Center.
-about_ltpcc()
-{
-    display_info_msg "About LTP Control Centre" \
-                     "The LTP Control Centre can be used to\
-                     to compile, install and execute\
-                     The Linux Test Project test suite. Written by\
-                     Manoj Iyer <manjo@mail.utexas.edu>"
-    return
-}
-
-
-# Function:    ltp_scenarios
-#
-# Description: This function displays a list of scenario files located
-#              in /runtest.  Users can list the contents of each file.
-#
-# Input:       Files from /runtest
-#
-# Output:      1) Menu selection containing each file as an option to list.
-#              2) Contents of selected scenario.
-ltp_scenarios()
-{
-
-RC=0
-SCENARIOS=$(for i in `ls -1 -A -I "CVS" runtest`;do echo -n "$i [more...] "; done)
-
-while [ $RC -ne "1" ]
-do
-  dialog --clear
-  dialog --backtitle "Linux Test Project Control Centre" \
-         --title "LTP Scenario Files" \
-         --menu "Move using[UP] [DOWN], Select using [ENTER]" 15 70 8 \
-                $SCENARIOS \
-                2>/tmp/runltp.scenario.$$ || RC=$?
-  scenario_item=$(cat /tmp/runltp.scenario.$$)
-  if ! [ -z $scenario_item ];then
-    dialog --clear
-    dialog --backtitle "Linux Test Project Control Centre" \
-           --title "LTP Scenario Files" \
-           --textbox runtest/$scenario_item 17 70
-  fi
-done
-}
-
-
-
-# Function:    main
-#
-# Description: Displays the main menu to the LTP Control Centre. The menu
-#              provides options to Compile, Execute, and View test execution
-#              results.
-#
-# Calls:       about_ltpcc()
-#              compile_ltp()
-#              execute_ltp()
-#              disp_ltpres()
-#
-# Input:       NONE
-#
-# Output:      Menu selection of actions to perform.
-
-# Global variables.
-RC=0              # return code from commands and local functions
-mmenu_item=" "
-RHOST=" "
-PASSWD=" "
-RUNALL_FLAGS=" "
-RESULTS_FILE=" "
-
-# test for dialog program exist
-if [ ! -x /usr/bin/dialog ]; then
-       echo "Sorry, ltpmenu GUI not available, can't find dialog. Exiting...";
-       exit 1;
-fi
-
-# call cleanup function on program exit.
-trap "cleanup" 0
-
-
-# wait in a loop until user hits [Cancel] button on the main menu.
-while :
-do
-    RC=0
-    dialog --clear
-    dialog --backtitle "Linux Test Project Control Centre" \
-           --title "Main Menu" \
-           --menu "Move using[UP] [DOWN], Select using [ENTER]" 15 70 5 \
-                  About        "About LTP Control Centre" \
-                  Compile      "Compile LTP testsuite" \
-		  Details      "Details of scenario files" \
-                  Execute      "Execute LTP testsuite" \
-                  Results      "Display a summary of test results" \
-                  2>/tmp/runltp.mainmenu.$$ || RC=$?
-
-    case $RC in
-        0) mmenu_item=`cat /tmp/runltp.mainmenu.$$` ;
-           # echo "return code = $RC" ;
-           # echo "MENU ITEM = $mmenu_item" ;
-           case $mmenu_item in
-                About)        about_ltpcc    ;;
-                Compile)      compile_ltp    ;;
-		Details)      ltp_scenarios  ;;
-                Execute)      execute_ltp    ;;
-                Results)      disp_ltpres    ;;
-           esac ;;
-
-        1) display_info_msg "Good Bye!" \
-                            "Thank you for using Linux Test Project test suite.\
-                             Please visit our project website \
-                             http://ltp.sourceforge.net \
-                             for latest news on The Linux Test Project. "
-           exit ;;
-
-        255) display_info_msg "Good Bye!" \
-                            "Thank you for using Linux Test Project test suite.\
-                             Please visit our project website\
-                             http://ltp.sourceforge.net for latest news\
-                             on The Linux Test Project. "
-            exit;;
-    esac
-done
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
