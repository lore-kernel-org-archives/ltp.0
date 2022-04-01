Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B92C433F5
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 22:12:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B44E03CA2DB
	for <ltp@archiver.kernel.org>; Sat,  2 Apr 2022 00:12:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 708823C9F01
 for <ltp@lists.linux.it>; Sat,  2 Apr 2022 00:12:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36E40600720
 for <ltp@lists.linux.it>; Sat,  2 Apr 2022 00:12:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F01FE210E7;
 Fri,  1 Apr 2022 22:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648851121;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1lxDQfhZSrwErh3y1SW/Aiz4mzltKK/UH+j2q3WeLa4=;
 b=bVzpIhECugo6VgxPoX1ViHxNH8+SrNNPkL/GliKu4kmrnhbrBapJIDZWeFClKTTPLnElYW
 ogGmnQpincZK/ooQqnmVVhIn4SbMfnrliAWu7DZhY9htk+I0snnboR/dOHKmjn7jumdz9h
 scSCeYuT26jispH6hzw4XHMbR6owc/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648851121;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1lxDQfhZSrwErh3y1SW/Aiz4mzltKK/UH+j2q3WeLa4=;
 b=MUFtwgu6tUMwGML8XTwd26Io4uk1hEkO+QyBmidC8kubhhxraSBC2FSqNa8oNUA51HMGlX
 w4I9KVsaePtjRNCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4258D132C1;
 Fri,  1 Apr 2022 22:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Dd6oDLF4R2JOLgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 01 Apr 2022 22:12:01 +0000
Date: Sat, 2 Apr 2022 00:11:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Ykd4qtgdNGNn0RXe@pevik>
References: <20220401215951.13976-1-pvorel@suse.cz>
 <20220401215951.13976-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220401215951.13976-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test.sh: Cleanup getopts usage
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

patch needs to be slightly adjusted: to fix tst_ipaddr_un.sh
which uses $TST_NET_SKIP_VARIABLE_INIT, so that shell library needs to be loaded
before.

(NOTE also netns tests are planning [1] to use $TST_NET_SKIP_VARIABLE_INIT
- I'll repost rebased patch after this is merged).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20220204194648.32165-4-pvorel@suse.cz/

diff --git testcases/lib/tst_net.sh testcases/lib/tst_net.sh
index 2ca9bea492..dae0ceaf1f 100644
--- testcases/lib/tst_net.sh
+++ testcases/lib/tst_net.sh
@@ -935,6 +935,7 @@ tst_default_max_pkt()
 	echo "$((mtu + mtu / 10))"
 }
 
+[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
 [ -n "$TST_PRINT_HELP" -o -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
 
 # Management Link
@@ -973,7 +974,6 @@ if [ -z "$_tst_net_parse_variables" ]; then
 	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
 fi
 
-[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
 [ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
 
 if [ -z "$_tst_net_parse_variables" ]; then

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
