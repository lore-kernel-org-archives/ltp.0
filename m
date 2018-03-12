From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Mar 2018 14:14:04 +0100
Subject: [LTP] [PATCH 2/3] syscalls/rmdir02,
 05: Cleanup && Convert to new API
In-Reply-To: <1518537696-22033-2-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1518537696-22033-1-git-send-email-xuyang.jy@cn.fujitsu.com>
 <1518537696-22033-2-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <20180312131404.GB30471@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

> +	tcases[4].dir = SAFE_MMAP(0, 1, PROT_NONE,
>  		MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);

I've changed this assigment to be a loop over the tcases array so that
we do not have hardcoded assigments to it in the test setup.

-- 
Cyril Hrubis
chrubis@suse.cz
