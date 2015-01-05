Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y88Gk-0006Vm-FN
	for ltp-list@lists.sourceforge.net; Mon, 05 Jan 2015 14:04:30 +0000
Date: Mon, 5 Jan 2015 15:03:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150105140334.GA31857@rei.suse.de>
References: <1417101031-5272-1-git-send-email-mmarhefk@redhat.com>
	<1418987492-17553-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1418987492-17553-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH v3] testcases/lib/test.sh: added tst_timeout()
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
> Function tst_timeout() added into LTP test interface:
> 
> 	tst_timeout "command arg1 arg2 ..." timeout
> 
> Function enables waiting for specified command for timeout
> seconds. Example usage:
> 
> 	cmd_output=$(tst_timeout "ping -c 3 localhost" 5)
> 	if [ $? -ne 0 ]; then
> 		tst_brkm TBROK "timeout reached!"
> 	fi
> 
> where $cmd_output contains stdout and stderr of ping command.

Pushed, thanks.

It would be a nice to have a paragraph about the usage in the test
writing guidelines. Can you send a patch for that too?

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
