Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1P5qk4-0007U7-1X
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:06:56 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5qk3-000839-6i
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:06:56 +0000
Date: Tue, 12 Oct 2010 22:06:47 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <792541009.267551286935607117.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <AANLkTikTpZrSUarHhWS3_QJO+Psw4LkHWd7XrA8b3mPg@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:

> On Tue, Oct 12, 2010 at 12:15 PM, Mike Frysinger <vapier@gentoo.org>
> wrote:
> > On Tuesday, October 12, 2010 10:07:16 CAI Qian wrote:
> >> +/* main setup function of test */
> >> +void setup();
> >> +/* cleanup function for the test */
> >> +void cleanup();
> >> +int mmapzero();
> 
> ...
> 
>     +1 to what Mike said, but in all actually what is the purpose of
> this test? There isn't a description either in the commit message or
> the code itself that mentions what this code should functionally do.
> We need both in order for the code to be committed (otherwise folks
> will play the "WTF does this code do?" game when semantics change a
> few years later in the GNU/Linux world).
> Thanks,
Fixed in v2.
> -Garrett

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
