Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EDEE7E62F
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 12:47:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEC4C3C9981
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 14:47:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEDE13CE1CB
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 14:46:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EB77920175D
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 14:46:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA0401F86A;
 Tue, 26 Sep 2023 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695732416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xcogh4b7/8hl7oWlyfBpkZdVGoLUIlXSI4u0AfJCLos=;
 b=Hno2Szowr/mq/bazZVe6YQ+waz6XOMkpd+momhaJPUKjR1RmzfI4pnV3uNO7TL8TDM6psX
 u3uhx/heAQTK0dGGudETynBJpypqZ3gp18gu2WrnL5S0tNPoy/EZCAAaSSbFs/M4Fphjfm
 ae9u8OJ5phr0ah6XWLE4LZATH+JF5+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695732416;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xcogh4b7/8hl7oWlyfBpkZdVGoLUIlXSI4u0AfJCLos=;
 b=BH3QDn58vF1+J9QmQi6v7RfZvrJzDUWFwl6tyEViFsnGvibmcNXPR+arYKH7kMNrfOobJa
 c7oSsqjsqHk7vRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90F4F13434;
 Tue, 26 Sep 2023 12:46:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UBTjIcDSEmXxHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Sep 2023 12:46:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 Sep 2023 14:46:46 +0200
Message-Id: <20230926124647.152972-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926124647.152972-1-pvorel@suse.cz>
References: <20230926124647.152972-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] vma05.sh: Add workaround for gdb debuginfod
 question
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

gdb asks if $DEBUGINFOD_URLS is set and there is no 'set debuginfod enabled on|off'
config in ~/.gdbinit:

    # echo $DEBUGINFOD_URLS
    https://debuginfod.opensuse.org/

    # grep 'set debuginfod enabled' ~/.gdbinit
    grep: /root/.gdbinit: No such file or directory

    # gdb -silent -ex="thread apply all backtrace" -ex="quit" vma05_vdso ./core*
    Segmentation fault (core dumped)
    Reading symbols from vma05_vdso...
    [New LWP 6070]

    This GDB supports auto-downloading debuginfo from the following URLs:
      <https://debuginfod.opensuse.org/>
    Enable debuginfod for this session? (y or [n])

Therefore disable this question with unsetting $DEBUGINFOD_URLS.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
A candidate for pre-release fix.

Kind regards,
Petr

 testcases/kernel/mem/vma/vma05.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index 9ef6f0a23..c9e4becdb 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -30,6 +30,7 @@ setup()
 {
 	ulimit -c unlimited
 	echo "core" > /proc/sys/kernel/core_pattern
+	unset DEBUGINFOD_URLS
 }
 
 cleanup()
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
