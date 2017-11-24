From: Li Wang <liwang@redhat.com>
Date: Fri, 24 Nov 2017 19:15:24 +0800
Subject: [LTP] <Failling_on_memcg_usage_in_bytes_test.sh>
In-Reply-To: <CAPiF6TgVWEt4u+5TmoePBb2=T91j54cFao6LUB2n+jyKT=AatQ@mail.gmail.com>
References: <CAPiF6Th1sDgRJH2bFb3jX-cBJNVO0s4zmMSH3ezifK7Y9nQCWw@mail.gmail.com>
 <CAEemH2c08B6QaXuqV=a3FT8V6O-yd8WPqR4=d+yME6iubF70Xw@mail.gmail.com>
 <CAPiF6TgVWEt4u+5TmoePBb2=T91j54cFao6LUB2n+jyKT=AatQ@mail.gmail.com>
Message-ID: <CAEemH2ccstsUJm+YgGhNy00S54Uki0qDJoKdafHGtsvKJ5CukQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, Nov 23, 2017 at 1:38 AM, Na Nha <minhnhan0801@gmail.com> wrote:
> Hello Li,
>
>
>
> Actually, I saw the below log:

That's it. I doubt you hit the same problem as this:
  https://github.com/linux-test-project/ltp/issues/93

>
>
>
> /opt/ltp/testcases/bin/memcg_lib.sh: line 514: echo: write error:
> Device or resource busy
>
> Or
>
> Something like:
> # mount -t cgroup -omemory memcg /dev/memcg/
> # mkdir -p /dev/memcg/ltp-test
> # echo 0 >/dev/memcg/memory.use_hierarchy
> -bash: echo: write error: Device or resource busy
>
>
>
> But so strangle, it has just appeared for the first time and it has been
> passed not failed.

Can you, confirm that whether this test is still failed when
memory.use_hierarchy is 0?


Test A:
1, reboot your system
2, ehco 0 >/sys/fs/cgroup/memory/memory.use_hierarchy
3, Run the ltp testcase: memcg_usage_in_bytes_test.sh


Test B:
1, reboot
2, ehco 1 >/sys/fs/cgroup/memory/memory.use_hierarchy
3, Run the ltp testcase: memcg_usage_in_bytes_test.sh


Which one(Test A or B?) you can get PASS on your ARM board?


>
> And the following times, it’s still passed. But sometime it’s failed.
>
> As mentioned previously, it is a dangling falling, sometimes the test result
> is pass and sometimes is failed
>
>
>
> I have attached 2 logs file (1 failed, 1 passed log) when I run command : sh
> –x  memcg_usage_in_bytes_test.sh for more detail log.
>
> Could you please review those and let me know what I should do next?
>
>
>
> Trân trọng / Best regards,
>
> Nhan Le Minh
>

Btw, please CC' LTP maillist when response email related to ltp thing. :)

-- 
Li Wang
liwang@redhat.com
