Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF043C19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 09:42:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AE653C95EE
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 11:42:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C0853C0763
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 11:42:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ADDCE1A00CAB
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 11:42:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F5215C919;
 Thu, 11 Aug 2022 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660210964;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u+rfhOqg2s8JY+GmoulBHbWXnPtCg6dhgFm5WYM3awM=;
 b=cogOdzvJaRmNhxqvt93uCJgZ6tZcYHg46lW+kln8CjbjRo15Hg9kQe1xf7bUJh2bYaE5Wz
 vZgoRnMH42IaUD1WYY4+54bCMvvsWz5imTFG+rHAxWPONjxHgFeHYDaIFf49gAvQLBnIsM
 CGNxThEaEIOm5bzSe+6BkPxvfgU5I2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660210964;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u+rfhOqg2s8JY+GmoulBHbWXnPtCg6dhgFm5WYM3awM=;
 b=oWME9yRJUHdlTjXIQ8UxQLIUDgtbxjSk+pXVM6CgtMofeDIVJaKP9PsAEY5myXMID+laFq
 eqtA9MA/8dJbHYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 651F31342A;
 Thu, 11 Aug 2022 09:42:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UhnwFhTP9GJldQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 11 Aug 2022 09:42:44 +0000
Date: Thu, 11 Aug 2022 11:42:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YvTPEoDUp4AKu/0V@pevik>
References: <20220810092804.5771-1-andrea.cervesato@suse.com>
 <YvOKbt1urOeVwQ57@yuki>
 <ade189ba-4211-99a8-d5e6-c99b1950e21b@suse.com>
 <YvOmiXBO1njKMzUM@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvOmiXBO1njKMzUM@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor aiocp using new LTP API
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

Hi all,

> Hi!
> > Yes, we can reduce the amount of time to generate file (especially if 
> > it's really big), but I wouldn't
> > introduce any repetition because we would like to check that file has 
> > been copied properly during
> > callbacks which are asynchronous by definition.

> I guess that we can do a little trick such as making the buffer with
> random data slightly bigger and choosing a random start offset in that
> etc.

I tested Andreas patches from v2 to v6 and aiocp with -f DIRECT works only on
btrfs. Running on $TMPDIR being on ext4, xfs, tmpfs endup with EINVAL:

# ./aiocp -b 1k -n 1 -f DIRECT
aiocp.c:240: TINFO: Maximum AIO blocks: 65536
aiocp.c:265: TINFO: Fill srcfile.bin with random data
aiocp.c:267: TBROK: open(srcfile.bin,16450,0666) failed: EINVAL (22)

Any idea what could be wrong?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
