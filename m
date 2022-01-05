Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D3FC433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 17:17:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A8553C92A3
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 18:17:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3B5B3C00A6
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 18:16:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DAC1E100095A
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 18:16:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 22CFB1F37F;
 Wed,  5 Jan 2022 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641403015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dn7SSKHDBLUlL2h1ZjVH+QU1kYVEW7cLS8hUwl3Hi7g=;
 b=TsyK1OaaFdSvnurJcAZfY8JNha5QgHNyfrsC76V12w5ipKNFbWtUVgnjk8KD4xjcZlXYNV
 Q4zDRGXJAi6LUP/685HQ9rSBxYvEwFTQePEBUs32DSxF0woRpzlbK0eL1xRKnxQuN1CNUO
 oKrVGJPGhEB6SBpYh+12EUE6BZxs7gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641403015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dn7SSKHDBLUlL2h1ZjVH+QU1kYVEW7cLS8hUwl3Hi7g=;
 b=GrLTC9rXA9xXsSfsK1Y5Zg8DVzLlUQ8yLrpjJe8KsHVNxo4J10RkU36RTgtvnOgw374nCp
 WvaxZR6/hG+Sh8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D765713BF9;
 Wed,  5 Jan 2022 17:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rdvHMYbS1WEjIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jan 2022 17:16:54 +0000
Date: Wed, 5 Jan 2022 18:16:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YdXShIOue2pXGr0C@pevik>
References: <20220103151332.1989-1-pvorel@suse.cz>
 <20220103151332.1989-2-pvorel@suse.cz> <YdQpS0WPRvz4vZup@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdQpS0WPRvz4vZup@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ustat0{1,
 2}: Mark failure on Btrfs with known-fail tag
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

Hi Cyril,

> > +	.tags = (const struct tst_tag[]) {
> > +		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs"},
>                                    ^
> 				   Maybe we should just remove the
> 				   "known to fail" from these messages.

> Since the code in the library will print:

> ---
> You _MAY_ be hit by known kernel failures:

> ustat() is known to fail with EINVAL on Btrfs
> ---

> so the 'known to fail' part is redundant here.

> What about:

> ---
> You _MAY_ be hit by known kernel failures:

> ustat() fails with EINVAL on Btrfs
> ---

+1

> Other than this I think that this is a good way how to put these kind of
> hints into the testcases.


> Also I do wonder if there is a good URL that would contain more verbose
> description of the problem but I guess there isn't. Well maybe this one:

> https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg95697.html
Let's use lore.
https://lore.kernel.org/linux-btrfs/CAB=NE6X2-mbZwVFnKUwjRmTGp3auZFHQXJ1h_YTJ2driUeoR+A@mail.gmail.com/

But I'd put Josef Bacik's reply as he's a maintainer:
https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/

> Not sure how to encode that, maybe just add it to the test top level
> comment?
I'd prefer to have it in metadata html/pdf and in known-bug section.
Thus I'd prefer:

	.tags = (const struct tst_tag[]) {
		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see "
			"https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
		},
		{}

But while this is obviously ok for test output:

$ ./ustat01 -h
...
Tags
----
known-fail: ustat() is known to fail with EINVAL on Btrfs, see https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/

It gets parsed as new line:

  "ustat01": {
   "tags": [
     [
      "known-fail",
      "ustat() is known to fail with EINVAL on Btrfs, see ",
      "https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
     ]
    ],
   "fname": "testcases/kernel/syscalls/ustat/ustat01.c"
  }

Unless you think it's useful to expect that tag values can have longer input and
thus testinfo.pl should use all array items (except the first which is key),
I'd go the easy way and put the link only to top level docparse section as you
suggested.


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
