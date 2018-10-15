From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 15 Oct 2018 21:07:54 +0200
Subject: [LTP] [PATCH v2 ltp] runltp: fix shellcheck error for sending
 email
In-Reply-To: <20181015095214.GA32587@dell5510>
References: <20180726083426.19026-1-yixin.zhang@intel.com>
 <20181015095214.GA32587@dell5510>
Message-ID: <20181015190754.GA26321@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yixin,

> > Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> > ---
> >  runltp | 139 +++++++++++++++++++++++++++++++----------------------------------
> >  1 file changed, 67 insertions(+), 72 deletions(-)

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
Although we should omit this check, I ignored that because the state of the file
(it's in maintenance mode). The main point of this commit was to fix basishm and
remove dead branch.

Pushed, with commit message adjustment.
Thanks for your time and care.

Kind regards,
Petr
