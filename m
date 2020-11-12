From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 12 Nov 2020 14:02:30 +0000
Subject: [LTP] [PATCH] lib: tst_bool_expr: Add support for strings
In-Reply-To: <20201112130224.GA17493@yuki.lan>
References: <20201111131131.17360-1-chrubis@suse.cz>
 <87mtzoou23.fsf@suse.de> <20201111143744.GA16874@yuki.lan>
 <87k0urpzdf.fsf@suse.de> <20201112130224.GA17493@yuki.lan>
Message-ID: <87h7puptah.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> I suppose it depends how much later and how such an error would look. If
>> the error will happen directly after leaving this function then I don't
>> think it matters either, but if it is possible that it manages to
>> complete the whole evaluation process before failing with TCONF because
>> the vars don't match then this has the potential to waste some time.
>
> Well I can easily add this kind of check here, however out of all
> possible mistakes that you can do with misplaced quotes this would only
> catch the cases where the number of quotes is odd. I.e. only a subset of
> all possible errors, everything else would be caught later on when we
> attempt to evaluate the expression.
>
> E.g.
>
> 	CONFIG_FOO"=val"
> 	"CONFIG_FOO=val & CONFIG_BAR"
> 	"CONFIG_FOO"
> 	etc.
>
> are all valid in this context, but completely wrong when evaluated.
>
> I guess that it would make more sense to check if variable token is sane
> in the upper layer, i.e. in the kconfig parser since we do have the full
> information about how it should look like there. And this check would
> also cover this case as well.

+1


-- 
Thank you,
Richard.
