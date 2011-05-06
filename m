Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QIJFG-0003Sk-Cn
	for ltp-list@lists.sourceforge.net; Fri, 06 May 2011 11:30:54 +0000
Date: Fri, 6 May 2011 13:25:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110506112531.GA17564@saboteur.suse.cz>
References: <1303477727.18220.15.camel@moss-pluto>
	<4DB1E88D.2030808@linux.vnet.ibm.com>
	<1303738356.4244.67.camel@moss-pluto>
	<96AA5F80-E871-4368-BEB7-BC9FA24FFABD@gmail.com>
	<1303824070.4244.102.camel@moss-pluto>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1303824070.4244.102.camel@moss-pluto>
Subject: Re: [LTP] selinux-testsuite has moved
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>, Serge Hallyn <serge@hallyn.com>

Hi!
Okay, let's renew the conversation now. What we have:

* selinux is outdated in LTP and maintained elsewhere
* and the selinux is not well integrated with LTP

And my points are:

* we don't have manpower to integrate selinux with LTP
* it's not good if testers use outdated selinux from LTP

And what we could do:

* remove selinux from LTP with redirect to it's repository
  - that is easy, but a little controversial

* start pulling changes in selinux git into LTP git
  - should be easy, may have some problems with LTP make system
    integration

* integrate selinux with LTP
  - hard one, anybody starting that would have my support (I could help
    with understanding LTP infrastructure)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
