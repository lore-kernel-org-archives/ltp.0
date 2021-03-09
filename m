From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Mar 2021 13:26:10 +0100
Subject: [LTP] [PATCH] splice02: Generate input in C
In-Reply-To: <YEc+T9Vx838EF7q2@pevik>
References: <20210308154421.2002-1-pvorel@suse.cz> <YEZTd+CT/Gag1ejK@yuki.lan>
 <YEZoCOqGeb4dVnpV@pevik> <YEZs/MTW0Pcyz6Ml@yuki.lan>
 <YEcPvIckAEbmMBi9@pevik> <YEcuh38X83GX1RPL@yuki.lan>
 <YEc+T9Vx838EF7q2@pevik>
Message-ID: <YEdpYimUgk2j+ICb@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Well yes, I guess that we can do something as:
> 
> > echo "SUCCESS" | grep -q "SUCCESS"
> 
> > Which at least returns 1 if the grep fails.
> Yep, that's better than using cat.
> 
> Although, IMHO it should be possible to do something like:
> 
> shell_test01 echo "SUCCESS" | shell_pipe01.sh
> 
> cat shell_pipe01.sh
> ...
> do_test()
> {
> 	tst_res TINFO "expecting SUCCESS string passed from stdin"
> 
> 	read line
> 	EXPECT_PASS [ "$line" = "SUCCESS" ]
> }
> 
> We'd use standard LTP interface with tst_test.sh. WDYT?

Well we have to figure out where to put the dummy test, but other than
that no complaints. Also please put that change in a separate commit.

-- 
Cyril Hrubis
chrubis@suse.cz
