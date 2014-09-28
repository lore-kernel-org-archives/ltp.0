Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XY4ca-0004V1-O0
	for ltp-list@lists.sourceforge.net; Sun, 28 Sep 2014 02:54:00 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XY4cZ-0001ay-1y
	for ltp-list@lists.sourceforge.net; Sun, 28 Sep 2014 02:54:00 +0000
Date: Sat, 27 Sep 2014 22:53:50 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <404505680.37811131.1411872830786.JavaMail.zimbra@redhat.com>
In-Reply-To: <54255DB0.3080500@oracle.com>
References: <722837953.31209749.1410431446352.JavaMail.zimbra@redhat.com>
	<5411ABF0.9070704@oracle.com>
	<1039610982.34479102.1411109260676.JavaMail.zimbra@redhat.com>
	<956604956.36871956.1411629477294.JavaMail.zimbra@redhat.com>
	<5424057E.2000407@oracle.com>
	<1096621493.37297301.1411701829900.JavaMail.zimbra@redhat.com>
	<54255DB0.3080500@oracle.com>
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

Hi!

----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: "Xiong Zhou" <xzhou@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Friday, September 26, 2014 8:36:00 PM
> Subject: Re: [LTP]  [PATCH v3 1/3] fcntl14: dup code clean up
> 
> Hi!
> 
> On 09/26/2014 07:23 AM, Xiong Zhou wrote:
> >
> >
> > ----- Original Message -----
> >> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> >> To: "Xiong Zhou" <xzhou@redhat.com>
> >> Cc: ltp-list@lists.sourceforge.net
> >> Sent: Thursday, September 25, 2014 8:07:26 PM
> >> Subject: Re: [LTP]  [PATCH v3 1/3] fcntl14: dup code clean up
> >>
> >> Hi!
> >>
> >> On 09/25/2014 11:17 AM, Xiong Zhou wrote:
> >>>
> >>> And block3 description message fix from "mandatory locking"
> >>> to "negative whence".
> >>>
> >>> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> >>> ---
> >>
> >> Patch 1 and patch 2 of the series are pushed.
> >> Btw, patch 2 didn't apply to index correctly with 'git am', I had to
> >> manually apply it.
> >>
> >
> > Sorry for the inconvenience.. I should keep my master branch updated.
> >
> >> I'm experiencing difficulties with checking patch 3. In particular,
> >> after applying your patch utime02 fails on NFSv4 with
> >> 2.6.32-431.29.2.el6.x86_64 kernel.
> >
> > Yes, I got the same results on 2.6.32-431.29.2.el6 kernel, v3 pass v4 fail.
> >
> >>
> >> I'm not quite sure if it's a kernel problem or test case error. Still
> >> investigating.
> >>
> >> Could you please check the test case in your RHEL 6 environment as well?
> >
> > I double checked that utime02 did pass on upstream 2.6.32 kernel
> > both NFSv3 and NFSv4 in my env.
> > On latest RHEL-6 kernel, both NFSv3 and NFSv4 passed utime02 test case.
> >
> > All failed test_output are just like:
> > tst_tmpdir.c:158: chown(/nfsmnt/ltp-6L6Oqow6wv/utiMPq3y5, -1, 0) \
> > failed: errno=EPERM(1): Operation not permitted
> 
> Sorry, I didn't get whether utime02+NFSv4 passed  with the latest RHEL-6
> kernel. Could you elaborate on this?

Sorry for the confusion. The latest kernel I have tested on was an internal
test temp build.

> 
> >
> > One single clean chown(nfsfile, -1, 0) call to NFSv3/4 file succeeds
> > on multiple kernels include 2.6.32-431.29.2.el6.
> >
> > Neither, I'm not sure about where the problem lies. Still checking.
> 
> test.c:
> 
> #include <error.h>
> #include <unistd.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> 
> int main(void)
> {
> 	if (setuid(99)) {
> 		perror("setuid() failed");
> 		goto out;
> 	}
> 
> 	if (mkdir("dir", 0700)) {
> 		perror("mkdir() failed");
> 		goto out;
> 	}
> 
> 	if (chown("dir", -1, 0))
> 		perror("chown() failed");
> 
> out:
> 	return 0;
> }
> 
> 99 is 'nobody'.
> 
> With both upstream 2.6.32 and 2.6.32.63 `strace ./test` on a nfsv4 fs
> will show:
> setuid(99)                              = 0
> mkdir("dir", 0700)                      = 0
> chown("dir", 4294967295, 0)             = 0
> 
> [root@ol6-x64 nfsv4]# ls -ld dir
> drwx------ 2 nobody root 4096 Sep 26 13:14 dir
> 
> But with 2.6.32-431.29.2.el6.x86_64:
> setuid(99)                              = 0
> mkdir("dir", 0700)                      = 0
> chown("dir", 4294967295, 0)             = -1 EPERM (Operation not permitted)
> 
> [root@ol6-x64 nfsv4]# ls -ld dir
> drwx------ 2 nobody root 4096 Sep 26 13:19 dir
> 
> So, most likely, it's a bug in the vendor kernels.

I agree, and I think it has been recorded already.

Thanks!
--
xzhou
> 
> So on I think that your patch may be pushed.
> 
> If there are no objections, I would like to do it on Monday.
> 
> Thanks.
> 
> >
> > Thanks for catching this!
> >
> > --
> > xzhou
> >
> >>
> >> Thank you.
> >>
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
