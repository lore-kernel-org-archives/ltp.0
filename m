Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D62DC7EE21
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 22:00:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A15923CBA55
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 00:00:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB1993CB737
 for <ltp@lists.linux.it>; Fri,  5 May 2023 00:00:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C4B06600C36
 for <ltp@lists.linux.it>; Fri,  5 May 2023 00:00:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 987D822C6A;
 Thu,  4 May 2023 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683237640;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1z8k3zObH13DGCmCkCzS7+8pYZEXK5t6Avey+wIKjAw=;
 b=ZivXYlGJUghyiDoOQAt0AHOcIB8RztQhs+chAn62waGVN4242NZPvkGRLIX2RBZtRW9MP8
 x9Hd3MqRrymgvmPB6uFiu4JC7eZz6RalfU3kiqfe5U0+c6WaJRfgG/UnTLvww9YNFsCJMB
 tgOXMeUN/8Jm0Gye9CqKO0XEKNtI3hA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683237640;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1z8k3zObH13DGCmCkCzS7+8pYZEXK5t6Avey+wIKjAw=;
 b=S05iTMO8VIhTo9P5f/rGHhkz7rx7OVsC6cDtVwdH+ji+pdEoFKnnb9EFCSB8ZoURSPQmpL
 hM1vuBs6B5ctRVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7A0E133F7;
 Thu,  4 May 2023 22:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PH29MAcrVGQjTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 22:00:39 +0000
Date: Fri, 5 May 2023 00:00:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230504220037.GB4244@pevik>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-6-pvorel@suse.cz> <ZFO6ywouPkmNKtkr@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFO6ywouPkmNKtkr@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 5/5] nfs: Run on btrfs, ext4, xfs
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> >  nfs_get_remote_path()
> > @@ -210,6 +213,7 @@ nfs_cleanup()
> >  		grep -q "$local_dir" /proc/mounts && umount $local_dir
> >  		n=$(( n + 1 ))
> >  	done
> > +	sleep 2

> >  	n=0
> >  	for i in $VERSION; do
> > @@ -219,12 +223,15 @@ nfs_cleanup()
> >  		if tst_net_use_netns; then
> >  			if test -d $remote_dir; then
> >  				exportfs -u *:$remote_dir
> > +				sleep 1
> >  				rm -rf $remote_dir
> >  			fi
> >  		else
> >  			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
> > +			sleep 1
> >  			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
> >  		fi
> > +
> >  		n=$(( n + 1 ))
> >  	done

> Generally I'm not happy about the sleeps in the code, the main problem
> is that the test still may fail in a case that something was slower than
> usuall and we decided to proceed after we slept for a pre-defined
> interval. Ideally these should be replaced with a active waiting, i.e.
> loop that checks some condition 10 times in a second or so. Hoewever I'm
> okay with getting this in so that we manage to have these tests in
> before the release and fixing it later on.

I wonder myself what is wrong and if there is a problem with my code (likely) or
with nfsd or with loop device (Christoph Hellwig has been changing
drivers/block/loop.c quite a lot).

Because if first umount is too early, it does not recover (i.e. tst_umount
contain 50 times trying to umount with 100ms, and that does not help).

I also wonder how should I detect it's ready to be umounted.
I'll have look if losetup "fuser -vm /dev/loop0" would help, but instead of
depending on the device, we'd probably want to look into /proc/mounts, right?
Tomorrow I'll test this:

check_umount()
{
	local i
	local dir="$1"
	local type="${2:-lhost}"
	local cmd="grep -q $dir /proc/mounts"

	for i in $(seq 50); do
		if [ "$type" = "lhost" ]; then
			$cmd || return
		else
			tst_rhost_run -c "$cmd" || return
		fi
		tst_sleep 100ms
		tst_res TWARN "failed to umount '$dir'"
	done
}

	for i in $VERSION; do
		local_dir="$(get_local_dir $i $n)"
		grep -q "$local_dir" /proc/mounts && umount $local_dir

		# instead of 'sleep 2' below check here:
		check_umount "$local_dir"

		n=$(( n + 1 ))
	done

	n=0
	for i in $VERSION; do
		type=$(get_socket_type $n)
		remote_dir="$(get_remote_dir $i $type)"

		if tst_net_use_netns; then
			if test -d $remote_dir; then
				exportfs -u *:$remote_dir
				check_umount "$remote_dir" # instead of sleep 1
				rm -rf $remote_dir
			fi
		else
			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
			check_umount "$remote_dir" rhost # instead of sleep 1
			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
		fi

		n=$(( n + 1 ))
	done

[1] https://gitlab.com/psmisc/psmisc/-/blob/master/src/fuser.c

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
