Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218ABC433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 13:02:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943C760F45
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 13:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 943C760F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCD763C8A2F
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 15:02:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F7713C2601
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 15:01:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 01FA21000A0E
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 15:01:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 587741FEF7;
 Mon,  6 Sep 2021 13:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1630933313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HKySar8UHKEB/ZBoMex5MklXX6zCep/miMjYCQr7VE0=;
 b=P5mjfmgpONv+sKfjJ0IxLTqHJqH08NH6qyadEq4Dr5zKMyufBOumRdSQs2y3/mimokTMQO
 vhMzB8lHfN1+n4O/KP8BVww/hI2YLdeHfbx/OMtc971YZiFfGc481bnwxdzKLqkya9/4xn
 WgMpH5sLlZ1kkE763R5OQBRAw8KCXDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1630933313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HKySar8UHKEB/ZBoMex5MklXX6zCep/miMjYCQr7VE0=;
 b=aBrZPgj1+z7gJJOiu1TLqNVSBHLkhnSjegCVoRFEtf3RGYkKhJfvRslZSu/szp1L0T5s4B
 947N/fWvc0L4FxBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4574613B50;
 Mon,  6 Sep 2021 13:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iinKD0ERNmGhRAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 06 Sep 2021 13:01:53 +0000
Date: Mon, 6 Sep 2021 15:02:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YTYRTG9uXJdUaGtg@yuki>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-5-mdoucha@suse.cz> <YTYJUPFc75TuOJSb@yuki>
 <77fd98d9-5257-c1da-a01b-77d8cc1b6bce@suse.cz>
 <YTYOpPM5uupQrayf@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YTYOpPM5uupQrayf@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] syscalls/kill05: Use any two unprivileged
 users
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
Message-ID: <20210906130204.nvJEnJabb2tllh96oUZ_vFJPPjHs9O8_owuRk94rnxE@z>

Hi!
> > We could just use UID 1 and 2 for this test but I'd rather not assume
> > that set*uid() functions allow setting unused UIDs. Even if it works
> > now, it could easily break in the future or on some special system auth
> > backends.
> 
> Don't we already depend on being able to use unused GID? How is this
> different?

Hmm we pass the unused GID mostly to chown(), but still.

The Linux manual page specify that setuid() may fail to change if
the UID is not valid inside a namespace, that means that either there is
no UID map or particular UID is missing from the UID map. So reading
/etc/passwd hypotetically help if we are inside of a thight container
and /etc/passwd matches the UID map, but I'm not sure if this is worth
of the effort.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
