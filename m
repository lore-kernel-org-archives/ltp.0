Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y8Urn-0005aF-PM
	for ltp-list@lists.sourceforge.net; Tue, 06 Jan 2015 14:12:15 +0000
Date: Tue, 6 Jan 2015 15:11:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150106141138.GA17948@rei>
References: <1418920057-53786-1-git-send-email-maxin.john@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1418920057-53786-1-git-send-email-maxin.john@gmail.com>
Subject: Re: [LTP] [PATCH] run-posix-option-group-test: remove set -x debug
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
To: maxin.john@gmail.com
Cc: ltp-list@lists.sourceforge.net, "Maxin B. John" <maxin.john@enea.com>

Hi!
> remove "set -x" in the shell script

While I agree that the script is too verbose as it is this is not right
solution. After this change it only prints summary of succeeded/failed
testcases without even telling what call has been tested.

The output should rather look something like:

***********************
Testing pthread_kill
***********************
PASS                 14
FAIL                  0
***********************

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
