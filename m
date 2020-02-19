From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Feb 2020 11:23:29 +0100
Subject: [LTP] cpuset_regression_test failure
In-Reply-To: <fa9fae7c-2110-d710-7df8-c3885e54d706@cn.fujitsu.com>
References: <MAXPR0101MB1468A284450566343010E440EE110@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
 <fa9fae7c-2110-d710-7df8-c3885e54d706@cn.fujitsu.com>
Message-ID: <20200219102329.GA28580@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I am trying to run *cpuset_regression_test* on my linux 5.4.3 with our 
> > Yocto distro,i got *FAIL* result for this test when i ran complete ltp 
> > test but i did not got reason for test failure but when i tried to run 
> > this test seperately it showing is it correct way to run this test,how 
> > this test needs to be ran independently?
> sh can not be ran independently unless using runltp sh.

They could, but you have to setup $PATH correctly first, we are sourcing
shell scripts and executing binaries from /opt/ltp/testcases/bin, so in
most cases this should work:

PATH="$PATH:/opt/ltp/testcases/bin" ./foo.sh

-- 
Cyril Hrubis
chrubis@suse.cz
