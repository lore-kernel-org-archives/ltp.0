From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Mar 2021 15:14:26 +0100
Subject: [LTP] [PATCH] splice02: Generate input in C
In-Reply-To: <YEdpYimUgk2j+ICb@yuki.lan>
References: <20210308154421.2002-1-pvorel@suse.cz> <YEZTd+CT/Gag1ejK@yuki.lan>
 <YEZoCOqGeb4dVnpV@pevik> <YEZs/MTW0Pcyz6Ml@yuki.lan>
 <YEcPvIckAEbmMBi9@pevik> <YEcuh38X83GX1RPL@yuki.lan>
 <YEc+T9Vx838EF7q2@pevik> <YEdpYimUgk2j+ICb@yuki.lan>
Message-ID: <YEeCwpkioTn3MYEl@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > We'd use standard LTP interface with tst_test.sh. WDYT?

> Well we have to figure out where to put the dummy test, but other than
> that no complaints. Also please put that change in a separate commit.
Sure! It will be in v2.
Place: it could be in new shell directory: either in testcases/misc/shell/ or testcases/shell/.

Kind regards,
Petr

