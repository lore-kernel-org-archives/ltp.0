From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Apr 2021 11:40:04 +0200
Subject: [LTP] [PATCH v5 1/2] splice02: Generate input in C
In-Reply-To: <YH8H7gnu9FYziyGG@pevik>
References: <20210420084410.16179-1-pvorel@suse.cz> <YH6c/cm9uY0QRrbu@yuki>
 <YH8H7gnu9FYziyGG@pevik>
Message-ID: <YH/y9JMUfbpSX8ev@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Yep. In your code you expect that written letter change each time.
> But original code writes the same letter for whole buffer (using memset()).

Ah, right, the mapping in the original code maps the remaning size to be
written to a letter and uses it for whole block.

I guess that it may be easier to understand if the letter was defined as
an function of a position in the file like I have expected in my
snippet. That way we can also produce different patterns without
changing the test code (and we can later on introduce a library
functions to fill buffer and check buffer as well, these would generally
take a pointer to a buffer, size and an offset).

That would mean that we will have to fill the buffer in a for loop
instead of memset, but as long as the get_letter() function is inlined
it should be fast enough.

-- 
Cyril Hrubis
chrubis@suse.cz
