Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XUryD-0003Vc-Sn
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 06:47:05 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XUryC-0001Cr-39
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 06:47:05 +0000
Date: Fri, 19 Sep 2014 02:46:57 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <867308142.34479006.1411109217618.JavaMail.zimbra@redhat.com>
In-Reply-To: <5411ABF0.9070704@oracle.com>
References: <722837953.31209749.1410431446352.JavaMail.zimbra@redhat.com>
	<5411ABF0.9070704@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] fcntl14: dup code clean up
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>, ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: "Xiong Zhou" <xzhou@redhat.com>, ltp-list@lists.sourceforge.net
> Sent: Thursday, September 11, 2014 10:04:32 PM
> Subject: Re: [LTP] [PATCH 1/3] fcntl14: dup code clean up
> 
> Hi!
> 
> On 09/11/2014 02:30 PM, Xiong Zhou wrote:
> > And block3 description message fix from "mandatory locking"
> > to "negative whence".
> >
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> >   testcases/kernel/syscalls/fcntl/fcntl14.c | 36
> >   +++++++++++--------------------
> >   1 file changed, 13 insertions(+), 23 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c
> > b/testcases/kernel/syscalls/fcntl/fcntl14.c
> > index 30a1ea9..9db88e8 100644
> > --- a/testcases/kernel/syscalls/fcntl/fcntl14.c
> > +++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
> > @@ -969,6 +969,15 @@ void catch1(int sig)
> >   	got1++;
> >   }
> >
> > +static void testcheck_end(int check_fail, char *msg)
> > +{
> > +	if (check_fail) {
> > +		tst_resm(TFAIL, "%s FAILED", msg);
> > +	} else {
> > +		tst_resm(TPASS, "%s PASSED", msg);
> > +	}
> > +}
> 
> There are many places left in fcntl14.c where you can put this
> "deduplication". Why aren't you doing it? ;)

I think I have done all of them, I cannot find other places which are applicable to this function.

I will resend this series based on your last comments.

Thanks.

> 
> > +
> >   int main(int ac, char **av)
> >   {
> >   	int lc;
> > @@ -1009,20 +1018,11 @@ int main(int ac, char **av)
> >   		 * mandatory locking
> >   		 */
> >   		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, 0, 0, 36);
> > -		if (fail) {
> > -			tst_resm(TFAIL, "Block 1, test 1 FAILED");
> > -		} else {
> > -			tst_resm(TPASS, "Block 1, test 1 PASSED");
> > -		}
> > +		testcheck_end(fail, "Block 1, test 1");
> >
> >   		/* Now try with negative values for L_start and L_len */
> >   		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, 5, 36, 45);
> > -
> > -		if (fail) {
> > -			tst_resm(TFAIL, "Block 1, test 2 FAILED");
> > -		} else {
> > -			tst_resm(TPASS, "Block 1, test 2 PASSED");
> > -		}
> > +		testcheck_end(fail, "Block 1, test 2");
> >
> >   		tst_resm(TINFO, "Exit block 1");
> >
> > @@ -1094,13 +1094,7 @@ int main(int ac, char **av)
> >   		close(fd);
> >   		unlink(tmpname);
> >
> > -		if (fail) {
> > -			tst_resm(TINFO, "Test with mandatory "
> > -				 "locking FAILED");
> > -		} else {
> > -			tst_resm(TINFO, "Test with mandatory "
> > -				 "locking PASSED");
> > -		}
> > +		testcheck_end(fail, "Test with negative whence locking");
> >   		tst_resm(TINFO, "Exit block 3");
> >
> >   /* //block4: */
> > @@ -1223,11 +1217,7 @@ int main(int ac, char **av)
> >   		close(fd);
> >   		unlink(tmpname);
> >
> > -		if (fail) {
> > -			tst_resm(TINFO, "Test of locks on file FAILED");
> > -		} else {
> > -			tst_resm(TINFO, "Test of locks on file PASSED");
> > -		}
> > +		testcheck_end(fail, "Test of locks on file");
> >   		tst_resm(TINFO, "Exit block 4");
> >   	}
> >   	cleanup();
> >
> 

------------------------------------------------------------------------------
Slashdot TV.  Video for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
