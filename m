Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBBEC433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 10:38:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C9560EBA
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 10:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0C9560EBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 304643C8D9A
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 12:38:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC02C3C077E
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 12:37:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 60BBE600842
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 12:37:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BEF6822119;
 Mon,  6 Sep 2021 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1630924669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bWvzfKBEkunxvk043+NYVODGvQuPcinY4vMj+4+EuU=;
 b=MmexavAOS8hWSoGe+yBjSVLJcytezuSLPx3jlct56CZgKl9CSru6PRMlDkqYDnwQXDDS9e
 U8hXchUbVbm+a/PUN6JSG1N2/LM+dR3SE1B7DqUhdg2ppjEfjqsDVnu1HIrJLUYcc2mabx
 abGD+ZbKnlZT6gvicRmNQa+nhvIZi4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1630924669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bWvzfKBEkunxvk043+NYVODGvQuPcinY4vMj+4+EuU=;
 b=+x2w5INP21EzAGFRwItHlgk/QlhiWlxxBirjv6VXi1rW/owjZmCxW7uhuqX+cGUWUoZqZ7
 grA2+kKiAnNK1DCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFA1F13B4C;
 Mon,  6 Sep 2021 10:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Zp3LKX3vNWHtGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 06 Sep 2021 10:37:49 +0000
Date: Mon, 6 Sep 2021 12:38:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YTXviHdUSqTaR1hx@yuki>
References: <20210906060020.3219023-1-liwang@redhat.com>
 <YTXYixG37nBTzhXk@yuki>
 <CAEemH2frfyGCsZAsam7CgGfW-BC1ah9YQZz=H=meJMM+zrTnAw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2frfyGCsZAsam7CgGfW-BC1ah9YQZz=H=meJMM+zrTnAw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] copy_file_range03: comparing timestamp in
 tst_timespec_diff
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
Message-ID: <20210906103800.Ja3U0FhghIX6NSgOb7lhin6EYLlnrIj4D5cJF8BLeuQ@z>

Hi!
> Theoretically, this is correct, but I'm fearing that the process might
> cost more time on performing with different system loads.
> 
> This means 'diff_us <= 2000000' is an unreliable condition to
> many virtual machines. That largely depends on the system
> scheduler at that moment as well.

Right, I guess that we can relax the upper bound, it can be even a
minute and it would still be a good sanity check.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
