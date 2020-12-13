From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Sun, 13 Dec 2020 22:50:11 +0000
Subject: [LTP] [PATCH v4 1/1] syscalls/{send|recv}mmsg: add a test case
 for timeout and errno test
In-Reply-To: <X9ONWQwAt8ZXqkms@yuki.lan>
References: <20200920154633.27255-1-Filip.Bozuta@syrmia.com>
 <20200920154633.27255-2-Filip.Bozuta@syrmia.com>
 <20200922135244.GA4167@yuki.lan>,<X9ONWQwAt8ZXqkms@yuki.lan>
Message-ID: <AM6PR03MB52339D881505195B709E241FEBC80@AM6PR03MB5233.eurprd03.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

I had some obligations and I forgot to work on this patch.

I sent a modified v5 of this patch and these modifications include:

    * compilation error fix in 'recvmmsg01.c'
    * a specific test setup for every test
    * removed the useless 'retval' variable in 'recvmmsg01.c'

Sorry about the compilation error in 'revmmsg01.c'. I forgot to commit the change before sending my patch in v4.

Best regards,
Filip
________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Friday, December 11, 2020 4:16 PM
To: Filip Bozuta <Filip.Bozuta@syrmia.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v4 1/1] syscalls/{send|recv}mmsg: add a test case for timeout and errno test

Hi!
Ping. Are you planning on finishing these?

--
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201213/b4ecfb76/attachment.htm>
