Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OJnWe-0008I2-Bc
	for ltp-list@lists.sourceforge.net; Wed, 02 Jun 2010 12:58:28 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OJnWc-0005Ui-0j
	for ltp-list@lists.sourceforge.net; Wed, 02 Jun 2010 12:58:28 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTimmc26-PkENwwuVG6dzu6BamzfSbmE_rjX9_5Mm@mail.gmail.com>
References: <103530624.1121001272433642504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<8B8139E0-F07A-433D-B38D-30DAB81E3FF5@gmail.com>
	<s2r700385ec1004272327n8b26491bt3609f8877b71a385@mail.gmail.com>
	<m2z42aa607e1004301227tfec6a200kda741f32b6feeb11@mail.gmail.com>
	<x2l364299f41004301315x20fa3ed6u488dc923334fd5d6@mail.gmail.com>
	<q2w42aa607e1004301556s76e89e8nf68d4bee860da4bd@mail.gmail.com>
	<u2u364299f41004301941pe0e04112u34e7da16e7d1f3df@mail.gmail.com>
	<x2y42aa607e1005032014se4159c89z95d2b670b7195df5@mail.gmail.com>
	<AANLkTimmc26-PkENwwuVG6dzu6BamzfSbmE_rjX9_5Mm@mail.gmail.com>
Date: Wed, 02 Jun 2010 18:28:00 +0530
Message-Id: <1275483481.4899.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Tue, 2010-06-01 at 17:55 -0700, Henry Yei wrote: 
> Hi,
> 
> I just wanted to see if there was still interest in the patch from
> this thread last month.

Thanks. I was not aware of this patch. Checked in now.

Regards--
Subrata

> 
> Henry Yei <hyei@mvista.com>
> 
> 
> On Mon, May 3, 2010 at 8:14 PM, Henry Yei <hyei@mvista.com> wrote:
> > Garrett,
> >
> > This patch installs the trap for cleanup_test which removes the
> > sudoers file only if it was installed by utimensat script, and also
> > takes care of detecting whether sudo knows about the -n option.
> >
> > Signed-Off-By: <hyei@mvista.com>
> >
> >
> > The patch was generated from ltp-dev git tree.
> >
> > I didn't realize Caspar's patch hadn't already been incorporated yet,
> > so didn't account for it.
> >
> > Henry Yei <hyei@mvista.com>
> >
> >
> > On Fri, Apr 30, 2010 at 7:41 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> >> On Fri, Apr 30, 2010 at 3:56 PM, Henry Yei <hyei@mvista.com> wrote:
> >>> If a sudo file exists, the patch doesn't touch it. If it does not, a
> >>> sudoers file will be created and then it will remove it afterwards. I
> >>> wouldn't feel confortable having a script modify a sudoers file if it
> >>> already exists. The sudoers content that it does put in place just
> >>> enables the root user to use sudo, which would not give it any more
> >>> access than it already has. This text is available in every sudoers
> >>> file I've looked at.
> >>>
> >>>
> >>>
> >>> While I was testing the patch with the ltp-dev branch, I noticed that
> >>> the -n option was put in front of every sudo call in commit
> >>> 2aa40f7e10518977881b933cc93b8f50847cf3cf in order to suppress the
> >>> interactive password check.
> >>>
> >>> However, neither sudo 1.6.8p12 from MontaVista Linux 6 or 1.6.9p17
> >>> from Ubuntu 9.04 supports the  -n option. The patch also removes the
> >>> -n option from sudo calls. This option was added in 3/2008.
> >>
> >> Ugh. The sudo in gentoo did this though and that's the reason why I
> >> added it in some scripts -- otherwise the pieces of junk halt waiting
> >> for user input and I had manually kill the scripts >:(... I guess a
> >> test will need to be added to ensure that sudo _does_ have the -n
> >> option beforehand, if it does, add the -n option. Otherwise all people
> >> running older versions are kind of SoL.
> >>
> >> sudo is still a non-standard tool and a pain in the butt to deal with
> >> in scripts as it changes from time to time.
> >>
> >> FWIW your patch only deals with the case when the script `exits
> >> cleanly' as there aren't any traps installed for cleanup_test.
> >>
> >>> On Fri, Apr 30, 2010 at 1:15 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> >>>> On Fri, Apr 30, 2010 at 12:27 PM, Henry Yei <hyei@mvista.com> wrote:
> >>>>> Speaking of the utimesat test and prerequisites, our test systems
> >>>>> don't have a sudoers file by default, so we have an internal patch to
> >>>>> utimesat to create a default one if non exist and remove it after the
> >>>>> test is done. Would that be of interest to LTP?
> >>>>>>>
> >> Thanks,
> >> -Garrett
> >>
> >
> 
> >>>>> On Tue, Apr 27, 2010 at 11:27 PM, Caspar Zhang <casparant@gmail.com> wrote:
> >>>>>> On Wed, Apr 28, 2010 at 2:04 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> >>>>>>> The first item is different from the other two. The first one ignores the
> >>>>>>> signal (SIG_IGN), whereas the latter two cases reset the handler to the
> >>>>>>> default one (SIG_DFL). I prefer the former format, because otherwise the
> >>>>>>> signal handlers become reentrable on accident.
> >>>>>>
> >>>>>> I see. Thank you.
> >>>>>>
> >>>>>> The final patch ;-)
> >>>>
> >>>> If it:
> >>>>
> >>>> 1. Works in all cases, i.e. doesn't use version specific constructs
> >>>> for sudo (which I haven't seen thus far, but just to be safe).
> >>>> 2. Is properly reverted when the test is done (which includes the
> >>>> following scenarios):
> >>>>    a. File already exists. Backup the old file, revert it when the
> >>>> test is completed (regardless of whether or not the test passed or the
> >>>> test failed properly [*]).
> >>>>    b. File doesn't exist. Nuke the file after the test is done.
> >>>>
> >>>>    ... sure.
> >>>> Thanks,
> >>>> -Garrett
> >>>>
> >>>> [*] SIGKILL or SIGSTOP can't be avoided, so technically it's a best effort.
> ------------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
