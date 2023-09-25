Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8F4CE7AB3
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 17:45:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 564FC3CE222
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 19:45:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 319093C9956
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 19:45:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 74AE31A004CE
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 19:45:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 871F21F74C;
 Mon, 25 Sep 2023 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695663929;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6wpX/KMSe+NK07Hj0KH4xbGagy9Uj3FRnxeusCmbhvk=;
 b=qRTDsIgvCv4bHgCGozLJIfhTnwgtQIQfBtY7mepzYy4+c2QF2UuZmjF866wckg/CTkZ84X
 MaabTn6GJox8pDDF4teiV6nVUXHPcJGFFS9aI/RuWeUIbkCbQJe5rTLiOQ7C2Zu0LygMH7
 IFBlDFM2Bx3cneS/YLdgJUodxplIHUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695663929;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6wpX/KMSe+NK07Hj0KH4xbGagy9Uj3FRnxeusCmbhvk=;
 b=5qWUYCuxhL5nMqKQj3HIm27KmBjJvz+3AblPtK7iX3W13Lma5WQTkhgNGdOcfPyGTJj2pL
 5P1s08W+v/DG4qAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14A3813580;
 Mon, 25 Sep 2023 17:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6S5sADnHEWW4HAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Sep 2023 17:45:29 +0000
Date: Mon, 25 Sep 2023 19:45:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230925174526.GB90566@pevik>
References: <20230920153145.30891-1-mdoucha@suse.cz> <ZQ2E_pKz2QSG61LY@yuki>
 <20230925131235.GB60471@pevik> <ZRGIeNK0Cf3-caZb@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRGIeNK0Cf3-caZb@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pidns05: Use tst_getpid()
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

> Hi!
> > Well, Martin found that some of SLES versions (e.g. some SLES versions based on
> > kernel 4.12 or older) started to fail after rewrite:

> I mean that the second instance of getpid() is not called from cloned()
> process, the first one has to be replaced for sure.

Ah, right. But be consistent with tst_getpid() looks to me slightly better.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
