Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AD0C27C5E
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 12:05:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E7B83D0B98
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 14:05:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 390C53C2FAF
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 14:04:50 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6DF4F2079E3
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 14:04:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 546B433749;
 Tue, 11 Jun 2024 12:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718107488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=haXS2o68Dtl5J0EXm14mdIQZczBwC9xsvspeIKVtR0Y=;
 b=aNY47Je1J8CZ0d0jXd/fMdBpOocQJU/UF5v8NwADrUc2X5gyK9quTBKwZpgeiSmMCWQsA9
 RmX4ylAAlzXC0dLeDeEPZMA6safyvDaRpy0mzXoIYpG/l5WcqhbRVwEIS/UPL/biEbV714
 yOBSHJdVXCAwNpD0iOSsAIpyqKNJb+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718107488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=haXS2o68Dtl5J0EXm14mdIQZczBwC9xsvspeIKVtR0Y=;
 b=ygSBkYzgFDbLbcD2jVgINVMHT9mRAl2y/eXIjzMMEPpgMHur4pJxI+buIfztbM1TrFGykI
 6MwzDNwHFaxvlMDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aNY47Je1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ygSBkYzg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718107488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=haXS2o68Dtl5J0EXm14mdIQZczBwC9xsvspeIKVtR0Y=;
 b=aNY47Je1J8CZ0d0jXd/fMdBpOocQJU/UF5v8NwADrUc2X5gyK9quTBKwZpgeiSmMCWQsA9
 RmX4ylAAlzXC0dLeDeEPZMA6safyvDaRpy0mzXoIYpG/l5WcqhbRVwEIS/UPL/biEbV714
 yOBSHJdVXCAwNpD0iOSsAIpyqKNJb+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718107488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=haXS2o68Dtl5J0EXm14mdIQZczBwC9xsvspeIKVtR0Y=;
 b=ygSBkYzgFDbLbcD2jVgINVMHT9mRAl2y/eXIjzMMEPpgMHur4pJxI+buIfztbM1TrFGykI
 6MwzDNwHFaxvlMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 449CD13A55;
 Tue, 11 Jun 2024 12:04:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MmB1D2A9aGZhJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 11 Jun 2024 12:04:48 +0000
Date: Tue, 11 Jun 2024 14:04:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Khem Raj <raj.khem@gmail.com>
Message-ID: <Zmg9WZ1TitB7D_RC@yuki>
References: <20240611055655.614782-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240611055655.614782-1-raj.khem@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,andestech.com:email,linux.it:url];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, linux.it:url, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 546B433749
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add __clear_cache declaration for clang
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
Cc: Hui Min Mina Chou <minachou@andestech.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> __clear_cache was enabled on RISCV recently with 7352ba02390116f1cd6a9b583860ba28aa0a1b7a
> however it fails to compile with clang19 on RISCV
> With this error
> 
>   hugemmap15.c:51:2: error: call to undeclared function '__clear_cache'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       51 |         __clear_cache(p, p + COPY_SIZE);
>          |         ^

This sounds like a clnag bug. The __clear_cache() is a pre-defined
function and as such the signature should be part of the compiler.

Is the call even supported by clang19 on RISCV?

> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Hui Min Mina Chou <minachou@andestech.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> index a84ba6476..856e22ff3 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> @@ -21,6 +21,7 @@
>  
>  #if defined(__clang__)
>  	#pragma clang optimize off
> +	void __clear_cache(void *start, void *end);
>  #endif
>  
>  #define _GNU_SOURCE
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
