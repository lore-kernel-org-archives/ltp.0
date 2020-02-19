From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Feb 2020 14:40:55 +0100
Subject: [LTP] [PATCH] cleanup: avoid to generate many redundant obj
 files
In-Reply-To: <d9fbb16b-e3c3-b66f-58ed-99310ff394c8@163.com>
References: <20200218115918.32203-1-liwang@redhat.com>
 <0774e1e5-c326-e4aa-8c74-45de61d8276b@163.com>
 <CAEemH2c9v87NWM6k_t4d9Vi3wAYYjwfEJp2Cw-zG9pPHvdtV-Q@mail.gmail.com>
 <701290c2-4cd6-154a-d400-7479c57ec910@163.com>
 <d9fbb16b-e3c3-b66f-58ed-99310ff394c8@163.com>
Message-ID: <20200219134055.GA10791@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The root cause is that libswapon.c is built as an object 
> file(libswapon.o) instead of a library file(libswapon.so/libswapon.a).
> 
> Sorry, I just feel strange about the left *.o files.

Given that the library is used in both swapon and swapoff tests we may
as well move it to the toplevel libs/ directory as libltpswap, which
would simplify the Makefiles a bit.

-- 
Cyril Hrubis
chrubis@suse.cz
