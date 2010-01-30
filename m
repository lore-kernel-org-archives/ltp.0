Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nb6VZ-0002FZ-Nr
	for ltp-list@lists.sourceforge.net; Sat, 30 Jan 2010 06:08:37 +0000
Received: from mail-gx0-f211.google.com ([209.85.217.211])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nb6VX-0001Mx-Ar
	for ltp-list@lists.sourceforge.net; Sat, 30 Jan 2010 06:08:37 +0000
Received: by gxk3 with SMTP id 3so2779602gxk.6
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Jan 2010 22:08:29 -0800 (PST)
References: <000001caa0a0$61792020$246b6060$@co.jp>
Message-Id: <DDA5465C-8033-450C-8826-F17173E034EB@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <000001caa0a0$61792020$246b6060$@co.jp>
Mime-Version: 1.0 (iPhone Mail 7D11)
Date: Fri, 29 Jan 2010 22:08:22 -0800
Subject: Re: [LTP] 2010-01-29 cvs build problem
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
To: Mitani <mitani@ryobi.co.jp>
Cc: "<ltp-list@lists.sourceforge.net>" <ltp-list@lists.sourceforge.net>

On Jan 28, 2010, at 9:03 PM, "Mitani" <mitani@ryobi.co.jp> wrote:

> Hi,
>
> I tried to build 2010-01-29 cvs in RHEL4.8 system.
>
> "make" and "make install" succeeded, but in "/opt/ltp" directory,  
> there
> were not "runltp". There were "bin", "share", "testcases" directories
> only.
>
> With 2010-01-28 cvs, "make install" installed necessary files such as
> "runltp" to "/opt/ltp" directory as follows:
>
> ------------
> [...]
> install -m 00775 "/home/LTP/ltp-2010-01-28/tools/genload/stress"
> "/opt/ltp/testcases/bin/stress"
> make[2]: Leaving directory `/home/LTP/ltp-2010-01-28/tools/genload'
> make[1]: Leaving directory `/home/LTP/ltp-2010-01-28/tools'
> make -C "runtest" \
>    -f "/home/LTP/ltp-2010-01-28/runtest/Makefile" install
> make[1]: Entering directory `/home/LTP/ltp-2010-01-28/runtest'
> test -d "/opt/ltp/runtest" || mkdir -p "/opt/ltp/runtest"
> install -m 00644 "/home/LTP/ltp-2010-01-28/runtest/admin_tools"
> "/opt/ltp/runtest/admin_tools"
> test -d "/opt/ltp/runtest" || mkdir -p "/opt/ltp/runtest"
> install -m 00644 "/home/LTP/ltp-2010-01-28/runtest/ballista"
> "/opt/ltp/runtest/ballista"
> test -d "/opt/ltp/runtest" || mkdir -p "/opt/ltp/runtest"
> install -m 00644 "/home/LTP/ltp-2010-01-28/runtest/can"
> "/opt/ltp/runtest/can"
> test -d "/opt/ltp/runtest" || mkdir -p "/opt/ltp/runtest"
> install -m 00644 "/home/LTP/ltp-2010-01-28/runtest/cap_bounds"
> "/opt/ltp/runtest/cap_bounds"
> [...]
> install -m 00755 "/home/LTP/ltp-2010-01-28/runltplite.sh"
> "//opt/ltp/runltplite.sh"
> install -m 00755 "/home/LTP/ltp-2010-01-28/ver_linux" "//opt/ltp/ 
> ver_linux"
> head -n 1 "/home/LTP/ltp-2010-01-28/ChangeLog" > "Version"
> install -m 00644 "/home/LTP/ltp-2010-01-28/Version" "//opt/ltp/ 
> Version"
> install -m 00755 "/home/LTP/ltp-2010-01-28/execltp" "//opt/ltp/bin/ 
> execltp"
> Checking for required user/group ids
>
> 'nobody' user id and group found.
> 'bin' user id and group found.
> 'daemon' user id and group found.
> Users group found.
> Sys group found.
> Required users/groups exist.
> ------------
>
> Just a quick note to tell you that.

Shortly after you reported the issue I fixed the root cause. Turns out  
the was a bug as far as how one of the variables was being set so I  
better defined the build tree "states" to accomodate that gap. I also  
wrote some test scripts to test those three sane build states by  
pulling a fresh copy from cvs each time, building, then testing in a  
mostly automated manner (analysis is manual and you have to press  
enter once it tries to login to cvs).

That should prevent really silly build issues in the future...

Cheers,
-Garrett

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
