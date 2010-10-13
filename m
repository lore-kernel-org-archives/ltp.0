Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1P5rDf-0006Ut-Pb
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:37:31 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5rDd-0000Kq-L1
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:37:31 +0000
Date: Tue, 12 Oct 2010 22:37:21 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1374795441.268351286937441344.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <201010122228.51488.vapier@gentoo.org>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] mmap/munmap /dev/zero
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net


----- "Mike Frysinger" <vapier@gentoo.org> wrote:

> On Tuesday, October 12, 2010 22:06:29 CAI Qian wrote:
> > ----- "Mike Frysinger" wrote:
> > > On Tuesday, October 12, 2010 10:07:16 CAI Qian wrote:
> > > > +	 x = mmap("/dev/zero", SIZE+SIZE-4096, PROT_READ|PROT_WRITE,
> > > > +		 MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> > > 
> > > uhh, have you even checked this test ?  this mmap() makes
> absolutely
> > > no sense on so many levels.
> > 
> > Can you elaborate?
> 
> so you havent actually looked at the syscalls made by the application
> and the 
> memory maps created nor used mmap() in detail before ?  well, let's
> start with 
> the mmap() man page:
> 
> 	void *mmap(void *addr, size_t length, int prot, int flags,
> 		int fd, off_t offset);
> 
> "addr" doesnt sound like "file name" to me, and the description
> agrees:
> 
> 	If addr is not NULL, then the kernel takes it as a hint about where
> to
> 	place the mapping; on Linux, the mapping will be created at a nearby
> page
> 	boundary.  The address of the new mapping is returned as the result
> of
> 	the call.
> 
> so basically you told the kernel to create a mapping in/near your
> .rodata 
> section (since that is the address of the constant string
> "/dev/zero").  the 
> contents of that pointer (which is not of type "char *") have
> absolutely no 
> meaning to the kernel.
> 
> then there are the flags you're using:
> 
> 	MAP_ANONYMOUS
> 		The mapping is not backed by any file; its contents are initialized
> 		to zero.  The fd and offset arguments are ignored; however, some
> 		implementations require fd to be -1 if MAP_ANONYMOUS (or MAP_ANON)
> 		is specified, and portable applications should ensure this.
> 
> so not only are you not getting a mapping from /dev/zero, you're just
> 
> allocating a random piece of memory that the kernel has guaranteed
> will be 
> zeroed out for you.  so any attempts to verify the contents are zero
> *because 
> the data came from /dev/zero* fail.
> 
> finally, there's the fd which you're passing as "-1":
> 
> 	The contents of a file mapping (as opposed to an anonymous mapping;
> see
> 	MAP_ANONYMOUS below), are initialized using length bytes starting at
> 	offset "offset" in the file (or other object) referred to by the
> file
> 	descriptor "fd".
> 
> "-1" is not a valid fd, so there's no way it could possibly be from
> /dev/zero.
> 
> so we're back where we started: this test makes no sense as written
> and you 
> apparently havent verified it "works" beyond "is the exit status 0
> when it 
> finished".
I see. MAP_ANONYMOUS is not needed. It certainly want to use int fd. v3 followed.
> 
> > > why are you using _exit() ?
> > 
> > It is used to terminate a child.
> 
> i meant why arent you using exit() ?  why do you need _exit()
> semantics ?
I don't think that too much. I think it can use exit() too.
> -mike

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
