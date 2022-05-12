Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F03AC433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:12:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE8903CA9D4
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 16:12:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 719BC3CA722
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:12:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7CDC9200C22
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:12:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE23621B29;
 Thu, 12 May 2022 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652364740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0N1lqN1w+OPJcDLdl7d9ov9Kw8x8D+OqhjYn7AmvuNk=;
 b=W5gC/Se8U40icEHh+OhZVQs+FNd9rzO4IHAQZ8n4ylcad5cic8FDKcFX/f/wcpIzlMUdQL
 T9dpiu19Jz0uFacYlQRSefJQ0qJRAALPA5FFQf/L5lwV/2I/f3Op2jAdaHILPKa6M4l8I7
 WT5UtsZiSxotDkEWQXB2+TouKm+12ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652364740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0N1lqN1w+OPJcDLdl7d9ov9Kw8x8D+OqhjYn7AmvuNk=;
 b=wp1c/z/EU+shZlOX7RhPdjMv0zHu5YfYf4bDsaprdeS7zmn6WZtHs9zsxGG9rQWtg65+Bx
 7X2enkd/uC2KOMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C49813A84;
 Thu, 12 May 2022 14:12:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8NU2JcQVfWI9TAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 14:12:20 +0000
Date: Thu, 12 May 2022 16:14:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Eirik Fuller <efuller@redhat.com>
Message-ID: <Yn0WSoEr71vTXtOf@yuki>
References: <20220511021636.2166562-1-liwang@redhat.com>
 <Ynt3c8ks6kkAGs/z@yuki>
 <CAEemH2ftLWEu76r7+7JHmMmHNxeZyrFaZw-BANR62v_0r4LSWg@mail.gmail.com>
 <CAF3Th=XPxhF6=g5ZcT1u3D0M9r9ACtYP76JcjGS7CJP_euhqwg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF3Th=XPxhF6=g5ZcT1u3D0M9r9ACtYP76JcjGS7CJP_euhqwg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] rtc02: loosen the compare precision with few
 seconds
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
> Sorry to chime in late, but do we care about crossing day, month, or year
> boundaries? For example, what if we write 23:59:59 and read 00:00:01 ?

As far as I can tell we avoid that by either adding or subscribing an
hour from the current date.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
