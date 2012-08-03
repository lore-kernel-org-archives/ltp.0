Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SxBWr-000220-Rw
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 06:38:33 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SxBWq-0003e5-L3
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 06:38:33 +0000
Date: Fri, 3 Aug 2012 02:38:24 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <238395883.7949798.1343975904079.JavaMail.root@redhat.com>
In-Reply-To: <501B4997.8060002@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/1] madvise03: let the system select an address
 for shmat()
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
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Simon Xu" <xu.simon@oracle.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Friday, 3 August, 2012 5:46:31 AM
> Subject: Re: [LTP] [PATCH 1/1] madvise03: let the system select an address for shmat()
> 
> On 08/03/2012 12:53 AM, Simon Xu wrote:
> > In certain occasions, 0x22000000 is invalid for shmat() and
> > madvise03 fails:
> > 
> > madvise03 1 TBROK : shmat error
> > madvise03 2 TBROK : Remaining cases broken
> > 
> > Use `NULL' for shmat() to let the system attach the shared memory
> > segment
> > at the first available address.
> > 
> > Signed-off-by: Simon Xu <xu.simon@oracle.com>
> > ---
> >  testcases/kernel/syscalls/madvise/madvise03.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/madvise/madvise03.c
> > b/testcases/kernel/syscalls/madvise/madvise03.c
> > index 2e696e8..fd0bd97 100644
> > --- a/testcases/kernel/syscalls/madvise/madvise03.c
> > +++ b/testcases/kernel/syscalls/madvise/madvise03.c
> > @@ -154,13 +154,13 @@ int main(int argc, char *argv[])
> >  		if (shmid1 == -1)
> >  			tst_brkm(TBROK, cleanup, "shmget failed");
> >  
> > -		/* Attach shared memory segment to 0x22000000 address */
> > -		addr1 = shmat(shmid1, (void *)0x22000000, 0);
> > +		/* Attach shared memory segment to an address selected by the
> > system */
> > +		addr1 = shmat(shmid1, NULL, 0);
> >  		if (addr1 == (void *) -1)
> >  			tst_brkm(TBROK, cleanup, "shmat error");
> >  
> >  		/* (1) Test case for MADV_REMOVE */
> > -		TEST(madvise((void *)0x22000000, 4096, MADV_REMOVE));
> > +		TEST(madvise((void *)addr1, 4096, MADV_REMOVE));
> 
> (void *) is not needed now ?
That shouldn't be needed for NULL.

> 
> otherwise, looks OK to me.
+1, this looks better than hardcoding some random address.

> 
> Thanks,
> Wanlong Gao
> 
> >  		check_and_print("MADV_REMOVE");
> >  
> >  		/* (2) Test case for MADV_DONTFORK */
> > 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
