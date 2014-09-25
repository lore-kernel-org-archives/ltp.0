Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XX7pj-0001wX-IA
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 12:07:39 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XX7ph-0001SS-S3
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 12:07:39 +0000
Message-ID: <5424057E.2000407@oracle.com>
Date: Thu, 25 Sep 2014 16:07:26 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <722837953.31209749.1410431446352.JavaMail.zimbra@redhat.com>
	<5411ABF0.9070704@oracle.com>
	<1039610982.34479102.1411109260676.JavaMail.zimbra@redhat.com>
	<956604956.36871956.1411629477294.JavaMail.zimbra@redhat.com>
In-Reply-To: <956604956.36871956.1411629477294.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v3 1/3] fcntl14: dup code clean up
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
To: Xiong Zhou <xzhou@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!

On 09/25/2014 11:17 AM, Xiong Zhou wrote:
>
> And block3 description message fix from "mandatory locking"
> to "negative whence".
>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---

Patch 1 and patch 2 of the series are pushed.
Btw, patch 2 didn't apply to index correctly with 'git am', I had to 
manually apply it.

I'm experiencing difficulties with checking patch 3. In particular, 
after applying your patch utime02 fails on NFSv4 with 
2.6.32-431.29.2.el6.x86_64 kernel.

I'm not quite sure if it's a kernel problem or test case error. Still 
investigating.

Could you please check the test case in your RHEL 6 environment as well?

Thank you.

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
