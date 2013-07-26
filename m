Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1V2dNm-00007n-K7
	for ltp-list@lists.sourceforge.net; Fri, 26 Jul 2013 08:28:14 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V2dNi-0001PG-Lo
	for ltp-list@lists.sourceforge.net; Fri, 26 Jul 2013 08:28:14 +0000
Date: Fri, 26 Jul 2013 04:28:00 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1515555986.6425405.1374827280068.JavaMail.root@redhat.com>
In-Reply-To: <51F22AB9.6060109@cn.fujitsu.com>
References: <1374807380-20319-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<221551028.6361858.1374822441673.JavaMail.root@redhat.com>
	<51F22AB9.6060109@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] pthread_rwlock_rdlock:2-1: do not test on
	glibc
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "LTP" <ltp-list@lists.sourceforge.net>
> Sent: Friday, 26 July, 2013 9:52:25 AM
> Subject: Re: [PATCH 1/3] pthread_rwlock_rdlock:2-1: do not test on glibc
> 
> On 07/26/2013 03:07 PM, Jan Stancek wrote:
> > 
> > 
> > ----- Original Message -----
> >> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> >> To: "LTP" <ltp-list@lists.sourceforge.net>
> >> Cc: "Cyril Hrubis" <chrubis@suse.cz>, "Caspar Zhang"
> >> <caspar@casparzhang.com>, "Garrett Cooper" <yanegomi@gmail.com>,
> >> "Mike Frysinger" <vapier@gentoo.org>, jstancek@redhat.com, "Wanlong Gao"
> >> <gaowanlong@cn.fujitsu.com>
> >> Sent: Friday, 26 July, 2013 4:56:18 AM
> >> Subject: [PATCH 1/3] pthread_rwlock_rdlock:2-1: do not test on glibc
> >>
> >> Since the reader can always acquire the rwlock if there's not a writer
> >> held the lock.
> >>
> >> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> > 
> > Hi,
> > 
> > I agree that these 3 fail by default on glibc at the moment.
> > Since we are adding a GLIBC ifdef, I'm wondering if we could use
> > glibc specific api to change default behaviour with
> > pthread_rwlockattr_setkind_np() and still run the testcase.
> 
> The first 2 *_rdlock cases can change to WRITER_PREFER to let them pass,
> but the last *_unlock one can't, because *_unlock will choose the writer
> first without any care of the NP KIND.
> How about change the first two cases to WRITER_PREFER and just skip the third
> *_unlock one?

I agree with skipping third one and let's see what other guys think about first two.
When you say "WRITER_PREFER", is that an actual define on your system? Or just
a shortcut for PTHREAD_RWLOCK_PREFER_WRITER...?

Regards,
Jan

> 
> Thanks,
> Wanlong Gao
> 
> > 
> > Regards,
> > Jan
> > 
> >> ---
> >>  .../conformance/interfaces/pthread_rwlock_rdlock/2-1.c              | 6
> >>  ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git
> >> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-1.c
> >> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-1.c
> >> index c6c1412..62a4b3b 100644
> >> ---
> >> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-1.c
> >> +++
> >> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-1.c
> >> @@ -141,6 +141,12 @@ int main(void)
> >>  	return PTS_UNSUPPORTED;
> >>  #endif
> >>  
> >> +#ifdef __GLIBC__
> >> +	printf("The reader can always acquire rwlock if there's"
> >> +		" not a writer held this lock in glibc\n");
> >> +	return PTS_UNTESTED;
> >> +#endif
> >> +
> >>  	int cnt = 0;
> >>  	pthread_t rd_thread, wr_thread;
> >>  	int priority;
> >> --
> >> 1.8.3.3.754.g9c3c367
> >>
> >>
> > 
> 
> 

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
