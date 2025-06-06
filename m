Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83DEC61CE8
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 11:27:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1692C3CA01B
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 13:27:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3E953C0FAD
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:27:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 221C31400971
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:27:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E1DD21EA3;
 Fri,  6 Jun 2025 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749209251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEpP07dNlygylIkl47y92TnNa2LyF1pfb7wkBzOZYKU=;
 b=msxI2beLckTDWV/Bnld1i/SPdBWXA2kJsg9Uyrha02FV9uz+ThFFYhqB6V6Zo6mjtjLTZN
 C6uzZ0QGeQZAtIz9JXeHzIviqq7kxH4TTTa27kwfn1OCP3fG+bprlDivAV+PR52480RmR0
 XW84SPctEfkQIpm95Rha4DzyXUWvo6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749209251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEpP07dNlygylIkl47y92TnNa2LyF1pfb7wkBzOZYKU=;
 b=ohmLort5xfHwaHQh1BeCBy7IX2e2u9lwCdYd+DVqQLSv/On47nUCAnB8bEEpwRP91Mbtq2
 K2WFJpqyd9ctCnCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749209250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEpP07dNlygylIkl47y92TnNa2LyF1pfb7wkBzOZYKU=;
 b=wEGY4PKxJEPi4C2N7X+N1l9VHT6vwSyoTBPXb7p9bnvrazPVFi1BDshbeiekJ9YUMXlnuJ
 DWE3XKoNusQb/AjNC0lLh1McJ72yg7m8GevuDIiWGyCD85H/s9GZv+5YjnbQ23zCk/C+ax
 +CShJ0RPW/lpfoXvXSSg3Le+gI1Ufy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749209250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEpP07dNlygylIkl47y92TnNa2LyF1pfb7wkBzOZYKU=;
 b=nVPEBcZcF9HonVpNRsnc9gG3t4a9aShQZpMVGlpni0f2vvcEcxPvkDmscvkEnj4ga2gLxi
 SbXLhEt9Hv/MdDCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D5B91336F;
 Fri,  6 Jun 2025 11:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pnf2BaLQQmiYRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jun 2025 11:27:30 +0000
Date: Fri, 6 Jun 2025 13:27:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250606112720.GC1289709@pevik>
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-4-0b5cff90c21c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605-conversions-mknod-v5-4-0b5cff90c21c@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/8] syscalls/mknod04: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

...
> -#define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO

Similarly, to what I noted to mknod03.c in v4:
https://lore.kernel.org/ltp/20250605073231.GC1190804@pevik/

Originally here was also S_IFIFO (used for both mkdir() and mknod()). Although
the tests "works" IMHO we should use mknod() with S_IFIFO (and I believe it's
not needed for mkdir().

> -#define MODE_SGID       S_IFIFO | S_ISGID | S_IRWXU | S_IRWXG | S_IRWXO

> +#define MODE_RWX 0777
But you omit it.

> +#define MODE_SGID (S_ISGID | 0777)
...
> -		/*
> -		 * TEST CASE CONDITION:
> -		 *  Attempt to create a filesystem node on a directory
> -		 *  with group id (sgid) bit set such that,
> -		 *  the node created by mknod(2) should not have group id
> -		 *  (sgid) bit set and node's gid should be equal to the
> -		 *  effective gid of the process.
> -		 */
> -		TEST(mknod(node_name, MODE_RWX, 0));
> +	SAFE_MKNOD(TEMP_NODE, MODE_RWX, 0);

I vote for following diff (no need to repost).

Kind regards,
Petr

+++ testcases/kernel/syscalls/mknod/mknod04.c
@@ -17,6 +17,7 @@
 #include "tst_test.h"
 
 #define MODE_RWX 0777
+#define MODE_FIFO (S_IFIFO | 0777)
 #define MODE_SGID (S_ISGID | 0777)
 
 #define TEMP_DIR "testdir"
@@ -29,7 +30,7 @@ static void run(void)
 {
 	struct stat buf;
 
-	SAFE_MKNOD(TEMP_NODE, MODE_RWX, 0);
+	SAFE_MKNOD(TEMP_NODE, MODE_FIFO, 0);
 
 	SAFE_STAT(TEMP_NODE, &buf);
 	TST_EXP_EQ_LI(buf.st_mode & S_ISGID, 0);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
