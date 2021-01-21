From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 21 Jan 2021 15:59:48 +0000
Subject: [LTP] [PATCH 1/2] docparse: Replace \t with space
In-Reply-To: <YAmhO8gMJ1KZ4EHA@pevik>
References: <20210121130033.20764-1-pvorel@suse.cz> <87mtx29wiq.fsf@suse.de>
 <YAmUwVWvm84w8ITB@yuki.lan> <YAmhO8gMJ1KZ4EHA@pevik>
Message-ID: <87k0s69t6z.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi,
>
>> > JQ says "control characters from U+0000 through U+001F must be
>> > escaped". So I expect it is only a matter of time until some other
>> > control character is used.
> +1
>
>> > Perhaps we should escape all control characters into the \uXXXX
>> > hexidecimal form?
>
>> Or fail the compilation if we get one of these into the parser?
> We do fail already, but it's a bit hidden now.
> I don't know why build continues for so long.
>
> Also there would have to be striking error message.
> But docparser is not mandatory (people might have it disabled), thus mostly it
> will be us the maintainers who is going to fix these whitespace issues :(.
>
>> There is no point in having them in the metadata anyways.
> That would be solved by replacing some reasonable subset. So far it was the tab
> character.
>
> Kind regards,
> Petr

I suppose actually I could just escape the tab in the C string. But as
Petr says, docparse is not mandatory so anything which can pass C
compilation, but fails docparse is likely to create trouble.

It would be possible to force running docparse and doing some validation
on the JSON. As this would not require any more dependencies. In fact it
would be nice to run docparse to produce just the JSON without having to
install asciidoc[tor].

The Makefile doesn't seem to allow this. Although it is quite easy to
compile docparse without it.

-- 
Thank you,
Richard.
