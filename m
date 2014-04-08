Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cl@linux.com>) id 1WXaN7-0003oM-G1
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 18:03:45 +0000
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WXaN6-0000Xd-I6
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 18:03:45 +0000
Date: Tue, 8 Apr 2014 13:03:36 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
In-Reply-To: <53442A99.6030208@oracle.com>
Message-ID: <alpine.DEB.2.10.1404081302570.13065@nuc>
References: <533D3BC7.8010309@oracle.com>
	<20140407013932.GU22728@two.firstfloor.org>
	<alpine.DEB.2.10.1404071044310.9896@nuc>
	<5344288E.3090306@oracle.com> <53442A99.6030208@oracle.com>
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

On Tue, 8 Apr 2014, Stanislav Kholmanskikh wrote:

> Forgot to mention. This eight-node system has 8k pages, two-node - 4k pages.

So they are not x86? There are some counter races on !x86.


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
