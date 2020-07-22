From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jul 2020 16:05:21 +0200
Subject: [LTP] [PATCH V2 3/3] syscalls: sigwait: Separate out code to
 relevant folders
In-Reply-To: <c5fabfa8e2626d69fbe39e412b64c40b10f35b0b.1595321086.git.viresh.kumar@linaro.org>
References: <cover.1595321086.git.viresh.kumar@linaro.org>
 <c5fabfa8e2626d69fbe39e412b64c40b10f35b0b.1595321086.git.viresh.kumar@linaro.org>
Message-ID: <20200722140521.GA19275@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Applied, thanks.

The library still could use some improvements, but the code is much
better after this patchset.

A few things for followup:

* Add the SAFE_SIG* macros and use them
* Remove the useless alarm() in test setup and cleanup
  as the new library maintains timeouts already
* Get rid of the ugly REPORT_SUCCESS() functions

-- 
Cyril Hrubis
chrubis@suse.cz
