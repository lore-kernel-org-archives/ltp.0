Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NHxG8-0004lN-Hy
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 10:25:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NHxG0-0002nD-Nv
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 10:25:32 +0000
Date: Tue, 8 Dec 2009 05:25:17 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <113043686.2301260267917617.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1397443934.2251260267853449.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH]fix make install problem for ltp-full-20091130
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
Cc: ltp-list@lists.sourceforge.net


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:

> On Dec 8, 2009, at 2:18 AM, Caspar Zhang wrote:
> 
> > Hello, After I executed make all; make install, I want to 
> > execute runltp but it always fails. The error message is:
> > 
> > FATAL: Test suite not installed correctly
> > INFO: as root user type 'make ; make install'
> > 
> > I searched in Makefile and found the following code:
> > 
> > $(INSTALL_TARGETS) include-install lib-install:
> > 	$(MAKE) -C "$(subst -install,,$@)" \
> > 		-f "$(abs_top_srcdir)/$(subst -install,,$@)/Makefile" all
> > 
> > I think the last word maybe "install".
> > 
> > I modified it to install and ltp ran well. the patch could be 
> > found in the attachment.
> 
> Thanks, but the typo was just fixed moments ago.
> Cheers!
> -Garrett

That's great! I should have read the codes a bit earlier :-)

Caspar

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
