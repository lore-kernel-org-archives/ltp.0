Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V6fEz-0006tv-4q
	for ltp-list@lists.sourceforge.net; Tue, 06 Aug 2013 11:15:49 +0000
Date: Tue, 6 Aug 2013 13:15:45 +0200
From: chrubis@suse.cz
Message-ID: <20130806111545.GC24437@rei>
References: <51FFBCC1.3030101@oracle.com>
	<1375780313-17327-3-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1375780313-17327-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 2/2 V3] lib/tst_module.c: modification for updated
 tst_run_cmd specification
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, alexey.kodanev@oracle.com

Hi!
> * to hide gcc warning "initialization discards qualifiers from pointer target type"

I think that correct solution is to declare the argv as:

const char *const argv[]

So that both the array and the stored strings are constant.

(Feel free to do this in separate patch)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
