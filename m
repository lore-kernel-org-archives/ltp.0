Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <andi.kleen@intel.com>) id 1S8YFi-0007ui-TT
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 14:35:34 +0000
Received: from mga03.intel.com ([143.182.124.21])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S8YFd-0007E0-C1
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 14:35:34 +0000
Date: Fri, 16 Mar 2012 07:35:22 -0700
From: Andi Kleen <andi.kleen@intel.com>
Message-ID: <20120316143522.GB19604@alboin.amr.corp.intel.com>
References: <4F58E36E.5000306@casparzhang.com>
	<4F594DE2.4040603@cn.fujitsu.com>
	<4F62EB70.7010400@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F62EB70.7010400@casparzhang.com>
Subject: Re: [LTP] [RFC] make mce-test a submodule
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Chen Gong <gong.chen@linux.intel.com>, ying.huang@intel.com

On Fri, Mar 16, 2012 at 03:27:44PM +0800, Caspar Zhang wrote:
> Hi all, I'll merge this change to master if I don't hear any objections
> from you by today.

Fine for me. Copying Gong Chen who did most of the mce-test work recently
too.

-Andi

> 
> 
> On 03/09/2012 08:25 AM, Wanlong Gao wrote:
> > On 03/09/2012 12:50 AM, Caspar Zhang wrote:
> > 
> >> Hi Garrett, Andi, and all:
> >>
> >> When I looked into current LTP tree, I found it a little messy due to
> >> some mce-test stuff, such as
> >>
> >>   - mce-test docs goes to $TOPDIR/README, and
> >>   - some mce-test files still lying under testcase/mce-test/.
> >>
> >> I think we need a cleanup for it.
> > 
> > 
> > yes, I think so.
> > 
> >>
> >> Also an idea comes to my mind, that we can try to make mce-test a
> >> submodule of LTP.
> > 
> > 
> > Not a bad idea.
> > 
> >>
> >> I am also thinking about the pros and cons:
> >>
> >> pro(s):
> >>   - easier for code maintenance, no need to sync periodically from
> >> maintainer side
> >>
> >> con(s):
> >>   - two extra steps added for LTP users, they have to do:
> >>     $ git submodule init
> >>     $ git submodule update
> >> to enable using mce-test.
> >>
> >> mce-test could no longer be found at kernel.org, so I cloned it from
> >> Andi's github repo, not sure if it is the right place:
> >>
> >>     git://github.com/andikleen/mce-test.git
> > 
> > 
> > The tree seems just a few update every month now, I wonder why intel guys
> > didn't sync the commits to LTP ?
> > 
> >>
> >> I have made this change to my personal LTP fork, you can review it here:
> >>
> >>     https://github.com/casparant/ltp/commit/5cca17f633
> > 
> > 
> > The patch loooks good.
> 
> Wanlong, thanks for review.
> 
> Thanks,
> Caspar
> 
> 
> 

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
