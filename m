Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cl@linux.com>) id 1WXZYi-0002kt-OJ
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 17:11:40 +0000
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WXZYh-00040l-Ow
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 17:11:40 +0000
Date: Tue, 8 Apr 2014 11:57:58 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
In-Reply-To: <5344288E.3090306@oracle.com>
Message-ID: <alpine.DEB.2.10.1404081153460.12735@nuc>
References: <533D3BC7.8010309@oracle.com>
	<20140407013932.GU22728@two.firstfloor.org>
	<alpine.DEB.2.10.1404071044310.9896@nuc>
	<5344288E.3090306@oracle.com>
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, vasily Isaenko <vasily.isaenko@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, linux-numa@vger.kernel.org

On Tue, 8 Apr 2014, Stanislav Kholmanskikh wrote:

> On a two-node system it prints:
> 1: 294
..

> 20: 294
>
> i.e. everything is ok.
>
> But on an eight-node system:
> 1: 173
> 2: 0
> 3: 0
> 4: 173
> 5: 173


> So in general we can't rely on stat_interval value. Correct?

Owww... This could have something to do with the tick being disabled on
idle without regard for pending vmstat updates. The processor goes to
sleep and never updates the global counters. Once in awhile the processor
wakes up to deal with the statistics.

The idle logic needs to check that all differentials are folded before
going to slee. Frederic: Can we add such a check?


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
