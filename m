Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OMPvL-0003ej-0W
	for ltp-list@lists.sourceforge.net; Wed, 09 Jun 2010 18:22:47 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OMPvK-0000N4-6J
	for ltp-list@lists.sourceforge.net; Wed, 09 Jun 2010 18:22:46 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o59IA7hq008367
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Jun 2010 14:10:07 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o59IMdgB115770
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Jun 2010 14:22:40 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o59IMZab014470
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Jun 2010 12:22:35 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <201006082057.AIJ21895.HSOVtJLFMOOFFQ@I-love.SAKURA.ne.jp>
References: <201006061713.BGF64500.OtOHFJVQLOSFFM@I-love.SAKURA.ne.jp>
	<1275834288.7037.3.camel@subratamodak.linux.ibm.com>
	<201006070651.o576p4S0093912@www262.sakura.ne.jp>
	<1275901898.4851.2.camel@subratamodak.linux.ibm.com>
	<201006082057.AIJ21895.HSOVtJLFMOOFFQ@I-love.SAKURA.ne.jp>
Date: Wed, 09 Jun 2010 23:52:29 +0530
Message-Id: <1276107750.8222.1.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [linux-2.6.36] TOMOYO Linux update
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
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2010-06-08 at 20:57 +0900, Tetsuo Handa wrote: 
> Garrett Cooper wrote:
> > On Jun 7, 2010, at 2:28 PM, Tetsuo Handa wrote:
> > 
> > > Garrett Cooper wrote:
> > >> 2. You might be trying to pull the from the wrong git branch. Try
> > >> something like: git clone
> > >> git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git next .
> > > 
> > > Is it possible to use http:// since I can't use git:// due to firewall.
> > 
> > Try and see whether or not it's possible :)...
> 
> I couldn't use http:// .
> Also http://sourceforge.net/apps/trac/sourceforge/wiki/Git says that
> anonymous (read-only) access supports only git:// .
> 
> 
> 
> Subrata Modak wrote:
> > Please create it properly and send me.
> Here is the updated patch against git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git#next .
> 
> Posting large patches (like below) OK in this ML?
> 
> Regards.
> ----------
> [PATCH] Update test programs for TOMOYO LSM module.
> 
> This patch updates test programs for TOMOYO 2.3 which will be included into
> Linux kernel 2.6.36.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

This applied fine. Thanks.

Regards--
Subrata

> 
>  README                      |   23 -
>  include.h                   |  326 +++++++++++---
>  newns.c                     |    2
>  testall.sh                  |   19
>  tomoyo_accept_test.c        |  145 ++++++
>  tomoyo_file_test.c          |  970 ++++----------------------------------------
>  tomoyo_filesystem_test.c    |  632 ++++++++++++++++++++++++++++
>  tomoyo_new_file_test.c      |  631 ++++++++++++++++++++++++++++
>  tomoyo_new_test.c           |  682 ++++++++++++++++++++++++++++++
>  tomoyo_policy_io_test.c     |  195 ++++++++
>  tomoyo_policy_memory_test.c |  358 ++++++++++++++++
>  tomoyo_rewrite_test.c       |  169 +++++++
>  12 files changed, 3181 insertions(+), 971 deletions(-)



------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
