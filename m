Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJllJ-00079b-5f
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:00:57 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJllH-00025m-Uc
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:00:57 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <ee8eb53d0906231508ta738039m562dee936319624c@mail.gmail.com>
References: <9a14a0630903130632s36a7f059hd093d30e97f894eb@mail.gmail.com>
	<1236962876.7439.3.camel@subratamodak.linux.ibm.com>
	<1237272937.5622.11.camel@subratamodak.linux.ibm.com>
	<43e72e890903181242i1be5818et8afd1157cff8af83@mail.gmail.com>
	<1237446038.5260.9.camel@subratamodak.linux.ibm.com>
	<1245768529.4860.61.camel@subratamodak.linux.ibm.com>
	<43e72e890906230831q6e6c9e2v49454ab66ca99156@mail.gmail.com>
	<ee8eb53d0906231508ta738039m562dee936319624c@mail.gmail.com>
Date: Thu, 25 Jun 2009 14:40:29 +0530
Message-Id: <1245921029.5542.44.camel@subratamodak.linux.ibm.com>
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
To: Georgy Berdyshev <codingmaster@gmail.com>
Cc: ltp-list@lists.sf.net, "Luis R. Rodriguez" <lrodriguez@atheros.com>, Jouni Malinen <j@w1.fi>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "John W. Linville" <linville@tuxdriver.com>, rahul Baliyan <rahul.lpt@gmail.com>, Luis Carlos Cobo <luisca@cozybit.com>, Johannes Berg <johannes@sipsolutions.net>, "Jouni.Malinen" <Jouni.Malinen@atheros.com>

On Tue, 2009-06-23 at 19:08 -0300, Georgy Berdyshev wrote: 
> Hi,
> 
> Luis did already mention that the idea is to contribute things back to
> LTP or have LTP use it.

Great to hear that again. I was trying to figure out the status of that
work ? When is it expected to complete, any idea ?

Regards--
Subrata

> In case that there is some work going on, I would like to merge those
> tests also into my project
> and later on extend the work with LTP.
> 
> In any case, feel free to contact me.
> 
> Regards, Georgy
> 
> On Tue, Jun 23, 2009 at 12:31 PM, Luis R.
> Rodriguez<lrodriguez@atheros.com> wrote:
> > On Tue, Jun 23, 2009 at 7:48 AM, Subrata
> > Modak<subrata@linux.vnet.ibm.com> wrote:
> >> On Thu, 2009-03-19 at 12:30 +0530, Subrata Modak wrote:
> >>> On Wed, 2009-03-18 at 12:42 -0700, Luis R. Rodriguez wrote:
> >>> > On Mon, Mar 16, 2009 at 11:55 PM, Subrata Modak
> >>> > <subrata@linux.vnet.ibm.com> wrote:
> >>> > > Hi Rahul,
> >>> > >
> >>> > > On Fri, 2009-03-13 at 22:17 +0530, Subrata Modak wrote:
> >>> > >> Hi,
> >>> > >>
> >>> > >> On Fri, 2009-03-13 at 19:02 +0530, rahul Baliyan wrote:
> >>> > >> > Hi,
> >>> > >> >
> >>> > >> > Pl.  confirm if LTP contains the test cases of W-LAN and WI-FI.
> >>> > >>
> >>> > >> Nope. We do not have till now. However, we initiated some discussion
> >>> > >> some 6 months back in the same mailing list regarding Wireless Mesh
> >>> > >> Netwoking tests. Please follow the following thread:
> >>> > >>
> >>> > >> http://marc.info/?t=121969812900007&r=1&w=2&n=4,
> >>> > >>
> >>> > >> There are some tests already avilable. We need somebody to volunteer to
> >>> > >> bring them to some shape so that they can be automated and then
> >>> > >> integrated inside LTP. Would you be ready to do that ?
> >>> > >
> >>> > > Would you like to take up my proposal ?
> >>> >
> >>> > BTW I've stashed a Linux wireless testing entry in the Linux
> >>> > Foundation GSoC, hopefully that can be merged back into LTP.
> >>> >
> >>> > https://www.linuxfoundation.org/en/Google_Summer_of_Code_2009#Automation_of_testing_using_mac80211_hwsim_and_Orbit
> >>>
> >>
> >> Hi,
> >>
> >> Is somebody working on this, and still interested to contribute the same
> >> to LTP ?
> >
> > Yes, the idea is to hopefully contribute it back to LTP. Or have LTP
> > use it. I've added Georgy, the student working on this project.
> >
> >  Luis
> >
> 
> 
> 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
