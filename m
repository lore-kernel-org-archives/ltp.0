Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NHxAd-0007QV-VJ
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 10:19:51 +0000
Received: from mail-yw0-f177.google.com ([209.85.211.177])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NHxAW-0000uK-Hp
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 10:19:51 +0000
Received: by ywh7 with SMTP id 7so6640762ywh.24
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Dec 2009 02:19:39 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1248829539.2041260267494377.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Tue, 8 Dec 2009 02:19:37 -0800
Message-Id: <4305249E-A72B-44FD-93FE-3DFD8C9CCB23@gmail.com>
References: <1248829539.2041260267494377.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Dec 8, 2009, at 2:18 AM, Caspar Zhang wrote:

> Hello, After I executed make all; make install, I want to 
> execute runltp but it always fails. The error message is:
> 
> FATAL: Test suite not installed correctly
> INFO: as root user type 'make ; make install'
> 
> I searched in Makefile and found the following code:
> 
> $(INSTALL_TARGETS) include-install lib-install:
> 	$(MAKE) -C "$(subst -install,,$@)" \
> 		-f "$(abs_top_srcdir)/$(subst -install,,$@)/Makefile" all
> 
> I think the last word maybe "install".
> 
> I modified it to install and ltp ran well. the patch could be 
> found in the attachment.

Thanks, but the typo was just fixed moments ago.
Cheers!
-Garrett

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
