Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X6gNX-0001EX-AO
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 13:33:15 +0000
Date: Mon, 14 Jul 2014 15:32:45 +0200
From: chrubis@suse.cz
Message-ID: <20140714133245.GA25946@rei.suse.cz>
References: <34c197c03d5d2d3296bd1e770e70922f72c770f5.1405337663.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34c197c03d5d2d3296bd1e770e70922f72c770f5.1405337663.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] fs-bench: rename test*.sh scripts to
 fs-bench-test*.sh
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
Cc: ltp-list@lists.sourceforge.net, Awais_Belal@mentor.com

Hi!
> Install name of these scripts is in conflict with testcases/lib/test.sh.
> In problem Awais reported, he ended up with test.sh from fs-bench in
> install directory, instead of shell script library he was expecting:
>   install -m 00775 "/root/ltp/testcases/lib/test.sh" "/opt/ltp/testcases/bin/test.sh"
>   ...
>   install -m 00775 "/root/ltp/testcases/kernel/fs/fs-bench/test.sh" "/opt/ltp/testcases/bin/test.sh"
> 
> Reported-by: Awais Belal <Awais_Belal@mentor.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Looks obvious to me, acked.

Also we really should add some collision detection to the install phase
to avoid failures like this one.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck&#174;
Code Sight&#153; - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
