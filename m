From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 Jul 2020 20:43:17 +0530
Subject: [LTP] [PATCH V2 2/2] libs: sigwait: Get rid of REPORT_SUCCESS()
 macro
In-Reply-To: <20200729144054.GI7152@yuki.lan>
References: <53c9ed8dc17ea6fa0b46502cd1c724a3a8539c8c.1595842740.git.viresh.kumar@linaro.org>
 <e964452fdb6c526a2cc61650573905e27adb83d5.1595842740.git.viresh.kumar@linaro.org>
 <20200729144054.GI7152@yuki.lan>
Message-ID: <20200729151317.evk2cphq7tclcww5@vireshk-mac-ubuntu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 29-07-20, 16:40, Cyril Hrubis wrote:
> Hi!
> Unfortunately half of this patch does not apply after the changes in the
> first one, can you please rebase?

I didn't see any issues with normal rebase of this patch over the other one, git
probably resolved issues itself.

I just now tried to apply this one with "git am -3" and it worked for me at
least (maybe git took some references from my tree).

But anyway, I will resend it now.

-- 
viresh
