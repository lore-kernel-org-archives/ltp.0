Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419C9C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 17:47:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87A793CAEB5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 19:47:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5825D3CA514
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 19:47:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BED73600066
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 19:47:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E3543370C;
 Mon, 10 Oct 2022 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665424046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvaxwgONXdovA9rZqUeMQfJSRqwQfe3GdoRVI0eU9tg=;
 b=SYENJ2Np8SZ/FpB1QZTvsQbQuhzxNb7NFKROM8tp3TAv/lxTDnbHR3psw09HFjabncbJz/
 +YlpZe+BbJugoMkZyt0Qa9g9mYaTbDEo0lAhbUTrxl1WL3ELPJIs7Tmm3XDO6QK8X9Poss
 ekesJLxUTLEFVLmjyopOTv92vX2MieU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665424046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvaxwgONXdovA9rZqUeMQfJSRqwQfe3GdoRVI0eU9tg=;
 b=yZnfjhos9FbQA7XPjHDzIAAORE3GUGsVZSC5QlJCJmEpUPSXHMjoFM2aCvBjL7z+ix2Lcg
 Df5pZG11ij479CBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE66113ACA;
 Mon, 10 Oct 2022 17:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 02kmOq1aRGMrcgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 10 Oct 2022 17:47:25 +0000
Date: Mon, 10 Oct 2022 19:49:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <Y0RbGMRj8rDC2Eti@yuki>
References: <20221006184228.3281392-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221006184228.3281392-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/4] mmapstress01: refactor to ltp framework
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Looks mostly done now, but there are still a few things to fix, some of
them purely cosmetic:

* The finished global has to be volatile otherwise it may get
  miscompiled and it has to be reset at the start for the run()
  otherwise the -i option is broken

* The sighandler setup can be moved to the test setup()

* Now we do not use the pidarray to kill the child processes so it
  became mostly useless, I would consider getting rid of that too

* I'm failing to see why we need to block SIGALRM just before alarm(0)
  as far as I can tell it's completely useless. Also blocking signals
  while we refork looks questionable.

* I would consider getting rid of obvious comments, quite a few of them
  are commenting the obvious

  The ifdefs in setup() does not look nice, maybe we should do something as:

#if _FILE_OFFSET_BITS == 64
# define FSIZE_MIN LONG_MIN
# define FSIZE_MAX LONG_MAX
#else
# define FSIZE_MIN INT_MIN
# define FSIZE_MAX INT_MAX
#endif

 And use the FSIZE_MIN and FSIZE_MAX to avoid ifdefs in the test setup()

* The top level comment should be converted to docparse comment so that
  it's picked up by the documentation parser, that means that the
  comment should start with:

  /*\
   * [Description]
   *

   And should be formatted in asciidoc

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
