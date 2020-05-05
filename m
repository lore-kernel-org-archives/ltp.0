From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 5 May 2020 15:20:40 +0530
Subject: [LTP] [PATCH] syscalls/utimensat: Migrate to new test framework
In-Reply-To: <40141c5d6ca8a92c2c8322880ddd2dc123717070.1588669752.git.viresh.kumar@linaro.org>
References: <40141c5d6ca8a92c2c8322880ddd2dc123717070.1588669752.git.viresh.kumar@linaro.org>
Message-ID: <20200505095040.uhmhralckdhlwysu@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05-05-20, 14:40, Viresh Kumar wrote:
> This gets rid of the test script and updates the utimensat01.c file to
> handle most of the tests covered earlier (apart from testing the same
> for files owned by root, as the test is run as root right now).
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Guys,
> 
> As discussed over LTP irc channel, I have tried to give this a try
> before converting the tests to time64. Please see if this looks
> reasonable.

Please discard this one and have a look at v2.

-- 
viresh
