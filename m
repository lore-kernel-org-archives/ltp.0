Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ACBC25B6B
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 09:37:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F0C23CCB48
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 11:37:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 580D73C83DA
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:37:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BC62A1401211
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:37:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DEB531F86A;
 Thu, 26 Oct 2023 09:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698313029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UI2gkD2geQ7rQBJcUmeFSiKlVbMSMsxF9dOwUC2f57s=;
 b=o8iPEAAFgt7sfWox5c6USaTmzFisgb9QmP8Ec3Hr2JoKgmYbuTKhAp3B8OWzQyo13Hp7sI
 Wz6tkj/9fnS/pHd9DGt4K8g1C9zsJqGkjdUBeMRUeUNAPnJkQqJNPBxf5Z2s58MlyvcPrh
 4ybbigo2qJEm9eoedTUHrs7OCrp2Ef8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698313029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UI2gkD2geQ7rQBJcUmeFSiKlVbMSMsxF9dOwUC2f57s=;
 b=625wnzbs7c27NR7fcbcJ1xmPHnA+s7yhCbegq9Xwyo9DBBZMC1BOJtNgBRab4j4s5lygwB
 GntL3VHHgcIKtbAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B20E7133F5;
 Thu, 26 Oct 2023 09:37:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LPOmKUUzOmVWMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 09:37:09 +0000
Date: Thu, 26 Oct 2023 11:37:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231026093708.GB580291@pevik>
References: <20231024084923.217110-1-pvorel@suse.cz> <ZTjgBkVwwvqgbWm1@rei>
 <20231025231448.GA510491@pevik> <ZTomvGZWq1QL2mnc@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTomvGZWq1QL2mnc@rei>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] stack_clash: Guard functions used only in
 64bit
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
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Pavel Boldin <pboldin@cloudlinux.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > force_bottom_up() is called only inside do_mmap_placement_test(), which is also
> > wrapped with #ifdef __x86_64_.

> > I did not notice that, compiler pointed it out :).

> Ah I was blind yesterday, sorry.

No problem, thanks for a review, merged.

Kind regards,
Petr

> > Can I merge with your RBT?

> Of course.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
