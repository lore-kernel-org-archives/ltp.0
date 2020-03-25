From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Mar 2020 16:28:21 +0100
Subject: [LTP] [PATCH v2] uart: add uart testcase in kernel
 device-drivers
In-Reply-To: <20200325102852.GD5404@yuki.lan>
References: <20200324121742.7130-1-gengcixi@gmail.com>
 <20200325102852.GD5404@yuki.lan>
Message-ID: <20200325152821.GA21800@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> This is problematic as well, it expects that all ports that are not
> in-use are loopback connected. This is not true in general case, which
> means that we cannot add the test to the kernel_misc runtest file as it
> is because it will fail on most of the systems out there.
Oh, I didn't realize this obvious thing.

> We will have to figure out how to pass which ports are interconnected to
> the test somehow, because that is something that only the user who set
> up the machine knows.
Maybe expect user sets it in some variable before running the test? e.g.:

if [ -n "$UART_INTERCONNECTED_PORTS" ]; then
    tst_brk TCONF "set space separated interconnected ports in \$UART_INTERCONNECTED_PORTS"
fi

Kind regards,
Petr
