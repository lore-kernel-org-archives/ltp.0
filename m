From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Aug 2021 11:40:53 +0200
Subject: [LTP] [PATCH 1/3] tst_test.sh: Simplify tst_cmd_available()
In-Reply-To: <7ac7a1d6-2d97-f8f5-8d60-040eb0753681@jv-coder.de>
References: <20210818091224.27578-1-pvorel@suse.cz>
 <20210818091224.27578-2-pvorel@suse.cz>
 <7ac7a1d6-2d97-f8f5-8d60-040eb0753681@jv-coder.de>
Message-ID: <YRzVpQT1zYOvxlWe@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

...
> > +	type $1 >/dev/null 2>&1
> I guess there was a reason, why command was used here in the first place.
> Iirc type is often a shell builtin, that can have different behavior, while
> command -v is posix and should be extremely portable.
> So maybe it is better to use "command -v" instead of type here. I hope most
> distributions have a command-command...
Well, I wrote that code, in dba1d50cb :). IMHO both are POSIX and both are shell
builtin.

I tested it on all implementations and the only difference is that both "type"
and "command -v" on dash and busybox sh returns 127 on missing command, the rest
return 1.

Kind regards,
Petr
