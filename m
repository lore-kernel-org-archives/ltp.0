From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 21 Apr 2021 12:04:30 +0200
Subject: [LTP] [PATCH v5 1/2] splice02: Generate input in C
In-Reply-To: <YH/y9JMUfbpSX8ev@yuki>
References: <20210420084410.16179-1-pvorel@suse.cz> <YH6c/cm9uY0QRrbu@yuki>
 <YH8H7gnu9FYziyGG@pevik> <YH/y9JMUfbpSX8ev@yuki>
Message-ID: <YH/4rmSu6Ie04hkI@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > Yep. In your code you expect that written letter change each time.
> > But original code writes the same letter for whole buffer (using memset()).

> Ah, right, the mapping in the original code maps the remaning size to be
> written to a letter and uses it for whole block.

> I guess that it may be easier to understand if the letter was defined as
> an function of a position in the file like I have expected in my
> snippet. That way we can also produce different patterns without
> changing the test code (and we can later on introduce a library
> functions to fill buffer and check buffer as well, these would generally
> take a pointer to a buffer, size and an offset).
Make sense.

> That would mean that we will have to fill the buffer in a for loop
> instead of memset, but as long as the get_letter() function is inlined
> it should be fast enough.
Right. I guess trying to "align" buffer with alphabet size (e.g. multiple of 26)
to avoid filling the buffer is not worth. Thus I keep buffer size 512 and fill
it each time.

Thanks for your suggestions and time.

Kind regards,
Petr
