Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D14C54788
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 13:52:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E4733CF9F2
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 14:52:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EBA63CEFB9
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 14:51:51 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CECD06018CF
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 14:51:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 609B71F7BA;
 Thu, 22 Feb 2024 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708609909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UW4kJC5C1ZUaFhqoAINGukdRURw5Y5rw/CJE+RhTCLc=;
 b=0m2pFbOOEUs3Wz/qvND59MTJsZJlg5mB9IHb76ACtcaEtH+zNy7vVY4MfuDxc2/Nh9szAX
 NEcOZcM/2DsXw0bgLcw05bVg2s4q9FNEH7X62UJvcn9rTbQCW+/KFX129yHoB3n7Ae4mpF
 Ee+0PJBnPjO1OgdVzPC4L8yz+M/qYz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708609909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UW4kJC5C1ZUaFhqoAINGukdRURw5Y5rw/CJE+RhTCLc=;
 b=Ttsb7lDAjGgIdLEWLgF4yTbOf+yT0bX5k0bOi5p+TbBefsb11ra7gu4O/bJes2bYh8VGAD
 +e4mStaJPOuLZwCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708609909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UW4kJC5C1ZUaFhqoAINGukdRURw5Y5rw/CJE+RhTCLc=;
 b=0m2pFbOOEUs3Wz/qvND59MTJsZJlg5mB9IHb76ACtcaEtH+zNy7vVY4MfuDxc2/Nh9szAX
 NEcOZcM/2DsXw0bgLcw05bVg2s4q9FNEH7X62UJvcn9rTbQCW+/KFX129yHoB3n7Ae4mpF
 Ee+0PJBnPjO1OgdVzPC4L8yz+M/qYz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708609909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UW4kJC5C1ZUaFhqoAINGukdRURw5Y5rw/CJE+RhTCLc=;
 b=Ttsb7lDAjGgIdLEWLgF4yTbOf+yT0bX5k0bOi5p+TbBefsb11ra7gu4O/bJes2bYh8VGAD
 +e4mStaJPOuLZwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4250613A8C;
 Thu, 22 Feb 2024 13:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bS28DnVR12XoPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 22 Feb 2024 13:51:49 +0000
Date: Thu, 22 Feb 2024 14:50:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZddRLm8zpX-wKBGe@yuki>
References: <20240222044119.28500-1-wegao@suse.com> <ZdcIT1WiEfV7MCQ-@rei>
 <ZddOKzhl1semChgB@wegao.166.144.58>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZddOKzhl1semChgB@wegao.166.144.58>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[37.27%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapoff01.c: Adjust blocks size base on
 pagesize
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
> > Isn't this more about Btrfs though? Looking at the make_swapfile() we do
> > use statvfs to get filesystem block size and if that is Btrfs with 64k
> > blocks we end up with swapfile of a size of 4GB that sounds like a bit
> > too much I guess.
> > 
> 
> Sorry for confusing. It should caused by block size instead of page size.
> The code change should change like following, but i suppose you will not agree
> on this solution, correct?
>
> --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> @@ -12,6 +12,7 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <stdlib.h>
> +#include <sys/statvfs.h>
> 
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
> @@ -44,8 +45,21 @@ static void setup(void)
>  {
>         is_swap_supported(TEST_FILE);
> 
> -       if (make_swapfile(SWAP_FILE, 65536, 1))
> +       struct statvfs fs_info;
> +       unsigned long blk_size;
> +       if (statvfs(".", &fs_info) == -1)
> +               tst_brk(TBROK, "Failed to get statvfs info");
> +
> +       blk_size = fs_info.f_bsize;
> +
> +       int blocks = 65535;
> +
> +       if (blk_size > 4096)
> +               blocks = 65535 * 4096 / blk_size;
> +
> +       if (make_swapfile(SWAP_FILE, blocks, 1))
>                 tst_brk(TBROK, "Failed to create file for swap");
> +
>  }

It may be easier to change the make_swapfile() function to accept
megabytes instead of working around it like this.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
