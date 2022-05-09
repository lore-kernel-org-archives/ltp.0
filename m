Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B584AC433EF
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 14:03:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CD5B3CA93A
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 16:03:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA1CE3CA788
 for <ltp@lists.linux.it>; Mon,  9 May 2022 16:03:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EBDE11400967
 for <ltp@lists.linux.it>; Mon,  9 May 2022 16:03:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41EEB21C1B;
 Mon,  9 May 2022 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652105010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0AdfJUyiEZ1ZwFJkDdojCyP13BIIKCHx7cuPEcdCJnI=;
 b=GFGUUnkvWNsMY75T66U8jnp8iCcsqxQ4xqsheCv9GYak+d0vJArdMyxi10fGnfHqo9UWMX
 LpDdSSG6SuZEIER6GKHtr6poXBTT4RMT09AOXCx76dIyS066xoPz1M0IVlncoVnGYnvvrF
 zdGr9DHbPhD1YMaWIoMWck3y/Zhk2pQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652105010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0AdfJUyiEZ1ZwFJkDdojCyP13BIIKCHx7cuPEcdCJnI=;
 b=jIweB65GVlO5LvmEt3Z8qIWD+nMZHudakAJxh7tyIuKVrSBZqT3+L1lLwYP4WqesWCjFPs
 029CO27HJ7ZnqUDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3101C13AA5;
 Mon,  9 May 2022 14:03:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0FXKCjIfeWIOcwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 09 May 2022 14:03:30 +0000
Date: Mon, 9 May 2022 16:05:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Ynkftw55rbyVFXb0@yuki>
References: <20220427125003.20815-1-pvorel@suse.cz>
 <20220427125003.20815-5-pvorel@suse.cz> <YnU0XII0YSf0CUnb@yuki>
 <d4552f0b-9f73-ec2b-0c81-3d86eeb36fc1@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4552f0b-9f73-ec2b-0c81-3d86eeb36fc1@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] tst_test.sh: Cleanup getopts usage
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
> >> +. netns_helper.sh
> >> +
> >> +PROG=$1
> >> +IP_VER=$2
> >> +COM_TYPE=$3
> > 
> > Can't we just keep these at the top along with the rest of the
> > variables? I do not see them redefined anywhere but maybe I miss
> > something.
> 
> tst_test.sh has to process command line arguments before these variables
> can be set. Otherwise you'd have to put all command line switches
> *AFTER* the positional arguments.

I did sleep on this and I guess that the cleanest solution for this is
to pass the positional arguments to the test setup function instead.
What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
