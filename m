Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95942C25B75
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 01:31:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7B613CF8CD
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 03:31:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A335B3CF095
 for <ltp@lists.linux.it>; Thu, 16 May 2024 03:31:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D94691000C60
 for <ltp@lists.linux.it>; Thu, 16 May 2024 03:31:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFD4C20EBC;
 Thu, 16 May 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDC8413A5D;
 Thu, 16 May 2024 01:31:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wlHlLNhhRWbIMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 May 2024 01:31:04 +0000
Date: Thu, 16 May 2024 03:30:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240516013048.GB260285@pevik>
References: <20240515093349.7347-1-andrea.cervesato@suse.de>
 <20240515093349.7347-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240515093349.7347-2-andrea.cervesato@suse.de>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DFD4C20EBC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 01/10] Add SAFE_STATX macro
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

Hi Andrea,

could you please fix these?

testcases/kernel/syscalls/statmount/statmount03.c: useless tag: format_device
testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
testcases/kernel/syscalls/statmount/statmount04.c: useless tag: format_device
testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
testcases/kernel/syscalls/statmount/statmount05.c: useless tag: format_device
testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
testcases/kernel/syscalls/statmount/statmount06.c: useless tag: format_device

> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 8de8ef106..43ff50a33 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -503,4 +503,11 @@ int safe_sscanf(const char *file, const int lineno, const char *restrict buffer,
>  #define SAFE_SSCANF(buffer, format, ...) \
>  	safe_sscanf(__FILE__, __LINE__, (buffer), (format),	##__VA_ARGS__)

> +struct statx;

Could you please remove this? (unneeded)

With that, you might add for this patch in the next version:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
