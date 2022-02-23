Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1FEC433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 12:41:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC2663C97AD
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 13:41:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04B823C690D
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 13:41:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E02C41401725
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 13:41:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B4C5A1F3A3;
 Wed, 23 Feb 2022 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645620066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0yycEC7AIMNNGhV2UF7k613SbxxioA3/bvTDKP0jy5s=;
 b=EkS+B0wKG+1cK6Jybmz0jXkBSHuXvz+CSbEW5dwdDPT3Wz8IIdY8gjft7CZEKNXhHyzo1E
 AV6dBZ97/3dQal4tyaCcGpl+y8smq4NqbEfEmVl17xULIy4SCGJ4rF/6yTn2l3lUDuIoEQ
 CQOnwUpFOZ/ZufgFbvDwlEl7q9K1dvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645620066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0yycEC7AIMNNGhV2UF7k613SbxxioA3/bvTDKP0jy5s=;
 b=N7Ub1Ukdl+0/CeF83UC096n1w/8pU8y34qEcV0XwZmmD1MevI/sUyJNNVzsg5rsv4szywf
 KTomw72c3mCG69Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BE2413D36;
 Wed, 23 Feb 2022 12:41:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MNwGGWIrFmK4EQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Feb 2022 12:41:06 +0000
Date: Wed, 23 Feb 2022 13:43:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kushal Chand <kushalkataria5@gmail.com>
Message-ID: <YhYr5w2BaHkO9f+q@yuki>
References: <20220210105101.38337-1-kushalkataria5@gmail.com>
 <YgUw7scGZwUcK22E@yuki>
 <CAKaR1hXZL5vfq_SXXwyh8wCr4Rwwugi4ydDzXKhMwGVUsiHoBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKaR1hXZL5vfq_SXXwyh8wCr4Rwwugi4ydDzXKhMwGVUsiHoBQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fstat_02: Increase test coverage by creating
 hard link to file and validate using fstat
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

Hi!
> Apology for the late reply.
> 
> I am not sure about the st_blocks size. If you can guide me how to check
> that I might work on that?

Just read the man 2 stat:

...
               blkcnt_t  st_blocks;      /* Number of 512B blocks allocated */
...

For large enough files the size/512 rounded up should be close to the
number of blocks (there would be usually a few more blocks preallocated
for the file than the actuall size is). Filesystems tend to allocate
more than one block when file needs to be extended, it looks like common
value is PAGE_SIZE/512. So I guess that a reasonable test would create a
few files somewhere between half a megabyte and a few megabytes in size
and then check that the size/blocks ratio is somewhere between 512 and
512-epsilon. As long as the file size is order of magnitude larger than
PAGE_SIZE it should be safe to set the epsion to 10% of the blocksize
i.e. 51.

> Are you planning to merge this patch with the st_blocks check or the
> current version is ready to be merged?

The patch has been already merged, I was just pointing out other fields
that are not validated in the test.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
