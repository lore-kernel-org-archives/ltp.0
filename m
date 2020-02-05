From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Feb 2020 14:44:29 +0100
Subject: [LTP] problem with leapsec01 with x86 as well as RISC v
In-Reply-To: <BMXPR01MB2999A74FB0C350C6377C7946EE020@BMXPR01MB2999.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB2999A74FB0C350C6377C7946EE020@BMXPR01MB2999.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20200205134429.GA20936@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Have you read the comment in the source code of the test?

...
 * Note: running this test simultaneously with a timesync daemon
 * (e.g. systemd-timesyncd) can cause this test to fail.
...

My guess is that there is some system daemon for time syncronization
running that is making the test to fail.

-- 
Cyril Hrubis
chrubis@suse.cz
