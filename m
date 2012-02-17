Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RyMDV-0001xj-60
	for ltp-list@lists.sourceforge.net; Fri, 17 Feb 2012 11:43:09 +0000
Date: Fri, 17 Feb 2012 12:43:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120217114304.GA9992@saboteur.suse.cz>
References: <1329406279-5989-1-git-send-email-filippo.arcidiacono@st.com>
	<4F3DB9FD.7080103@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F3DB9FD.7080103@casparzhang.com>
Subject: Re: [LTP] [PATCH v3] getrusage03: add opportunity to reduce memory
 allocation's size
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > To use this test also in embedded systems it needs to reduce the memory
> > allocation to avoid the test failing when it check the ru_maxrss field
> > expecting a value close to the allocated one.
> > The ru_maxrss field contains the total amount of resident set memory
> > used, so this field doesn't take into account of the swapped memory.
> > Passing [num] parameter at command line the test is executed using the
> > input parameter as multiply factor instead of 10, that is the default
> > value when no argument is passed.
> > 
> > Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
> > Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
> 
> This version looks good to me. @Cyril?

Yes, looks good. I usually use snprintf() to be extra sure not to
rewrite memory, but as far as the BUFSIZ is big enough, this shouldn't
be a problem.

And I would like to have some mechanism how to get free system memory
and compute this automatically in the future (as more tests are failing
when there is not enough memory)...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
