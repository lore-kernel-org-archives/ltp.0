From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Jun 2021 10:24:30 +0200
Subject: [LTP] [PATCH] fix pan/ltp-pan return values
In-Reply-To: <20210608084431.62769-1-dongshijiang@inspur.com>
References: <20210608084431.62769-1-dongshijiang@inspur.com>
Message-ID: <YL8pPn8Z8O566R/g@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Can we please stop adding band aids over the broken-by-design runltp
script and ltp-pan?

We are going to finally push runltp-ng into LTP git during this
development cycle and finally deprecate ltp-pan, feel free to try it
yourself:

https://github.com/metan-ucw/runltp-ng

-- 
Cyril Hrubis
chrubis@suse.cz
