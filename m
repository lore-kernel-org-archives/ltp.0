From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Apr 2020 16:56:02 +0200
Subject: [LTP] [PATCH 1/3] lib/safe_file_ops: print file info when
 file_lines_scanf parsed fail
In-Reply-To: <1587450108-31100-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1587450108-31100-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200428145602.GB4244@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	if (strict && ret != arg_count) {
>  		tst_brkm(TBROK, cleanup_fn, "Expected %i conversions got %i"
> -			" at %s:%d", arg_count, ret, file, lineno);
> +			" in %s at %s:%d", arg_count, ret, path, file, lineno);

I've changed the " in %s" to " FILKE '%s'" to match the style in the
rest of the file and pushed, good catch, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
