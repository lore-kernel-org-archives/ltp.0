From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Jul 2020 12:52:10 +0200
Subject: [LTP] [blk] 6e6fcbc27e: ltp.fs_fill.fail
In-Reply-To: <20200727093156.GA29739@dell5510>
References: <20200726075511.GI1850@shao2-debian>
 <20200727093156.GA29739@dell5510>
Message-ID: <20200727105210.GA12348@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > tst_test.c:1308: INFO: Testing on vfat
> > tst_mkfs.c:90: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> > tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> > fs_fill.c:103: INFO: Running 10 writer threads
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> The only "error" I found is that fs_fill test timeouted on vfat. That might
> indicate some problems. Note, for slow machines, there is LTP_TIMEOUT_MUL
> https://github.com/linux-test-project/ltp/wiki/User-Guidelines#1-library-environment-variables

Actually you had removed the most important part, it not only timeouted
but the process ended up stuck in kernel and could not be killed. So
this looks like deadlock somewhere in filesystem code.

-- 
Cyril Hrubis
chrubis@suse.cz
