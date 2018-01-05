From: Pavel Boldin <pboldin@cloudlinux.com>
Date: Fri, 5 Jan 2018 16:17:48 +0200
Subject: [LTP] meltdown exploit PoC
In-Reply-To: <cb84905a-b930-19f9-b1ae-744821a418bd@cloudlinux.com>
References: <cb84905a-b930-19f9-b1ae-744821a418bd@cloudlinux.com>
Message-ID: <d1f0e293-9959-87eb-a47f-fe8e6e7ec8ee@cloudlinux.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard,

Sorry, missed you in CC.

The meltdown pull request is here. It reads few bytes of 
`linux_proc_banner`:

https://github.com/linux-test-project/ltp/pull/244

--
Pavel

On 05.01.18 14:17, Pavel Boldin wrote:
> Richard,
>
> The exploit provided by https://github.com/paboldin/meltdown-exploit 
> is easily
> adapted to become a side-channel check, which should be enough to 
> check for
> general vulnerability without exploiting it.
>
> I will prepare a pull request.
>
> -- 
> Pavel

