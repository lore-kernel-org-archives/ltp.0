Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BB8C43217
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 09:05:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01B083CADA4
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 10:05:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5A5D3CA86B
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 10:05:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C698A200977
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 10:04:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 853F4336F9;
 Wed,  2 Nov 2022 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667379899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qVqJ1r8hmTS1Wt+KZs4Gb49D4tiAoz46OvG8vu+Si0s=;
 b=D67Feb98vIwtec3g4IJy7/Y4S+cEfnOsPBw4CWhv+33R5tdxqbZlsbEt6TIE3QwpbTidag
 x8KRkYt4yYmnGVGs1bRUFndAlEcC5B1PfaF8vVUfui8h2kEI/vS3y0Im66kBR3q36RMtKM
 Mvdz0y9kh+WdVcJISLkLfqGcWFhAf4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667379899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qVqJ1r8hmTS1Wt+KZs4Gb49D4tiAoz46OvG8vu+Si0s=;
 b=8dQhICMseX+0SkpqypRGybuqi4+1mkoC6nSYMEBC1VpNEC+xm/WPahk2M+ALKlDiXCJTTg
 XbjvX9YrYHt2qrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3B95139D3;
 Wed,  2 Nov 2022 09:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jGh5O7oyYmMZIQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 02 Nov 2022 09:04:58 +0000
Date: Wed, 2 Nov 2022 10:06:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <Y2IzGBIyAoA7fm2m@yuki>
References: <0aaeb7d55c194ca79b2958dc8c4e5204@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0aaeb7d55c194ca79b2958dc8c4e5204@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork02: new test for fork()
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
> > > Man-pages does not menthion this, and the other field inherited does
> > not mentioned too.
> > 
> > I guess that this is described in POSIX in:
> > 
> > "The new process (child process) shall be an exact copy of the calling
> > process (parent process) except as detailed below:"
> > 
> > at https://pubs.opengroup.org/onlinepubs/9699919799/
> > 
> > And there is nothing about working dir in the list of special cases hence
> > working dir is exactly the same as for parent since it has to be exact copy
> > of parent.
> > 
> 
> It seems reasonable to not test the result of full inheritance from the parent process, otherwise there are a lot of testcases.

Certainly the interesting part would be testing all the exceptions, but
having one test that checks a few things that are supposed to be the
same wouldn't harm either.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
