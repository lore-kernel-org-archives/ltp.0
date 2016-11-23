From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Nov 2016 12:05:52 +0100
Subject: [LTP] setregid04_16
In-Reply-To: <CAJ5vXcRNEmDk-sbbvc_6yFACeB=z78T1_MdbjdMQ3kEhTV1+uA@mail.gmail.com>
References: <CAJ5vXcT-GH08vsrmGFtSnB+jW=9vJbpC6Csw0AbG_otK5FJJpw@mail.gmail.com>
 <20161122082110.GF5620@rei.lan>
 <CAJ5vXcRNEmDk-sbbvc_6yFACeB=z78T1_MdbjdMQ3kEhTV1+uA@mail.gmail.com>
Message-ID: <20161123110551.GB3346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LTP ver: 20150119
> Kernel Version: 3.14.65
> glibc version 2.19
> I am using ARM architecture.

That is kind of icomplete, is that 32bit, 64bit or the strange mix
between these two called x32?

> Do not have strace support on my system

It's hard to debug any syscall tests without that.

-- 
Cyril Hrubis
chrubis@suse.cz
