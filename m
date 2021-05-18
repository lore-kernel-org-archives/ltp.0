From: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Tue, 18 May 2021 07:23:47 +0000
Subject: [LTP] LTP msgstress03,
 msgstress04 failure on linux 5.10.19 and 5.10.22
In-Reply-To: <BMXPR01MB2870B48DB06939CF5F7FF3FCEE2D9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB287023E7E5B34F6D27B63564EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <60619D5B.6090507@fujitsu.com>
 <BMXPR01MB2870D0447A89D1BEE08EDCA7EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <BM1PR01MB2868C0458678E57C87BBC708EE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
 <YG7Mbc/ZTnD85SAh@yuki>
 <BM1PR01MB28686329F64867227F9F9279EE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
 <YG7asu6B4EEa1HUD@yuki>
 <BM1PR01MB2868EDABC10031EC53337C1FEE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>,
 <YHQu6l0xp8VmG+ry@yuki>,
 <BMXPR01MB2870B48DB06939CF5F7FF3FCEE2D9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <BMXPR01MB287078E4F686A47E30C5F642EE2C9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Kind reminder. Please help me with approaches.


Thanks
________________________________
From: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Sent: Monday, May 17, 2021 1:11 PM
To: Cyril Hrubis <chrubis@suse.cz>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] LTP msgstress03, msgstress04 failure on linux 5.10.19 and 5.10.22

Hi Cyril,

With value of msgmni 8000 it worked well for me but i want to understand which part from the log (produced by strace or some other method) i should be focused on to get to know ohkk it is failure because of value of msgmni is more.
How you analyzed and helped me to fix ,what approach you have followed ?

Thanks
________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Monday, April 12, 2021 4:58 PM
To: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] LTP msgstress03, msgstress04 failure on linux 5.10.19 and 5.10.22

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
[EXT]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210518/5757494f/attachment.htm>
