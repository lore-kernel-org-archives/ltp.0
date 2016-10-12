From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 12 Oct 2016 10:54:44 -0400 (EDT)
Subject: [LTP] new shell library
In-Reply-To: <20161012131726.GC24231@rei.lan>
References: <20161003145835.GD7583@rei.suse.cz>
 <1484818671.202716.1475571733691.JavaMail.zimbra@redhat.com>
 <20161004093549.GC29418@rei.lan>
 <254451816.211402.1475574875165.JavaMail.zimbra@redhat.com>
 <20161012100806.GA24231@rei.lan>
 <1175646125.448517.1476268354007.JavaMail.zimbra@redhat.com>
 <20161012123602.GB24231@rei.lan> <20161012131726.GC24231@rei.lan>
Message-ID: <1527497475.514457.1476284084454.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 12 October, 2016 3:17:26 PM
> Subject: Re: [LTP] new shell library
> 
> Hi!
> > What about greping the test source as in [2] instead? Because that way
> > we can print error if the test source touches any of the internally used
> > variables as well. For instance if it tries to do anything with
> > TST_PASS/TST_FAIL/...

True.

> 
> What about this one:
> 
> https://github.com/metan-ucw/ltp/commit/445e3ae253bdd11f18ec12ccc74fe99eb582eeb6

Looks OK, chances of someone making MYTST_VARIABLE is quite small,
and we can always improve that regex if needed.

Couple notes:
- these seem to be missing: TST_DEVICE, TST_MODPATH, TST_CHECKPOINT_*, TST_NEEDS_CHECKPOINTS
- doc page mentions "TST_NEEDS_CMD" and "TST_NEEDS_CMDS", the latter looks like typo.

Regards,
Jan

> 
> $ cat d.sh
> 
> #!/bin/sh
> TST_ID="test"
> TST_TESTFUNC=do_test
> . tst_test.sh
> 
> do_test()
> {
>         tst_res TPASS "Passed"
> 
>         TST_FOO=1
> 
>         echo "$TST_PASS"
> }
> 
> tst_run
> 
> # PATH is set to contain both path to tst_test.sh and d.sh
> $ ./d.sh
> test 1 TWARN : Reserved variable TST_FOO used!
> test 1 TWARN : Reserved variable TST_PASS used!
> test 1 TPASS : Passed
> 1
> 
> Summary:
> passed   1
> failed   0
> skipped  0
> warnings 2
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
