From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Mar 2021 07:03:40 +0100
Subject: [LTP] [PATCH] splice02: Generate input in C
In-Reply-To: <YEZs/MTW0Pcyz6Ml@yuki.lan>
References: <20210308154421.2002-1-pvorel@suse.cz> <YEZTd+CT/Gag1ejK@yuki.lan>
 <YEZoCOqGeb4dVnpV@pevik> <YEZs/MTW0Pcyz6Ml@yuki.lan>
Message-ID: <YEcPvIckAEbmMBi9@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > > I do wonder if this should be replaced with something that includes a
> > > shell pipe instead. It has been selected here to make sure we pass the
> > > command line correctly to a shell interpreter.

> > > Maybe something as:

> > > shell_test01 echo "SUCCESS" | cat

> > I guess you mean to add another test to cover shell pipe.
> > Makes sense to me, but I'd wrap it to a test file, e.g. something like:

> > cat shell01.sh
> > #!/bin/sh
> > TST_TESTFUNC=do_test
> > TST_NEEDS_CMDS="cat"
> > . tst_test.sh

> > do_test()
> > {
> > 	EXPECT_PASS [ "$(echo 'SUCCESS' | cat)" = "SUCCESS" ]
> > }

> > tst_run

> That would not work, the pipe is supposed to be in the runtest file.
Do you want to test that runtest is working with pipe?
I considered anything but shell script with getopt parameters a bit strange and
thought it'd be removed in new shell runner. But obviously you want to keep it.

But in case of failure script don't detect it. e.g.:

echo "SUCCESS" | cat /asdf
cat: /asdf: No such file or directory

=> there is no TFAIL/TBROK/TCONF. Not sure if all users check exit status (which
they should now, because that is the only common thing so far).

Kind regards,
Petr
