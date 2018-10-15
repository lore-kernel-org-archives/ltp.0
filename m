From: Dan Rue <dan.rue@linaro.org>
Date: Mon, 15 Oct 2018 09:18:57 -0500
Subject: [LTP] [PATCH v2 ltp] runltp: fix shellcheck error for sending
 email
In-Reply-To: <20181015095214.GA32587@dell5510>
References: <20180726083426.19026-1-yixin.zhang@intel.com>
 <20181015095214.GA32587@dell5510>
Message-ID: <20181015141857.2q7yhvhs6q3c7hdm@xps.therub.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Oct 15, 2018 at 11:52:14AM +0200, Petr Vorel wrote:
> Hi Yixin,
> 
> > runltp:894:11: error: Couldn't parse this test expression. [SC1073]
> > runltp:894:13: error: If grouping expressions inside [..], use \( ..\). [SC1026]
> > runltp:894:15: error: Expected test to end here (don't wrap commands in []/[[]]).
> >                       Fix any mentioned problems and try again. [SC1072]
> 
> > Change '-o' to '&&' according to the comment and context.
> > Then as "$LOGFILE_NAME" is always not empty, remove below "if" statement
> > and update indentation accordingly:
> 
> > if [ -z "$HTMLFILE_NAME" ] && [ -z "$OUTPUTFILE_NAME" ] && [ -z "$LOGFILE_NAME" ]; then
> >   ##User does not have output/logs/html-output, nothing to be mailed in this situation
> >   echo "Nothing to be mailed here...."
> 
> Just to warn you this file si deprecated as Cyril Hrubis works on new runner [1] [2]
> So it might be better test it than invest time into something which is going to
> be deleted.

It might be easier to get people using it if it were in tree. Would it
be possible to have runltp and runltp-ng both in tree? Until then, it's
hard to not support the only available runner.

Looking at the README at
https://github.com/metan-ucw/ltp/tree/master/tools/runltp-ng, it's hard
to tell if it has feature parity with runltp, or if there are still
gaps. Some example usecases would be nice too. For example, I see the
list of back ends, but what if I want to run it locally (today's
behavior)?

Dan

> 
> > Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> > ---
> >  runltp | 139 +++++++++++++++++++++++++++++++----------------------------------
> >  1 file changed, 67 insertions(+), 72 deletions(-)
> 
> ...
> > +    if [ "$ALT_EMAIL_OUT" -eq 1 ] ; then                    ## User wants reports to be e-mailed
> > +        TAR_FILE_NAME=LTP_RUN_$version_date$DEFAULT_FILE_NAME_GENERATION_TIME.tar
> > +        if [ "$HTMLFILE_NAME" ] ; then                      ## HTML file Exists
> > +            if [ "$ALT_HTML_OUT" -ne 1 ] ; then             ## The HTML file path is absolute and not $LTPROOT/output
> > +                mkdir -p $LTPROOT/output                    ## We need to create this Directory
> > +                cp $HTMLFILE_NAME $LTPROOT/output/
> > +            fi
> > +        fi
> > +        if [ "$OUTPUTFILE_NAME" ] ; then                    ## Output file exists
> > +            if [ "$ALT_DIR_OUT" -ne 1 ] ; then              ## The Output file path is absolute and not $LTPROOT/output
> > +                mkdir -p $LTPROOT/output                    ## We need to create this Directory
> > +                cp $OUTPUTFILE_NAME $LTPROOT/output/
> > +            fi
> > +        fi
> > +        if [ "$LOGFILE_NAME" ] ; then                       ## Log file exists
> As I wrote in comment to v1 [3], $LOGFILE_NAME is always defined, so no need to check for it.
> And the same is for for $OUTPUTFILE_NAME
> 
> > +            if [ "$ALT_DIR_RES" -ne 1 ] ; then              ## The Log file path is absolute and not $LTPROOT/results
> > +                mkdir -p $LTPROOT/results                   ## We need to create this Directory
> > +                cp $LOGFILE_NAME $LTPROOT/results/
> > +            fi
> > +        fi
> 
> 
> Kind regards,
> Petr
> 
> [1] https://hackweek.suse.com/17/projects/prototype-new-ltp-upstream-runltp-script
> [2] https://github.com/metan-ucw/ltp
> [3] http://lists.linux.it/pipermail/ltp/2018-July/008783.html
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
