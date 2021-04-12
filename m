From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Apr 2021 13:28:42 +0200
Subject: [LTP] LTP msgstress03,
 msgstress04 failure on linux 5.10.19 and 5.10.22
In-Reply-To: <BM1PR01MB2868EDABC10031EC53337C1FEE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB287023E7E5B34F6D27B63564EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <60619D5B.6090507@fujitsu.com>
 <BMXPR01MB2870D0447A89D1BEE08EDCA7EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <BM1PR01MB2868C0458678E57C87BBC708EE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
 <YG7Mbc/ZTnD85SAh@yuki>
 <BM1PR01MB28686329F64867227F9F9279EE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
 <YG7asu6B4EEa1HUD@yuki>
 <BM1PR01MB2868EDABC10031EC53337C1FEE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <YHQu6l0xp8VmG+ry@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for your response and help for understanding the reason of testcase failure
> I too running the test on the machine with 8GB of RAM and the value for the msgmmni is 32000 by default and i have changed 16000 then also i am not able to see any diff in output.
> 
> Anything else that i can try ??

Try with less, I suppose 8000 should work fine.

If estimating how many processes we can run was easy the test would have
been fixed a long time ago.

-- 
Cyril Hrubis
chrubis@suse.cz
