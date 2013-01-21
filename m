Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TxJnS-0000cx-42
	for ltp-list@lists.sourceforge.net; Mon, 21 Jan 2013 16:00:30 +0000
Date: Mon, 21 Jan 2013 17:00:36 +0100
From: chrubis@suse.cz
Message-ID: <20130121160036.GE3768@rei>
References: <4ef1b12514c08ad8ee67c571a9a9b79c8c184829.1358783800.git.zliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ef1b12514c08ad8ee67c571a9a9b79c8c184829.1358783800.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/sendmsg01: using 'ip' command to replace
 'ifconfig'
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> 'ip' tools is more general than 'ifconfig', and there are some
> distros don't support to install 'ifconfig' tools under default,
> which will cause such below error:
> 
>    sh: ifconfig: command not found
>    sendmsg01    1  TBROK  :  ifconfig failed to bring up loop back device
>    sendmsg01    2  TBROK  :  Remaining cases broken
> 
> the patch displaced 'ifconfig' using 'ip', and also the case need root
> permission and checking capture unexpected signal.

But this breaks distros that yet doesn't install ip by default. What
about trying ip and fallback to ifconfig if ip has failed?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
