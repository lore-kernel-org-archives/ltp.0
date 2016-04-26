From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Apr 2016 07:19:36 -0400 (EDT)
Subject: [LTP] duplicated runltp options
In-Reply-To: <20160426110743.GA6766@rei.lan>
References: <20160426110743.GA6766@rei.lan>
Message-ID: <447366764.328002.1461669576415.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 26 April, 2016 1:07:43 PM
> Subject: [LTP] duplicated runltp options
> 
> Hi!
> Looks like we overided the -T option for runltp in:
> 
> commit 5f71cf97d5753c5506cdf8287812f28e2fffe4aa
> Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> Date:   Tue Sep 23 15:59:43 2014 +0800
> 
>     runltp, pan/ltp-pan.c: record test cases(not fully tested) into file
> 
> 
> And now the -T is listed twice in the options and in the case.
> 
> ...
> -T TCONFCMDFILE Command file with all test cases that are not fully tested.
> ...
> -T REPETITION   Execute the testsuite for REPETITION no. of times
> ...
> 
> And since nobody reported the problem so far, I guess that -T for
> repetition wasn't widely used. So I would like to fix that by renaming
> the -T REPETIONT to  -I ITERATIONS. Does that sound reasonably?

It does to me, code seems to call it as "iteration" already:
  echo "Test Tags will be Prepended with ITERATION NO.s....."

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
