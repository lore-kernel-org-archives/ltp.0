From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Dec 2020 11:18:54 +0100
Subject: [LTP] [RFC] openposix: Use TMPDIR instead of hardcoded /tmp
In-Reply-To: <20201215060702.507970-1-lkml@jv-coder.de>
References: <20201215060702.507970-1-lkml@jv-coder.de>
Message-ID: <X9iNjuaLFLuVoQ0n@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> What is your opionion? Does a change like this make sense or would
> you do it differently?

Sounds reasonable.

I guess that we should also bump the buffer sizes a bit since tests
seems to use 256 bytes, which is not that hard to overflow. I would go
for at least 4096.

Or we may as well give up on passing a stack allocated buffer and use
malloc() for the path instead.

As for mkdtemp() if we added that we would have to add a function to
remove the directory at the end, so I wouldn't do that unless we want to
actually write a test library for the openposix tests.

And lastly but not least we do have testcases there that open files in
current directory, these should be ideally converted to create the files
in TMPDIR as well.

-- 
Cyril Hrubis
chrubis@suse.cz
