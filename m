From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jan 2018 11:38:29 +0100
Subject: [LTP] cross compilation failing
In-Reply-To: <CAN9dZwefF=KqefnuMS-OAVN+icQt=bczdk0QGrBRWEPKdNWFhg@mail.gmail.com>
References: <CAN9dZwefF=KqefnuMS-OAVN+icQt=bczdk0QGrBRWEPKdNWFhg@mail.gmail.com>
Message-ID: <20180116103829.GB24595@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> we are facing issue while compiling ltp for kernel version 2.6.34.15.
> could you please let me know, does ltp depend on kernel version.

The build does not depend on the running kernel at all. The usuall
suspects are libc version and version of the kernel-headers.

Can you append a log of the failing compilation? Without that we cannot
really help here.

-- 
Cyril Hrubis
chrubis@suse.cz
