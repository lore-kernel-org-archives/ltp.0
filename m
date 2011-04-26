Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QEkGy-0000mX-MW
	for ltp-list@lists.sourceforge.net; Tue, 26 Apr 2011 15:33:56 +0000
Date: Tue, 26 Apr 2011 17:59:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110426155923.GB28253@saboteur.suse.cz>
References: <20110304170932.19819907@regolo>
	<AANLkTin_4rBGj5O-ZgTdu2C8nV6Lc9-pa9ig8NsAowAd@mail.gmail.com>
	<AANLkTik6nKzqp2tuyhsuk6FvMd540xZVGGddr=B13D-R@mail.gmail.com>
	<20110305010600.0c7cd017@regolo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110305010600.0c7cd017@regolo>
Subject: Re: [LTP] [PATCH] kill05: fix regression
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
To: Cristian Greco <cristian@regolo.cc>
Cc: ltp-list@lists.sourceforge.net

Hi!
> you're right. In fact, the problem is in safe_getpwnam(), which does not
> correctly reproduce the behavior of the deprecated my_getpwnam().
> Moreover, I'm not noticing the problem on my laptop due to a race
> condition in kill05, while it shows an inconsistent behavior on the box
> I'm running tests on (mipsel with glibc, for the sake).
> 
> Could you please fix safe_getpwnam() with either one of the following
> patches?

Technically you are right, but my_getpwnam() behaviour is broken too. As
the strings the structure is pointing to are statically allocated too,
this copying preserves only uid and gid. So instead of creating
crippled interface we will rather fix the test itself.

Thanks the report anyway.

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
