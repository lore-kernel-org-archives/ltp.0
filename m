Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7Qo-00032i-K5
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:57:06 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7Qi-0006IF-KI
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:57:01 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1237446038.5260.9.camel@subratamodak.linux.ibm.com>
References: <9a14a0630903130632s36a7f059hd093d30e97f894eb@mail.gmail.com>
	<1236962876.7439.3.camel@subratamodak.linux.ibm.com>
	<1237272937.5622.11.camel@subratamodak.linux.ibm.com>
	<43e72e890903181242i1be5818et8afd1157cff8af83@mail.gmail.com>
	<1237446038.5260.9.camel@subratamodak.linux.ibm.com>
Date: Tue, 23 Jun 2009 20:18:49 +0530
Message-Id: <1245768529.4860.61.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Support of WIFI and W-LAN test cases in LTP
Reply-To: subrata@linux.vnet.ibm.com
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
To: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Cc: ltp-list@lists.sf.net, Luis Carlos Cobo <luisca@cozybit.com>, Jouni Malinen <j@w1.fi>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "John W. Linville" <linville@tuxdriver.com>, rahul Baliyan <rahul.lpt@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, "Jouni.Malinen" <Jouni.Malinen@atheros.com>

On Thu, 2009-03-19 at 12:30 +0530, Subrata Modak wrote: 
> On Wed, 2009-03-18 at 12:42 -0700, Luis R. Rodriguez wrote:
> > On Mon, Mar 16, 2009 at 11:55 PM, Subrata Modak
> > <subrata@linux.vnet.ibm.com> wrote:
> > > Hi Rahul,
> > >
> > > On Fri, 2009-03-13 at 22:17 +0530, Subrata Modak wrote:
> > >> Hi,
> > >>
> > >> On Fri, 2009-03-13 at 19:02 +0530, rahul Baliyan wrote:
> > >> > Hi,
> > >> >
> > >> > Pl.  confirm if LTP contains the test cases of W-LAN and WI-FI.
> > >>
> > >> Nope. We do not have till now. However, we initiated some discussion
> > >> some 6 months back in the same mailing list regarding Wireless Mesh
> > >> Netwoking tests. Please follow the following thread:
> > >>
> > >> http://marc.info/?t=121969812900007&r=1&w=2&n=4,
> > >>
> > >> There are some tests already avilable. We need somebody to volunteer to
> > >> bring them to some shape so that they can be automated and then
> > >> integrated inside LTP. Would you be ready to do that ?
> > >
> > > Would you like to take up my proposal ?
> > 
> > BTW I've stashed a Linux wireless testing entry in the Linux
> > Foundation GSoC, hopefully that can be merged back into LTP.
> > 
> > https://www.linuxfoundation.org/en/Google_Summer_of_Code_2009#Automation_of_testing_using_mac80211_hwsim_and_Orbit
> 

Hi,

Is somebody working on this, and still interested to contribute the same
to LTP ?

Regards--
Subrata

> Thanks. That would be really great. Send me the automation test patch
> when it is ready with some results, etc.
> 
> Regards--
> Subrata
> 
> > 
> >   Luis
> 
> 
> ------------------------------------------------------------------------------
> Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
> powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
> easily build your RIAs with Flex Builder, the Eclipse(TM)based development
> software that enables intelligent coding and step-through debugging.
> Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
