Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Rb9Cm-0008Kk-JI
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 11:10:28 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rb9Cg-0003bC-V8
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 11:10:28 +0000
Received: by obcwn6 with SMTP id wn6so250982obc.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Dec 2011 03:10:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ee737595-7ec2-4e85-a5fe-a393c4a86c7f@zmail16.collab.prod.int.phx2.redhat.com>
References: <CAGH67wSnNDgrg5700WhGZ_8==v2wpo9AzSGwnwvVpyUzPq3QEQ@mail.gmail.com>
	<ee737595-7ec2-4e85-a5fe-a393c4a86c7f@zmail16.collab.prod.int.phx2.redhat.com>
Date: Thu, 15 Dec 2011 03:10:17 -0800
Message-ID: <CAGH67wTvxOTeyN6K2a23FG30TDA=Mn6xT6Xy4X3Hjmph09yBTg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2 2/2] pipeio: prevent race between SIGCHLD and
	open()
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Dec 15, 2011 at 2:36 AM, Jan Stancek <jstancek@redhat.com> wrote:
> Garrett,
>
> I'm not sure what happened, but I see only first patch from series
> committed with description belonging to second one.
>
> Regards,
> Jan

    I got confused by the multiple patches. Is this thread the one I
need to look at to rectify the other issues identified?
Thanks,
-Garrett

------------------------------------------------------------------------------
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  
But none more important than the need to reduce IT complexity 
while improving strategic productivity.  Learn More! 
http://www.accelacomm.com/jaw/sdnl/114/51507609/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
