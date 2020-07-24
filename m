From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jul 2020 17:13:07 +0200
Subject: [LTP] [PATCH V7 12/19] syscalls/recvmmsg: Add support for
 time64 tests
In-Reply-To: <deb0577515085afad54ff93f61b103032017be3d.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <deb0577515085afad54ff93f61b103032017be3d.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200724151307.GB10254@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've corrected the commit message with s/recvmmsg/sendmmsg/ and also
fixed two wrong TTERRNO in the code and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
