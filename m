Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PvW0M-0003Qg-LY
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 14:29:18 +0000
Date: Fri, 4 Mar 2011 15:50:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110304145011.GC21064@saboteur.suse.cz>
References: <OF9AB4C7C7.EB1D7DBD-ON87257822.0057786A-07257822.00583026@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OF9AB4C7C7.EB1D7DBD-ON87257822.0057786A-07257822.00583026@us.ibm.com>
Subject: Re: [LTP] Fw: [Ltp Patch for ext4 punch hole 1/1] Added a new ext4
 hole punch test case
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
To: Allison C Henderson <achender@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This is a re-submission of an earlier patch to add an ext4 testcase to 
> ltp.  I've cleaned up the patch according to the stlye guide and attached 
> a git friendly patch.  This is my first time doing one of these, so please 
> let me know if I left anything out.  Thx!

Sorry for the delay. Looking at the patch, it has dos newlines (CR+LF).

And I see some minor coding style violation like missing spaces after
keywords and so.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
