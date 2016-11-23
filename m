From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Nov 2016 13:21:38 +0100
Subject: [LTP] [PATCH] fs_racer: cleanup
In-Reply-To: <1479902450-53501-1-git-send-email-cuibixuan@huawei.com>
References: <1479902450-53501-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <20161123122138.GD3346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +    rm -rf $DIR >/dev/null

There shouldn't be any need to redirect the output to /dev/null once you
pass the -f argument to the rm. Otherwise this is obviously correct.

-- 
Cyril Hrubis
chrubis@suse.cz
