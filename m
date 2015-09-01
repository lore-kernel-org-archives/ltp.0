Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZWjz3-0002uk-0q
	for ltp-list@lists.sourceforge.net; Tue, 01 Sep 2015 11:44:13 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZWjz1-0000AP-1u
	for ltp-list@lists.sourceforge.net; Tue, 01 Sep 2015 11:44:12 +0000
Date: Tue, 1 Sep 2015 13:43:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150901114330.GB27041@rei.suse.cz>
References: <20150813123035.GB14976@rei.suse.de>
	<20150820150617.GE3994@rei.suse.de>
	<20150831112319.GB17776@rei.suse.cz>
	<75454012.15990077.1441091460626.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75454012.15990077.1441091460626.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] LTP release
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
Cc: ltp-list@lists.sourceforge.net, Jiri Jaburek <jjaburek@redhat.com>

Hi!
> as you mentioned, the problem in ns_exec was setns'ing the "user" namespace,
> I think it would be sufficient to just comment/remove this line:
> rf |= open_ns_fd(argv[1], "user");
> from ns_exec.c or even all calls to open_ns_fd() function except for the network
> namespace as it is used in netns testcases. I will rewrite ns_create and ns_exec
> after the release.

I was trying to be more defensive and remove everything that is not
needed, but I can live with this solution as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
