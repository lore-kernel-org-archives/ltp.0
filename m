From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Mar 2017 17:43:00 +0100
Subject: [LTP] [PATCH v2 1/1] cron: Rewrite and cleanup cron_tests.sh
 script
In-Reply-To: <20170309123154.32018-1-pvorel@suse.cz>
References: <20170309123154.32018-1-pvorel@suse.cz>
Message-ID: <20170309164300.GC17980@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Look for results into more possible log locations, look also into
> journalctl output.
> 
> This fixes systems with different cron log (Debian, Ubuntu and their
> derivates, see github issue #136) and systems which log into journalctl
> only (openSUSE Tumbleweed).

Looks good, pushed, thanks.

> +	sleep 10
> +
> +	grep_logs 'crontab.*REPLACE' \
> +		"cron activity not recorded" \
> +		"cron activity logged"

We can improve the grep_logs function and instead of sleeping for 10
seconds before we call it, we could grep the logs in a loop ten times,
do 1s sleep at the end of the loop and exit with pass once the expected
logs are found and with a failure once we are out of iterations. That
should save ~20 seconds of the test runtime.

-- 
Cyril Hrubis
chrubis@suse.cz
