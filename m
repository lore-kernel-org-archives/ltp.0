Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2fVM-0000b9-Hu
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 12:53:16 +0000
Date: Wed, 10 Jun 2015 14:52:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150610125207.GC31980@rei.suse.de>
References: <CAHNg1SruVvcH1TjAmACDW7+CTDOeaHP4j9zvZSQ61PHPgOJTEQ@mail.gmail.com>
	<55780AF5.5050407@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55780AF5.5050407@oracle.com>
Subject: Re: [LTP] How to add test case in LTP for my local use
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> For example, you could create a directory somewhere inside your LTP 
> sources with Makefile including testcases.mk and generic_leaf_target.mk 
> like this:
> 
> top_srcdir              ?= ../
> 
> include $(top_srcdir)/include/mk/testcases.mk
> 
> include $(top_srcdir)/include/mk/generic_leaf_target.mk
> 
> And put your C files there. 'make' and 'make clean' will work inside 
> this directory.

The buildsystem is explained in:

https://github.com/linux-test-project/ltp/wiki/BuildSystem

To include the testcase in a testrun you have to add a line into the
correspoding runtest file (files in runtest/ dirctory).
(which is explained in the Test Writing Guidelines)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
