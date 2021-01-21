From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Jan 2021 15:50:41 +0100
Subject: [LTP] [PATCH 1/2] docparse: Replace \t with space
In-Reply-To: <87mtx29wiq.fsf@suse.de>
References: <20210121130033.20764-1-pvorel@suse.cz>
 <87mtx29wiq.fsf@suse.de>
Message-ID: <YAmUwVWvm84w8ITB@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> JQ says "control characters from U+0000 through U+001F must be
> escaped". So I expect it is only a matter of time until some other
> control character is used.
> 
> Perhaps we should escape all control characters into the \uXXXX
> hexidecimal form?

Or fail the compilation if we get one of these into the parser?

There is no point in having them in the metadata anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
