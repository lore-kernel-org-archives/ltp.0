Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE378EC8730
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 14:10:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A106A3CE9A9
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 16:10:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0EB63CC2C7
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 16:09:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C27921000DE9
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 16:09:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF9591F8B0;
 Thu,  7 Sep 2023 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694095795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UJBqdL51HTptBQnDAc8oa9n9b6uqNNpvkKPhe+cj76A=;
 b=zOquMUTc2IE0gXtUT//jQRM2pJdletLO77lTjNfxQgqJ5wCRlJetSh3thO0i3jlOJ5Vssv
 Y1m+ZaT7JJM9NdzEStVrsENrQ5fQz8Ppc32SAPeZKTmqRnLUQa70M6PSMPQu6KQvRtLkoQ
 zYMhFtEUvS1HFrVm9ywVaYrQfXHgGx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694095795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UJBqdL51HTptBQnDAc8oa9n9b6uqNNpvkKPhe+cj76A=;
 b=k0CeC1N5kivZCwNNLaMaJKyhrrWJmofHr3zt8gSHR9exiSz3ySIATKYIGa/ocS8ImzvwET
 NJY0o0sbkGQLDHDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEDBB138F9;
 Thu,  7 Sep 2023 14:09:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 21VqLbPZ+WQMUwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 07 Sep 2023 14:09:55 +0000
Date: Thu, 7 Sep 2023 16:10:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZPnZ29GMkQsMZF55@yuki>
References: <20230524093930.43971-1-liwang@redhat.com> <ZPmXN9GyrhLC3aw5@yuki>
 <CAEemH2f+oQuiFNM_AHpszJHOE_+CspoNoZzfZD0R=5rUhVzeYg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f+oQuiFNM_AHpszJHOE_+CspoNoZzfZD0R=5rUhVzeYg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] lib: add support for kinds of hpsize
 reservation
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
> > This pointer (hugepage_path) is on stack and is passed to a function
> > that stores the structure into a list and then uses it to restore the
> > value at the end of the testrun, which will probably crash the test
> > since there will be random leftovers on the stack.
> >
> 
> 
> But the function tst_sys_conf_save_str allocates a new memory
> area for saving the structure info, the original is not used for
> appending to the list, isn't it?
> 
> strncpy() inside that function helps avoid the problem you pointed.

My bad, I was for some reason under impression that it just stores the
pointer.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
