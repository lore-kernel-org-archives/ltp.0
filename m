Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R20EO-00017j-20
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 12:30:52 +0000
Date: Fri, 9 Sep 2011 14:31:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110909123134.GA3552@saboteur.suse.cz>
References: <mailman.342816.1314268291.22889.ltp-list@lists.sourceforge.net>
	<20110825174602.GB6398@us.ibm.com>
	<20110826113843.GA17499@saboteur.suse.cz>
	<20110908110129.GA8261@saboteur.suse.cz>
	<20110908225757.GA31906@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110908225757.GA31906@us.ibm.com>
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
> > Any update on this? I could probably live with the tarbals...
> 
> I'm happy to hear you're feeling flexible about this one.  I started
> fiddling with turning those into subdirs, but found there was being some
> ripple effect into another script which was turning this into a bigger
> job than I currently have time for.  I was going to counter-propose that
> we just leave things as-is for now -- i.e., leave the existing tarballs
> where they currently exist -- but I'd be quite pleased if you'd accept
> moving them to their new home since the new organization makes it
> easier to understand how to use pounder.

I would still rather see this as dirs, but if the change is more than
just untar them and change one script, I could live with the tarballs
for now.

> >  but we
> > should at least do something about the LTP patches.
>  
> I just perused this issue more closely, and realize that the diff is
> already doing what you want.  The existing script patches the setregid02
> subtest, but Lucy's patch comments out those lines.
> 
> I could delete them completely rather than commenting them out, but
> I'd appreciate keeping the comments for now in case I encounter the
> original problem with some older distro. 

Well there are two patches, one that is used to add some include lines
in case of debian distro and actually that one is still in place and
even may be correct. Could you check if this one is correct, int this
case we would just apply it to LTP and drop it from pounder entirely.

PS: the second patch for setregid is not likely to apply now as there
    were some changes in the source code.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Why Cloud-Based Security and Archiving Make Sense
Osterman Research conducted this study that outlines how and why cloud
computing security and archiving is rapidly being adopted across the IT 
space for its ease of implementation, lower cost, and increased 
reliability. Learn more. http://www.accelacomm.com/jaw/sfnl/114/51425301/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
