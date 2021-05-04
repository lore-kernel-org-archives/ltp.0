From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 May 2021 16:57:41 +0200
Subject: [LTP] [PATCH v3 1/1] docparse: Escape backslash,
 tab and double quote in JSON
In-Reply-To: <YJFd6x+P7lFhLfXm@pevik>
References: <20210504125729.18781-1-pvorel@suse.cz> <YJFH4vLeaXnc8mzN@yuki>
 <YJFd6x+P7lFhLfXm@pevik>
Message-ID: <YJFg5eIaVhUKO4ax@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also does this even escape newlines? If you write "\n" in C it's stored
> > in memory as [0x0a, 0x00], no actual \ are stored in the string. What
> > the '\\' case does it to escape literal backslash i.e. "\\" which is
> > stored as [0x5c, 0x00].
> Well, due first handling '\\' any text written as \n will be kept as \n
> (obviously anything starting with \ will be handled the same, e.g. \t, \r, \b, \f).
> We'd like to interpret \n at least for .options (unless we transform them
> to array of arrays as you suggested). But I'm not sure if we want to do
> everywhere, e.g. in doc there might be \n which we want to keep, thus I'd prefer
> to interpret only tabs ('\t' => "\\t") and the rest escape via escaping '\\'
> (already in the patch).
>
> I don't think there is real new line character in our JSON (unlike tab, which
> was put there into CAN tests and needed to be reverted). If yes, I think we'd
> prefer to interpret it instead escaping it (as well as form feed and carriage return).
> Unless any of these is ascii before 0x20 (which will be handled by last change
> you're suggested.

Ah, I got confused here as well, we parse the C code and we do not
replace the \n with the actual ascii value in the docparse code so it
ends up verbatim in the strings in memory and then it's translated into
the JSON files.

This is even more complicated than I originally thought since there are
several types of strings from a different parts of the C code, i.e. the
expected values depens on context.

If we parse a C comment '"' is a valid character and does not need to be escaped,
while in the middle of C string it has to be encoded as "\"".

We have to think of all different cases here, I will have a closer look tomorrow.

-- 
Cyril Hrubis
chrubis@suse.cz
