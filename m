Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WY7nO-0004sk-Le
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 05:45:06 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WY7nM-0005G1-Rt
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 05:45:06 +0000
Message-ID: <53462FC7.1020701@oracle.com>
Date: Thu, 10 Apr 2014 09:44:39 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <533D3BC7.8010309@oracle.com>
	<20140407013932.GU22728@two.firstfloor.org>
	<alpine.DEB.2.10.1404071044310.9896@nuc>
	<5344288E.3090306@oracle.com> <53442A99.6030208@oracle.com>
	<alpine.DEB.2.10.1404081302570.13065@nuc>
In-Reply-To: <alpine.DEB.2.10.1404081302570.13065@nuc>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Christoph Lameter <cl@linux.com>
Cc: vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list <ltp-list@lists.sourceforge.net>, Andi Kleen <andi@firstfloor.org>, linux-numa@vger.kernel.org



On 04/08/2014 10:03 PM, Christoph Lameter wrote:
> On Tue, 8 Apr 2014, Stanislav Kholmanskikh wrote:
>
>> Forgot to mention. This eight-node system has 8k pages, two-node - 4k pages.
>
> So they are not x86? There are some counter races on !x86.

Yes. This is Linux on SPARC.

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-numa" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

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
