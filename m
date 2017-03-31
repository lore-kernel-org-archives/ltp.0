From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Mar 2017 13:29:35 +0200
Subject: [LTP] Access02 and use of system() library function
In-Reply-To: <c5d9de57-9847-1471-210f-b4a053237ab1@gezedo.com>
References: <beacb487-181d-2d9c-380a-128b985b2250@gezedo.com>
 <20170320111128.GA3322@rei.lan>
 <1e809374-8b45-aae8-69b2-14a0728fc2d6@gezedo.com>
 <20170330141913.GA886@rei.lan>
 <c5d9de57-9847-1471-210f-b4a053237ab1@gezedo.com>
Message-ID: <20170331112935.GD17943@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Yes it does, and the test passes.

I've pushed the fix.

> IMHO returning explicitely 0 (exit 0) will make the test even more
> robust, because 0 is the value returned by the system() library
> function call, and expected by the test.

The POSIX specification requires the sh to exit with zero if the input
file is empty or consits solely of blank lines and comments. So I would
say that file with just a shebang is robust enough.

-- 
Cyril Hrubis
chrubis@suse.cz
