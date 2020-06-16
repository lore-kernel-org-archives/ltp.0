From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jun 2020 15:10:14 +0200
Subject: [LTP] [PATCH V2 0/6] syscalls: Add tests to verify the
 _time_high fields
In-Reply-To: <cover.1592302358.git.viresh.kumar@linaro.org>
References: <cover.1592302358.git.viresh.kumar@linaro.org>
Message-ID: <20200616131014.GB2790@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added one more patch that includes config.h in the
include/lapi/ipcbuf.h, since otherwise we may not get the HAVE_* macros
defined and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
