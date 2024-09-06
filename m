Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF458CE7B0D
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 13:30:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A93CA3C28E8
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 15:30:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35D23C1C87
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 15:30:03 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 403391A0015C
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 15:30:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2DB781F8B5;
 Fri,  6 Sep 2024 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725629400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJ/3vIpwH5EJkoCQ4SLsiBDbW78ioiRxiKItcwquTok=;
 b=haYzZq/2bDfHhJ2j6SiX7zNL2RTn37kV6qcEZPP0F0WTrDiQvuwhe/swQJd7iv/hC1SjgU
 5p5xy1XUHixv8pAVPx2bCA/Jq8xD+tXu1pS2iDABnn39vnVRIgRLTLlTi/cSG5cJ1gNjpB
 lvuoGxrJbs0a4FI6OpAvMn5Va+WARKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725629400;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJ/3vIpwH5EJkoCQ4SLsiBDbW78ioiRxiKItcwquTok=;
 b=/yuN4xmlMARWHd1BFsoic+qWz2UCkua8lI56by50LsHHySLfaemDfYE4vndBxt0GFnQL3j
 /ifthc1Key0MQOAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="haYzZq/2";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/yuN4xml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725629400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJ/3vIpwH5EJkoCQ4SLsiBDbW78ioiRxiKItcwquTok=;
 b=haYzZq/2bDfHhJ2j6SiX7zNL2RTn37kV6qcEZPP0F0WTrDiQvuwhe/swQJd7iv/hC1SjgU
 5p5xy1XUHixv8pAVPx2bCA/Jq8xD+tXu1pS2iDABnn39vnVRIgRLTLlTi/cSG5cJ1gNjpB
 lvuoGxrJbs0a4FI6OpAvMn5Va+WARKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725629400;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJ/3vIpwH5EJkoCQ4SLsiBDbW78ioiRxiKItcwquTok=;
 b=/yuN4xmlMARWHd1BFsoic+qWz2UCkua8lI56by50LsHHySLfaemDfYE4vndBxt0GFnQL3j
 /ifthc1Key0MQOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C7EB1395F;
 Fri,  6 Sep 2024 13:30:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a5rrBdgD22YLJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Sep 2024 13:30:00 +0000
Date: Fri, 6 Sep 2024 15:28:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZtsDheQySS4co49v@yuki.lan>
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
 <CAEemH2eQQfhTfVo5xrBHFjzuf4dn=VqK2M=9Y3+hy+r8yzMtAA@mail.gmail.com>
 <ZtrRCVxNKuu5ZdHN@yuki.lan>
 <CAEemH2eHa10SCrdVrPPTWZfQFpyDZ1poFEC=BL1raQECgpjf7g@mail.gmail.com>
 <ZtrmCfp5dPTx6vk_@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZtrmCfp5dPTx6vk_@yuki.lan>
X-Rspamd-Queue-Id: 2DB781F8B5
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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
> The difference is that /bin/sh links to dash in debian. But as you
> pointed out even if all /bin/sh is changed to /bin/bash in the scripts
> the tests stil fails.
> 
> It looks like on RPi alias with variables does not work at all.

So it looks like aliases may not be expanded on non-interactive shells
unless it's enabled explicitely.

This patch uses shopt to enable that and also works around dash that
does not support $LINENO:

diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
index 67ba80744..bb0c586d7 100644
--- a/testcases/lib/tst_env.sh
+++ b/testcases/lib/tst_env.sh
@@ -6,6 +6,16 @@
 
 tst_script_name=$(basename $0)
 
+# bash does not expand aliases in non-iteractive mode, enable it
+if [ -n "$BASH_VERSION" ]; then
+       shopt -s expand_aliases
+fi
+
+# dash does not support line numbers even though this is mandated by POSIX
+if [ -z "$LINENO" ]; then
+       LINENO=-1
+fi
+
 if [ -z "$LTP_IPC_PATH" ]; then
        echo "This script has to be executed from a LTP loader!"
        exit 1


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
