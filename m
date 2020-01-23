From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jan 2020 12:13:48 +0100
Subject: [LTP] [PATCH v2] syscalls/add_key01: test the length of payload
In-Reply-To: <1579670796-21233-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200121151342.GD6337@rei>
 <1579670796-21233-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200123111347.GE27845@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Seeing add_key manpages, the length of payload for "user"/"logon"
> is 32767, this value is up tp 1M for "big_key". For "keyring" type
> , this value is zero.

This version is nearly good, there are a few minor things I can fix up
before applying.

However the test fails for me unless I run it as root. Looks like any
key that is bigger than certain threshold fails with EDQUOT for me. Have
you tried to run the test as an unpriviledged user?

-- 
Cyril Hrubis
chrubis@suse.cz
