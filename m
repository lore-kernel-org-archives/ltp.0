From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Nov 2017 14:20:19 +0100
Subject: [LTP] [PATCH v2 09/13] syscalls/mount03: Copy setuid_test to
 execute instead of 'TEST FILE'
In-Reply-To: <20171114155929.24237-10-punit.agrawal@arm.com>
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-10-punit.agrawal@arm.com>
Message-ID: <20171129132019.GC18489@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When testing the MS_NOSUID mount flag, mount03 forgets to copy
> setuid_test into the new filesystem. Instead it writes 'TEST FILE' into
> a new file and attempts to execute it with S_ISUID. This fails, but not
> for the reasons ltp expects.

What is the exact error here? I guess that the file does not have
execute bit set and that check kicks in first?

Anyway we really should check the errno from the exec() is EPERM which
should have caught this problem.

-- 
Cyril Hrubis
chrubis@suse.cz
