From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Mar 2021 10:22:23 +0100
Subject: [LTP] [PATCH] splice02: Generate input in C
In-Reply-To: <YEcuh38X83GX1RPL@yuki.lan>
References: <20210308154421.2002-1-pvorel@suse.cz> <YEZTd+CT/Gag1ejK@yuki.lan>
 <YEZoCOqGeb4dVnpV@pevik> <YEZs/MTW0Pcyz6Ml@yuki.lan>
 <YEcPvIckAEbmMBi9@pevik> <YEcuh38X83GX1RPL@yuki.lan>
Message-ID: <YEc+T9Vx838EF7q2@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > > That would not work, the pipe is supposed to be in the runtest file.
> > Do you want to test that runtest is working with pipe?

> Yes, that was the original idea behind adding the splice test there.

> > I considered anything but shell script with getopt parameters a bit strange and
> > thought it'd be removed in new shell runner. But obviously you want to keep it.

> We will have to keep the functionality for the time being.

> > But in case of failure script don't detect it. e.g.:

> > echo "SUCCESS" | cat /asdf
> > cat: /asdf: No such file or directory

> > => there is no TFAIL/TBROK/TCONF. Not sure if all users check exit status (which
> > they should now, because that is the only common thing so far).

> Well yes, I guess that we can do something as:

> echo "SUCCESS" | grep -q "SUCCESS"

> Which at least returns 1 if the grep fails.
Yep, that's better than using cat.

Although, IMHO it should be possible to do something like:

shell_test01 echo "SUCCESS" | shell_pipe01.sh

cat shell_pipe01.sh
...
do_test()
{
	tst_res TINFO "expecting SUCCESS string passed from stdin"

	read line
	EXPECT_PASS [ "$line" = "SUCCESS" ]
}

We'd use standard LTP interface with tst_test.sh. WDYT?

Kind regards,
Petr
