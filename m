Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y9AZa-00048z-Bf
	for ltp-list@lists.sourceforge.net; Thu, 08 Jan 2015 10:44:14 +0000
Date: Thu, 8 Jan 2015 11:43:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150108104325.GA25712@rei>
References: <20141001171032.698f1356@as>
	<53591103.3121779.1420538854789.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53591103.3121779.1420538854789.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] recvfrom01: fix test for invalid message flags
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
Cc: ltp-list@lists.sourceforge.net, Chuck Ebbert <cebbert.lkml@gmail.com>

Hi!
> > Note that this introduces a failure on kernels before 3.17, which has
> > a bug fix for MSG_ERRQUEUE flag handling. This failure is a legitimate
> > bug on these older kernels. (They should not be returning success with
> > no data available.)
> 
> I hit a failure in this testcase while trying latest LTP before release.
> Are you sure this is a bug?
> 
> Looking at commit history and man-pages, this looks more like new feature to me,
> flag that has not been supported before and now it is.
> 
> "MSG_ERRQUEUE is illegal on SOCK_STREAM sockets." [1]
> "TCP timestamping introduced MSG_ERRQUEUE handling for TCP sockets." [2][3]
> 
> Until commit [3], tcp_recvmsg() has ignored this flag and it was also documented
> that way. So, I don't see why TFAIL is valid result on <3.17 for MSG_ERRQUEUE test:

I think that there is no harm in disabling that case for kernels prior 3.17.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
