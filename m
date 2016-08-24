From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Aug 2016 15:42:18 +0200
Subject: [LTP] [PATCH V2 1/4] memcg/functional: rewrite
In-Reply-To: <1471951555-4230-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1471951555-4230-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160824134217.GB12443@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  shmmax=`cat /proc/sys/kernel/shmmax`
>  if [ $shmmax -lt $HUGEPAGESIZE ]; then
> -	echo $(($HUGEPAGESIZE)) > /proc/sys/kernel/shmmax
> +	ROD "$HUGEPAGESIZE" \> /proc/sys/kernel/shmmax
           ^
	   Missing echo here?

The rest looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
