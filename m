Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZSPtU-000257-8L
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2015 13:28:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZSPtP-00022e-MX
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2015 13:28:36 +0000
Date: Thu, 20 Aug 2015 15:27:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150820132758.GA2944@rei.suse.de>
References: <1436876572-28759-2-git-send-email-mmarhefk@redhat.com>
	<1439899125-7646-1-git-send-email-mmarhefk@redhat.com>
	<20150819134438.GA22714@rei.suse.de>
	<1244717184.10704034.1439998635401.JavaMail.zimbra@redhat.com>
	<20150819162621.GA2356@rei.suse.de>
	<2086887252.11104808.1440076288678.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2086887252.11104808.1440076288678.JavaMail.zimbra@redhat.com>
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
> > Also do we want to assert that the dummy0 device is listed in the /sys
> > inside the namespace?
> 
> Don't you think that this is sufficient ?
> 
> ns_exec $NS_HANDLE ip link add dummy0 type dummy || \                           
>     tst_brkm TBROK "failed to add a new dummy device"

We are testing sysfs in network namespaces, so I'm tepmted to do
something as:

if [ -d /sys/class/net/dummy0 ]; then
	tst_resm TPASS ...
else
	tst_resm TFAIL ...
fi

After sysfs is mounted.

> >> Anyway, one thing you can do before pushing the patch is to remove
> >> kill -9 $NS_HANDLE
> >> command from the test code, as this is done inside cleanup function.
> >
> > Killing it twice once in the test and once in the cleanup is mistake as
> > well. Since the NS_HANDLE is pid and it may have been reused if there
> > was a lot of forking done on the system meanwhile. Which is unlikely but
> > still possible.
> 
> True. Will you remove that kill command on pushing or should I resend the patch v4 ?

No need to resend, I will fix that before pusing.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
