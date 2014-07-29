Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XC4OQ-0002rS-1V
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 10:12:26 +0000
Date: Tue, 29 Jul 2014 12:11:37 +0200
From: chrubis@suse.cz
Message-ID: <20140729101137.GE18038@rei>
References: <4506ACC2AE90484D87F9A883BA36C21C2ADF02C2@LCHQEX03.lancope.local>
	<53D20F4D.5000702@oracle.com> <53D21A7D.5020704@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53D21A7D.5020704@oracle.com>
Subject: Re: [LTP] More observations on HEAD
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Joseph Beckenbach <jbeckenbach@lancope.com>

Hi!
> Sorry, I overlooked that thread "[PATCH v2 1/2] lib/tst_res.c: introduce 
> tst_record_childstatus()" already addresses these issues.

And it took longer than it should because it require changes in the test
library.

I've just commited a fix, please retest. :)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
