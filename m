From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Dec 2020 12:08:40 +0100
Subject: [LTP] [PATCH] syscalls: Allocate handles at setup time only
In-Reply-To: <ca094a13188d52cca6cfb913c2341429d3967bfb.1607425101.git.viresh.kumar@linaro.org>
References: <20201124152446.GC12878@yuki.lan>
 <ca094a13188d52cca6cfb913c2341429d3967bfb.1607425101.git.viresh.kumar@linaro.org>
Message-ID: <X89euAzbRsPLP+Hr@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Cyril, I think you merged the patch for open_by_handle_at by mistake,
> and that too without your signed-off.

Sorry, looks like I had messed up again. I will revert that one and
apply it again with these changes on the top. Thanks a lot.

-- 
Cyril Hrubis
chrubis@suse.cz
