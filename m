Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TqinA-0004pW-2t
	for ltp-list@lists.sourceforge.net; Thu, 03 Jan 2013 11:16:56 +0000
Date: Thu, 3 Jan 2013 12:17:03 +0100
From: chrubis@suse.cz
Message-ID: <20130103111703.GB4780@rei.Home>
References: <24ea25c3c6664fadf44f2497fd72db939791b731.1356921636.git.zliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <24ea25c3c6664fadf44f2497fd72db939791b731.1356921636.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] lib/mm: rewrote create_same_memory function
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
> I splited it for five sub-functions:
> 
>   _ksm_child_memset();
>   _create_ksm_child();
>   _stop_ksm_children();
>   _resume_ksm_children();
>   create_smae_memory();

Identificators that start with _ or __ are reserver for compiler/libc
implementation please do not use them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
