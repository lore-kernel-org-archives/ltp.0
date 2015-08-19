Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZS3g0-0001T4-TU
	for ltp-list@lists.sourceforge.net; Wed, 19 Aug 2015 13:45:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZS3fy-0001Pp-7C
	for ltp-list@lists.sourceforge.net; Wed, 19 Aug 2015 13:45:12 +0000
Date: Wed, 19 Aug 2015 15:44:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150819134438.GA22714@rei.suse.de>
References: <1436876572-28759-2-git-send-email-mmarhefk@redhat.com>
	<1439899125-7646-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1439899125-7646-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH 2/2 v3] containers/netns tests rewritten
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +cleanup()
> +{
> +	tst_rmdir
> +	ip link del dummy0 2>/dev/null
> +	kill -9 $NS_HANDLE 2>/dev/null
> +}
> +
> +tst_tmpdir
> +NS_HANDLE=$(ns_create net mnt)
> +if [ $? -eq 1 ]; then
> +	tst_resm TINFO "$NS_HANDLE"
> +	tst_brkm TBROK "unable to create a new network namespace"
> +fi
> +TST_CLEANUP=cleanup
> +ls /sys/class/net >sysfs_before
> +
> +
> +ns_exec $NS_HANDLE ip link add dummy0 type dummy || \
> +	tst_brkm TBROK "failed to add a new dummy device"
> +ns_exec $NS_HANDLE mount -t sysfs none /sys 2>/dev/null
> +kill -9 $NS_HANDLE

I'm a bit puzzled here. Why do we have to mount the sysfs in the
namespace if we aren't doing anything with it?

Also shouldn't we destroy the namespace after we save the sysfs_after?

> +ls /sys/class/net >sysfs_after
> +diff sysfs_before sysfs_after
> +if [ $? -eq 0 ]; then
> +	tst_resm TPASS "sysfs not affected by a separate namespace"
> +else
> +	tst_resm TFAIL "sysfs affected by a separate namespace"
> +fi
> +
> +tst_exit

Otherwise I'm ready to push these two patches (I did minor fixes in the
first one to silence compiler warnings though).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
