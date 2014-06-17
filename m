Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WwrId-00041B-PZ
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 11:11:35 +0000
Date: Tue, 17 Jun 2014 13:11:21 +0200
From: chrubis@suse.cz
Message-ID: <20140617111120.GA31854@rei>
References: <1402624697.2098.8.camel@G08JYZSD130126>
	<1183733259.23953127.1402660578711.JavaMail.zimbra@redhat.com>
	<1402972112.2294.26.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402972112.2294.26.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 1/3] syscalls: fix returning TCONF without device
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > I like TBROK here, because if you forget the required parameter,
> > testcase will end with non-zero exit code, which should be
> > easily visible for any test harness, while with TCONF the
> > problem can go unnoticed (with retcode == 0).

Yes, I think that this should be TCONF rather than TBROK because the
conditions for the test weren't met.

However I understand your concerns as well and this is a one of the
reasons I was thinking of changing the library to propagate the TCONF to
the test exit value as well.

Ideally we should fix the GitHub issue #11 which would change the code
so that we don't have to do the check in the first place.
(https://github.com/linux-test-project/ltp/issues/11)

I was thinking of adding a function that would either get the LTP_DEV
env variable or create a loop0 device if LTP_DEV is not set and will
format it with LTP_DEV_FS_TYPE or a default passed value and it's
counter part that does the cleanup.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
