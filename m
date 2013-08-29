Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1VF2h2-0005Rb-Hf
	for ltp-list@lists.sourceforge.net; Thu, 29 Aug 2013 13:55:24 +0000
Received: from mail-la0-f53.google.com ([209.85.215.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VF2h0-0002GL-NS
	for ltp-list@lists.sourceforge.net; Thu, 29 Aug 2013 13:55:24 +0000
Received: by mail-la0-f53.google.com with SMTP id el20so391731lab.12
	for <ltp-list@lists.sourceforge.net>;
	Thu, 29 Aug 2013 06:55:15 -0700 (PDT)
Date: Thu, 29 Aug 2013 16:00:05 +0200
From: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20130829140004.GL31610@nexon.se>
References: <1377761241-17744-1-git-send-email-anders.roxell@linaro.org>
	<1377761241-17744-3-git-send-email-anders.roxell@linaro.org>
	<CA+icZUWpYYd__ZKdX6SBbbpN9tJHGnywVhrawHo_UJ3ub=3cOA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUWpYYd__ZKdX6SBbbpN9tJHGnywVhrawHo_UJ3ub=3cOA@mail.gmail.com>
Subject: Re: [LTP] [PATCH 2/2] runltp: remove bashisms
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net, patches@linaro.org

Hi,

On 2013-08-29 10:41, Sedat Dilek wrote:
> On Thu, Aug 29, 2013 at 9:27 AM, Anders Roxell <anders.roxell@linaro.org> wrote:
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  runltp | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/runltp b/runltp
> > index a419bf8..970c4ee 100755
> > --- a/runltp
> > +++ b/runltp
> > @@ -733,15 +733,15 @@ main()
> >      #$PAN_COMMAND #Duplicated code here, because otherwise if we fail, only "PAN_COMMAND" gets output
> >
> >      ## Display the Output/Log/Failed/HTML file names here
> > -    echo -e "LOG File: \c"
> > +    echo -n "LOG File: "
> >      echo $LOGFILE | cut -b4-
> >
> >      if [ "$OUTPUTFILE" ]; then
> > -       echo -e "OUTPUT File: \c"
> > +       echo -n "OUTPUT File: "
> >         echo $OUTPUTFILE | cut -b4-
> >      fi
> >
> > -    echo -e "FAILED COMMAND File: \c"
> > +    echo -n "FAILED COMMAND File: "
> >      echo $FAILCMDFILE | cut -b4-
> >
> >      if [ "$HTMLFILE" ]; then
> > --
> > 1.8.1.2
> >
> 
> Yesterday, I looked through diverse GIT repos where I saw a commit
> saying that "echo" (dunno if it was "-e" or "-n") is not
> POSIX-compliant and "printf" should be used.
> I am no POSIX guy, but maybe someone can confirm this?
Thanks, I will rework and resend the patch.

/Anders

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
