Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XC4Mt-0007I7-4q
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 10:10:51 +0000
Date: Tue, 29 Jul 2014 12:10:06 +0200
From: chrubis@suse.cz
Message-ID: <20140729101005.GD18038@rei>
References: <24aca741786196af9ca38705970289a66b12ab9b.1406622527.git.jstancek@redhat.com>
	<20140729084306.GA15240@rei>
	<1706184967.16286722.1406624646852.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1706184967.16286722.1406624646852.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] mem/oom: check for multiple outcomes if
 overcommit_memory is 0 or 1
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Not many. ENOMEM/SIGKILL or 0 (meaning child completed without issues)
> are the most likely ones we'll need.
> 
> How about:
>   oom(int testcase, int lite, int retcode, int can_be_killed)

Looks good to me.

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
