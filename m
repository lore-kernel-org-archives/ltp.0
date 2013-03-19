Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UHzXs-0000lj-Pt
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 16:37:52 +0000
Date: Tue, 19 Mar 2013 17:38:32 +0100
From: chrubis@suse.cz
Message-ID: <20130319163832.GA1087@rei>
References: <20130319160917.GA14021@rei>
	<1590001509.21115132.1363709682126.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1590001509.21115132.1363709682126.JavaMail.root@redhat.com>
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
> > > Nice. I will have a look at the data too.
> > 
> > Here are some statistical data:
> > 
> > The total number of tests mentioned in the report is 747, 600 is from
> > the
> > testcases/kernel/ directory along with some in network, misc. There
> > seems to be quite a number of reports in the lib/ directory.
> > 
> > Could you run the tool for the openposix testcases as well?
> 
> I forgot that those are not compiled along with everything else.
> Yes, I can do that, I'll adjust my setup and give a try.
> 
> I noticed you are making changes in this area, would it make more sense
> to run it on latest rather than latest LTP stable?

Most of the fixes I've did was to remove stubs, but there vere some real
fixes (but most likely single digit number). The same applies to
the rest of the testcases.

So if running it in latest git is simple enough, please do so, otherwise
stick with the latest release.

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
