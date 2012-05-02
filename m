Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SPZp7-0006oC-3J
	for ltp-list@lists.sourceforge.net; Wed, 02 May 2012 13:42:29 +0000
Date: Wed, 2 May 2012 15:40:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120502134037.GD366@saboteur.suse.cz>
References: <CABxY-SJqTBTDJQimvByQT3GEnk021YtHggPgw9F5NWk9ec8uXg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABxY-SJqTBTDJQimvByQT3GEnk021YtHggPgw9F5NWk9ec8uXg@mail.gmail.com>
Subject: Re: [LTP] Query regarding Open Posix fail Test Case
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
To: Jubi Taneja <jubitaneja@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> In LTP(Jan 2012 release) Open Posix Test Suite, the test case
> "aio-suspend/1-1.c" passes
> successfully for Linux Kernel 2.6.35 for Target ARM but the same test case
> fails for Kernel
> version: 3.0.18.
> 
> It throws error as :
> aio_suspend/1-1.c Error at write(): No such file or directory.

That pretty much looks like problem on your side. All the test does
prior to this error message is open a file and try to write into it.

The file is created in /tmp so look for problems with creating files on
your /tmp.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
