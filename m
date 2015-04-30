Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YniPa-0002jg-3O
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 06:57:30 +0000
Date: Thu, 30 Apr 2015 08:56:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150430065658.GA479@rei.suse.de>
References: <1430295293-13106-1-git-send-email-zlang@redhat.com>
	<20150429140938.GA19358@rei>
	<1822683538.7446641.1430373748322.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1822683538.7446641.1430373748322.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] aiocp: modify segfault in dev_block_size_by_path
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
To: Zirong Lang <zlang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Thanks. And I have another little question about debug ltp. When I hit this
> segfault I got a core file, but that core without debug information.
> So I tried to add "-g" for gcc and remove "-O2" option. I did that
> job manually(deleted -O2 from every files contain it).
> 
> Is there some good configure or make options can be used to build a
>  debug version ltp? Can you give me some steps to do that?

Hm, passing CFLAGS to configure should work as:

CFLAGS="-W -Wextra -O0 -ggdb" ./configure

But looking at what we have in LTP there are OPT_CFLAGS and WCFLAGS
which adds the -O2 and more. So at the moment you have to modify CFLAGS
manually in the include/mk/config.mk.

Does anybody have an idea why the CFLAGS are split among three variables
to optimizations and warnings? It does no make much sense to me. There
is only one place in the source tree where these are redefined, I will
check if that is really needed and possibly get rid of this mess. Is
anybody opposed?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
