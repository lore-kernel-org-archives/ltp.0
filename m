From: Xiao Yang <ice_yangxiao@163.com>
Date: Wed, 19 Feb 2020 21:35:46 +0800
Subject: [LTP] [PATCH] cleanup: avoid to generate many redundant obj
 files
In-Reply-To: <701290c2-4cd6-154a-d400-7479c57ec910@163.com>
References: <20200218115918.32203-1-liwang@redhat.com>
 <0774e1e5-c326-e4aa-8c74-45de61d8276b@163.com>
 <CAEemH2c9v87NWM6k_t4d9Vi3wAYYjwfEJp2Cw-zG9pPHvdtV-Q@mail.gmail.com>
 <701290c2-4cd6-154a-d400-7479c57ec910@163.com>
Message-ID: <d9fbb16b-e3c3-b66f-58ed-99310ff394c8@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/19/20 9:07 PM, Xiao Yang wrote:
>
> You can build and link libswapon.c directly, as below:
>
> ---------------------------------
>
> # grep MAKE_TARGETS Makefile
> $(MAKE_TARGETS): %: ../swapon/libswapon.c
>
> ---------------------------------
>
> Sorry, I am not sure if your improvement is the best way.
>
Hi Li,

The root cause is that libswapon.c is built as an object 
file(libswapon.o) instead of a library file(libswapon.so/libswapon.a).

Sorry, I just feel strange about the left *.o files.

Thanks,

Xiao Yang

