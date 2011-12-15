Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Rb8Ln-0008Ug-4L
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 10:15:43 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Rb8Lj-00031B-I0
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 10:15:43 +0000
Received: by ggnh1 with SMTP id h1so2219502ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Dec 2011 02:15:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EE9BF5F.1020704@redhat.com>
References: <4EE9BF5F.1020704@redhat.com>
Date: Thu, 15 Dec 2011 02:15:34 -0800
Message-ID: <CAGH67wSnNDgrg5700WhGZ_8==v2wpo9AzSGwnwvVpyUzPq3QEQ@mail.gmail.com>
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

On Thu, Dec 15, 2011 at 1:35 AM, Jan Stancek <jstancek@redhat.com> wrote:
>
> This test occasionally hangs on some machines. The hang has been
> observed mostly on single CPU ones.
>
> pipeio code is using signal(2), setting by default SA_RESTART
> flag, which is also the case for SIGCHLD.
>
> If last child manages to exit while parent is still at open(),
> parent gets SIGCHLD and open() is restarted. At this point test
> hangs.
>
> Here's strace output from parent point of view:

Committed -- thanks!
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
