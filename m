From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Jun 2020 15:38:05 +0200
Subject: [LTP] [PATCH 5/5] syscalls: msgctl: Add new test to verify the
 _time_high fields
In-Reply-To: <96f9e90b0903939f6dab9dfe66e84e23d31c9e97.1590057824.git.viresh.kumar@linaro.org>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
 <96f9e90b0903939f6dab9dfe66e84e23d31c9e97.1590057824.git.viresh.kumar@linaro.org>
Message-ID: <20200615133805.GE25279@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  configure.ac                                  |   1 +
>  include/msgbuf.h                              | 306 ++++++++++++++++++

Here as well, I mainly do not like polluting the include/ with headers
that belongs into lapi/

-- 
Cyril Hrubis
chrubis@suse.cz
