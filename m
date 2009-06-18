Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MHK78-0001aB-NR
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 16:05:22 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHK77-0003ve-CH
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 16:05:22 +0000
Received: by gxk3 with SMTP id 3so4353330gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Jun 2009 09:05:14 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 21:35:14 +0530
Message-ID: <f5a7b3810906180905g2abd23bbk2a268741134371b9@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] installation error ltp-full-20090531
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
To: naveen penumala <naveenspen@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Naveen,

ln: creating hard link `../../../bin/mem01' to `mem01': No such file or
directory

make: *** [install] Error 1
yes.
this is a valid error.
please do a "make install" command at ltp-full-20090531/testcases
before execute the "make install" command in the sub directory.

Because ltp-full-20090531/testcases/Makefile will create
ltp-full-20090531/testcases/bin/ directory

install:
        mkdir -p bin
        @set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done


Best regards,
naresh Kamboju

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
