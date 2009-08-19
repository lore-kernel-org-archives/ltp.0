Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <manoj.iyer@canonical.com>) id 1MdZyg-00083U-M3
	for ltp-list@lists.sourceforge.net; Wed, 19 Aug 2009 01:28:38 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MdZyZ-00044i-Th
	for ltp-list@lists.sourceforge.net; Wed, 19 Aug 2009 01:28:38 +0000
Date: Tue, 18 Aug 2009 19:44:07 -0500 (CDT)
From: manoj.iyer@canonical.com
In-Reply-To: <1250586433.9913.15.camel@subratamodak.linux.ibm.com>
Message-ID: <alpine.DEB.2.00.0908181914590.3832@little>
References: <1250586433.9913.15.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] Dead End with LTP Options
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Cai Qian <qcai@redhat.com>, Nate Straz <nate@refried.org>, "manoj.iyer" <manoj.iyer@canonical.com>


>     1. "./runltp -h" will scroll up and will not show on a single
>        screen,
>     2. It will be difficult for users to remember all options and their
>        usage as no. of options increase manifold, which is already too
>        much.

Well many applications do that, and something that cannot be avoided, you 
could spend some time and remove least useful options if you want to trim 
the output a little.

I think your other option is to use /etc/bash_completion and create a CLI 
for 
runltp. something like this:

./runltp option option option=value

for example:
./runltp <tab-tab> prints something like:
./runltp verbose prettyprint iostress ...<more options>... logfile=<enter 
filename>

./runltp ver<tab-tab> expands to ./runltp verbose

./runltp verbose lo<tab-tab> expands to ./runltp verbose logfile= and the 
user enters the filename.

etc. I think you get the drift.

So the user can build the command line on the fly and dont have to hit -h 
then remember options etc.

You could also write the entire CLI in perl which I think offers more 
flexibility to do command complition & CLI.

You can then parse those options & arguments do construct your command 
line for runltp.

> to hear from you on how it can be done best. I would like to see just
> the following command execute LTP as desired by the user:
>
> ./runltp
>
> And the remaining choice of providing more options to 'runltp' hidden
> somewhere.

have you polled to see what options consumers of LTP are using? my 
guess is they are just running with the options that the help command 
prints at the end.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
