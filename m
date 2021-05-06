From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 09:50:54 +0200
Subject: [LTP] [PATCH v3 1/1] docparse: Escape backslash,
 tab and double quote in JSON
In-Reply-To: <YJFH4vLeaXnc8mzN@yuki>
References: <20210504125729.18781-1-pvorel@suse.cz>
 <YJFH4vLeaXnc8mzN@yuki>
Message-ID: <YJOf3tGdYHam+8Jl@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> Also does this even escape newlines? If you write "\n" in C it's stored
> in memory as [0x0a, 0x00], no actual \ are stored in the string. What
> the '\\' case does it to escape literal backslash i.e. "\\" which is
> stored as [0x5c, 0x00]. Looking at JSON specification anything that is
> in ascii before 0x20 (space) is invalid character in a JSON string. I
> guess that the safest to write strings would be:

> 	...
> 	default:
> 		if (*str >= 20)
> 			putc(*str, f);
> 	}
Actually, space 20 is hex, it should be 0x20 or 32.

https://tools.ietf.org/html/rfc8259#page-9
unescaped = %x20-21 / %x23-5B / %x5D-10FFFF

BTW preparing v4, it should definitely go to the release (or we need to fix
formatting of c39b29f0a ("bpf: Check truncation on 32bit div/mod by zero")).

Kind regards,
Petr

> And we would have to add escape at least for '\n' the same way we have
> for '\t' in the switch.
