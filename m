From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Apr 2021 14:32:54 +0200
Subject: [LTP] [PATCH] Fix the 64-bit macro definition of mips
 architecture
In-Reply-To: <20210426074812.27798-1-sujiaxun@uniontech.com>
References: <20210426074812.27798-1-sujiaxun@uniontech.com>
Message-ID: <YIgEdkx+XSv81V3e@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> The mips architecture gcc does not have a built-in __arch64__,
> you can also use "__BITS_PER_LONG == 64"

Thanks for the fix, merged!

Please next time mark new version of the patchset with -vN switch
(e.g. in this case: git format-patch origin/master -v2).

Kind regards,
Petr
