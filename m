Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XEzHT-0007Ch-Vs
	for ltp-list@lists.sourceforge.net; Wed, 06 Aug 2014 11:21:20 +0000
Date: Wed, 6 Aug 2014 13:20:28 +0200
From: chrubis@suse.cz
Message-ID: <20140806112028.GA18182@rei>
References: <1404116297.3148.7.camel@G08JYZSD130126>
	<982989271.447892.1404117506779.JavaMail.zimbra@redhat.com>
	<1404120652.2132.20.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1404120652.2132.20.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] waitid/waitid02.c: Add new ECHILD errno test
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
> > Hi,
> > 
> > looks good to me. I'm assuming the reason for setup/cleanup
> > is that you wanted some unrelated child to be present.
> > 
> 
> Hi,
> Thank you for your review and test. :)
> As you can see, there has been a test for ECHILD in waitid02.c. That
> test for idtype and id (waitid()) does not exist.
> In this patch, the process calls fork to get a child, but it waits for
> the other process, then ECHILD would return. After the test, calling
> cleanup. That test for idtype and id (waitid()) is not a child of the
> calling process.

I've modified the commit message to explain why we keep child waiting in
the background and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
