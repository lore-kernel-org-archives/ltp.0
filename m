Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1E3C433F5
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 10:05:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32E803CA924
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 12:05:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 950B13CA4E1
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 12:05:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8CC691A01755
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 12:05:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CDFBA218B2;
 Fri, 30 Sep 2022 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664532330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZRn0MddnvQHd/eCyUDh/QkAlwMNmwRSQ/5j2pYXc6oY=;
 b=26kMdAP3VanUKstd5PdsoFyRLQ846YGwYQlI4hdPHgh3Vc0iuvUkwaachv0p3jux/meQ5I
 crWLdXxGCS68W4hWRiXysKYmIENHNnscSXLbGxfBlGxoqjAKOi0tBIPAnNU7HUE0I6UcJn
 CaBrAkKqtEhFJsjeqE1kIAB68zyEBys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664532330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZRn0MddnvQHd/eCyUDh/QkAlwMNmwRSQ/5j2pYXc6oY=;
 b=P9KlGwxbXMZmt6JvvJr/MAEvxAARJ8cEkTNXk6oD8MCwv4PPQHDHC6q6SoQdM0pUrOqkto
 tErVOjI16CHM0WDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6872813677;
 Fri, 30 Sep 2022 10:05:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QNj2F2q/NmNVbAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 10:05:30 +0000
Date: Fri, 30 Sep 2022 12:05:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yza/Z9SVounz+MrC@pevik>
References: <Yxr+EpKTnKQbKXTb@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yxr+EpKTnKQbKXTb@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

OK, we have another regression in 1f6bd6e66 ("tst_test.sh: Add
$TST_ALL_FILESYSTEMS"). I'll reply to release thread.

tst_brk TCONF in network tests causes broken tests.
I'll try to send patch soon, it's up to you if we release with known issue
or fix it before release.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
