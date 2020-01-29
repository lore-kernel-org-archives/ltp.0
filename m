From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Jan 2020 11:01:26 +0100
Subject: [LTP] [PATCH 1/1] ioctl02.c: check for struct termio
In-Reply-To: <20200128213902.GA23927@dell5510>
References: <20200128212725.22781-1-petr.vorel@gmail.com>
 <20200128213902.GA23927@dell5510>
Message-ID: <20200129100126.GB21699@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hm, am I wrong, and we should rewrite ioctl01.c and ioctl02.c to use struct
> termios? Or do we want to test with both new struct termios and legacy termio?

Just have a look at 'man ioctl_list' there are two sets of ioctls one
for termio and one for termios and as usuall we should ideally test both.

-- 
Cyril Hrubis
chrubis@suse.cz
