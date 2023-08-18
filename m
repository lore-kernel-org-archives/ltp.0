Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2995C7113C
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 14:16:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 600A53CCAB9
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 16:16:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C519E3C02C7
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 16:16:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BF520600050
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 16:16:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8932B1F74B;
 Fri, 18 Aug 2023 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692368172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VOnEwIe24qJU6qUR6DgTGz5JcY+/sXULrAPgOGnhkgM=;
 b=HuRZk4aI6OLKx6tLsv0KcwotQAgCoD51297qqaUHCvSq9p4yOLwP5Q3nLgpa9DqyU5qB9k
 2YSpdz7QNAvYvXGe9ppAGVIaiCSUOxBaKzTuqjt9v7JIVAARwFk4orsAaju+ka5DAvU5fF
 eSbS3P9kVkG51Wr1K8trfoU/jAFMMak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692368172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VOnEwIe24qJU6qUR6DgTGz5JcY+/sXULrAPgOGnhkgM=;
 b=OHQ3GjR2D3gNB2NgQwlRDXV2AdpN4mvwUMTdZOd+jvbWdMkKtRvGBj+rXMbmFyH1WTKtGE
 DYGrGzAB8L7KLSDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76AC913441;
 Fri, 18 Aug 2023 14:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Y7umHCx932TdOwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Aug 2023 14:16:12 +0000
Date: Fri, 18 Aug 2023 16:17:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZN99Y9lKPZz-MMlu@yuki>
References: <20230811115647.32387-1-chrubis@suse.cz>
 <20230811115647.32387-2-chrubis@suse.cz>
 <CAEemH2fCOye2v8yL7AR6JO7Ar4tW83sB4Fi=YzJUuSCzhmtkiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fCOye2v8yL7AR6JO7Ar4tW83sB4Fi=YzJUuSCzhmtkiQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] lib: tst_buffers: Add bufs .str and
 tst_aprintf()
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
> Anyway, the whole patch set looks pretty good to me.
> 
> Reviewed-by: Li Wang <liwang@redhat.com>

Pushed, thanks for the review.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
