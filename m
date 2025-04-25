Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC521C369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 12:10:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D42A3CB7CE
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 14:10:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F073A3C2ED8
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 14:10:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 25C4460070C
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 14:10:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 366DE21160;
 Fri, 25 Apr 2025 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745583023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2ELlZKvatCYl/bRgPmQoLVm5lWhOuzv5TNH9Ld88mM=;
 b=aoZkRM5qxy4mys7NO7hmVTtR1C6Sc7tmk1ifk7FH72+Ucp+kh3ajhfiRPofsm9IwzVB3xf
 nQYqTaSoVY97FxDVOblvysHvEMh8CVPJiHs3NyV58o5pfJR28jcmvkXIazay4Z1g8TDFQM
 SlKPekVsdq1exZENR4SlcrMQG6TiQMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745583023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2ELlZKvatCYl/bRgPmQoLVm5lWhOuzv5TNH9Ld88mM=;
 b=ZdoJKVdgpEmR3K5qx4EvNtF4hJkYIZWpFA/4CvCs/17cTwFxA3XIYPVu59SH7wIuQCIcpG
 n01qGOOjL9w2kyCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745583023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2ELlZKvatCYl/bRgPmQoLVm5lWhOuzv5TNH9Ld88mM=;
 b=aoZkRM5qxy4mys7NO7hmVTtR1C6Sc7tmk1ifk7FH72+Ucp+kh3ajhfiRPofsm9IwzVB3xf
 nQYqTaSoVY97FxDVOblvysHvEMh8CVPJiHs3NyV58o5pfJR28jcmvkXIazay4Z1g8TDFQM
 SlKPekVsdq1exZENR4SlcrMQG6TiQMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745583023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2ELlZKvatCYl/bRgPmQoLVm5lWhOuzv5TNH9Ld88mM=;
 b=ZdoJKVdgpEmR3K5qx4EvNtF4hJkYIZWpFA/4CvCs/17cTwFxA3XIYPVu59SH7wIuQCIcpG
 n01qGOOjL9w2kyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 250C61398F;
 Fri, 25 Apr 2025 12:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SdIsCK97C2jnPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 25 Apr 2025 12:10:23 +0000
Date: Fri, 25 Apr 2025 14:10:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <aAt70nA53AqpVyZc@yuki.lan>
References: <20250423120516.10680-1-lufei@uniontech.com>
 <20250425093355.14063-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250425093355.14063-1-lufei@uniontech.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/unshare: New test: CLONE_NEWNS
 unshares fs info
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
I've adjusted the test description a bit and pushed, thanks!


I've clarified what we are testing that CWD is being unshared with:


diff --git a/testcases/kernel/syscalls/unshare/unshare04.c b/testcases/kernel/syscalls/unshare/unshare04.c
index 5b3e5d98f..4305c5cb1 100644
--- a/testcases/kernel/syscalls/unshare/unshare04.c
+++ b/testcases/kernel/syscalls/unshare/unshare04.c
@@ -4,9 +4,8 @@
  */

 /*\
- * This test case is to verify unshare(CLONE_NEWNS) also unshares filesystem
- * information.
- *
+ * This test case is to verify unshare(CLONE_NEWNS) also unshares process
+ * working directory.
  */

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
