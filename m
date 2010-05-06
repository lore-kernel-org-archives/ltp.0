Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OA24m-0000I3-PF
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 14:29:20 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OA24k-0003qX-7O
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 14:29:20 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100506135510.GB12072@us.ibm.com>
References: <1272997208.5342.7.camel@subratamodak.linux.ibm.com>
	<20100504192248.GA3696@us.ibm.com>
	<y2l364299f41005041402uce37fd2axc6f1fc7f7df70497@mail.gmail.com>
	<20100504223315.GA16615@us.ibm.com>
	<j2u364299f41005042219vfa5c5aa7ld5673a7eba8b6c64@mail.gmail.com>
	<20100505141829.GA10714@us.ibm.com>
	<E6FF74A2-EB5B-4D11-A9B8-AA25D426D902@gmail.com>
	<20100506135510.GB12072@us.ibm.com>
Date: Thu, 06 May 2010 19:58:40 +0530
Message-Id: <1273156121.4898.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix FILECAPS test hanging for more than 12 hours
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Thu, 2010-05-06 at 08:55 -0500, Serge E. Hallyn wrote:
> Quoting Garrett Cooper (yanegomi@gmail.com):
> > On May 5, 2010, at 7:18 AM, Serge E. Hallyn wrote:
> > 
> > > Quoting Garrett Cooper (yanegomi@gmail.com):
> > >>>                p = index(buf, '.')+1;
> > > 
> > > Jinkeys!  The intertubes archives insist I wrote that, but I'm finding
> > > it hard to believe.
> > > 
> > >>> -               if (p==(char *)1) {
> > >>> -                       tst_resm(TFAIL, "got a bad message from print_caps\n");
> > >>> -                       tst_exit();
> > >>> -               }
> > >>> +               if (p==(char *)1)
> > >>> +                       tst_brkm(TFAIL, tst_exit, "got a bad message from print_caps\n");
> > >> 
> > >>    This is a really incorrect way to do things. I think that the
> > >> assumption made was that index(3) would return 0 ('\0') if it fails to
> > >> find '.'. That's incorrect and would cause a segfault on some systems
> > >> (does on FreeBSD at least... don't see why it would pass on Linux):
> > >> 
> > >> $ ~/test_null_inc
> > >> Segmentation fault: 11 (core dumped)
> > >> [garrcoop@bioshock ~]$ cat ~/test_null_inc.c
> > >> #include <stdio.h>
> > >> int
> > >> main(void)
> > >> {
> > >> 	printf("%s\n", (NULL + 1));
> > >> 	return 0;
> > >> }
> > > 
> > > Well, that's different - you're dereferencing NULL+1, whereas I'm
> > > just checking the the value of the pointer.  
> > > 
> > > Still what I did is darned ugly, cleanup below.
> > > 
> > > thanks,
> > > -serge
> > > 
> > >>    Could you please change this to check and see whether or not index
> > >> returns NULL instead of accessing memory like that?
> > >>    Other than that, patch looks good.
> > > 
> > > From: Serge E. Hallyn <serue@us.ibm.com>
> > > Date: Wed, 5 May 2010 02:59:05 -0500
> > > Subject: [PATCH 1/1] check for index(3) returning NULL
> > > 
> > > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> > > ---
> > > .../kernel/security/filecaps/verify_caps_exec.c    |    5 +++--
> > > 1 files changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
> > > index c3f65a9..605f0f6 100644
> > > --- a/testcases/kernel/security/filecaps/verify_caps_exec.c
> > > +++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
> > > @@ -182,9 +182,10 @@ int fork_drop_and_exec(int keepperms, cap_t expected_caps)
> > > 			tst_resm(TINFO, "got a bad seqno (c=%d, s=%d, seqno=%d)",
> > > 				c, s, seqno);
> > > 		}
> > > -		p = index(buf, '.')+1;
> > > -		if (p==(char *)1)
> > > +		p = index(buf, '.');
> > > +		if (!p)
> > > 			tst_brkm(TFAIL, tst_exit, "got a bad message from print_caps\n");
> > > +		p += 1;
> > > 		actual_caps = cap_from_text(p);
> > > 		if (cap_compare(actual_caps, expected_caps) != 0) {
> > > 			capstxt = cap_to_text(expected_caps, NULL);
> > 
> > Looks good! If that's the complete diff, then Acked-by: Garrett Cooper <yanegomi@gmail.com>
> 
> Right - that one on top of the previous longer one, please.  (or I can rebase-squash
> them and resend if Subrata prefers)

A resend will be great.

Regards--
Subrata

> 
> -serge


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
