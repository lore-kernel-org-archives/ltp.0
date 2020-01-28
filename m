From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 28 Jan 2020 22:39:02 +0100
Subject: [LTP] [PATCH 1/1] ioctl02.c: check for struct termio
In-Reply-To: <20200128212725.22781-1-petr.vorel@gmail.com>
References: <20200128212725.22781-1-petr.vorel@gmail.com>
Message-ID: <20200128213902.GA23927@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Test is meant to use legacy struct termio, so we need to check for it.
Hm, am I wrong, and we should rewrite ioctl01.c and ioctl02.c to use struct
termios? Or do we want to test with both new struct termios and legacy termio?

Kind regards,
Petr
