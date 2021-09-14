Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4F9C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FFF60F58
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1FFF60F58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3DFE3C89CE
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 14:50:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A95063C89CE
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 14:50:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 976872001CE
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 14:50:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B768820109;
 Tue, 14 Sep 2021 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631623817;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xwC7vC9dcg8GqFk/PuXb8f1Hm+DeB1gSi4+DPKa1ZpY=;
 b=CUBgLtH9IFqI6bu681fveAy9yAP8JcMaNApgLA96Sv1A+z0Fzc3jOih9KpELtry3NJTIAR
 neGpcMT+9KVwE5DAk6nIwWkehrYrlI/XBG2rtoQskaveNpu2BD6b2800NlFSl5s90HM7cr
 lBtD5UajOZX/Vj9lcYnMFSmisRN5E04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631623817;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xwC7vC9dcg8GqFk/PuXb8f1Hm+DeB1gSi4+DPKa1ZpY=;
 b=7Woi13Kg+LIFUtF/OZZbn45hvVWLyRTIH/raqmVDMuhvYQ2B6oZXo+zfm8aQi+FTzUml4r
 Sus+Usyg/xOsGvDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E2C713B8A;
 Tue, 14 Sep 2021 12:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZNt4IImaQGFgOAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Sep 2021 12:50:17 +0000
Date: Tue, 14 Sep 2021 14:50:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <YUCah4R0SBDKZvPQ@pevik>
References: <20210914122425.85129-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914122425.85129-1-naresh.kamboju@linaro.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] runtest/smoketest: Remove intermittent failed
 test case route4-change-dst
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
Message-ID: <20210914125015.5x92ZH169AkQZdOM-FZeaMs6pLc2L-FdF2YpIVlTZDA@z>

> The test case route4-change-dst fails intermittently creating
> the problem for smoketest results verdict. route4-change-dst
> is a stress test should not be a part of smoketest. because of
> these issues removing route4-change-dst from the smoketest.

> Suggested-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Did 75184c30a ("lib/tst_net.sh: disable ipv6_dad work on test interfaces")
fixed your problem? I'd actually like to route4-change-dst in smoketest to
have it as a detection DAD issue is working.

Kind regards,
Petr

> ---
>  runtest/smoketest | 1 -
>  1 file changed, 1 deletion(-)

> diff --git a/runtest/smoketest b/runtest/smoketest
> index 7f395936e..dd689bd6f 100644
> --- a/runtest/smoketest
> +++ b/runtest/smoketest
> @@ -12,5 +12,4 @@ stat04 symlink01 -T stat04
>  utime01A symlink01 -T utime01
>  rename01A symlink01 -T rename01
>  splice02 splice02 -s 20
> -route4-change-dst route-change-dst.sh
>  shell_test01 echo "SUCCESS" | shell_pipe01.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
