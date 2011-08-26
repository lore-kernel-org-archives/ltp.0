Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwuhH-0006LI-FI
	for ltp-list@lists.sourceforge.net; Fri, 26 Aug 2011 11:35:39 +0000
Date: Fri, 26 Aug 2011 13:40:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110826114054.GB17499@saboteur.suse.cz>
References: <mailman.342816.1314268291.22889.ltp-list@lists.sourceforge.net>
	<20110825172626.GA6398@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110825172626.GA6398@us.ibm.com>
Subject: Re: [LTP] [PATCH 4/7 ver2 w/attachment] Changes to pounder's build
 scripts (Cyril Hrubis)
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
To: James Takahashi <takahash@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Lucy was a summer intern here at IBM, but her internship has ended.  I'll
> try to resolve any open issues with her pounder patch submission.  Please
> direct any future comments to me.

Okay.

> > Patching LTP before build from this build script is not really long term
> > solution. We should get these patches applied to LTP (as it should have
> > been done long time ago) and drop this logic entrirely.
> 
> I agree that this smells like a workaround, not a long term solution.
> 
> I'll investigate whether the setregid02 patch is still needed or not,
> then I'll resubmit this patch.

Ideally if these patches are needed, they should be merged into LTP and
dropped from here. (I've found at least two LTP patches there).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
