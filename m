From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Sep 2015 11:20:33 +0200
Subject: [LTP] How to run individual C testcase file like
 ltp/testcases/kernel/containers/pidns/pidns01.c
In-Reply-To: <5608D654.2010400@linux.vnet.ibm.com>
References: <5608D654.2010400@linux.vnet.ibm.com>
Message-ID: <20150929092033.GB24796@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>      I am new to LTP and developing a testcase under pidns. I want to
> start with , if there is any way to run , suppose pidns01.c using only
> gcc command. Only using gcc command, it should be possible to run
> pidns01.c as the file contains main program. I am also interested in
> knowing the parameters used to call the file using gcc command.

This does not make any sense at all. You speak about running testcases
then continue to talk about the gcc compiler.

What do you want to do? Compile individual test? Run individual test? Or
both?

-- 
Cyril Hrubis
chrubis@suse.cz
