Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WTAVy-0007IO-35
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:38:38 +0000
Date: Thu, 27 Mar 2014 14:38:09 +0100
From: chrubis@suse.cz
Message-ID: <20140327133809.GA4234@rei>
References: <1394543097-21115-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394543097-21115-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 1/2] ltpstress.sh: added cmdline option to set
 temporary directory
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> -export TMPBASE="/tmp"

You have removed the default value for TMPBASE so the default dir is now
/ltpstress-$$ and not /tmp/ltpstress-$$.

> -export TMP="${TMPBASE}/ltpstress-$$"
>  export PATH=$LTPROOT/testcases/bin:$PATH
>  memsize=0
>  hours=24
> @@ -57,7 +55,7 @@ usage()
>  {
>  
>  	cat <<-END >&2
> -	usage: ${0##*/} [ -d datafile ] [ -i # (in seconds) ] [ -I iofile ] [ -l logfile ] [ -m # (in Mb) ] [ -n ] [ -t duration ] [ [-S]|[-T] ]
> +	usage: ${0##*/} [ -d datafile ] [ -i # (in seconds) ] [ -I iofile ] [ -l logfile ] [ -m # (in Mb) ] [ -n ] [ -t duration ] [ -x TMPDIR ] [ [-S]|[-T] ]
>  
>      -d datafile     Data file for 'sar' or 'top' to log to. Default is "/tmp/ltpstress.data".
>      -i # (in sec)   Interval that 'sar' or 'top' should take snapshots. Default is 10 seconds.
> @@ -68,6 +66,7 @@ usage()
>      -S              Use 'sar' to measure data.
>      -T              Use LTP's modified 'top' tool to measure data.
>      -t duration     Execute the testsuite for given duration in hours. Default is 24.
> +    -x TMPDIR       Directory where temporary files will be created.

It's shame that -d is allready taken and we are not compatible with
runltp... but I guess we cannot do anything about it.

>  
> -
> -mkdir -p ${TMP}
> -
> -cd ${TMP}
> -if [ $? -ne 0 ]; then
> -  echo "could not cd ${TMP} ... exiting"
> -  exit
> -fi
> -
> -while getopts d:hi:I:l:STt:m:n\? arg
> +while getopts d:hi:I:l:STt:m:nx:\? arg
>  do  case $arg in
>  
>  	d)	datafile="$OPTARG";;
> @@ -137,11 +127,30 @@ do  case $arg in
>          t)      hours=$OPTARG
>  		duration=$(($hours * 60 * 60));;
>  
> +	x)	export TMPBASE=$(readlink -f ${OPTARG});;

Why readlink?


The rest is fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
