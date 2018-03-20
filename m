From: sunlianwen <sunlw.fnst@cn.fujitsu.com>
Date: Tue, 20 Mar 2018 08:18:00 +0800
Subject: [LTP] [PATCH] busy_poll* : revise poll_cmp
In-Reply-To: <fae2ea47-a416-f2b4-ee2b-f022f14a14a0@oracle.com>
References: <c999a175-d02b-beda-7418-95a5b0f2d432@cn.fujitsu.com>
 <fae2ea47-a416-f2b4-ee2b-f022f14a14a0@oracle.com>
Message-ID: <a10e1806-2646-528d-c327-d061affc522b@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Alexey

   You are right, I think is wrong, I debug this case again,

and find the driver is virtio_net no support busy poll.

Thanks your advise.

Best Regards,

Lianwen Sun.


On 03/19/2018 08:25 PM, Alexey Kodanev wrote:
> On 19.03.2018 11:18, sunlianwen wrote:
>> set low latency busy poll to 50 per socket will
>> spent more time than set low latency busy poll
>> to 0 per socket. that mean the value of res_50
>> is bigger than res_0, so the value of poll_comp
>> always less than zero and  test fail.
> No, if busy poll is enabled, i.e. value set above 0, we should expect
> performance gain in this test.
>
> With what driver and kernel version you have such results?
> Is it really supported by that driver?
>
> Thanks,
> Alexey
>
>
>



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180320/900716ab/attachment.html>
