Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XPX7H-0000YZ-P3
	for ltp-list@lists.sourceforge.net; Thu, 04 Sep 2014 13:30:23 +0000
Date: Thu, 4 Sep 2014 15:30:07 +0200
From: chrubis@suse.cz
Message-ID: <20140904133007.GB9603@rei.suse.cz>
References: <CA+G9fYvRGMkgNAkVCsnTNhTfQCW_CTAtH3LDV=tELpG0wjfxCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYvRGMkgNAkVCsnTNhTfQCW_CTAtH3LDV=tELpG0wjfxCQ@mail.gmail.com>
Subject: Re: [LTP] LTP: overcommit_memory -R 0 failed due to
 overcommit_ratio = 0 ?
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
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Steve Capper <steve.capper@linaro.org>, Mark Brown <mark.brown@linaro.org>

Hi!
> Test case : overcommit_memory -R 0
> Test faild.
> Because overcommit_ratio = 0 ???
> Is this a test case bug or any thing missing in kernel ?

The testcase seems to be broken unless you have big enough swap so that
CommitLimit (which depends on size of the swap) is greater than
Commit_AS. In your case the swap size was not big enough to be greater
than the amount of currently overcommited memory (Commit_AS).

The test should be changed to skip the particular testcase and give a
beteter message if there is no room to alloace any memory in this case.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
