From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2015 13:05:01 +0100
Subject: [LTP] [PATCH] controllers/cpuacct: add kernel version check
In-Reply-To: <1447926563-26726-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1447926563-26726-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20151119120501.GC28969@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	tst_require_root
>  
> +	tst_kvercmp 2 6 30
> +	if [ $? -eq 0 ]; then
> +		tst_brkm TCONF "Test should be run with kernel 2.6.30 or newer"
> +	fi

Can we do 'grep -q cpuacct /proc/cgroups' to figure out if it's
supported instead?

-- 
Cyril Hrubis
chrubis@suse.cz
