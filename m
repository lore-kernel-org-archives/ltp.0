From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Feb 2020 20:20:34 +0800
Subject: [LTP] [PATCH] cleanup: avoid to generate many redundant obj
 files
In-Reply-To: <0774e1e5-c326-e4aa-8c74-45de61d8276b@163.com>
References: <20200218115918.32203-1-liwang@redhat.com>
 <0774e1e5-c326-e4aa-8c74-45de61d8276b@163.com>
Message-ID: <CAEemH2c9v87NWM6k_t4d9Vi3wAYYjwfEJp2Cw-zG9pPHvdtV-Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

Why don't you avoid libftest.o as well if you want to build test by new
> rule?


That should be generated because it is the local library. In LTP Makefile,
the sequencing is to build the library first then compile&link to the
testcase. We can avoid dumping the testname.o since it only exists in the
last phase.

And, I don't want to change too much for LTP build rule(I think it works
correctly), especially in the case directory some of the local libraries
are reused.  e.g The swapoff test needs linking to ../swapon/libswapon.o,
that requires libswapon.o is in the correct path.

Or, did I misunderstand your words? if yes, please correct me.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200219/f2185e4b/attachment.htm>
