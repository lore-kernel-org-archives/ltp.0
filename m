From: Dong ZHu <bluezhudong@gmail.com>
Date: Tue, 31 May 2016 08:59:22 +0800
Subject: [LTP] memcg_memsw_limit_in_bytes_test mlock failed: Resource
 temporarily unavailable
In-Reply-To: <20160530113923.GA6079@rei>
References: <CAAUgArDNuD89q3dFLxqwjMi-6opiggZhWo_oEL9qUNUxcxCkrA@mail.gmail.com>
 <20160530113923.GA6079@rei>
Message-ID: <CAAUgArD93+SMQUcNDSpAK=R+Sv__BAxc6agL6ZNRamxBLX23xA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>> I think mlock failed it is a expect behavior, so why mask the test as
>> Failed ?
>
> So the test fails in mlock() and the mlock() supposedly returns with
> ENOMEM right?

Yes.

> This is indeed valid outcome and the test should report
> pass. I guess that we have to return something different from 1 from the
> test process if some of the calls has failed with ENOMEM and change the
> test library to report that as success as well.
>

I agree with that, I will develop a patch for fixing this issue.

-- 
Best Regards,
Dong Zhu

My Site: http://bluezd.info
