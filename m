Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OO8sf-0004al-CD
	for ltp-list@lists.sourceforge.net; Mon, 14 Jun 2010 12:35:09 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OO8se-0005zz-0B
	for ltp-list@lists.sourceforge.net; Mon, 14 Jun 2010 12:35:09 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5ECR863027833
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 06:27:08 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5ECYjxA099960
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 06:34:47 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o5ECYgGI010630
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 06:34:42 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTik7Ez_k6vndvmd61jVhxlOjFFV8ih590qUtmE-3@mail.gmail.com>
References: <AANLkTina6_TBV4b6ky66yrw9QgBVwRHYh8WCRhwENLeb@mail.gmail.com>
	<AANLkTin508xMLwEI4xIdaXfU2Wc4sHUZtUBqjukLYFCT@mail.gmail.com>
	<AANLkTik7Ez_k6vndvmd61jVhxlOjFFV8ih590qUtmE-3@mail.gmail.com>
Date: Mon, 14 Jun 2010 18:04:27 +0530
Message-Id: <1276518868.4885.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH][runtest/fs] fix issue where growfiles tests	still
	not creating temp files in directory specified by TMPDIR as expected
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
Cc: ltp-list@lists.sourceforge.net

On Fri, 2010-06-11 at 15:40 -0700, Henry Yei wrote: 
> This is an updated patch which changes the arguments for gf12, gf13
> test to use the named pipes created by mkfifo properly, rather then
> the ordinary file created by and incorporates the previous changes.
> Hopefully that catches everything, these fs tests are quite hard to
> interpret.
> 
> Henry Yei <hyei@mvista.com>

Thanks.

Regards--
Subrata

> 
> On Wed, Jun 9, 2010 at 6:32 PM, Henry Yei <hyei@mvista.com> wrote:
> > On Wed, Jun 9, 2010 at 6:30 PM, Henry Yei <hyei@mvista.com> wrote:
> >> Hello,
> >>
> >> A previous patch that attempts to force tests to use the TMPDIR env
> >> variable is incomplete. This patch fixes growfiles test arguments in
> >> the fs scenario.
> >>
> >> Scripts which use growfiles with command-line file names are not performing the
> >> tests in the expected target directory. When file names are provided on the
> >> growfiles command line, they are taken relative to the cwd and not the -d
> >> auto_dir passed on the command line. This renders many of the test scripts in
> >> runtests ineffective in that the tests are not being performed on the expected
> >> filesystem.
> >>
> >> For example, the first line of the fs scenario reads:
> >>
> >> gf01 growfiles -B 800000 -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10
> >> glseek20 glseek20.2 -d $TMPDIR
> >>
> >> The -d $TMPDIR construct is almost always used in the scripts to point to the
> >> filesystem under test. However, the presence of the
> >> glseek20 glseek20.2 command line parameters constitute full file names from the
> >> test's view, so they will be used as-is (in the current working directory) as
> >> opposed to $TMPDIR/glseek20 or $TMPDIR/glseek20.2 as expected by the script.
> >>
> >> To get the desired behavior, here are the key switches:
> >>
> >> -f specifies the 'auto_file' which is the base file name (gf is used if it's
> >> missing)
> >>
> >> -d specifies the 'auto_dir' to be used ('.' is used if it's missing)
> >>
> >> -S specifies the number of 'auto seq' files to be used. These files are of the
> >> form: "%s/%s%d" using auto_dir, auto_file, file_number.
> >>
> >>
> >> Signed-off-by: Henry Yei <hyei@mvista.com>
> >>
> >
> > Patch for review now attached!
> >
> > Henry Yei <hyei@mvista.com>
> >
> ------------------------------------------------------------------------------
> ThinkGeek and WIRED's GeekDad team up for the Ultimate 
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
> lucky parental unit.  See the prize list and enter to win: 
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
