Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4wsV-0002KV-Im
	for ltp-list@lists.sourceforge.net; Thu, 01 Aug 2013 17:41:31 +0000
Date: Thu, 1 Aug 2013 19:41:23 +0200
From: chrubis@suse.cz
Message-ID: <20130801174123.GA708@rei.scz.novell.com>
References: <51EF9E51.1070208@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51EF9E51.1070208@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH] Containers test case is hanging at two sub test
 cases
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
To: Tejaswini <tejaswin@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> two_children_ns and
> >> par_chld_ipv6
> 
> The function crtchild() in two_children_ns.c and par_chld_ipv6.c is called
> with only one parameter while the definition has two parameters: 
> crtchild (char *, char *)

The definition of the function should really be in some header
(presumbly common.h) and included in common.c and all the tests that
uses it (there are three instances of the wrong definiton of the
function at the moment).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
