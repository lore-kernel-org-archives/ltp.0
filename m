From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Feb 2020 17:21:59 +0100
Subject: [LTP] [PATCH V2] syscalls/pidfd_open: Continue with rest of the
 tests on failure
In-Reply-To: <2f579843fb1ff09cfaaa1b991b48437f525740b3.1582673499.git.viresh.kumar@linaro.org>
References: <54a3d6fcef8cfed89a1e4f0b56717f56aa502293.1582611994.git.viresh.kumar@linaro.org>
 <2f579843fb1ff09cfaaa1b991b48437f525740b3.1582673499.git.viresh.kumar@linaro.org>
Message-ID: <20200226162159.GA31170@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		return;
> +	 }
        ^
I've removed this space that I suppose was added accidentally and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
