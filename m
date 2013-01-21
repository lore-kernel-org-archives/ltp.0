Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TxLY2-0006sX-FN
	for ltp-list@lists.sourceforge.net; Mon, 21 Jan 2013 17:52:42 +0000
Date: Mon, 21 Jan 2013 18:52:59 +0100
From: chrubis@suse.cz
Message-ID: <20130121175258.GB12074@rei>
References: <C0DEA5E8FC36694CB7391338195EAAEB05DC9A2F37@GUREXMB02.ASIAN.AD.ARICENT.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <C0DEA5E8FC36694CB7391338195EAAEB05DC9A2F37@GUREXMB02.ASIAN.AD.ARICENT.COM>
Subject: Re: [LTP] LTP queries
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
To: Shivakumar Haravi <Shivakumar.Haravi@aricent.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "kumar_haravi@yahoo.com" <kumar_haravi@yahoo.com>

Hi!
> I am currently working on LTP.
> 
> My objective of using LTP.  LTP need to be run on target board (Ex: Panda board). I am able to run script as. /RUNLTP. As per my understanding RUNLTP does only do stress and some functional verification of system call. If I am wrong pls. correct me.

It does mostly system call/glibc call verifications (both for negative
and possitive caseds) and some stress tests too.

It's good idea to run the open_posix_testsuite too (it's not compiled
nor executed by default). These tests utilizes majority of POSIX
interfaces.

> Our next objective is all driver code need to be executed on panda board.
> 
> 
> Need your guidance to proceed further:
> I). Under device driver folder, Each driver code need to be run independently.
> Our objective is to automated the driver code also (Ex: run this script as ./runltp) device driver code also gets executed. Kindly guide us how to do this?
> 
> II )
> 
> Tried to run one driver code as "agp"
> 
>                       1. Able to compile the user_space folder
>                       2. I am not able to compile the kernel_space folder.

The device-drivers tests are known to be broken and basically
unmaintained since 2009 (and this is the reason why they are not build by
default).

> III) How to integrated our new driver code

Sorry you are on your own here. But as usuall patches are welcomed.

> ============================================================================
> 
> IV) S>>> ./runltp -a kumar_haravi@yahoo.com -f shiva > DEBUGLOG/testmail
> NOTE: "shiva" is my command line file,
> Following error getting displayed:
> ./runltp: 882: [: [: unexpected operator
> tar: Removing leading `/' from member names
> tar: Removing leading `/' from member names
> ./runltp: 945: ./runltp: ./runltp: 945: ./runltp: uuencode: not foundmail: not found
> ==============================================================================
> 
> V) I am not able to generate html report also.

Well it seems that you are missing some options from [ test operator and
some binaries. This is most likely caused by your minimal busybox
installation that doesn't support some flags and by missing mail client
(looking at the runltp source you need either uuencode+mail binaries or
mutt installed).

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
