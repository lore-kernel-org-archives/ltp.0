From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Sep 2020 10:43:25 +0200
Subject: [LTP] Error with fs_fill
In-Reply-To: <BMXPR01MB23441EA1A33E38BF93274ED1EE230@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB23445019F67B128E04B26612EE250@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
 <20200914083623.GA5524@yuki.lan>
 <BMXPR01MB23441EA1A33E38BF93274ED1EE230@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20200914084325.GB5524@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> how i can resolve it?

That's a kernel bug, so it could be resolved by fixing the kernel.

> is there any way that i can find what's exactly happening ??

You would need to understand how Btrfs filesystem works internally. I
guess that a year or two spend studying it will do.

-- 
Cyril Hrubis
chrubis@suse.cz
