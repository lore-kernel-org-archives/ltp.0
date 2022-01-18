Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6E0C433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 09:36:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6B9F3C9688
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 10:36:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FA463C9617
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 23:13:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B2F820097D
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 23:13:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 79C5A1F37E;
 Tue, 18 Jan 2022 22:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642544024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AAHvca2bpoYeHXHo+BMAx7zj5Lkev8D5VT+5PlIT8ec=;
 b=OT4sSt4GojfmivoxgbSzf3kcx6BhT9Wz2GnqgxB5rHsSgMVnm709x6CX+f1f2/1JNNI7ge
 wcQpayQRI7np0jcvd5N1znxArTQPEq1aebZRoE6hmMHE4FXEgDU6utOkmEErOtmE3C8jN6
 p4IHVPqvH1enkMxyGjjlJa68Ww8alDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642544024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AAHvca2bpoYeHXHo+BMAx7zj5Lkev8D5VT+5PlIT8ec=;
 b=4r/8QtGnoQrcptONNaqaCvzG/YBhIRAQhKGym1kxw0LQ0vRdSv6bliofXkqQt1N9mpWOvm
 brZbD4LXD9rdcuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E83E13AD9;
 Tue, 18 Jan 2022 22:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id y6sfB5U752HnGQAAMHmgww
 (envelope-from <neilb@suse.de>); Tue, 18 Jan 2022 22:13:41 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Nikita Yushchenko" <nikita.yushchenko@virtuozzo.com>
In-reply-to: <a35ebb8b-6e61-8445-cf19-285bf2f875ad@virtuozzo.com>
References: <YebcNQg0u5cU1QyQ@pevik>,
 <a35ebb8b-6e61-8445-cf19-285bf2f875ad@virtuozzo.com>
Date: Wed, 19 Jan 2022 09:13:35 +1100
Message-id: <164254401568.24166.883582030601071761@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
 kernel@openvz.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 19 Jan 2022, Nikita Yushchenko wrote:
> 18.01.2022 18:26, Petr Vorel wrote:
> > Hi all,
> > 
> > this is a test failure posted by Nikita Yushchenko [1]. LTP NFS test nfslock01
> > looks to be failing on NFS v3:
> > 
> > "not unsharing /var makes AF_UNIX socket for host's rpcbind to become available
> > inside ltpns. Then, at nfs3 mount time, kernel creates an instance of lockd for
> > ltpns, and ports for that instance leak to host's rpcbind and overwrite ports
> > for lockd already active for root namespace. This breaks nfs3 file locking."
> 
> What exactly happens is:
> 
> Test runs 'mount' in non-root netns, trying to mount a directory from root netns of the same host via nfsv3
> 
> (Part of) call chain inside the kernel
> 
> nfs_try_get_tree()
>   nfs3_create_server()
>    nfs_create_server()
>     nfs_init_server()
>      nfs_start_lockd()
>       nlmclnt_init()
>        lockd_up()
>         svc_bind()
>          svc_rpcb_setup()
>           rpcb_create_local()
> 
> ... and at this point it tries AF_UNIX connection to /var/run/rpcbind.sock
> 
> AF_UNIX is not netns-aware.
> So it connects to host's rpcbind.
> And overwrites ports registered in host's rpcbind by lockd instance for root namespace. Since this 
> point, lockd instance for root namespace becomes no longer accessible (it still listens but nobody can 
> learn the ports). Thus nfs locks don't work.
> 
> I'm not sure what is the correct behavior here.
> 
> Maybe rpcb_create_local() shall detect that it is not in root netns, and only try AF_INET connection to 
> localhost in that case.

That would be simple and might be sensible.  IF changing the AF_UNIX
path to "/run/rpcbind.sock" isn't sufficient, then testing for the
root_ns is probably the best second option.

Thanks,
NeilBrown

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
