Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VMcnt-0004Fc-Qc
	for ltp-list@lists.sourceforge.net; Thu, 19 Sep 2013 11:53:49 +0000
Date: Thu, 19 Sep 2013 13:37:21 +0200
From: chrubis@suse.cz
Message-ID: <20130919113721.GA13055@rei>
References: <237700855.16313743.1379574291879.JavaMail.root@redhat.com>
	<990284776.16332618.1379576730822.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <990284776.16332618.1379576730822.JavaMail.root@redhat.com>
Subject: Re: [LTP] broken install in kernel/firmware (possibly all
	device-drivers)
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
Cc: alexey.kodanev@oracle.com, ltp-list <ltp-list@lists.sf.net>

Hi!
> we ignore build failures in kernel/firmware, so this doesn't stop build phase.
> But when build fails (for whatever reason) then it always breaks install phase:
> 
> make[3]: Entering directory `/root/ltp/testcases/kernel/firmware'
> make[4]: Entering directory `/root/ltp/testcases/kernel/firmware/fw_load_kernel'
> install -m 00775 "/root/ltp/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.ko" "/opt/ltp/testcases/bin/ltp_fw_load.ko"
> install: cannot stat ??/root/ltp/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.ko??: No such file or directory
> make[4]: *** [/opt/ltp/testcases/bin/ltp_fw_load.ko] Error 1
> make[4]: Leaving directory `/root/ltp/testcases/kernel/firmware/fw_load_kernel'
> make[3]: *** [install] Error 2
> make[3]: Leaving directory `/root/ltp/testcases/kernel/firmware'
> make[2]: *** [install] Error 2
> make[2]: Leaving directory `/root/ltp/testcases/kernel'
> make[1]: *** [install] Error 2
> make[1]: Leaving directory `/root/ltp/testcases'
> make: *** [testcases-install] Error 2

We are about to move the code into include/mk/modules.mk, so let's make
sure it's fixed there.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
