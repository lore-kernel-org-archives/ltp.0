Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UHz5X-0005Ml-1j
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 16:08:35 +0000
Date: Tue, 19 Mar 2013 17:09:17 +0100
From: chrubis@suse.cz
Message-ID: <20130319160917.GA14021@rei>
References: <1437086244.21063924.1363705319128.JavaMail.root@redhat.com>
	<623806259.21081036.1363706313082.JavaMail.root@redhat.com>
	<20130319152805.GB11291@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130319152805.GB11291@rei>
Subject: Re: [LTP] Coverity report for ltp-20130109
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> > What is Coverity?
> > Coverity Prevent is commercial enterprise level tool for static analysis
> > (analysis based only on compiling of sources, not based on running of binary)
> > of the C/C++ and Java code.
> > 
> > analyzer coverity
> > analyzer-args --wait-for-license -co BAD_FREE:allow_first_field:true --all
> > analyzer-version Coverity Static Analysis for C/C++ version 6.5.1 on Linux 2.6.32-279.el6.x86_64 x86_64
> > 
> > I ran it for current LTP stable (20130109) (on top of RHEL6.4)
> > and I'm sharing results here:
> > http://jan.stancek.eu/coverity/ltp-20130109-1.el6.err.xz
> > 
> > I looked at results only very briefly so far. The one that caught my
> > eye was actually my previous email: inode02: fix "slash" array overrun.
> > This run includes "--all" parameter, so it's likely there are some false
> > positives.
> 
> Nice. I will have a look at the data too.

Here are some statistical data:

The total number of tests mentioned in the report is 747, 600 is from the
testcases/kernel/ directory along with some in network, misc. There
seems to be quite a number of reports in the lib/ directory.

Could you run the tool for the openposix testcases as well?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
