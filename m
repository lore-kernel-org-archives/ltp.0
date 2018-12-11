From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 11 Dec 2018 09:46:36 +0100
Subject: [LTP] [PATCH v2 0/3] ltp: new test for crypto_user information
	leak bug
In-Reply-To: <20181211060317.18698-1-ebiggers@kernel.org>
References: <20181211060317.18698-1-ebiggers@kernel.org>
Message-ID: <87in00mowj.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Eric,

Eric Biggers <ebiggers@kernel.org> writes:

> This series adds a test for an information leak bug in the crypto user
> configuration API which was recently fixed.
>
> Changed since v1:
>   - Check all attributes, not just the first of each type
>   - Work around dependency bug in old kernel headers
>   - Rename __check_for_leaks() to do_check_for_leaks()
>   - Use SPDX license identifier

Thanks, I tested it and it LGTM.

-- 
Thank you,
Richard.
