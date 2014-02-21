Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WGnwk-0005h2-Jt
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 11:07:10 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGnwi-00031S-L4
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 11:07:10 +0000
Date: Fri, 21 Feb 2014 06:01:22 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <387845948.7047521.1392980482074.JavaMail.zimbra@redhat.com>
In-Reply-To: <D2A2C37B00D2EA4CB1886D29B96695C55AE486@SAFEX1NODE23.st.com>
References: <1392969112-15851-1-git-send-email-francesco.rundo@st.com>
	<5307080F.8000702@cn.fujitsu.com>
	<D2A2C37B00D2EA4CB1886D29B96695C55AE388@SAFEX1NODE23.st.com>
	<775921692.6959618.1392973731667.JavaMail.zimbra@redhat.com>
	<D2A2C37B00D2EA4CB1886D29B96695C55AE401@SAFEX1NODE23.st.com>
	<1636908988.6999631.1392977205402.JavaMail.zimbra@redhat.com>
	<D2A2C37B00D2EA4CB1886D29B96695C55AE486@SAFEX1NODE23.st.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] madvise/madvise03.c: Changed test exit code
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Francesco RUNDO" <francesco.rundo@st.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net
> Sent: Friday, 21 February, 2014 11:25:03 AM
> Subject: RE: [LTP] [PATCH] madvise/madvise03.c: Changed test exit code
> 
> 
> >>Why should this case be unsupported when addr1 is backed by shared memory?
> >>  TEST(madvise(addr1, 4096, MADV_REMOVE));
> 
> The reported scenario MADV_REMOVE is managed -at kernel side- by
> madvise_remove() function on KERNEL_ROOT/mm/madvice.c.
> From this file I got (mm/madvice.c):
> 
> ==
> static long madvise_remove(struct vm_area_struct *vma,
> 				struct vm_area_struct **prev,
> 				unsigned long start, unsigned long end)
> {
> [snip]
> error = do_fallocate(f, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> 		        offset, end - start);
> [snip]
> }
> ==
> 
> Now, "do_fallocate()" needs fallocate() op. but on ext3 this is not supported
> i.e. ENOTSUP.

This is the "unexpected part" for me. What I expect and get on x86_64
with 3.10 based kernel is call to shmem_fallocate():

madvise(start=0x7fcff6d66000 len_in=0x1000 behavior=0x9)
Call Trace:
 0xffffffff81150130 : shmem_fallocate+0x0/0x300 [kernel]
 0xffffffff8122d056 : shm_fallocate+0x26/0x40 [kernel]
 0xffffffff811a0089 : do_fallocate+0xf9/0x190 [kernel]
 0xffffffff8115ac95 : SyS_madvise+0x355/0x7a0 [kernel]
 0xffffffff815d05d9 : system_call_fastpath+0x16/0x1b [kernel]

Do you have possibility to run original testcase with strace?
# strace ./madvise03 2>&1 | grep -v abcdefghijklmnopqrstuvwxyz12345

Regards,
Jan

> This is the reason for which I consider this scenario as not supported and
> not ENOSYS as the system call is supported as the remaining scenarios worked
> fine (MADV_DONTFORK and MADV_DOFORK).
> 
> Regards
> FR
> > 
> > Regards,
> > FR
> > 
> > >>Regards,
> > >>Jan
> > 
> > 
> > > 
> > > 
> > > Regards,
> > > FR
> > > 
> > > -----Original Message-----
> > > From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com]
> > > Sent: Friday, February 21, 2014 9:02 AM
> > > To: Francesco RUNDO
> > > Cc: ltp-list@lists.sourceforge.net
> > > Subject: Re: [LTP] [PATCH] madvise/madvise03.c: Changed test exit
> > > code
> > > 
> > > On 02/21/2014 03:51 PM, Francesco RUNDO wrote:
> > > > Changed exit code from TFAIL to TCONF  in case of unsupported syscall.
> > > > The "madvise" syscall needs kernel support as well as fs support
> > > > as -for specific advice- it requires specific filesystem
> > > > operations such as fallocate().
> > > 
> > > Could you paste the running log on not supported system?
> > > 
> > > Thanks,
> > > Wanlong Gao
> > > 
> > > > So, if kernel support is missed or fs doesn't provide specific
> > > > operation needed for such "advice" scenario of that syscall, the
> > > > right exit code (according to LTP defs) is not TFAIL as it is not
> > > > a failure but it is TCONF as the syscall is unsupported.
> > > > 
> > > > Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
> > > > ---
> > > >  testcases/kernel/syscalls/madvise/madvise03.c |   17 +++++++++++++----
> > > >  1 files changed, 13 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/testcases/kernel/syscalls/madvise/madvise03.c
> > > > b/testcases/kernel/syscalls/madvise/madvise03.c
> > > > index b0c17e8..23dd9a6 100644
> > > > --- a/testcases/kernel/syscalls/madvise/madvise03.c
> > > > +++ b/testcases/kernel/syscalls/madvise/madvise03.c
> > > > @@ -160,10 +160,19 @@ static void cleanup(void)  static void
> > > > check_and_print(char *advice)  {
> > > >  	if (TEST_RETURN == -1) {
> > > > -		tst_resm(TFAIL,
> > > > -			 "madvise test for %s failed with "
> > > > -			 "return = %ld, errno = %d : %s",
> > > > -			 advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
> > > > +		if (TEST_ERRNO != ENOTSUP) {
> > > > +			tst_resm(TFAIL,
> > > > +				 "madvise test for %s failed with "
> > > > +				 "return = %ld, errno = %d : %s",
> > > > +				 advice, TEST_RETURN, TEST_ERRNO,
> > > > +				 strerror(TEST_ERRNO));
> > > > +		} else {
> > > > +			tst_resm(TCONF,
> > > > +				"madvise test for %s unsupported "
> > > > +				"return = %ld, errno = %d : %s",
> > > > +				advice, TEST_RETURN, TEST_ERRNO,
> > > > +				strerror(TEST_ERRNO));
> > > > +		}
> > > >  	} else if (STD_FUNCTIONAL_TEST) {
> > > >  		tst_resm(TPASS, "madvise test for %s PASSED", advice);
> > > >  	}
> > > > 
> > > 
> > > 
> > > --------------------------------------------------------------------
> > > --
> > > -------- Managing the Performance of Cloud-Based Applications Take
> > > advantage of what the Cloud has to offer - Avoid Common Pitfalls.
> > > Read the Whitepaper.
> > > http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.
> > > clktrk _______________________________________________
> > > Ltp-list mailing list
> > > Ltp-list@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > > 
> > 
> 

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
