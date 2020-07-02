From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Jul 2020 15:34:18 +0200
Subject: [LTP] [PATCH 1/2] syscalls/timer_settime01: Improve print
 messages
In-Reply-To: <7c68854a1b6ef828ed8dd83cb611bd5b5d53c2f8.1593430825.git.viresh.kumar@linaro.org>
References: <7c68854a1b6ef828ed8dd83cb611bd5b5d53c2f8.1593430825.git.viresh.kumar@linaro.org>
Message-ID: <20200702133418.GD9101@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This improves the print messages by providing additional information
> about the tests.

Do we really need this?

We do print which test variant we test at the start of each block and no
other tests with test variant prefix the messages like this...

-- 
Cyril Hrubis
chrubis@suse.cz
