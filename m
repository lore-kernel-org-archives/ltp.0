Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M8cnZ-0007J5-NY
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 16:13:13 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M8cnU-00028W-Nm
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 16:13:13 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4PGFZJ7016336
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 12:15:35 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4PGD7bi222502
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 12:13:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4PGB2eU021687
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 12:11:02 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d51f89b0905220225u4cc3d98dsc9b402b1bd11a772@mail.gmail.com>
References: <d51f89b0905220013v353268d4p3054995a3db0ee0a@mail.gmail.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B35726@exch.hq.tensilica.com>
	<d51f89b0905220225u4cc3d98dsc9b402b1bd11a772@mail.gmail.com>
Date: Mon, 25 May 2009 21:42:57 +0530
Message-Id: <1243267979.6752.17.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Detect test results more accurately
	when	generating HTML
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
To: rohit verma <rohit.170309@gmail.com>, Marc Gauthier <marc@tensilica.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Fri, 2009-05-22 at 14:55 +0530, rohit verma wrote: 
> Hi,
> 
> 
> There is no problem with the genhtml.pl script. The real problem is in
> the pan driver (ltp/pan/pan.c). This seems to be a problem of race
> condition after going through the code.
> 

I would rather want to get this guy fixed inside pan.c. See, if there is
a way so that the concerned test is provisioned by pan:

1) Only after <<test_output>>
2) Pan must flush out everything for writing tags before the actual test
is provisioned
3) The test must have written/flushed everything before Pan started
writing <<test_end>>

Regards--
Subrata

