Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D93FC433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 15:17:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 080803CA0AB
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 16:17:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8AD53C9564
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 16:17:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EDD860208E
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 16:17:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3DAA31F37D;
 Thu, 17 Feb 2022 15:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645111063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rSrEa14utIyquvsBe/TWfN8eEtErWaCmMCkgl59Y6i8=;
 b=pFwjmAUeQ1Wv+53lnIJGVa+W5fGGR9rO49/DsSCLMk2Pz/0D9ljjnOokv8kg5d+W1vfdaw
 UKJG7+c5A9E/m0pphBQFVe+fSQkhPcxbm9z88KSJe1FiAN3nj0G/tvTP7/UvohlwHK0Bo/
 Y2xcLisguSBGKck90a7qyYl1SUYdJQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645111063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rSrEa14utIyquvsBe/TWfN8eEtErWaCmMCkgl59Y6i8=;
 b=dwLXDV9Xk4ZqJ6Jbg3HaJ1cqLswyXc4flDeK0xLZpC63Qk3/RFxBChd3ZAR569mZeB+4AN
 fgrL0a5scjGlJmCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AEC813C1B;
 Thu, 17 Feb 2022 15:17:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 78tMCRdnDmKIVwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 17 Feb 2022 15:17:43 +0000
Date: Thu, 17 Feb 2022 16:19:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yg5nllcFYkaFlWR/@yuki>
References: <20220208132414.2852202-1-liwang@redhat.com>
 <20220209085213.2882229-1-liwang@redhat.com> <YgzJwTxk7Lnf7uG+@rei>
 <CAEemH2dd0Ctejvx2bZvHVWHd4Q=3y1sguoq=-CLCZvTYZafEeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dd0Ctejvx2bZvHVWHd4Q=3y1sguoq=-CLCZvTYZafEeQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getrusage03: mlock all address space for
 process calling consume_mb
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
> I think yes, Linux Capabilities makes it possible for specific privileges to
> the test process, and avoid that .needs_root limited many tests scenario
> to skip directly with non-root users. Especially beneficial for running LTP
> in the docker with only part of root privileges for reasons like strict
> security
> verification.

Looks good then:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
