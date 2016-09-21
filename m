From: Zorro Lang <zlang@redhat.com>
Date: Wed, 21 Sep 2016 12:56:51 +0800
Subject: [LTP] [PATCH v2] runltp: add -R option for randomize test order
In-Reply-To: <20160920143916.GA4272@rei.suse.cz>
References: <1473344468-7835-1-git-send-email-zlang@redhat.com>
 <20160920143916.GA4272@rei.suse.cz>
Message-ID: <20160921045651.GS12847@dhcp12-143.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 20, 2016 at 04:39:17PM +0200, Cyril Hrubis wrote:
> Hi!
> > @@ -64,6 +64,8 @@
> >  #               - Added capability for default Log file generation
> >  #		Aug 17 2009 - Modified - Subrata Modak
> >  #		- Added Fault Injection generation Capability through -F Option
> > +#		Sep 08 2016 - Modified - Zorro Lang
> > +#		- Added randomize test order capability through -R Option
> 
> We do not update this changelog anymore since the information about the
> change is stored in the git commit messatge.

OK, I saw there's changelog, so I thought maybe you hope it can be updated.
V3 will remove this.

> 
> >  #
> >  #################################################################################
> >  
> > @@ -153,6 +155,7 @@ usage()
> >      -p              Human readable format logfiles.
> >      -q              Print less verbose output to screen.
> >      -r LTPROOT      Fully qualified path where testsuite is installed.
> > +    -R              Randomize test order.
> >      -s PATTERN      Only run test cases which match PATTERN.
> >      -S SKIPFILE     Skip tests specified in SKIPFILE
> >      -t DURATION     Execute the testsuite for given duration. Examples:
> > @@ -213,12 +216,13 @@ main()
> >      local EMAIL_TO=""
> >      local TAG_RESTRICT_STRING=""
> >      local PAN_COMMAND=""
> > +    local RANDOMRUN=0
> >      local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%m_%d-%Hh_%Mm_%Ss"`
> >      local scenfile=
> >  
> >      version_date=$(cat "$LTPROOT/Version")
> >  
> > -    while getopts a:c:C:T:d:D:f:F:ehi:I:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B:z:Z: arg
> > +    while getopts a:c:C:T:d:D:f:F:ehi:I:K:g:l:m:M:Nno:pqr:Rs:S:t:T:w:x:b:B:z:Z: arg
> >      do  case $arg in
> >          a)  EMAIL_TO=$OPTARG
> >              ALT_EMAIL_OUT=1;;
> > @@ -410,6 +414,8 @@ main()
> >  
> >          r)  LTPROOT=$OPTARG;;
> >  
> > +        R)  RANDOMRUN=1;;
> > +
> >          s)  TAG_RESTRICT_STRING=$OPTARG;;
> >  
> >  	S)  case $OPTARG in
> > @@ -740,6 +746,12 @@ main()
> >           done
> >      fi
> >  
> > +    # randomize alltests
> 
> This comment is useless, it's pretty obvious what the code does.
Sure, V3 will remove this.

Thanks,
Zorro

> 
> > +    if [ "$RANDOMRUN" != "0" ]; then
> > +        sort -R ${TMP}/alltests > ${TMP}/alltests.temp
> > +        cat ${TMP}/alltests.temp > ${TMP}/alltests
> > +    fi
> > +
> >      [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
> >      PAN_COMMAND="${LTPROOT}/bin/ltp-pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ \
> >      -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE $TCONFCMDFILE"
> > -- 
> > 2.7.4
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
