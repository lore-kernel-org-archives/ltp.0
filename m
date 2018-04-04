From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Apr 2018 15:46:13 +0200
Subject: [LTP] [RFC] tst_check_cmds to exit only current test
In-Reply-To: <20180404131501.GH32109@rei>
References: <20180329114536.vsmsjzatryu4h5dm@dell5510>
 <20180404131501.GH32109@rei>
Message-ID: <20180404134612.y23nxu27r3eoyx4t@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Is it valid approach approach or should we use getopts to run the test twice?

> That is a valid approach as well, we can just do:

> if-addr-adddel_ifconfig if-addr-adddel ifconfig
> if-addr-adddel_ip if-addr-adddel ip

> in the runtest file, which would make the test results more detailed,
> as it will be clear what was actually skipped, which is always nice.
Any objection to this? I'd prefer to use this way (changed in all interface tests).


Kind regards,
Petr
