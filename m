From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 12 Nov 2020 09:44:26 +0800
Subject: [LTP] [PATCH 2/2] syscalls/uname02: Convert to new API and
 cleanup
In-Reply-To: <20201111145733.GC16874@yuki.lan>
References: <20201106065014.1118435-1-yangx.jy@cn.fujitsu.com>
 <20201106065014.1118435-2-yangx.jy@cn.fujitsu.com>
 <20201111145733.GC16874@yuki.lan>
Message-ID: <5FAC937A.2080202@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/11/11 22:57, Cyril Hrubis wrote:
> Hi!
>> +	TEST(uname((struct utsname *)-1));
> Can we get a bad address by calling tst_get_bad_addr() in the test setup
> plase?
Hi Cyril,

Sure, I will send v2 patch soon.

Best Regards,
Xiao Yang
> Otherwise the rest is good.
>



