From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Mar 2021 19:29:16 +0100
Subject: [LTP] [PATCH] splice02: Generate input in C
In-Reply-To: <YEZoCOqGeb4dVnpV@pevik>
References: <20210308154421.2002-1-pvorel@suse.cz> <YEZTd+CT/Gag1ejK@yuki.lan>
 <YEZoCOqGeb4dVnpV@pevik>
Message-ID: <YEZs/MTW0Pcyz6Ml@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I do wonder if this should be replaced with something that includes a
> > shell pipe instead. It has been selected here to make sure we pass the
> > command line correctly to a shell interpreter.
> 
> > Maybe something as:
> 
> > shell_test01 echo "SUCCESS" | cat
> 
> I guess you mean to add another test to cover shell pipe.
> Makes sense to me, but I'd wrap it to a test file, e.g. something like:
> 
> cat shell01.sh
> #!/bin/sh
> TST_TESTFUNC=do_test
> TST_NEEDS_CMDS="cat"
> . tst_test.sh
> 
> do_test()
> {
> 	EXPECT_PASS [ "$(echo 'SUCCESS' | cat)" = "SUCCESS" ]
> }
> 
> tst_run

That would not work, the pipe is supposed to be in the runtest file.

-- 
Cyril Hrubis
chrubis@suse.cz
