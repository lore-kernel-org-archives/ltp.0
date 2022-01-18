Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C49CC433EF
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 10:33:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35EF43C963E
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 11:33:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 237D63C1810
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 11:33:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 484A110009AB
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 11:33:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3BE741F3A1;
 Tue, 18 Jan 2022 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642501993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5bPAWVb2VAvLovT+/jhL6oUFQdoU1qUN8CuDu42L9fk=;
 b=0fEKB4nO1d+09k36T0ygxSucBQzzOywmZMETFOMIe9KD6MxIzkX0RBkXQ6GVssVNVEgA5J
 ZIDL5hKqzPOnRD2LQ6Zb06NUqVYgqPSSQFJorsmau5uH1we9wXfx7N1BRPvri9CMgQLv1b
 DVKYiTNSaZZZSeURtsMZPvvM7L4qn4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642501993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5bPAWVb2VAvLovT+/jhL6oUFQdoU1qUN8CuDu42L9fk=;
 b=UOu0p9iOwb1BiLsccsiZjqXYN6eql7RJa1BvU4rA6vUWc2uLwZbyn+RBspmTEYhUTE/6VJ
 iDcOOMfG/lKbmgCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26E5E13DC7;
 Tue, 18 Jan 2022 10:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cT60B2mX5mEPLgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 18 Jan 2022 10:33:13 +0000
Date: Tue, 18 Jan 2022 11:34:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YeaXz+GLmFhKCqTB@yuki>
References: <20220114210034.16177-1-pvorel@suse.cz>
 <CAEemH2ddzfJ48prJTejCBq-=u4O-w0ENR27A_DjUo_OsqShCow@mail.gmail.com>
 <CAEemH2cMpFUz1nzq6DDfe+S-bYam3fYvb8ci=hfXHkjbfxbkeQ@mail.gmail.com>
 <YeUxCq4rsLX98E3d@pevik>
 <CAEemH2eLo7BF5+WuQS8jerbQc6Dzcg4quQK6=HC_7KsrQZXbQQ@mail.gmail.com>
 <YeaB+smLnVt9voPy@pevik>
 <CAEemH2fNfFes-eUtiQKX9JJxqEQUQ+O5nWQM8G-yNyTo8sxviw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fNfFes-eUtiQKX9JJxqEQUQ+O5nWQM8G-yNyTo8sxviw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] utime03.c: Fix filesystem name
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
> > > Sorry, what does that 'remove the entry' mean? I didn't catch your point here.
> > As you pointed out it does not have any effect now to whitelist 9p.
> > It's kind of documentation. Maybe instead of fixing the line we should remove it
> > and put a comment above.
> 
> Ah sure, I'm fine with that quick fix (before the new release)
> unless Cyril has additional comments.

I would go for removing the entry as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
