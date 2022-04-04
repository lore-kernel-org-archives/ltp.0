Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C866FC433EF
	for <ltp@archiver.kernel.org>; Mon,  4 Apr 2022 12:55:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 475EC3CA3F9
	for <ltp@archiver.kernel.org>; Mon,  4 Apr 2022 14:55:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FDFF3C712C
 for <ltp@lists.linux.it>; Mon,  4 Apr 2022 14:55:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C385520015D
 for <ltp@lists.linux.it>; Mon,  4 Apr 2022 14:55:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C20B0210EE;
 Mon,  4 Apr 2022 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649076943;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BzNZxsL12g47WQItUgDKUXW4GOizzaBzmFR/v/nqhiE=;
 b=bUtwPiaKzZNyifHS8ZHEBlgQVHu3WMGqYMpuy0uPhybXZ3rNCtngTD6rwIujcuLc554tXx
 D7b9Gehs24hBnKE+G6AJyFGZisPT20eZ2u3RAmDvUBNn5B9bVKCFbnYqmhuHGzD+Q3vm6r
 MbX+blqlD1LF4vwqN/9+KS9S94qbnZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649076943;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BzNZxsL12g47WQItUgDKUXW4GOizzaBzmFR/v/nqhiE=;
 b=dfgK7kedsxgDa/DjotYCWgKqKr8DzdmebzJs0NJUPHXxIxye1KGMzk7Mn8yAA75t4ZH4cZ
 psZHm7Gy3MO69/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8060912FC5;
 Mon,  4 Apr 2022 12:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EEENHc/qSmIXDwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 04 Apr 2022 12:55:43 +0000
Date: Mon, 4 Apr 2022 14:55:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YkrqzV+W2qYKJuIw@pevik>
References: <20220401050804.1286-1-andrea.cervesato@suse.de>
 <YkrJfb0vZq6WSZmX@pevik>
 <348d5c14-97e2-7c23-9666-92ba77354417@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <348d5c14-97e2-7c23-9666-92ba77354417@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Rewrite userns06.c using new LTP API
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

Hi Andrea,

> Hi Petr,

> can TST_TEST_CONF be used even if TST_NO_DEFAULT_MAIN is defined?
I'm sorry, you're right it can't be used like that.

TST_NO_DEFAULT_MAIN could be defined only in #ifdef HAVE_LIBCAP:

#include "config.h"
#ifdef HAVE_LIBCAP

#define _GNU_SOURCE
#define TST_NO_DEFAULT_MAIN
#include "tst_test.h"
...
#else
#include "tst_test.h"
TST_TEST_TCONF("System is missing libcap");

But that's not much improvement indeed, thus lets ignore it.

Also, #define _GNU_SOURCE should be IMHO before any first include,
i.e. even before tst_test.h (it includes many system headers).

Kind regards,
Petr

> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
