From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 31 Oct 2019 05:53:40 -0400 (EDT)
Subject: [LTP] Unable to run eventfd test,
 even the libaio-dev installed on debian 10.
In-Reply-To: <tencent_28D2BF821D50F4EC33C1EF97@qq.com>
References: <tencent_4D69C182358CFFEA3F0A95F7@qq.com>
 <1615187401.9901286.1572514591876.JavaMail.zimbra@redhat.com>
 <tencent_28D2BF821D50F4EC33C1EF97@qq.com>
Message-ID: <246485198.9905451.1572515620925.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Thanks for your reply!
> After I check the config.log, I think all check go into the right place, but
> confdefs.h didn't show up, it's sort of weird.
> Some output from config.log:
> configure:6159: checking libaio.h usability
> configure:6159: gcc -c -g -O2  -D_FORTIFY_SOURCE=2 conftest.c >&5
> configure:6159: $? = 0
> configure:6159: result: yes
> configure:6159: checking libaio.h presence
> configure:6159: gcc -E  -D_FORTIFY_SOURCE=2 conftest.c
> configure:6159: $? = 0
> configure:6159: result: yes
> configure:6159: checking for libaio.h
> configure:6159: result: yes
> configure:6170: checking for io_setup in -laio
> configure:6195: gcc -o conftest -g -O2  -D_FORTIFY_SOURCE=2  conftest.c -laio
> >&5
> configure:6195: $? = 0
> configure:6204: result: yes
> configure:6218: checking io_set_eventfd is defined in aio library or aio
> header

Above looks OK. Please do also "make clean" on everything, just to be sure
you're not using old binaries. I don't see eventfd01 being rebuilt in your
first email.

