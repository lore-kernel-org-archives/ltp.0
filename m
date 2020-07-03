From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 3 Jul 2020 07:52:21 +0530
Subject: [LTP] [PATCH 1/2] syscalls/timer_settime01: Improve print
 messages
In-Reply-To: <20200702133418.GD9101@yuki.lan>
References: <7c68854a1b6ef828ed8dd83cb611bd5b5d53c2f8.1593430825.git.viresh.kumar@linaro.org>
 <20200702133418.GD9101@yuki.lan>
Message-ID: <20200703022221.upylhdvugtnp6hr2@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02-07-20, 15:34, Cyril Hrubis wrote:
> Hi!
> > This improves the print messages by providing additional information
> > about the tests.
> 
> Do we really need this?
> 
> We do print which test variant we test at the start of each block and no
> other tests with test variant prefix the messages like this...

Damn, I missed that somehow and thought some information is missing :(

-- 
viresh
