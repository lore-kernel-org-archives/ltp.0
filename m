Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cl@linux.com>) id 1WXByX-0005Xl-Ag
	for ltp-list@lists.sourceforge.net; Mon, 07 Apr 2014 16:00:45 +0000
Received: from qmta11.emeryville.ca.mail.comcast.net ([76.96.27.211])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WXByV-0000lw-F4
	for ltp-list@lists.sourceforge.net; Mon, 07 Apr 2014 16:00:45 +0000
Date: Mon, 7 Apr 2014 10:47:05 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
In-Reply-To: <20140407013932.GU22728@two.firstfloor.org>
Message-ID: <alpine.DEB.2.10.1404071044310.9896@nuc>
References: <533D3BC7.8010309@oracle.com>
	<20140407013932.GU22728@two.firstfloor.org>
Subject: Re: [LTP] numastats updates
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, linux-numa@vger.kernel.org

On Mon, 7 Apr 2014, Andi Kleen wrote:

> >   * starts a binary with the specified numa memory policy using
> > numactl (or a like):
> >     numactl --interleave=all get_some_memory_with_malloc_and_write_it
> >   * `sleep` for few seconds
> >   * numastat > /tmp/after
> >   * compares /tmp/before and /tmp/after to check that the numa policy
> > was applied the right way
> >
> > But the problem is that on a host with many NUMA nodes (8) the process
> > of updating that numastats statistics takes some time. Even 10 seconds
> > may be not enough. Therefore the test fails.
> >
> > Is there a direct or indirect way to force the kernel to update the
> > NUMA statistics?
>
> Not currently. It depends on how much memory you have and subsequent
> operations. I guess would need to add one.

The kernel vm statistics are brought up to date with the default
settings every 2 seconds.

The interval is controlled via /proc/sys/vm/stat_interval

Check the value that you have setup there.


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees_APR
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
