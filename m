Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WcytO-0002bh-DK
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 15:15:22 +0000
Date: Wed, 23 Apr 2014 17:14:26 +0200
From: chrubis@suse.cz
Message-ID: <20140423151426.GA15663@rei.suse.cz>
References: <5357D79C.40706@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5357D79C.40706@oracle.com>
Subject: Re: [LTP] posix_fallocate
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> I would like to add "posix_fallocate" test based on what we already have 
> in syscalls/fallocate, because the behavior of "posix_fallocate" is 
> close to what is doing fallocate by default, so most test scenarios will 
> be the same. What is the correct way to do it, place it in 
> open_posix_testsuite as new ones or add it to fallocate tests?

That is hard to tell.

If you care for posix_fallocate strictly POSIX conformace add it to
open_posix_testsuite and write the tests accordingly to the POSIX
specification.

If you care about API coverage add it to the syscalls testcases and
share as much code with the fallocate testcases as possible.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
