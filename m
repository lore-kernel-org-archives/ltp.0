Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XeMp2-0008Rh-CC
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 11:32:52 +0000
Date: Wed, 15 Oct 2014 13:32:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141015113230.GB5006@rei.suse.cz>
References: <1407402404.1347.29.camel@G08JYZSD130126>
	<179118855.6420138.1407923193096.JavaMail.zimbra@redhat.com>
	<1411718817.9511.9.camel@G08JYZSD130126>
	<237697509.31082624.1411735385050.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <237697509.31082624.1411735385050.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v2] securebits: some cleanup
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> # ./check_keepcaps 1
> keepcaps    0  TWARN  :  tst_brk_: Invalid Type: 0. Using TBROK
> keepcaps    1  TBROK  :  check_keepcaps.c:88: dropped privs as expected
> 
> from lib/tst_res.c:
>         /*
>          * Only FAIL, BROK, CONF, and RETR are supported by tst_brk().
>          */

When I was looking at the tst interface this looked to me like an
artificial limitation. I guess that we can introduce an function that
would report success and exit the test as well, the only complicated
part would be figuring out good name.

And more progressive view may be that we need two functions for
reporting results. One that just reports the result and one that also
exit the test execution (and calls an optional cleanup callback). But
that would require more changes in the test library and in testscases.
And I do not want to add an unfamiliar interface as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
