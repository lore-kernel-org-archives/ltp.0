Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D40BCD4F33
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 09:09:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D49283CE37D
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 11:09:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A63923C8946
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 11:09:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 269FD1BB9FAF
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 11:09:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 740BA1F38A;
 Fri, 22 Sep 2023 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695373775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=onGdSnf1TabhST/nVQOzguCOB3OwnFwkbl9U7FML82U=;
 b=QQWghVX07yAEd/c8giGyj2aEmDo+G/Nrdhdvi5pyuL7lXrmlUdxjDG2Lguao/8N4tv7zTv
 yT/FmpboyILjqAavxFaxW8CtXIK/u7q4ZdR7Tl62C+YLNK6ZYq4er0Sde/5aJIVtY6gE1w
 5tg8jI1RtR0CJBHZFeCx/zsQ47rjhWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695373775;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=onGdSnf1TabhST/nVQOzguCOB3OwnFwkbl9U7FML82U=;
 b=ohri14qvNI6wH0btb6pqb/u4FXiGUIfOjHLYfJdc9tzLbQZgtJnDLd3Hty0RfgP8qoO1Ja
 bDifj/b95uzQaqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D23D13478;
 Fri, 22 Sep 2023 09:09:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tEqNFc9ZDWWgUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 22 Sep 2023 09:09:35 +0000
Date: Fri, 22 Sep 2023 11:10:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Reuben Hawkins <reubenhwk@gmail.com>
Message-ID: <ZQ1Z_JHMPE3hrzv5@yuki>
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com, willy@infradead.org,
 oe-lkp@lists.linux.dev, kernel test robot <oliver.sang@intel.com>,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> ack.  Will try to test.  My Ubuntu 22.04 system wasn't able to find
> packages called
> for by the test case, so it'll take me a little while to figure out how to
> get the
> test case working...

Huh? The test is a simple C binary you shouldn't need anything more
than:

$ git clone https://github.com/linux-test-project/ltp.git
$ cd ltp
$ make autotools
$ ./configure

$ cd testcases/kernel/syscalls/readahead
$ make
$ ./readahead01

And this is well described in the readme at:

https://github.com/linux-test-project/ltp/

And the packages required for the compilation are make, C compiler and
autotools nothing extraordinary.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
