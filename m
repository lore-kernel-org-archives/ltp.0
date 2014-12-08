Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XxuSZ-0008Jm-QQ
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 09:18:27 +0000
Date: Mon, 8 Dec 2014 10:18:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208091810.GA6401@rei.suse.de>
References: <001701d012c2$e2ae8d30$a80ba790$@samsung.com>
	<1917282961.14573534.1418030128901.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1917282961.14573534.1418030128901.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] How to compile indiviual packages/modules in LTP
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
> If none of configure options works for you, as outline by Cyril here:
>   http://thread.gmane.org/gmane.linux.ltp/21992
> 
> you need to make changes yourself. If specific Makefile doesn't name
> sub-directories by name, then delete the ones you don't want to compile from tree.
> If Makefile does list sub-directories by name, then you need to patch that Makefile
> and remove those you wish to skip.

And I have a feeling that you are trying to solve wrong problem. What
exactly do you want to do?

If you want to run a subset of testcases you should compile and install
all of them and then tell test driver to executed only these you are
interested in.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
