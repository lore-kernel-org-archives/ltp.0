From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Mar 2018 15:25:13 +0300
Subject: [LTP] [PATCH] busy_poll* : revise poll_cmp
In-Reply-To: <c999a175-d02b-beda-7418-95a5b0f2d432@cn.fujitsu.com>
References: <c999a175-d02b-beda-7418-95a5b0f2d432@cn.fujitsu.com>
Message-ID: <fae2ea47-a416-f2b4-ee2b-f022f14a14a0@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 19.03.2018 11:18, sunlianwen wrote:
> set low latency busy poll to 50 per socket will
> spent more time than set low latency busy poll
> to 0 per socket. that mean the value of res_50
> is bigger than res_0, so the value of poll_comp
> always less than zero and=C2=A0 test fail.

No, if busy poll is enabled, i.e. value set above 0, we should expect
performance gain in this test.

With what driver and kernel version you have such results?
Is it really supported by that driver?

Thanks,
Alexey
