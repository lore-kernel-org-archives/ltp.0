From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Jan 2018 16:19:26 +0100
Subject: [LTP] [PATCH v2] skipfile: allow regular expressions
In-Reply-To: <1516089674-16119-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1516089674-16119-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20180122151926.GA16105@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/runltp
> +++ b/runltp
> @@ -692,10 +692,11 @@ main()
>      fi
>  
>      # Blacklist or skip tests if a SKIPFILE was specified with -S
> +    # The SKIPFILE can contain regular expressions (e.g.: cron.*)
>      if [ -n "${SKIPFILE}" ]; then
>          for test_name in $(awk '{print $1}' "${SKIPFILE}"); do
>              case "${test_name}" in \#*) continue;; esac
> -            sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
> +            sed -i "s/^\(${test_name}\)\s.*/\1 exit 32;/" alltests
>          done
>      fi

Looks good, but please update runltplite.sh as well.

-- 
Cyril Hrubis
chrubis@suse.cz
