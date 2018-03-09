From: Michael Moese <mmoese@suse.de>
Date: Fri, 9 Mar 2018 09:06:10 +0100
Subject: [LTP] [PATCH] Add tst_flush() library function
In-Reply-To: <20180308151359.GA1777@rei>
References: <20180308105704.7823-1-mmoese@suse.de> <20180308151359.GA1777@rei>
Message-ID: <20180309080610.hp7wixwldupnftuz@linux.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
Now that you tell me that, I can see this as well. Of course I did a local
build test, but the issue did not show up at first.

I will send more patches, changing safe_fork() and the old library.


Michael

On Thu, Mar 08, 2018 at 04:14:03PM +0100, Cyril Hrubis wrote:
> Hi!
> I've tried to apply this but found out that there is tst_flush() in the
> old library and because of that the code does not even compile.
> 
> So we have to rename the tst_flush() in the old library to something as
> tst_old_flush() and also remove it from the ltpapicmd.c since there are
> no shell tests that call that command (ltpapicmd.c should hopefully die
> some day soon). Should I do that or will you send another patch? :-)
> 
> Also we should make use of the tst_flush() in the safe_fork() so that we
> finally flush the right stream in the new test library...
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
