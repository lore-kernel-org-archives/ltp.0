Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdMat-0002RO-Cz
	for ltp-list@lists.sourceforge.net; Wed, 21 Dec 2011 13:52:31 +0000
Date: Wed, 21 Dec 2011 15:02:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111221140207.GD22113@saboteur.suse.cz>
References: <1324374835-22722-1-git-send-email-Wei.Yang@windriver.com>
	<1324374835-22722-2-git-send-email-Wei.Yang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324374835-22722-2-git-send-email-Wei.Yang@windriver.com>
Subject: Re: [LTP] [PATCH 1/1] using mutex to protect the global variable
 accessed by muti-threads
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
To: Wei.Yang@windriver.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Wei Yang <Wei.Yang@windriver.com>
> ---
>  .../interfaces/pthread_barrier_wait/2-1.c          |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
