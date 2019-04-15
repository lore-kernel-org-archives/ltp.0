From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 15 Apr 2019 13:32:20 +0200
Subject: [LTP] Option '-n' is processing is missing
In-Reply-To: <657145623.3169563.1555324026007@mail.yahoo.com>
References: <657145623.3169563.1555324026007.ref@mail.yahoo.com>
 <657145623.3169563.1555324026007@mail.yahoo.com>
Message-ID: <20190415113220.GA994@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Muthu,

> In the help, I am seeing the following option, but not processing in the main() function. -n Run LTP with network traffic in background.
Thanks for your bug report. Indeed, runltp script is missing -n option.
This is a result of 9519bb462 ("runltp: Remove references to netpipe.sh"), which
was fix of f7201dfc ("tools: Remove unused code.") and handled in #158 [1].
I'm going to fix it.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/158

> Please fix.
> RegardsMuthu Mohan
