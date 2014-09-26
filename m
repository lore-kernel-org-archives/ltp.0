Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XXM8U-0003Ie-P1
	for ltp-list@lists.sourceforge.net; Fri, 26 Sep 2014 03:23:58 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XXM8S-0001Ny-UW
	for ltp-list@lists.sourceforge.net; Fri, 26 Sep 2014 03:23:58 +0000
Date: Thu, 25 Sep 2014 23:23:49 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <1096621493.37297301.1411701829900.JavaMail.zimbra@redhat.com>
In-Reply-To: <5424057E.2000407@oracle.com>
References: <722837953.31209749.1410431446352.JavaMail.zimbra@redhat.com>
	<5411ABF0.9070704@oracle.com>
	<1039610982.34479102.1411109260676.JavaMail.zimbra@redhat.com>
	<956604956.36871956.1411629477294.JavaMail.zimbra@redhat.com>
	<5424057E.2000407@oracle.com>
MIME-Version: 1.0
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: "Xiong Zhou" <xzhou@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Thursday, September 25, 2014 8:07:26 PM
> Subject: Re: [LTP]  [PATCH v3 1/3] fcntl14: dup code clean up
> 
> Hi!
> 
> On 09/25/2014 11:17 AM, Xiong Zhou wrote:
> >
> > And block3 description message fix from "mandatory locking"
> > to "negative whence".
> >
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> 
> Patch 1 and patch 2 of the series are pushed.
> Btw, patch 2 didn't apply to index correctly with 'git am', I had to
> manually apply it.
> 

Sorry for the inconvenience.. I should keep my master branch updated.

> I'm experiencing difficulties with checking patch 3. In particular,
> after applying your patch utime02 fails on NFSv4 with
> 2.6.32-431.29.2.el6.x86_64 kernel.

Yes, I got the same results on 2.6.32-431.29.2.el6 kernel, v3 pass v4 fail.

> 
> I'm not quite sure if it's a kernel problem or test case error. Still
> investigating.
> 
> Could you please check the test case in your RHEL 6 environment as well?

I double checked that utime02 did pass on upstream 2.6.32 kernel 
both NFSv3 and NFSv4 in my env.
On latest RHEL-6 kernel, both NFSv3 and NFSv4 passed utime02 test case.

All failed test_output are just like:
tst_tmpdir.c:158: chown(/nfsmnt/ltp-6L6Oqow6wv/utiMPq3y5, -1, 0) \
failed: errno=EPERM(1): Operation not permitted

One single clean chown(nfsfile, -1, 0) call to NFSv3/4 file succeeds 
on multiple kernels include 2.6.32-431.29.2.el6. 

Neither, I'm not sure about where the problem lies. Still checking.

Thanks for catching this!

--
xzhou

> 
> Thank you.
> 

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
