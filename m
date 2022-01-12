Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FF4C433F5
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 13:07:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 856623C94FE
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 14:07:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CF263C8BBB
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 14:06:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E796A200274
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 14:06:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF3451F385;
 Wed, 12 Jan 2022 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641992811;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0D7iElc2KBU4F3mP8SKPzfDB41mMoY/kXSh/x1Pnzy8=;
 b=UsNnxGAeV0fwkDNUYiW7BW27V2BxPImo6KrmWXhl70oPDX0PnKuw53++kLnram5e+ji2sK
 9/q0HV+iFRRDqrkOZ9zQkKK6GqWZkFEsw0uwmhKGLFPOWZEDxMVECEez49M/vn4KX6HZcQ
 tVHroNE+M5gAZy/1qZokn3nMhdAl+lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641992811;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0D7iElc2KBU4F3mP8SKPzfDB41mMoY/kXSh/x1Pnzy8=;
 b=pw0THi05QwDNihuOTbytvxfEvxp0BbxqJcp9HW1EyJMpbF/2EBv95Q0iIBgLZA1X+TU2kJ
 NvwBE9/IvV4zYlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75F5013B61;
 Wed, 12 Jan 2022 13:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ARgCG2vS3mEDTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 12 Jan 2022 13:06:51 +0000
Date: Wed, 12 Jan 2022 14:06:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Yd7SaS2TIaUrlcIN@pevik>
References: <20211006103059.9617-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211006103059.9617-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 0/3] IMA: Add tests for uid, gid, fowner,
 and fgroup options
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
Cc: alexhenrie24@gmail.com, linux-integrity@vger.kernel.org,
 Alex Henrie <alexh@vpitech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

FYI patchset merged with diff below. Fixed
* "cat: '>': No such file or directory" error reported by Mimi
* use /proc/uptime to not require date

Thanks for your work and patience.

FYI we had some discussion about merging patches earlier - after they met rc1 or
next-tree (I guess getting into maintainer tree could be accepted). Feel free to
contribute to this discussion:

https://lore.kernel.org/ltp/20211221113042.21357-1-rpalethorpe@suse.com/
https://lore.kernel.org/ltp/87lf0ffw1y.fsf@suse.de/
https://lore.kernel.org/ltp/YdW5WEXgrotentzM@yuki/

Kind regards,
Petr

diff --git testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index c83006f6d1..095028e163 100755
--- testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -5,8 +5,11 @@
 # Author: Alex Henrie <alexh@vpitech.com>
 #
 # Verify that conditional rules work.
+#
+# gid and fgroup options test kernel commit 40224c41661b ("ima: add gid
+# support") from v5.16.
 
-TST_NEEDS_CMDS="chgrp chown id sg sudo"
+TST_NEEDS_CMDS="cat chgrp chown id sg sudo"
 TST_CNT=1
 TST_NEEDS_DEVICE=1
 
@@ -28,16 +31,16 @@ verify_measurement()
 
 	tst_res TINFO "verify measuring user files when requested via $request"
 	ROD echo "measure $request=$value" \> $IMA_POLICY
-	ROD echo "$(date) $request test" \> $test_file
+	ROD echo "$(cat /proc/uptime) $request test" \> $test_file
 
 	case "$request" in
 	fgroup)
 		chgrp $user $test_file
-		$cmd
+		sh -c "$cmd"
 		;;
 	fowner)
 		chown $user $test_file
-		$cmd
+		sh -c "$cmd"
 		;;
 	gid) sudo sg $user "sh -c '$cmd'";;
 	uid) sudo -n -u $user sh -c "$cmd";;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
