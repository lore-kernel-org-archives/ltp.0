Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838D3C433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 09:36:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 780CF3C968F
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 10:36:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B70D23C9617
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 23:12:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A76810004A4
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 23:12:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 23425212B8;
 Tue, 18 Jan 2022 22:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642543923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIjGoioz1ktw+V2nDlWEmosZi3TFcipP21grgpN+1V0=;
 b=gaY5uJ1oI+p1+NKVysvm/SE7c0eXXqunxjC+rxHTQHojHvA7zr2W7gHvJOoZS9/2xHSCnR
 rMaR2UlYk8nfdUOWbFbmwKFgK4Rm6H4bRj3KE4SqhEAx77obgtmv5rmtTQStTD9xRRMjgR
 wNsNY2TaJN8wgqvvDz2LjErHKNiYXZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642543923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIjGoioz1ktw+V2nDlWEmosZi3TFcipP21grgpN+1V0=;
 b=p9rAbPEHAH/GkzjdVt4UYmnDTTwJxkP7+H4//IGoW754UKGW8MHbFx8xPdRTBSnNxqzIn5
 w5+6i52UNNI6iLBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64CC713AD9;
 Tue, 18 Jan 2022 22:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xZtaCDA752EeGQAAMHmgww
 (envelope-from <neilb@suse.de>); Tue, 18 Jan 2022 22:12:00 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Petr Vorel" <pvorel@suse.cz>
In-reply-to: <YebcNQg0u5cU1QyQ@pevik>
References: <YebcNQg0u5cU1QyQ@pevik>
Date: Wed, 19 Jan 2022 09:11:57 +1100
Message-id: <164254391708.24166.6930987548904227011@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 19 Jan 2022 10:36:30 +0100
Subject: Re: [LTP] LTP nfslock01 test failing on NFS v3 (lockd: cannot
 monitor 10.0.0.2)
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
Cc: linux-nfs@vger.kernel.org, Steve Dickson <SteveD@redhat.com>,
 Anna Schumaker <anna.schumaker@netapp.com>,
 "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, ltp@lists.linux.it,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 19 Jan 2022, Petr Vorel wrote:
> Hi all,
> 
> this is a test failure posted by Nikita Yushchenko [1]. LTP NFS test nfslock01
> looks to be failing on NFS v3:
> 
> "not unsharing /var makes AF_UNIX socket for host's rpcbind to become available
> inside ltpns. Then, at nfs3 mount time, kernel creates an instance of lockd for
> ltpns, and ports for that instance leak to host's rpcbind and overwrite ports
> for lockd already active for root namespace. This breaks nfs3 file locking."

"not unsharing /var" ....  can this be fixed by simply unsharing /var?
Or is that not simple?

On could easily argue that RPCBIND_SOCK_PATHNAME in the kernel should be
changed to "/run/rpcbind.sock".  Does this test suite unshare /run ??

BTW, your email contains [1], [2], etc which suggests there are links
somewhere - but there aren't.

NeilBrown

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
