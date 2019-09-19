From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Sep 2019 16:26:45 +0200
Subject: [LTP] [RFC PATCH v2 0/1] Add automated tests for shell lib
In-Reply-To: <cover.1566500817.git.clanig@suse.com>
References: <20181003113215.GB21139@dell5510>
 <cover.1566500817.git.clanig@suse.com>
Message-ID: <20190919142644.GA20853@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

> Hi,

> I am sorry that my reply took so long. Thank you very much for your comments
> which helped me to improve the code.
> I have made an overhaul of the code based on your suggestions but an option to
> pass parameters to the tests is still not implemented. 
> I'm sending you what I have so far because it would help me when you could
> provide me more information regarding this.

> I agree that it is difficult to find a way to process text the way needed here
> without disregarding the Linux Kernel Coding Style that asks for code which is
> transparent and easy to read when we only consider Shell commands. To address
> this issue I have drafted a Python script that might go in the tools folder and
> may perhaps be helpful in other cases as well. Since there are already Python
> files in the project it might be a valid option.

> Thank you very much for your patience.
No problem, thanks continue for it.

I'm also not sure if we should put them into separate testcases/ directory.
I'd put them into shell/ directory and rename test_sh_newlib.sh to run.sh or
something simple.

BTW (nit, no hard feeling :) as lib/newlib_tests/test.*.sh are based on my
previous work, you could might mention it in the change log. You updated them to
have timeout output, so it's your work, (if not, it'd be better to send them as
mine separate

Kind regards,
Petr
