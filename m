Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD9BEB64DA
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 09:10:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87FB53C9901
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 11:10:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C8FA3C98F6
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 11:10:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E2CE81400DB3
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 11:10:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D5872195F;
 Tue, 18 Jul 2023 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689671434;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjTjy8bD3w9DvRPImUgRpOPNPTrxRdwaCRNZC4ChKoU=;
 b=MBiFUahqa/MCGv/mqC8Ps52wf8DzczakgtxZMqZSuHa+5iNwPFoADR6fcr4EG1yKUWPXKP
 dKbUqMsQdrn6kpPmRpNonkieRdJw6CCcVbohvpQ8icnfTjl1CLsuxj78Fc/46+01ThCOVx
 1iOGHQAlOVdJLIjOdYdNIiKRM/H6aPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689671434;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjTjy8bD3w9DvRPImUgRpOPNPTrxRdwaCRNZC4ChKoU=;
 b=x8C9NF5/Qyg+tX17//LLcfNgr5MhVohJLIfu9eo4JqX0SUVHTURTy403q3dyWagM9jOx+j
 AS4rr9UdHBVxP7Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8486613494;
 Tue, 18 Jul 2023 09:10:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 97IkHglXtmSGWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jul 2023 09:10:33 +0000
Date: Tue, 18 Jul 2023 11:10:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <20230718091031.GB1140910@pevik>
References: <20230717213424.GB3842864@mit.edu>
 <87h6q2nfr7.fsf@doe.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87h6q2nfr7.fsf@doe.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next: kernel BUG at fs/ext4/mballoc.c:4369!
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
Cc: Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-mm <linux-mm@kvack.org>, Andreas Dilger <adilger.kernel@dilger.ca>,
 LTP List <ltp@lists.linux.it>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> "Theodore Ts'o" <tytso@mit.edu> writes:

> > On Mon, Jul 17, 2023 at 08:04:54PM +0530, Ritesh Harjani wrote:

> >> These can basically trigger in extremely low memory space and only when
> >> such ranges exist in the PA rbtree. Hence, I guess it is a little hard
> >> to tigger race.

> > Ritesh, thanks for looking into this!

> > Naresh, how easy is it for you to trigger the BUG when using LTP?  I
> > did two xfstests runs using "gce-xfstests -c ext2/default -g auto",
> > one on the ext4 dev branch, and one on linux-next 20230717, and I
> > wasn't able to trigger the BUG.

> > If you can trivially trigger it using LTP (perhaps with a low memory
> > configuration in your test setup?), that would be useful to know.

> Hi Ted,

Hi Ted, Ritesh, all,

> Sorry for wrong choice of words. By low memory space I meant low disk
> space i.e. ENOSPC test (fs_fill). I reproduced it like this - 

> root@ubuntu:/opt/ltp# while [ 1 ]; do ./runltp -s fs_fill; sleep 1; done

Late, but better than never: LTP C tests can be run without any wrapper.
e.g. to reproduce the bug triggered by fs_fill, you can just:

git clone https://github.com/linux-test-project/ltp.git && cd ltp
./ci/your-distro.sh # optionally install the dependencies
make autotools
./configure
cd testcases/kernel/fs/fs_fill/
make -j`nproc`
while true; do ./fs_fill; sleep 1; done

NOTE: runltp is
1) deprecated, replaced by runltp-ng [1]
2) again, there is no need to use this shell wrapper to run a single C binary

Kind regards,
Petr

[1] https://github.com/linux-test-project/runltp-ng

> For me it took around ~1-2 hours for it to reproduce when I tried again.
> I am hoping if we run generic/269 (fsstress ENOSPC) in a while loop like
> this maybe it can hit this bug. But I didn't give it a shot.

> -ritesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
