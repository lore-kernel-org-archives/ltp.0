From: Li Wang <liwang@redhat.com>
Date: Sun, 25 Sep 2016 17:38:07 +0800
Subject: [LTP] [PATCH v3] runltp: add -R option for randomize test order
In-Reply-To: <1474720519-12067-1-git-send-email-zlang@redhat.com>
References: <1474720519-12067-1-git-send-email-zlang@redhat.com>
Message-ID: <CAEemH2foVLCW=XTmR9a8qmAJQvjw8ZEsOrrAAmUPSCX45ob=Fw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Sat, Sep 24, 2016 at 8:35 PM, Zorro Lang <zlang@redhat.com> wrote:
> Generally we write test entries into runtests/${testfile}, then
> runltp reads and runs lines sequentially everytime, nearly no one
> will change the test order.
>
> Recently we find bugs by change the test order=EF=BC=8Cdifferent test
> combination maybe find more bugs. So I add this new option -R to
> randomize test order.
>
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>
> V2 use 'sort -R' to instead of 'randlines.awk'.
> V3 remove change log and someone useless comment
>
> Thanks,
> Zorro
>
>  runltp | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/runltp b/runltp
> index bb2e5d8..33e23ab 100755
> --- a/runltp
> +++ b/runltp
> @@ -153,6 +153,7 @@ usage()
>      -p              Human readable format logfiles.
>      -q              Print less verbose output to screen.
>      -r LTPROOT      Fully qualified path where testsuite is installed.
> +    -R              Randomize test order.
>      -s PATTERN      Only run test cases which match PATTERN.
>      -S SKIPFILE     Skip tests specified in SKIPFILE
>      -t DURATION     Execute the testsuite for given duration. Examples:
> @@ -213,12 +214,13 @@ main()
>      local EMAIL_TO=3D""
>      local TAG_RESTRICT_STRING=3D""
>      local PAN_COMMAND=3D""
> +    local RANDOMRUN=3D0
>      local DEFAULT_FILE_NAME_GENERATION_TIME=3D`date +"%Y_%m_%d-%Hh_%Mm_%=
Ss"`
>      local scenfile=3D
>
>      version_date=3D$(cat "$LTPROOT/Version")
>
> -    while getopts a:c:C:T:d:D:f:F:ehi:I:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:=
B:z:Z: arg
> +    while getopts a:c:C:T:d:D:f:F:ehi:I:K:g:l:m:M:Nno:pqr:Rs:S:t:T:w:x:b=
:B:z:Z: arg
>      do  case $arg in
>          a)  EMAIL_TO=3D$OPTARG
>              ALT_EMAIL_OUT=3D1;;
> @@ -410,6 +412,8 @@ main()
>
>          r)  LTPROOT=3D$OPTARG;;
>
> +        R)  RANDOMRUN=3D1;;
> +
>          s)  TAG_RESTRICT_STRING=3D$OPTARG;;
>
>         S)  case $OPTARG in
> @@ -740,6 +744,11 @@ main()
>           done
>      fi
>
> +    if [ "$RANDOMRUN" !=3D "0" ]; then
> +        sort -R ${TMP}/alltests > ${TMP}/alltests.temp
> +        cat ${TMP}/alltests.temp > ${TMP}/alltests

How about combine them in one line?

  shuf ${TMP}/alltests -o ${TMP}/alltests
or,
  sort -R ${TMP}/alltests -o ${TMP}/alltests

> +    fi
> +
>      [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
>      PAN_COMMAND=3D"${LTPROOT}/bin/ltp-pan $QUIET_MODE -e -S $INSTANCES $=
DURATION -a $$ \
>      -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFI=
LE $TCONFCMDFILE"
> --
> 2.7.4
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp



--=20
Regards,
Li Wang
Email: liwang@redhat.com
