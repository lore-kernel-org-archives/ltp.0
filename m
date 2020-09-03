From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Sep 2020 14:08:52 +0200
Subject: [LTP] [PATCH V11 1/2] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <9ba8ffe0a93eb8d6c722ce22e9042f146f83bec9.1599058700.git.viresh.kumar@linaro.org>
References: <9ba8ffe0a93eb8d6c722ce22e9042f146f83bec9.1599058700.git.viresh.kumar@linaro.org>
Message-ID: <20200903120852.GB15281@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> - Change timeout to 10 us for all the tests except semop03, that fails
>   randomly if the timeout is less than 10 ms.

The short timeout is important only to semop02, where we actually wait
for the timeout. We can raise the timeout for semop03 to minutes if
needed, since we actually do not wait for it to expire.

-- 
Cyril Hrubis
chrubis@suse.cz
