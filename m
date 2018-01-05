From: Pavel Boldin <pboldin@cloudlinux.com>
Date: Fri, 5 Jan 2018 14:17:20 +0200
Subject: [LTP] meltdown exploit PoC
Message-ID: <cb84905a-b930-19f9-b1ae-744821a418bd@cloudlinux.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard,

The exploit provided by https://github.com/paboldin/meltdown-exploit is 
easily
adapted to become a side-channel check, which should be enough to check for
general vulnerability without exploiting it.

I will prepare a pull request.

--
Pavel
