Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B46C6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 17:48:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87B963CE61A
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 18:48:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AE9E3CAC83
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 18:47:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EFB22600712
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 18:47:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24C271FD80;
 Wed, 15 Mar 2023 17:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678902476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1gwKVagE4VumdaUbNW7zOgJt6lPQYen0moHxJPw9fc=;
 b=ZG4eARt69+WGAxm4V3TieBkzF9gp4pq9z93eodxExLpAKepBGH9gVcC+YCgSnG/tOlTBCH
 TLic8ThMWNWG+ata0ElLyQneYAblPT5hroE0G9uHFPNUFfp5G09wameLvAGJNiIsDQdqCj
 nOXFgYwBoVW2qBTQ6SD8j/K1Ptlut4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678902476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1gwKVagE4VumdaUbNW7zOgJt6lPQYen0moHxJPw9fc=;
 b=KtLMbZ+drAn6ISwMwshaLURFK95XQYd4+3Fefdr/wYg2fPs+BWtRYRcz7kDZL3QoDHzjKb
 0TDb9SlzuiyPygCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB9ED13A2F;
 Wed, 15 Mar 2023 17:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /y91N8sEEmROMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Mar 2023 17:47:55 +0000
Date: Wed, 15 Mar 2023 18:47:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230315174754.GA172450@pevik>
References: <20230120010533.11202-1-wegao@suse.com>
 <20230302071555.18420-1-wegao@suse.com>
 <20230302071555.18420-2-wegao@suse.com>
 <20230315123119.GA164307@pevik> <20230315131146.GD10248@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230315131146.GD10248@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] Move semaphore/ tests to semop/
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

Hi Wei,

> > > There is no point in having two different directories with semop()
> > > testcaes so it would make sense to move these two tests into the
> > > syscalls/ipc/semop/ directory as semop04 and semop05.
> > > So we move ipc/semaphore/ tests to syscalls/ipc/semop/.
> > > Also update runtest files accordingly.

> > As I already stated, I'm not really sure this is good to do, but maybe I'm
> > missing something.  I wonder what others thing about it.

> Ah, you also start work on this?
No, I just shared my doubt about this move.

> Should i still continue work on this patch or not?
> To me this is not bad thing at least, we do some clean work and reorganize the test cases.

Probably yes, but I'd prefer somebody else from LTP maintainers has also acked this.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
