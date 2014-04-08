Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WXZLt-0005jT-1u
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 16:58:25 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WXZLs-0003H4-9p
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 16:58:25 +0000
Message-ID: <53442A99.6030208@oracle.com>
Date: Tue, 08 Apr 2014 20:58:01 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <533D3BC7.8010309@oracle.com>
	<20140407013932.GU22728@two.firstfloor.org>
	<alpine.DEB.2.10.1404071044310.9896@nuc>
	<5344288E.3090306@oracle.com>
In-Reply-To: <5344288E.3090306@oracle.com>
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
To: Christoph Lameter <cl@linux.com>, Andi Kleen <andi@firstfloor.org>
Cc: vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list <ltp-list@lists.sourceforge.net>, linux-numa@vger.kernel.org



On 04/08/2014 08:49 PM, Stanislav Kholmanskikh wrote:

>
> On a two-node system it prints:
> 1: 294
> 2: 294
> 3: 295
> 4: 294
> 5: 294
> 6: 295
> 7: 294
> 8: 294
> 9: 293
> 10: 293
> 11: 294
> 12: 295
> 13: 296
> 14: 293
> 15: 295
> 16: 294
> 17: 295
> 18: 294
> 19: 294
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
> 6: 0
> 7: 173
> 8: 173
> 9: 0
> 10: 0
> 11: 173
> 12: 0
> 13: 173
> 14: 0
> 15: 346
> 16: 0
> 17: 0
> 18: 89
> 19: 0
> 20: 173
>

Forgot to mention. This eight-node system has 8k pages, two-node - 4k pages.

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
