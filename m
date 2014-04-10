Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WYHyt-0004F5-R5
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 16:37:39 +0000
Date: Thu, 10 Apr 2014 18:36:55 +0200
From: chrubis@suse.cz
Message-ID: <20140410163655.GB25778@rei>
References: <19a2d985.16036.14520092241.Coremail.eeslook@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <19a2d985.16036.14520092241.Coremail.eeslook@163.com>
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
>     Attach the patch file for fix sar command error.
> 
> 
> -------- ???????????? --------
> ????????"Cyril Hrubis" <notifications@github.com>
> ??????????2014-04-01 21:23:33
> ????????linux-test-project/ltp <ltp@noreply.github.com>
> ????????look <eeslook@163.com>
> ??????Re: [ltp]  ltp / testscripts / ltpstress.sh #line 257 : error command format for sar  (#10)
> 
> 
> Can you please send a patch to the LTP mailing list?

Can you also write short commit message (with kernel like Signed-of-by:
line) that explains the change?

I've looked at the systat pages and the looks like zero was never
supported as a number of iterations (but may have been wrongly accepted
some time ago).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
