Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88614C021B8
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 16:00:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 885D63C9D50
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 17:00:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A90C3C2472
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 17:00:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C215E636621
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 17:00:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2093121193;
 Wed, 26 Feb 2025 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740585637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nhRHQuhPygA2KmPhrDPUvg4AicgaObpx1MH9VQ9bG4=;
 b=ANH5GuwQpqkZyNfKzCiCdKHYbTgky7oFVF9Pxps3lk9J+a3BYpyolJEe4WrvPnjZquqYR+
 ukFI4QlPI8KqM3pK9ytYXsalt/LlxDCUNmwu8vj0XVdo0yUzikSYZymXh9ZUpUxEaEx6nN
 2A65DMxtnE0bjo2y6Tv0CZr+7ZCb8AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740585637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nhRHQuhPygA2KmPhrDPUvg4AicgaObpx1MH9VQ9bG4=;
 b=2iFHq45XmBsYz4ejTXwSuRpjYlwjyL9bNCZ9fs6h/DwnE/1mAnqCuiqWux01Kvdqnr1zsM
 9bga8HaL9NoKrsAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ANH5GuwQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2iFHq45X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740585637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nhRHQuhPygA2KmPhrDPUvg4AicgaObpx1MH9VQ9bG4=;
 b=ANH5GuwQpqkZyNfKzCiCdKHYbTgky7oFVF9Pxps3lk9J+a3BYpyolJEe4WrvPnjZquqYR+
 ukFI4QlPI8KqM3pK9ytYXsalt/LlxDCUNmwu8vj0XVdo0yUzikSYZymXh9ZUpUxEaEx6nN
 2A65DMxtnE0bjo2y6Tv0CZr+7ZCb8AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740585637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nhRHQuhPygA2KmPhrDPUvg4AicgaObpx1MH9VQ9bG4=;
 b=2iFHq45XmBsYz4ejTXwSuRpjYlwjyL9bNCZ9fs6h/DwnE/1mAnqCuiqWux01Kvdqnr1zsM
 9bga8HaL9NoKrsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 102CE13A53;
 Wed, 26 Feb 2025 16:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D08LA6U6v2dpZQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 26 Feb 2025 16:00:37 +0000
Date: Wed, 26 Feb 2025 17:00:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <Z786sJf4MyshC-my@yuki.lan>
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
 <20250224-conversions-pause-v3-4-5e3989d37f1d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250224-conversions-pause-v3-4-5e3989d37f1d@suse.com>
X-Rspamd-Queue-Id: 2093121193
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] syscalls/pause03: Refactor into new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Applied with minor change, thanks:

diff --git a/testcases/kernel/syscalls/pause/pause03.c b/testcases/kernel/syscalls/pause/pause03.c
index 9d7fee1e8..612209935 100644
--- a/testcases/kernel/syscalls/pause/pause03.c
+++ b/testcases/kernel/syscalls/pause/pause03.c
@@ -14,7 +14,8 @@
 void do_child(void)
 {
        TST_CHECKPOINT_WAKE(0);
-       TST_EXP_PASS(pause());
+       pause();
+       tst_res(TFAIL, "pause() returned after SIGKILL");
 }

 void run(void)
@@ -34,7 +35,7 @@ void run(void)
        SAFE_WAITPID(pid, &status, 0);

        if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
-               tst_res(TPASS, "pause() did not return after SIGKILL");
+               tst_res(TPASS, "pause() killed by SIGKILL");
        else
                tst_res(TFAIL, "Child %s", tst_strstatus(status));
 }

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
