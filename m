Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwufC-0006Dk-QS
	for ltp-list@lists.sourceforge.net; Fri, 26 Aug 2011 11:33:30 +0000
Date: Fri, 26 Aug 2011 13:38:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110826113843.GA17499@saboteur.suse.cz>
References: <mailman.342816.1314268291.22889.ltp-list@lists.sourceforge.net>
	<20110825174602.GB6398@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110825174602.GB6398@us.ibm.com>
Subject: Re: [LTP] [PATCH 6/7 ver2 w/attachment] Modified pounder install
 and run scripts
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
> > I'm not happy to have tarballs stored in the git for several reasons. Is
> > this really needed? Shouldn't having directories with files serve the
> > same purpose?
> 
> The tarball form makes more sense since we want to select and extract
> only one of the available schedules.

Hmm, but wouldn't copying directory, or even better symlinking it do the
same job?

> These schedule tarballs already exist in the git repository.  Lucy's
> patch merely moved them all into their own subdirectory to improve the
> file organization.  In fact, she even removed one, so now there are
> only 3 instead of 4 :-)

Well, that is exactly the the problem with tarballs, you can't say this
for sure unless you checks by hand.

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
