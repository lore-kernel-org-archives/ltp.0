From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Feb 2020 21:40:07 +0800
Subject: [LTP] [PATCH] cleanup: avoid to generate many redundant obj
 files
In-Reply-To: <701290c2-4cd6-154a-d400-7479c57ec910@163.com>
References: <20200218115918.32203-1-liwang@redhat.com>
 <0774e1e5-c326-e4aa-8c74-45de61d8276b@163.com>
 <CAEemH2c9v87NWM6k_t4d9Vi3wAYYjwfEJp2Cw-zG9pPHvdtV-Q@mail.gmail.com>
 <701290c2-4cd6-154a-d400-7479c57ec910@163.com>
Message-ID: <CAEemH2fUMV4H3sALU4hDz4PXyS_31NXcGZv-zxQML3W_yDXhtg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xiao Yang <ice_yangxiao@163.com> wrote:

> Why don't you remove all object files and mix building and link at the
> last phase?
>
As I mentioned the library file shouldn't be deleted.

> And, I don't want to change too much for LTP build rule(I think it works
> correctly), especially in the case directory some of the local libraries
> are reused.  e.g The swapoff test needs linking to ../swapon/libswapon.o,
> that requires libswapon.o is in the correct path.
>
> You can build and link libswapon.c directly, as below:
>
> ---------------------------------
>
> # grep MAKE_TARGETS Makefile
> $(MAKE_TARGETS): %: ../swapon/libswapon.c
>
FWIK, It breaks up the principle of the library design in C compilation, it
just regards the library as a general C file, I think it's a horrible idea.

> ---------------------------------
>
> Sorry, I am not sure if your improvement is the best way.
>
I have never say that's an improvement, that's just a cleanup patch. I just
want the code directory to be cleaner even after compilation.

But if you give a performance evaluation, you will find my build way is a
little faster than previous:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200219/37e9425c/attachment.htm>
