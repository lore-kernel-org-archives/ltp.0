From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 Sep 2021 12:30:57 +0200
Subject: [LTP] [PATCH 5/5] checkbashisms: Disable 'type' check
In-Reply-To: <YTDSn6ucuuIsfB19@yuki>
References: <20210902115837.2199-1-pvorel@suse.cz>
 <YTDSn6ucuuIsfB19@yuki>
Message-ID: <YTH5YaacIHvvjxAq@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> Looks good.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Looks like 'command -v' which is POSIX works (tested in bash, dash, busybox sh
and android shell), thus I suggest to drop this patch and use 'command -v'
instead of 'type'.

$ foo(){ echo "in foo";}
$ command -v foo
foo

Kind regards,
Petr
