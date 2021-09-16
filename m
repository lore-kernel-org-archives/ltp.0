From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Sep 2021 14:56:15 +0200
Subject: [LTP] [PATCH 4/4] syscalls/utime03: Convert to new API
In-Reply-To: <20210915134505.22771-4-mdoucha@suse.cz>
References: <20210915134505.22771-1-mdoucha@suse.cz>
 <20210915134505.22771-4-mdoucha@suse.cz>
Message-ID: <YUM+76XsQB57U3rE@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	mintime = time(0);
> +	TST_EXP_PASS(utime(TEMP_FILE, NULL));
> +	maxtime = time(0);

I wonder if this suffers the problem as the ipc timestamps:

https://github.com/linux-test-project/ltp/commit/d37bde3defa12556ba7399f4131996f8e490490a


The rest of the test looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
