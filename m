Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wf5xy-0002iQ-Pe
	for ltp-list@lists.sourceforge.net; Tue, 29 Apr 2014 11:12:50 +0000
Date: Tue, 29 Apr 2014 13:11:55 +0200
From: chrubis@suse.cz
Message-ID: <20140429111155.GA10768@rei>
References: <19a2d985.16036.14520092241.Coremail.eeslook@163.com>
	<20140410163655.GB25778@rei>
	<5534fca.23dd.1454e729368.Coremail.eeslook@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5534fca.23dd.1454e729368.Coremail.eeslook@163.com>
Subject: Re: [LTP] Fw:Re: [ltp] ltp / testscripts / ltpstress.sh #line 257 :
 error command format for sar (#10)
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
To: ???? <eeslook@163.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hello Cyril Hrubis,

Sorry for the delay, I've been quite bussy with the release.

>     You are right! this error was found at lastest version(20140115).
>     I add 2 patch files:    
>     1. ltp-fix-sar-command-error-20140411.patch:
>         Fix sar command error with commit messages.

This one looks good to me.

>     2.ltp-fix-bad-variable-nameerr-20140411.patch:
>          Fix a bad variable name in runltp script for DEFAULT_FILE_NAME_GENERATION_TIME when ltp running at
>          differenct language os(chinese).
>         This error was found in  my os, I use zh_CN for default language, the `date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
>         will get like "2014_ 4??_11-09h_36m_52s", it can not be a variable name because include chinese characters.

Can you please move this detailed description to the patch itself so
that it gets included in the git repository?

Also please add a signed-of-by line to the patches (git can help create
these once you setup your name and email address) and send these to
mailing list one patch per email (ideally inline as well as attached).

There is a good howto for sumbitting patches to Linux kernel and most of
the information is applicable to other open source projects as well.
Have a look at:

https://www.kernel.org/doc/Documentation/SubmittingPatches

At least paragraphs 2, 3, 7, 11 are directly applicable to LTP as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
