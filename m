From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 17 Mar 2020 16:12:22 +0800
Subject: [LTP] [PATCH] open_posix_testsuite: Enable the testsuite
In-Reply-To: <CAEemH2f5sMfOX5XjEOr8cmLRwu+YzMziEwRFPAegG+FAURi90A@mail.gmail.com>
References: <1584430400-47359-1-git-send-email-zou_wei@huawei.com>
 <CAEemH2f5sMfOX5XjEOr8cmLRwu+YzMziEwRFPAegG+FAURi90A@mail.gmail.com>
Message-ID: <5E708666.6010100@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/3/17 15:55, Li Wang wrote:
> Hi Zou & Xiao,
>
> Do we really need to enable the open_posix_testsuite explicitly? By
> default, LTP uses "--with-open-posix-testsuite" as the configure
> parameter to enabling it, is that work for you?
Hi Li,

Agreed.  We don't need to enable the open_posix_testsuite unconditionally.

We can enable open_posix_testsuite by ./configure 
--with-open-posix-testsuite or ./build.sh.

Thanks,
Xiao Yang
>
> i.e you can include the open_posix_testsuite build by perform `./build.sh`



