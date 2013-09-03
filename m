Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VGoRY-0004ai-5W
	for ltp-list@lists.sourceforge.net; Tue, 03 Sep 2013 11:06:44 +0000
Date: Tue, 3 Sep 2013 13:06:51 +0200
From: chrubis@suse.cz
Message-ID: <20130903110651.GB2100@rei>
References: <20130828095459.GB22849@rei.Home>
	<1377782535-15955-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130902155929.GA2146@rei> <52257D67.5020900@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52257D67.5020900@oracle.com>
Subject: Re: [LTP] [PATCH V3 1/3] syscalls/utils/compat_16.mk: fix build
 dependencies
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> But I think that my approach is easier to understand: we explicitly 
> define object files targets, make them depend on compat_16.h and also 
> mark them as intermediate targets (so make will remove them after linking).
> 
> And if we make binaries to depend on compat_16.h gcc treats this header 
> file not as a header:
> 
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall 
> -I/home/stas/ltp/testcases/kernel/include 
> -I/home/stas/ltp/testcases/kernel/syscalls/setgroups 
> -I/home/stas/ltp/testcases/kernel/syscalls/setgroups/../utils 
> -I../../../../include -I../../../../include   -L../../../../lib 
> setgroups01.c 
> /home/stas/ltp/testcases/kernel/syscalls/setgroups/../utils/compat_16.h 
> -lltp -o setgroups01
> 
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall 
> -I/home/stas/ltp/testcases/kernel/include 
> -I/home/stas/ltp/testcases/kernel/syscalls/setgroups 
> -I/home/stas/ltp/testcases/kernel/syscalls/setgroups/../utils 
> -I../../../../include -I../../../../include 
> -DTST_USE_COMPAT16_SYSCALL=1  -c -o setgroups01_16.o setgroups01.c
> gcc   -L../../../../lib  setgroups01_16.o 
> /home/stas/ltp/testcases/kernel/syscalls/setgroups/../utils/compat_16.h 
> -lltp -o setgroups01_16
> 
> It doesn't look nice :)

Ah, it gets to the list of prerequisities and gets apended to the
linking. I Should have noticed this.

I guess that your approach is better.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
