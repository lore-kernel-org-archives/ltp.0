Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E5DC44515
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 07:48:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFA083E55DC
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 09:48:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 367E93C9911
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 09:48:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E54D26009F9
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 09:48:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 787B277172;
 Fri, 17 Jul 2026 07:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784274490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YdiLbY2RQT3KvFbMmONY2dEy6/uUaweniYubJjHTVts=;
 b=KseG+45/jHUISqZmq8VWxoTPMNile85zyslUe0tagA49lY2wbRUbj+a0OdvKxqwEh2bUSj
 Ivk1RVsTjDNi3xpelgX/U0qExtX3KqiTKexRbkYqLrN+rFdCUtCNYT5S216Cld+X3wUKor
 P34o2VVYJI4FIgz8a3viwZtrzZtqQMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784274490;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YdiLbY2RQT3KvFbMmONY2dEy6/uUaweniYubJjHTVts=;
 b=RAk3xcV1slz7tI0cK+hOzn53MokU/X5cD5nwlLIjL19stGjg5MrDcHfs4dSkVQtzvtZLfu
 l/cd8jxoBj8z9CBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784274490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YdiLbY2RQT3KvFbMmONY2dEy6/uUaweniYubJjHTVts=;
 b=KseG+45/jHUISqZmq8VWxoTPMNile85zyslUe0tagA49lY2wbRUbj+a0OdvKxqwEh2bUSj
 Ivk1RVsTjDNi3xpelgX/U0qExtX3KqiTKexRbkYqLrN+rFdCUtCNYT5S216Cld+X3wUKor
 P34o2VVYJI4FIgz8a3viwZtrzZtqQMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784274490;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YdiLbY2RQT3KvFbMmONY2dEy6/uUaweniYubJjHTVts=;
 b=RAk3xcV1slz7tI0cK+hOzn53MokU/X5cD5nwlLIjL19stGjg5MrDcHfs4dSkVQtzvtZLfu
 l/cd8jxoBj8z9CBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 686D6779AA;
 Fri, 17 Jul 2026 07:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vsk6GDreWWotFwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jul 2026 07:48:10 +0000
Date: Fri, 17 Jul 2026 09:48:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <alneMq4cprTbWZTj@yuki.lan>
References: <20260717-fix_tst_test_hugepages-v1-1-a63bf2ccdd17@suse.com>
 <alnbk-wNqcenHl2S@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alnbk-wNqcenHl2S@linux.dev>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugepages: ensure CONFIG_COMPACTION is defined
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Given that, I don't think we should tst_brk(TCONF) here at all.
> My suggetion is not to use SAFE_* macros:
> 
> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -47,7 +47,7 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
>         }
>  
>         SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
> -       SAFE_FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");
> +       FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");

Looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
