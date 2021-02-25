From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Feb 2021 11:30:29 +0100
Subject: [LTP] ????:  [PATCH 1/2] syscalls/getpid01: Convert to new API
In-Reply-To: <OSBPR01MB2920DF74B48CA7A680A03257F49E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210224031227.151844-1-ruansy.fnst@cn.fujitsu.com>
 <YDYqZMYBVfh8oiYH@yuki.lan>
 <OSBPR01MB2920DF74B48CA7A680A03257F49E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Message-ID: <YDd8RZkgR0IdlShx@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Do you mean loop 100 times to fork 100 children processes?  I tried in this
> way and found that the pid number just increased sequentially from +0 to +100
> (Because no other processes were created during the test).  So, I am not sure
> if 100 times is enough to test the range?

I'm not sure if it's reasonable to test the whole range, my intention
was to run the test a few times since fork+getpid() should fast enough,
but I guess that if it's fast enough we can fork enough times for the
pid to wrap around.

-- 
Cyril Hrubis
chrubis@suse.cz
