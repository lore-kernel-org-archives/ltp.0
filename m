Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vgoyal@redhat.com>) id 1XUyKO-0000ek-2I
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 13:34:24 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XUyKM-0007BE-Qr
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 13:34:24 +0000
Date: Fri, 19 Sep 2014 09:33:53 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20140919133353.GD2190@redhat.com>
References: <145412866.25258463.1411119061796.JavaMail.zimbra@redhat.com>
	<293476264.25264480.1411120345360.JavaMail.zimbra@redhat.com>
	<20140919132236.GB2190@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140919132236.GB2190@redhat.com>
Subject: Re: [LTP] [RFC] autokdump - automated kdump testsuite
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, crash-utility <crash-utility@redhat.com>, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, kexec kdump redhat mailing list <kexec-kdump-list@redhat.com>

On Fri, Sep 19, 2014 at 09:22:36AM -0400, Vivek Goyal wrote:
> On Fri, Sep 19, 2014 at 05:52:25AM -0400, CAI Qian wrote:
> > I plan to release an automated kdump testsuite that will be
> 
> So will this be a standalone test suit? Can it be merged with
> something already existing say, LTP.

Also how about calling it just kdumptest. autokdump feels more
like as if there have been improvements to kdump mechanism and
there is improved method named "autokdump".

kdumptest is more intuitive and it being "auto" is more or less
implied.

Thanks
Vivek

------------------------------------------------------------------------------
Slashdot TV.  Video for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
