Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4531CC433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 12:58:10 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C1E6101B
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 12:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79C1E6101B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17DE23C926B
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:58:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 035E63C8A84
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:57:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9580160009E
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:57:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E16E61FFD1;
 Mon, 13 Sep 2021 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631537877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G16xbJGz9jI6CiuOEMIuTITnPYCAV/Vf9gC0sr3mABU=;
 b=Ffo4Tl0u8DbiFUSsHMoqrjBO15Wc+OsouQo/uGS70Dc+nqMWOqLWlEwRszxMgPIw2z48tg
 6AxUXgiCfzLlrM3a5Gv+WOmJT1LTcW52MfAS5+EOB6kUoTtaHx2Qp1/8uuFU6zqLZIIzq3
 odUF6ZgieZ8pSRCUdWuz3o0s48b67XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631537877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G16xbJGz9jI6CiuOEMIuTITnPYCAV/Vf9gC0sr3mABU=;
 b=eCu8le/oJMF8L/+GUqKe/Djmmy4tjra1K9x/iS6N/kdMX5xR1n7nF9guHHiHyTVyKuAh59
 vd5LCxDgk0QIGzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBA2413AA9;
 Mon, 13 Sep 2021 12:57:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4KMdMtVKP2HqLwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Sep 2021 12:57:57 +0000
Date: Mon, 13 Sep 2021 14:58:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YT9K6Xl9iP8sx2/y@yuki>
References: <20210913100022.14501-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913100022.14501-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] sched: Remove process.c
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
Message-ID: <20210913125817._j69lBbfuKH-VkIdxWybZyd6Ru19DbJFlF8bK14mgGk@z>

Hi!
> Test was removed as buggy from the runtest file nearly 20 years ago in:
> 576f1ee56 ("Removed a test that was not correctly running.")
> 
> Test is probably obsolete, not using even legacy API, non-zero exit:
> 
> $ ./process -d 8 -b 2 -t 1; echo $?
> total number of process to be created nodesum (511) is greater
>  than the allowed SEMMSL value (250)
> reseting the value of nodesum to SEMMSL
> Terminated
> 143
> 
> + leaving very high load after being terminated.
> 
> Reported-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

I was looking at the test and while the idea seems to valid and
interesting, the implementation is buggy, it does not take much to make
it segfault and it tends to leave processes unterminated, so it would be
probably easier to implement something from scratch.[

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
