Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VeSJP-0006VP-4v
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 16:20:03 +0000
Date: Thu, 7 Nov 2013 17:19:51 +0100
From: chrubis@suse.cz
Message-ID: <20131107161950.GC9653@rei.Home>
References: <1383719585-692-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383719585-692-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] sendfile: add SF_Server into INSTALL_TARGETS in
 Makefile
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> sendfile01 always fails because SF_Server file is not installed.
> 
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>  testcases/network/tcp_cmds/sendfile/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/network/tcp_cmds/sendfile/Makefile b/testcases/network/tcp_cmds/sendfile/Makefile
> index 124ce5d..17a985a 100644
> --- a/testcases/network/tcp_cmds/sendfile/Makefile
> +++ b/testcases/network/tcp_cmds/sendfile/Makefile
> @@ -27,7 +27,7 @@ include $(abs_srcdir)/../Makefile.inc
>  
>  CPPFLAGS		+= -I$(abs_srcdir)/../include
>  
> -INSTALL_TARGETS		:= sendfile01
> +INSTALL_TARGETS		:= sendfile01 SF_Server

Good catch, but can you please rename the file to sendfile01_server and
fix the execution accordingly before it gets applied?

Note that all the test binaries are installed into one directory which
makes it harder to avoid collisions and figure out what belongs to
what...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
