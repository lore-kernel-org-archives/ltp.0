Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cl@linux.com>) id 1WYQZh-0005UY-CL
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 01:48:13 +0000
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WYQZg-000251-Hb
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 01:48:13 +0000
Date: Thu, 10 Apr 2014 20:48:04 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
In-Reply-To: <53462FC7.1020701@oracle.com>
Message-ID: <alpine.DEB.2.10.1404102046170.4702@nuc>
References: <533D3BC7.8010309@oracle.com>
	<20140407013932.GU22728@two.firstfloor.org>
	<alpine.DEB.2.10.1404071044310.9896@nuc>
	<5344288E.3090306@oracle.com> <53442A99.6030208@oracle.com>
	<alpine.DEB.2.10.1404081302570.13065@nuc>
	<53462FC7.1020701@oracle.com>
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
Cc: vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list <ltp-list@lists.sourceforge.net>, Andi Kleen <andi@firstfloor.org>, linux-numa@vger.kernel.org

On Thu, 10 Apr 2014, Stanislav Kholmanskikh wrote:

> On 04/08/2014 10:03 PM, Christoph Lameter wrote:
> > On Tue, 8 Apr 2014, Stanislav Kholmanskikh wrote:
> >
> > > Forgot to mention. This eight-node system has 8k pages, two-node - 4k
> > > pages.
> >
> > So they are not x86? There are some counter races on !x86.
>
> Yes. This is Linux on SPARC.

Hmmm... I just got the infrastructure merged to define fast counter
updates. If we would define raw_cpu_ops for sparc then we could fix
the issue. Sparc has atomics that can increment a register relative to a
percpu base register right?


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
