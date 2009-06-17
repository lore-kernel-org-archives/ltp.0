Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sgrubb@redhat.com>) id 1MGv5G-0001jM-NZ
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 13:21:46 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGv5D-0007BU-C7
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 13:21:46 +0000
From: Steve Grubb <sgrubb@redhat.com>
Date: Wed, 17 Jun 2009 08:22:18 -0400
References: <49b7c2350906151813r31a9fe24icee5b1244f560f7a@mail.gmail.com>
	<20090616184148.GA3043@us.ibm.com>
	<49b7c2350906161642y1222c3e5h45f5912a01c77f06@mail.gmail.com>
In-Reply-To: <49b7c2350906161642y1222c3e5h45f5912a01c77f06@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906170822.27961.sgrubb@redhat.com>
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

On Tuesday 16 June 2009 07:42:33 pm GeunSik Lim wrote:
> On Wed, Jun 17, 2009 at 3:41 AM, Serge E. Hallyn<serue@us.ibm.com> wrote:
> > enabling testing still gave me only libcap-2.16-2, but
> > I downloaded and installed libcap-devel-2.16-4.fc11.i586.rpm
> > after which all compiled fine.
> >
> > GeunSik, please give that a shot.
>
> Thanks for fast reply about this problem.
> I tested "make" command with ltp-full-20090531 and libcap-2.16-4 again.
> "make" command finished successfully without compatibility related errors.
> Belows is screenshot.
>
> Steve,
> Please, Can you move  this rpm files from test repository  to official
> repository?

I am not the maintainer, so I don't have that ability. I did record a 
successful test message in bodhi on LTP's behalf to encourage the maintainer 
to ask for it to be marked stable asap.

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
