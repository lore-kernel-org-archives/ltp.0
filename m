Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1P5qjn-0007T5-Mp
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:06:39 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5qjm-00005P-HH
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:06:39 +0000
Date: Tue, 12 Oct 2010 22:06:29 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <190532638.267491286935589416.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <201010121515.07416.vapier@gentoo.org>
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

> On Tuesday, October 12, 2010 10:07:16 CAI Qian wrote:
> > +/* main setup function of test */
> > +void setup();
> > +/* cleanup function for the test */
> > +void cleanup();
> > +int mmapzero();
> 
> functins that take no args should be "(void)" and not "()"
Fixed in v2.
> 
> > +int main(int ac, char **av)
> 
> use consistent style.  this should be "int argc" and "char *argv[]".
Fixed.
> 
> > +	if (msg != (char *)NULL) {
> 
> useless cast
Fixed.
> 
> > +		if(TEST_RETURN != 0)
> 
> need a space before the "("
Fixed
> 
> > +	 x = mmap("/dev/zero", SIZE+SIZE-4096, PROT_READ|PROT_WRITE,
> > +		 MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> 
> uhh, have you even checked this test ?  this mmap() makes absolutely
> no sense 
> on so many levels.
Can you elaborate?
> 
> > +	 if (x == MAP_FAILED) {
> > +		 perror("error");
> 
> make this perror() slightly less useless by replacing "error" with
> "mmap".  
> although, i wonder why you cant use any of the ltp helper functions
> for error 
> reporting ... tests rarely (if ever) should be writing to
> stdout/stderr 
> themselves.
Fixed.
> 
> > +	 if (!fork()) {
> > +		 munmap(x + SIZE+4096, SIZE-4096*2);
> > +		 _exit(0);
> > +	 }
> > +	 if (!fork()) {
> > +		 if (!fork()) {
> > +			 munmap(x + SIZE+4096, SIZE-4096*2);
> > +			 _exit(0);
> > +		 }
> > +		 munmap(x + SIZE+4096, SIZE-4096*2);
> > +		 _exit(0);
> > +	 }
> > +	 munmap(x, SIZE+SIZE-4096);
> 
> fork() returns -1 on error which means this code misbehaves.
Fixed.
> 
> why are you using _exit() ?
It is used to terminate a child.
> 
> munmap() returns a value you shouldbe checking.  blindly calling funcs
> doesnt 
> accomplish much.
Fixed.
> 
> > + void cleanup()
> > + {
> > +	 /*
> > +	  * remove the tmp directory and exit
> > +	  */
> > +	 TEST_CLEANUP;
> > +	 tst_rmdir();
> > +	 tst_exit();
> > +
> > + }
> 
> useless newline before the closing brace
Fixed.
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
