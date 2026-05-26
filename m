Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FD6CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 13:46:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4E1B3E62BE
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:45:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B9863C71F4
 for <ltp@lists.linux.it>; Tue, 26 May 2026 15:45:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B73881000496
 for <ltp@lists.linux.it>; Tue, 26 May 2026 15:45:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0533866D9E;
 Tue, 26 May 2026 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779803136;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvVchA16NL1adpxI0nyVN7nyLpj3KnseRH+9wKwbXAM=;
 b=Uvp5ck4xlXRFVRmWdZS6ogpjJefZ/NtrMxL7aCvihGvUP7CWTxHt39La1sMtjCiZFk3Irv
 RHlEDoRvm4iUkiokxAHwqFJPCs0z4t6cFIKy6nqsMnLYEOnUQDUBpNLmRUsAhMzRqavYfM
 slG/4rQRO+ABTrhBFLC85AJwQcRztuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779803136;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvVchA16NL1adpxI0nyVN7nyLpj3KnseRH+9wKwbXAM=;
 b=0NjYupIDcn2cZhh4oVa9TJQeOOD//dURO0e7A/PzuRjUjAUhj8WzjxtL9bh7lfw+7TnF0K
 enJAj5lL1ehyyZCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779803136;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvVchA16NL1adpxI0nyVN7nyLpj3KnseRH+9wKwbXAM=;
 b=Uvp5ck4xlXRFVRmWdZS6ogpjJefZ/NtrMxL7aCvihGvUP7CWTxHt39La1sMtjCiZFk3Irv
 RHlEDoRvm4iUkiokxAHwqFJPCs0z4t6cFIKy6nqsMnLYEOnUQDUBpNLmRUsAhMzRqavYfM
 slG/4rQRO+ABTrhBFLC85AJwQcRztuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779803136;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvVchA16NL1adpxI0nyVN7nyLpj3KnseRH+9wKwbXAM=;
 b=0NjYupIDcn2cZhh4oVa9TJQeOOD//dURO0e7A/PzuRjUjAUhj8WzjxtL9bh7lfw+7TnF0K
 enJAj5lL1ehyyZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BAD05A22C;
 Tue, 26 May 2026 13:45:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 39dVIf+jFWptBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 May 2026 13:45:35 +0000
Date: Tue, 26 May 2026 15:45:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260526134533.GC215060@pevik>
References: <20260526083406.357092-1-chrubis@suse.cz>
 <20260526083406.357092-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260526083406.357092-3-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/inotify{07,
 08}: Fix TBROK on older kernels
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks for fixing it!

> -	int len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
> +	int len = SAFE_READ(SAFE_READ_ANY_EAGAIN, fd_notify, event_buf, EVENT_BUF_LEN);

Maybe later after the release we could think about about shorten this with
definitions. I'm ok if you consider this as not useful.

Kind regards,
Petr

+++ include/tst_safe_macros.h
@@ -117,6 +117,15 @@ int safe_pipe2(const char *file, const int lineno, int fildes[2], int flags);
 #define SAFE_READ(len_strict, fildes, buf, nbyte) \
 	safe_read(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
 
+#define SAFE_READ_ANY(fildes, buf, nbyte) \
+	SAFE_READ(SAFE_READ_ANY, fildes, buf, nbyte)
+
+#define SAFE_READ_ALL(fildes, buf, nbyte) \
+	SAFE_READ(SAFE_READ_ALL, fildes, buf, nbyte)
+
+#define SAFE_READ_ANY_EAGAIN(fildes, buf, nbyte) \
+	SAFE_READ(SAFE_READ_ANY_EAGAIN, fildes, buf, nbyte)
+
 #define SAFE_SETEGID(egid) \
 	safe_setegid(__FILE__, __LINE__, NULL, (egid))
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
