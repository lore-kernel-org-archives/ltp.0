From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Apr 2016 17:30:42 +0200
Subject: [LTP] Issue with the reporting of failed tests
In-Reply-To: <5718E81B.6060101@free.fr>
References: <5718D4CA.5010607@free.fr>
 <5718E81B.6060101@free.fr>
Message-ID: <20160421153041.GA25307@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Calling fflush does appear to solve the problem:
> 
> # grep -c FAIL result-log.5160
> 38
> 
> # wc -l result-failed.5160
> 38 result-failed.5160
> 
> Does this mean no one ever reads FAILCMDFILE?!

Just to have complete image here. I've discussed this a bit more at #ltp
irc channel and the reason why we do not see this bug often is that the
exec() that is done by the child after pan forks must fail (for example
since bash is missing) then the code proceeds to exit(errno) line which
flushes the buffers on open files...

-- 
Cyril Hrubis
chrubis@suse.cz
