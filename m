From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 May 2018 11:10:07 +0200
Subject: [LTP] runltp - error when using another tmp folder
In-Reply-To: <20180502174621.6087aaea@windsurf>
References: <20180502162214.5d962173@dell-desktop.home>
 <20180502174621.6087aaea@windsurf>
Message-ID: <20180516091007.GB7222@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hum, I think the situation is a bit more complicated than that. The
> runltp code goes like this:
> 
>             export TMPBASE=$(readlink -f ${OPTARG}) ;;
> [...]
> 
>     # Added -m 777 for tests that call tst_tmpdir() and try to
>     #  write to it as user nobody
>     mkdir -m 777 -p $TMPBASE || \
>     {
>         echo "FATAL: Unable to make temporary directory $TMPBASE"
>         exit 1
>     }
>     # use mktemp to create "safe" temporary directories
>     export TMPTEMPLATE="${TMPBASE}/ltp-XXXXXXXXXX"
>     TMP=`mktemp -d $TMPTEMPLATE` || \
>     {
>         echo "FATAL: Unable to make temporary directory: $TMP"
>         exit 1
>     }
>     export TMP
>     # To be invoked by tst_tmpdir()
>     # write to it as user nobody
>     export TMPDIR=$TMP
> 
>     chmod 777 $TMP || \
>     {
>       echo "unable to chmod 777 $TMP ... aborting"
>       exit 1
>     }
> 
> So you've got two possible situations:
> 
>  (1) TMPBASE is an already existing directory. In this case, the "-m
>      777" argument in mkdir -m 777 -p $TMPBASE is useless because it is
>      only used by mkdir when the directory to be created doesn't exist
>      yet.
> 
>  (2) TMPBASE is not an existing directory. In this case, readlink will
>      return an empty string, and mkdir will fail because TMPBASE is
>      empty.

Actually you may pass a path with last nonexisting component and the
readlink -f will still work fine. Hence if you pass -d /tmp/nonexistent/
it will create the nonexistent directory with the mkdir there.

But that does not change the fact that runltp is user unfriendly with
it's options...

-- 
Cyril Hrubis
chrubis@suse.cz
