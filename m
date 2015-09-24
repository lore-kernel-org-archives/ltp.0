From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Sep 2015 20:45:51 +0200
Subject: [LTP] [PATCH] cgroup_fj: fixed exit codes in case of not
 supported tests
In-Reply-To: <1441889771-8243-1-git-send-email-chnyda@suse.com>
References: <1441889771-8243-1-git-send-email-chnyda@suse.com>
Message-ID: <20150924184551.GC1260@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -125,8 +125,8 @@ esac
>  ret=$?
>  if [ $ret -eq 0 ]; then
>       tst_resm TPASS "case$i($CASETYPE$CASECMD)    PASS"
> -elif [ $ret -ne 9 ]; then
> +elif [ $ret -ne 32 ]; then
>       tst_resm TFAIL "case$i($CASETYPE $CASECMD)    FAIL"
>  fi
>
> -exit $ret;
> +tst_exit

Unless the whole script is converted to the test.sh the exit $ret must
stay here, otherwise the return status from the test will be always 0.

The rest looks fine.

(CCing new list)

-- 
Cyril Hrubis
chrubis@suse.cz
