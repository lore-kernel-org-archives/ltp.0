Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF605C369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 08:57:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B9C43CBB40
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 10:57:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E00223CBB40
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 10:56:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A5181A0092D
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 10:56:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8CEA21195;
 Wed, 30 Apr 2025 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746003411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0rQOElz8ezvwVRKeDeOmEXuDmg3UXIxxw7xwgOxn0wM=;
 b=s86qYmGtUNr/tFkvnRnihHDeCwKbxph16jXfRiaH8NWBCxNbT6xtj8swW+9ktAr+be/bIR
 9UVx1am62lqIZHl2ADu58JuI7zcRMIaCfIpBO2oJ6Yv6ZCfsZ13GQjLwDBC1zbFJ/u0h2z
 HC+tO++yiT1j15BF2JsdN2ITeyAhs2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746003411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0rQOElz8ezvwVRKeDeOmEXuDmg3UXIxxw7xwgOxn0wM=;
 b=qI0JjsaVl4AJ44Ctc0uvKPCyd9t10S7RY/wrsQWMXYa2iOPWgHemaFQasK+fUA8y7bUy8b
 p26P2ZswCHhhz/Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746003411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0rQOElz8ezvwVRKeDeOmEXuDmg3UXIxxw7xwgOxn0wM=;
 b=s86qYmGtUNr/tFkvnRnihHDeCwKbxph16jXfRiaH8NWBCxNbT6xtj8swW+9ktAr+be/bIR
 9UVx1am62lqIZHl2ADu58JuI7zcRMIaCfIpBO2oJ6Yv6ZCfsZ13GQjLwDBC1zbFJ/u0h2z
 HC+tO++yiT1j15BF2JsdN2ITeyAhs2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746003411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0rQOElz8ezvwVRKeDeOmEXuDmg3UXIxxw7xwgOxn0wM=;
 b=qI0JjsaVl4AJ44Ctc0uvKPCyd9t10S7RY/wrsQWMXYa2iOPWgHemaFQasK+fUA8y7bUy8b
 p26P2ZswCHhhz/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAA2C13A25;
 Wed, 30 Apr 2025 08:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mNaiKNPlEWh5GQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 30 Apr 2025 08:56:51 +0000
Date: Wed, 30 Apr 2025 10:57:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aBHl-Rqg1QFe8tjw@yuki.lan>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-5-pvorel@suse.cz>
 <Z8shfrkfVkwsCOTw@yuki.lan> <20250425183345.GA79209@pevik>
 <aBHkswcLfiC7sXSz@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aBHkswcLfiC7sXSz@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 4/5] shell lib: Add basic support for test
 cleanup
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
And one possible solution is to source the environment first and the
loader last, on the top of your shell-loader-setup-cleanup.v2 branch:

diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
index eeed122c1..01acf6d35 100755
--- a/testcases/lib/tests/shell_loader.sh
+++ b/testcases/lib/tests/shell_loader.sh
@@ -14,6 +14,8 @@
 # }
 # ---

+. tst_env.sh
+
 tst_test()
 {
        tst_res TPASS "Shell loader works fine!"
diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
index 68f9a0daa..585790a7d 100644
--- a/testcases/lib/tst_env.sh
+++ b/testcases/lib/tst_env.sh
@@ -18,11 +18,6 @@ if [ -z "$LINENO" ]; then
        LINENO=-1
 fi

-if [ -z "$LTP_IPC_PATH" ]; then
-       echo "This script has to be executed from a LTP loader!"
-       exit 1
-fi
-
 tst_brk_()
 {
        tst_res_ "$@"


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
