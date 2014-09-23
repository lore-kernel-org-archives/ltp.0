Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vgoyal@redhat.com>) id 1XWOvP-0008Gf-H1
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 12:10:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XWOvO-0000va-9J
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 12:10:31 +0000
Date: Tue, 23 Sep 2014 08:09:59 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20140923120959.GB1732@redhat.com>
References: <145412866.25258463.1411119061796.JavaMail.zimbra@redhat.com>
	<293476264.25264480.1411120345360.JavaMail.zimbra@redhat.com>
	<20140919132236.GB2190@redhat.com>
	<594480021.25988504.1411355660836.JavaMail.zimbra@redhat.com>
	<20140922144713.GA4250@redhat.com>
	<1446076274.27552759.1411440835273.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1446076274.27552759.1411440835273.JavaMail.zimbra@redhat.com>
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, crash-utility <crash-utility@redhat.com>

On Mon, Sep 22, 2014 at 10:53:55PM -0400, CAI Qian wrote:

[..]
> > Why not simply let the respective service on the host do this job and
> > test only makes sure that kdump service is running. It feels little
> > out of place that a test is generating custom initramfs.
> Because not every distro will have a kdump service like Fedora.

So which distro does not have a service? Do we know this or we are
assuming that distributions don't have a service to load/unload
kdump kernel.

[..]
> > makedumpfile will reduce the vmcore file size to few hundreds of mega
> > bytes on most of the systems. Especially, this is just a test, so
> > system will be lightly loaded and vmcore will be small after filtering.
> It probably actually have test cases to heavily loaded the memory before
> dumping.

Your original proposal does not take care of this case either. A test
case could be heavily used memory and if user does not have sufficient
memory to save core, so be it. That test will fail.

Thanks
Vivek

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
