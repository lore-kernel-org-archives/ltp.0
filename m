Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XZJvN-0000m1-83
	for ltp-list@lists.sourceforge.net; Wed, 01 Oct 2014 13:26:33 +0000
Date: Wed, 1 Oct 2014 15:25:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141001132550.GC4701@rei.suse.cz>
References: <21cfeabab1b94a95295f03c96c2a1cb7f99faada.1411546290.git.jstancek@redhat.com>
	<20140930084916.GA5702@rei.suse.cz>
	<225320409.2008145.1412168278476.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <225320409.2008145.1412168278476.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v2] ldd01: remove all -m32/-m64 logic
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Here you are expecting that the testcase is executed with the working
> > directory is LTPROOT, which may not be the case if somebody adds
> > tst_tmpdir to the test. Let's use
> > LD_LIBRARY_PATH="$LTPROOT/datafiles/:$LD_LIBRARY_PATH" instead.
> > 
> > Otherwise the auto detection is really nice to have. Maybe we can do
> > this even better and add a LTP_DATAROOT to test.sh which will
> > automatically point to a directory with the datafiles. If we define that
> > datafiles must be stored in subdirectory named 'datafiles' we can just
> > set the variable in test.sh and then do just:
> > 
> > export LD_LIBRARY_PATH="$LTP_DATAROOT:$LD_LIBRARY_PATH"
> > 
> > in the testcase. What do you think?
> 
> I think it's good idea - then we can avoid doing that in every testcase.
> Is this close to what you had in mind?

Yes, a few comments below.

> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index a59fdd9..d157419 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -181,10 +181,14 @@ IMPORTANT: The runtest files should have one entry per a test. Creating a
>  ^^^^^^^^^^^^^^^
>  
>  If your test needs datafiles to work, these should be generally put into a
> -subdirectory named test name ('TCID' see below) and install it into the
> -'testcases/data/' directory. The datafiles can be accessed as
> -'$LTPROOT/testcases/data/TCID/...'. See
> -'testcases/network/rpc/basic_tests/rpc01/' for example.
> +subdirectory named "datafiles" and installed into the 'testcases/data/$TCID'
> +directory.
> +
> +If your test includes "test.sh" you can use LTP_DATAROOT
> +  '$LTP_DATAROOT/...'
> +The datafiles can also be accessed as
> +  '$LTPROOT/testcases/data/$TCID/...'

Maybe note here that LTP_DATAROOT is prefered because it works both in
the git checkout as well as after installation.

> +See 'testcases/network/rpc/basic_tests/rpc01/' for example.
>  
>  NOTE: There may be some convenience interface added later.

This note should be removed because with the LTP_DATAROOT we added
convenient way to get the path to the datafiles.

And ideally we should add similar interface to the C library as well,
but I'm not sure how we should shape the API. Maybe just a const char
*tst_dataroot(void) function that would return pointer to a static
string initialized on frist call and stored in the test library. But I'm
open to anything else if you have a better idea.

> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index 10282f4..49e3d83 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -144,4 +144,8 @@ export TST_TOTAL="$TST_TOTAL"
>  # Setup LTPROOT, default to current directory if not set
>  if [ -z "$LTPROOT" ]; then
>         export LTPROOT="$PWD"
> +       export LTP_DATAROOT="$LTPROOT/datafiles"
> +else
> +       export LTP_DATAROOT="$LTPROOT/testcases/data/$TCID"
>  fi
> +

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
