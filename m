From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Sep 2015 14:24:42 +0200
Subject: [LTP] How to run individual C testcase file like
 ltp/testcases/kernel/containers/pidns/pidns01.c
In-Reply-To: <560A7046.70803@linux.vnet.ibm.com>
References: <5608D654.2010400@linux.vnet.ibm.com>
 <20150929092033.GB24796@rei.suse.cz>
 <560A7046.70803@linux.vnet.ibm.com>
Message-ID: <20150929122442.GA30371@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I want to compile and run all the individual testcase (like, pidns01.c 
> from ltp/testcases/kernel/containers/pidns/pidns01.c) only from github 
> source files. If there is any way to do this?

There is an howto for building LTP from git checkout:

https://github.com/linux-test-project/ltp/blob/master/doc/mini-howto-building-ltp-from-git.txt

All you need is basically:

make autotools
./configure --prefix=$PREFIX
make

Which will create binary for each of the pidns testcases. Then you can just run
them.

[CC: The LTP mailing list, you should always at least CC it when asking
 questions about LTP]

-- 
Cyril Hrubis
chrubis@suse.cz
