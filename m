Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XJPGd-0004Di-27
	for ltp-list@lists.sourceforge.net; Mon, 18 Aug 2014 15:54:43 +0000
Date: Mon, 18 Aug 2014 17:53:43 +0200
From: chrubis@suse.cz
Message-ID: <20140818155343.GA12026@rei.suse.cz>
References: <1407944666-32659-1-git-send-email-asavkov@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1407944666-32659-1-git-send-email-asavkov@redhat.com>
Subject: Re: [LTP] [PATCH v2 0/6] testcases/kernel/containers cleanup
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
To: Artem Savkov <asavkov@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Container tests are currently clumped together in a single script, this
> patchset separates them so that they are listed one by on in runtest/containers
> 
> v2 set contains a bunch of changes for better compliance with LTP codestyle and
> an additional patch doing the same for old code in netns testcases.

All pushed, thanks.

For me the par_chld_ftp test fails (after vsftpd was installed), I will
have a look into that tomorrow.

I will also rename a few of the scripts in order to avoid installation
collisions (rename initialize.sh to netns_initialize.sh etc.)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
