Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sgrubb@redhat.com>) id 1MGvyr-00084v-4H
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 14:19:13 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGvym-0003j7-Aa
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 14:19:09 +0000
From: Steve Grubb <sgrubb@redhat.com>
Date: Wed, 17 Jun 2009 09:31:25 -0400
References: <49b7c2350906151813r31a9fe24icee5b1244f560f7a@mail.gmail.com>
	<200906170822.27961.sgrubb@redhat.com>
	<49b7c2350906170610q775cf031va3dd2e3ae8c868fc@mail.gmail.com>
In-Reply-To: <49b7c2350906170610q775cf031va3dd2e3ae8c868fc@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906170931.30480.sgrubb@redhat.com>
Subject: Re: [LTP] Report - make error of ltp-full-20090531.tgz
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
To: GeunSik Lim <leemgs1@gmail.com>
Cc: Andrew Morgan <morgan@kernel.org>, ltp-list@lists.sourceforge.net

On Wednesday 17 June 2009 09:10:20 am GeunSik Lim wrote:
> On Wed, Jun 17, 2009 at 9:22 PM, Steve Grubb<sgrubb@redhat.com> wrote:
> > I am not the maintainer, so I don't have that ability. I did record a
> > successful test message in bodhi on LTP's behalf to encourage the
> > maintainer to ask for it to be marked stable asap.
>
> Steve and Serge, Thanks.
>
> Unfortunately,
> If ltp version will not upgrade  current ltp-full-20090531 version for
> Fedora11 support,
> or If libcap version of fedora11 will not upgrade,
> I have to modify some ltp files like belows.

The intention of Fedora is to upgrade the library. That's why its in the 
testing repo. It just takes a few days to work through the system. There was a 
release of a bunch of updates yesterday, so it will be a few days before the 
next push.

-Steve

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