> 
> My suggestion was to use the buffered mode as default. This can be
> done with the -O option followed by a directory name where the
> buffered data can be stored. But, there is a problem - the -O option
> has no effect unless the -x option with an argument greater than 1 is
> used. 
> 
> 
> In your test runs you can add the options " -O <dirname> -x 2" and
> find out if the problem with logging still persists.
> 
> 
> Regards,
> rohit
> 
> 
> 
> 
> 
> 
> On Fri, May 22, 2009 at 2:43 PM, Marc Gauthier <marc@tensilica.com>
> wrote:
>         Hi Rohit, 
>           
>         I guess we've each observed output that the other has
>         not  :-) 
>         
>         Per your (1):  I've seen a few cases where lines between
>         test_end and test_start do belong to the preceding one, though
>         they are indeed the exception, not the rule.  Looking at the
>         name to assign to previous seems to catch the proper ones in
>         all the cases I've seen (default test lists don't repeat the
>         same test twice in a row). 
>           
>         Per your (2):  Haven't seen that, interesting.  That's a bit
>         harder to sort out, but the script could at least catch the
>         lines that report PASS/FAIL/BROK etc.  And perhaps lines that
>         don't look like a collection of var=value.  Hmmm.... maybe all
>         it needs is another regexp test, see patch below (against the
>         genhtml.pl file I posted, which btw was against its latest
>         version, 1.3). 
>           
>         I haven't taken time to look at why things get out of order in
>         the first place, which seems like the correct thing to fix
>         (well, I looked enough to notice that fflush(stdout) was
>         really there :-).  Though making the script handle it doesn't
>         hurt, and I've simply been trying to get an accurate look at
>         test results, this was the quickest way to do it. 
>           
>         -Marc 
>           
>         --- genhtml-v4.pl       2009-05-21 01:08:14.747493000 -0700
>         +++ genhtml.pl  2009-05-22 02:07:47.756226000 -0700
>         @@ -116,18 +116,18 @@
>                         } 
>           
>                         #  Read test result parameters and test output
>         -               while ($line !~ /$end_tag/) {
>         +               while (1) {
>         +                       get_line(\$line) or last TEST;
>         +                       last if $line =~ /$end_tag/;
>                                 ($read_output = 1, next) if $line
>         =~ /$output_tag/;
>                                 ($read_output = 0, next) if $line
>         =~ /$execution_tag/;
>         -                       if ($read_output) {
>         +                       if ($read_output or $line !~ /^(\s*\w
>         +=(".*"|\S*))+\s*$/) {
>                                     push @output_lines, $line;
>                                 } else {
>                                     while ($line =~ s/^\s*(\w+)=(".*"|
>         \S*)//) {
>                                         $values{$1} = $2;
>                                     }
>                                 }
>         -               } continue {
>         -                       get_line(\$line) or last TEST;
>                         } 
>           
>                         #  Treat lines that follow <<<end_test>>> as
>         output lines
>         
>           
>           
>           
>           
>         
>                 
>                 ______________________________________________________
>                 
>                 From: rohit verma [mailto:rohit.170309@gmail.com] 
>                 Sent: Friday, May 22, 2009 00:13
>                 To: subrata@linux.vnet.ibm.com
>                 Cc: Marc Gauthier; LTP List
>                 Subject: Re: [LTP] [PATCH] Detect test results more
>                 accurately when generating HTML
>                 
>                 
>                 
>                 
>                 Hi, 
>                 
>                 
>                 The suggestion to - "Process test output lines that
>                 appear between <<<test_end>>> 
>                 and the following <<<test_start>>>.  Assign to the
>                 preceding test where the name matches, else to the
>                 following test." does not solve the problem
>                 completely.  
>                 
>                 
>                 My observation is:  
>                 
>                 
>                 1. Lines between <<<test_end>>> and <<<test_start>>>
>                 belongs to the following test case and not to the
>                 preceding one. 
>                 2. Also, at times I have observed the test output is
>                 spread in such a way that few lines of the test output
>                 fall between <<<test_end>>> and <<<test_start>>> and
>                 rest of lines appear between the <<<test_start>>> and
>                 <<<test_output>>> of the corresponding testcase. 
>                 
>                 
>                 Regards, 
>                 rohit
>                 
>                 On Fri, May 22, 2009 at 12:22 PM, Subrata Modak
>                 <subrata@linux.vnet.ibm.com> wrote:
>                         On Thu, 2009-05-21 at 01:13 -0700, Marc
>                         Gauthier wrote:
>                         > Hi, my first patch to this list.  Actually
>                         not a patch,
>                         > but the files themselves, to avoid
>                         line-wrapping issues
>                         > and because the diff is twice the size of
>                         the new file.
>                         >
>                         > -Marc
>                         
>                         Thanks Marc.
>                         
>                         Rohit,
>                         
>                         Can you test this and see if these solves the
>                         problem that you were
>                         discussing for long ?
>                         
>                         Regards--
>                         Subrata
>                         
>                         >
>                         >
>                         > -----------
>                         > Detect test results more accurately when
>                         generating HTML
>                         >
>                         > Process test output lines that appear
>                         between <<<test_end>>>
>                         > and the following <<<test_start>>>.  Assign
>                         to the preceding
>                         > test where the name matches, else to the
>                         following test.
>                         >
>                         > If a single test has multiple types of
>                         results (e.g. both
>                         > FAIL and WARN), report only the most
>                         significant one, to
>                         > avoid mis-computing the total number of PASS
>                         tests or
>                         > total counts that don't add up to the number
>                         of tests.
>                         >
>                         > If a test's output has no explicit result
>                         (PASS, FAIL, etc),
>                         > look at the exit value to determine whether
>                         it passed.
>                         >
>                         > Setting the SHOW_UNRESOLVED environment
>                         variable to 1
>                         > classifies as UNRESOLVED any test with no
>                         explicit result
>                         > and a zero exit code.
>                         >
>                         > Setting the SUMMARY_OUTPUT environment
>                         variable to 1
>                         > causes only one line of output per test to
>                         be shown, for a
>                         > tighter page that allows quickly scanning
>                         the results.
>                         >
>                         > Show percentage of each result type in
>                         summary section.
>                         >
>                         > Simplify parsing a bit.
>                         >
>                         > Signed-off-by:  Marc Gauthier
>                         <marc@tensilica.com>
>                         >
>                         >
>                         ------------------------------------------------------------------------------
>                         > Register Now for Creativity and Technology
>                         (CaT), June 3rd, NYC. CaT
>                         > is a gathering of tech-side developers &
>                         brand creativity professionals. Meet
>                         > the minds behind Google Creative Lab, Visual
>                         Complexity, Processing, &
>                         > iPhoneDevCamp asthey present alongside
>                         digital heavyweights like Barbarian
>                         > Group, R/GA, & Big Spaceship.
>                         http://www.creativitycat.com
>                         >
>                         _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list
>                         
>                 
>                 
> 


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
