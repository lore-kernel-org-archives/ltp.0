Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XLux3-0000xE-5R
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 14:08:53 +0000
Date: Mon, 25 Aug 2014 16:07:50 +0200
From: chrubis@suse.cz
Message-ID: <20140825140749.GB13778@rei.suse.cz>
References: <e70bae8bd74a29e9959cae96900a849254b37c9f.1408615314.git.jstancek@redhat.com>
	<20140825130920.GA13575@rei.suse.cz>
	<400651514.12451738.1408972658808.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <400651514.12451738.1408972658808.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] safe_macros: turn functions with off_t parameter
 into static inline
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

Hi!
> > And the testcase that fails in SAFE_SETRLIMIT() is truncate03_64 after
> > the patch that fixes the EFBIG limit.
> > 
> > So unless you are already working on it I will prepare and push a patch
> > that moves rlimit related safe macros to the header as well.
> 
> I'm not - it did not fail when I tested the patch for some reason.

Fixed and pushed, please test.

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
