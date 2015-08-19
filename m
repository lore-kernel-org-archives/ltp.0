Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZS6CV-0001X8-Iy
	for ltp-list@lists.sourceforge.net; Wed, 19 Aug 2015 16:26:55 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZS6CT-0007Lr-Or
	for ltp-list@lists.sourceforge.net; Wed, 19 Aug 2015 16:26:55 +0000
Date: Wed, 19 Aug 2015 18:26:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150819162621.GA2356@rei.suse.de>
References: <1436876572-28759-2-git-send-email-mmarhefk@redhat.com>
	<1439899125-7646-1-git-send-email-mmarhefk@redhat.com>
	<20150819134438.GA22714@rei.suse.de>
	<1244717184.10704034.1439998635401.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1244717184.10704034.1439998635401.JavaMail.zimbra@redhat.com>
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
> mounting sysfs in a separate (net + mnt) namespace will cause that
> inside that namespace in /sys/class/net/ we will see only network
> devices local to the separated namespace including dummy device
> created by the test (without mounting sysfs we would see all the devices
> from main namespace). Now back in the main namespace we check that this
> mount had no influence on the main namespace (ls /sys/class/net >sysfs_after).
> I thought that test description says it clear.

So we are testing that mounting the /sys in new mount namespace does no
propagate to the main namespace?

In this case it makes sense.

Also do we want to assert that the dummy0 device is listed in the /sys
inside the namespace?

> To the namespace destroying: as NS_HANDLE is a pid of a process, which keeps
> namespace alive (see ns_create.c for details), we can destroy namespace
> by killing this process.

I pretty much know that allready (I've spend quite some time reading the
code you wrote).

And if I understand it correctly removing the namespace will also remove
the dummy device that has been created in that namespace, right? So that
the sysfs_after will be same regardless if the dummy device was
propagated or not. Which is the reason I wanted to sample the directory
before we remove it.

> Anyway, one thing you can do before pushing the patch is to remove
> kill -9 $NS_HANDLE
> command from the test code, as this is done inside cleanup function.

Killing it twice once in the test and once in the cleanup is mistake as
well. Since the NS_HANDLE is pid and it may have been reused if there
was a lot of forking done on the system meanwhile. Which is unlikely but
still possible.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
