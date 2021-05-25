From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 25 May 2021 15:03:58 +0100
Subject: [LTP] [RFC PATCH 0/4] Auto review and Coccinelle
In-Reply-To: <YKzp0rxGfaxL1blw@yuki>
References: <20210524144745.10887-1-rpalethorpe@suse.com>
 <YKzp0rxGfaxL1blw@yuki>
Message-ID: <87sg2akj01.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> I'm not sure how to integrate it with the build system. We may just
>> want to do something similar to the kernel. Also I guess we want to
>> have a way of checking patches sent to the mailing list.
>
> I guess that having it in travis as a post commit check would be better
> than nothing.
>
> Pre commit hook would be ideal but requiring coccinelle installed for
> LTP development would increase the bar for contribution too much I
> guess.

I fear this defeats my primary goal of giving very quick feedback
without involving patch submission. This makes me think of clang-tidy
(clang-tools?) again. It will probably be more difficult to write LTP
specific checks, but I guess every desktop Linux distro less than 10
years old has Clang?

I don't think there is much else I can do than try writing the same
check in clang as well. See how that goes...

Anyway, we could copy the kernel to some extent. Make it so running

make coccicheck

or

make clang-tidy

or more generic

make check

Will recursively run the checks on the files under the current
directory?

-- 
Thank you,
Richard.
