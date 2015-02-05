Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YJHg8-00030G-IE
	for ltp-list@lists.sourceforge.net; Thu, 05 Feb 2015 08:20:48 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YJHg6-0004r4-Tp
	for ltp-list@lists.sourceforge.net; Thu, 05 Feb 2015 08:20:48 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t158KeYo006854
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Feb 2015 03:20:40 -0500
Date: Thu, 5 Feb 2015 03:20:39 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <283950318.7038749.1423124439939.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150203132336.GB15523@rei.scz.novell.com>
References: <71cb5b390704d5eeca9db095d599830577acbdff.1422967561.git.jstancek@redhat.com>
	<20150203132336.GB15523@rei.scz.novell.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] sendmsg01: remove ".flags = ~MSG_CMSG_COMPAT" case
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
To: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 3 February, 2015 2:23:36 PM
> Subject: Re: [LTP] [PATCH] sendmsg01: remove ".flags = ~MSG_CMSG_COMPAT" case
> 
> Hi!
> >  char *TCID = "sendmsg01";
> >  int testno;
> > @@ -305,23 +304,6 @@ struct test_case_t tdat[] = {
> >  	 .cleanup = cleanup4,
> >  	 .desc = "rights passing"}
> >  	,
> > -	{.domain = PF_UNIX,
> > -	 .type = SOCK_DGRAM,
> > -	 .proto = 0,
> > -	 .iov = iov,
> > -	 .iovcnt = 1,
> > -	 .buf = buf,
> > -	 .buflen = sizeof(buf),
> > -	 .msg = &msgdat,
> > -	 .flags = ~MSG_CMSG_COMPAT,
> > -	 .to = (struct sockaddr *)&sun1,
> > -	 .tolen = sizeof(sun1),
> > -	 .retval = -1,
> > -	 .experrno = EOPNOTSUPP,
> > -	 .setup = setup4,
> > -	 .cleanup = cleanup4,
> > -	 .desc = "invalid flags set w/ control"}
> > -	,
> 
> I'm more inclined to changing this case to MSG_OOB, but apart from that
> it's acked.

Anyone else care to weigh in?

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
