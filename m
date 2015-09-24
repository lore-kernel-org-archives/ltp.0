From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Sep 2015 20:25:31 +0200
Subject: [LTP] [PATCH] cgroup_fj: renamed arguments because the previous
 ones were not clear.
In-Reply-To: <1441708477-26192-1-git-send-email-chnyda@suse.com>
References: <1441708477-26192-1-git-send-email-chnyda@suse.com>
Message-ID: <20150924182531.GA1260@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +''|*[!0-9]*)
> +     usage
> +     exit_parameter;;
> +    *) ;;
>  esac

I've removed the trailing whitespace at the end of the ''|*[!0-9]*) and
updated the commit message and pushed, thanks.

BTW: The canonical format for the git commit message is:

short commit description <= 50 characters
[empty line]
longer commit description that may span across multiple lines with lines
up to 72 chars long...
[empty line]
Signed-off-by: ...

(send for second time, this time with the new ML in CC)

-- 
Cyril Hrubis
chrubis@suse.cz
