Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD64C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 13:14:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4018C3C9AA6
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 14:14:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D30993C0720
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 14:14:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 35F206000E6
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 14:14:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05CFB1F37F;
 Mon,  7 Feb 2022 13:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644239659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4n1q/5d3xPdPvF13h9Z3fbLtpys/vhUzaeEz/rbhnU=;
 b=QfSYhbSa8pci385pjtIhdsY5pxuGBN/MQ7JNdibYhYQZcdYj9P2O+9hijLjhOFP0ftZa1Y
 LpHj5UA1rUyhe4BoXHiRSOxWGqXuP0+QglL66zTYDA63SbrranZxVyy5q+MslS/Jh8viqo
 ZXKj9BZ/w1nkVrnjtROvQceHufSs3Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644239659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4n1q/5d3xPdPvF13h9Z3fbLtpys/vhUzaeEz/rbhnU=;
 b=0sjTZwQcCKq3iiFuDFC64YTlo6YZqZWUo83/lAEgkpHC0LUUE/nSWHe8FPYP1zrviYRFJc
 Zrrow+B5cqrDqeAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE58713C00;
 Mon,  7 Feb 2022 13:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ElfjLyobAWIBGwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 07 Feb 2022 13:14:18 +0000
Date: Mon, 7 Feb 2022 14:16:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YgEbpTni5ID6d/bs@yuki>
References: <20220207040447.2803113-1-liwang@redhat.com>
 <CAASaF6ytd7ROq_S48NnYWY4-VU+nGjX7NTcgM5aGQG6G0rh_OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6ytd7ROq_S48NnYWY4-VU+nGjX7NTcgM5aGQG6G0rh_OQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: skip on small RAM system
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Signed-off-by: Li Wang <liwang@redhat.com>
> 
> Acked-by: Jan Stancek <jstancek@redhat.com>
> 
> This should fix the immediate failure, just wondering,
> would there be any downside of replacing that TBROK with TCONF?

I guess that we may end up in a state where the test would TCONF on
every run and it would end up being ingnored.

Can't we just change the consume_mb to lock the memory with mlock() in
the consume_mb() instead? As long as we add the check for a free memory
it should be fine I guess.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
